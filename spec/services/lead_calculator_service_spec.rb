require "rails_helper"

RSpec.describe LeadCalculatorService do
  describe "#calculate" do
    let(:lead) do
      Lead.new(
        address: "123 Main St",
        loan_term: 12,
        purchase_price: 100000,
        repair_budget: 20000,
        arv: 150000,
        name: "John Doe",
        email: "john.doe@example.com",
        phone: "123-456-7890"
      )
    end

    subject { described_class.new(lead) }

    before do
      @result = subject.calculate
    end

    it "calculates the correct loan amount" do
      max_loan_by_purchase_price = lead.purchase_price * 0.9
      max_loan_by_arv = lead.arv * 0.7
      initial_loan_amount = [max_loan_by_purchase_price, max_loan_by_arv].min
      total_loan_amount = initial_loan_amount + lead.repair_budget
      expected_loan_amount = [total_loan_amount, max_loan_by_arv].min.round(2)

      expect(@result[:loan_amount]).to eq(expected_loan_amount)
    end

    it "calculates the correct total interest expense" do
      max_loan_by_purchase_price = lead.purchase_price * 0.9
      max_loan_by_arv = lead.arv * 0.7
      initial_loan_amount = [max_loan_by_purchase_price, max_loan_by_arv].min
      total_loan_amount = initial_loan_amount + lead.repair_budget
      loan_amount = [total_loan_amount, max_loan_by_arv].min
      expected_interest_expense = (loan_amount * (0.13 / 12) * lead.loan_term).round(2)

      expect(@result[:total_interest_expense]).to eq(expected_interest_expense)
    end

    it "calculates the correct estimated profit" do
      max_loan_by_purchase_price = lead.purchase_price * 0.9
      max_loan_by_arv = lead.arv * 0.7
      initial_loan_amount = [max_loan_by_purchase_price, max_loan_by_arv].min
      total_loan_amount = initial_loan_amount + lead.repair_budget
      loan_amount = [total_loan_amount, max_loan_by_arv].min
      total_interest_expense = loan_amount * (0.13 / 12) * lead.loan_term
      expected_profit = (lead.arv - loan_amount - total_interest_expense).round(2)

      expect(@result[:estimated_profit]).to eq(expected_profit)
    end
  end
end
