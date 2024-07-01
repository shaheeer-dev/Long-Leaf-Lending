class LeadMailer < ApplicationMailer
  def termsheet_email(lead, pdf)
    @lead = lead
    attachments["loan_summary_report.pdf"] = {mime_type: "application/pdf", content: pdf}
    mail(to: @lead.email, subject: "Long Leaf Lending - Your Loan Termsheet")
  end
end
