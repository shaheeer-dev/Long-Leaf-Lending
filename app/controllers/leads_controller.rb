class LeadsController < ApplicationController
  def new
    @lead = Lead.new
  end

  def create
    @lead = Lead.new(lead_params)

    if @lead.save!
      calculations = LeadCalculatorService.new(@lead).calculate
      pdf = PdfGeneratorService.new(@lead, calculations).generate

      # Enqueue the email job
      SendTermsheetEmailJob.perform_later(@lead.id, pdf)

      redirect_to new_lead_path, notice: "Lead was successfully created and termsheet emailed."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def lead_params
    params.require(:lead).permit(:address, :loan_term, :purchase_price, :repair_budget, :arv, :name, :email, :phone)
  end
end
