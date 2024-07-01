class LeadCalculatorService
  FUNDABLE_LOAN_PERCENTAGE = 0.9
  ARV_LOAN_PERCENTAGE = 0.7
  INTEREST_RATE = 0.13

  attr_reader :lead

  def initialize(lead)
    @lead = lead
  end

  def calculate
    {
      loan_amount: loan_amount.round(2),
      total_interest_expense: total_interest_expense.round(2),
      estimated_profit: estimated_profit.round(2)
    }
  end

  private

  def max_loan_by_purchase_price
    lead.purchase_price * FUNDABLE_LOAN_PERCENTAGE
  end

  def max_loan_by_arv
    lead.arv * ARV_LOAN_PERCENTAGE
  end

  def loan_amount
    [max_loan_by_purchase_price, max_loan_by_arv].min + lead.repair_budget
  end

  def monthly_interest_rate
    INTEREST_RATE / 12
  end

  def total_interest_expense
    loan_amount * monthly_interest_rate * lead.loan_term
  end

  def estimated_profit
    lead.arv - loan_amount - total_interest_expense
  end
end
