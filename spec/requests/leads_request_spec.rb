require "rails_helper"

RSpec.describe "Leads", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get new_lead_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      let(:valid_attributes) do
        {
          address: "123 Main St",
          loan_term: 12,
          purchase_price: 100000,
          repair_budget: 20000,
          arv: 150000,
          name: "John Doe",
          email: "john.doe@example.com",
          phone: "123-456-7890"
        }
      end

      let(:calculations) { {loan_amount: 90000, total_interest_expense: 3000, estimated_profit: 57000} }
      let(:pdf) { "PDF_CONTENT" }

      before do
        allow(LeadCalculatorService).to receive(:new).and_return(instance_double("LeadCalculatorService", calculate: calculations))
        allow(PdfGeneratorService).to receive(:new).and_return(instance_double("PdfGeneratorService", generate: pdf))
        ActiveJob::Base.queue_adapter = :test
      end

      it "creates a new Lead" do
        expect {
          post leads_path, params: {lead: valid_attributes}
        }.to change(Lead, :count).by(1)
      end

      it "calculates the lead details" do
        post leads_path, params: {lead: valid_attributes}
        lead = Lead.last
        expect(LeadCalculatorService).to have_received(:new).with(lead)
      end

      it "generates a PDF" do
        post leads_path, params: {lead: valid_attributes}
        lead = Lead.last
        expect(PdfGeneratorService).to have_received(:new).with(lead, calculations)
      end

      it "enqueues the SendTermsheetEmailJob" do
        post leads_path, params: {lead: valid_attributes}
        lead = Lead.last
        expect(SendTermsheetEmailJob).to have_been_enqueued.with(lead.id, pdf)
      end

      it "redirects to the new lead path with a notice" do
        post leads_path, params: {lead: valid_attributes}
        expect(response).to redirect_to(new_lead_path)
        expect(flash[:notice]).to match(/Lead was successfully created and termsheet emailed./)
      end
    end

    context "with invalid parameters" do
      let(:invalid_attributes) do
        {
          address: "123 Main St",
          loan_term: 12,
          purchase_price: 100000,
          repair_budget: 20000,
          arv: 150000,
          name: "John Doe",
          email: nil,
          phone: "123-456-7890"
        }
      end

      it "does not create a new Lead" do
        expect {
          post leads_path, params: {lead: invalid_attributes}
        }.to change(Lead, :count).by(0)
      end

      it "re-renders the 'new' template with unprocessable entity status" do
        post leads_path, params: {lead: invalid_attributes}
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "shows the correct error messages" do
        post leads_path, params: {lead: invalid_attributes}
        expect(response.body).to include("Email can't be blank")
      end
    end
  end
end
