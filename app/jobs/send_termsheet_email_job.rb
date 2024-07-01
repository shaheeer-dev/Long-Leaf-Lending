class SendTermsheetEmailJob < ApplicationJob
  queue_as :default

  def perform(lead_id, pdf)
    lead = Lead.find(lead_id)
    LeadMailer.termsheet_email(lead, pdf).deliver_later
  end
end
