class PdfGeneratorService
  LOGO_IMG_PATH = "app/assets/images/longleaf_lending_logo.png"

  attr_reader :lead, :calculations, :pdf, :document_width

  def initialize(lead, calculations)
    @lead = lead
    @calculations = calculations
    @pdf = Prawn::Document.new
    @document_width = @pdf.bounds.width
  end

  def generate
    header
    client_information
    property_details
    loan_calculations
    terms_and_conditions
    pdf.render
  end

  private

  def header
    pdf.image LOGO_IMG_PATH, width: 150, position: :right
    pdf.move_down 20
    pdf.text "Loan Analysis Report", size: 24, style: :bold, align: :center
    pdf.move_down 20
  end

  def client_information
    pdf.move_down 20
    add_section_header("Client Information")

    data = [
      ["Name", "Email", "Phone"],
      [lead.name, lead.email, lead.phone]
    ]

    add_table(data)
  end

  def property_details
    pdf.move_down 20
    add_section_header("Property Details")

    data = [
      ["Address", "Loan Term", "Purchase Price", "Repair Budget", "After Repair Value (ARV)"],
      [lead.address, "#{lead.loan_term} months", "$#{lead.purchase_price}", "$#{lead.repair_budget}", "$#{lead.arv}"]
    ]

    add_table(data)
  end

  def loan_calculations
    pdf.move_down 20
    add_section_header("Loan Calculations")

    data = [
      ["Calculated Loan Amount", "Total Interest Expense", "Estimated Profit"],
      ["$#{calculations[:loan_amount]}", "$#{calculations[:total_interest_expense]}", "$#{calculations[:estimated_profit]}"]
    ]

    add_table(data)
  end

  def terms_and_conditions
    pdf.move_down 30
    add_section_header("Terms and Conditions")

    pdf.text "Please check Longleaf Lending Terms and Conditions here...", size: 12
  end

  def add_section_header(title)
    pdf.text title, size: 18, style: :bold
    pdf.move_down 10
  end

  def add_table(data)
    style_options = {
      width: document_width,
      row_colors: ["ffffff"],
      cell_style: {
        border_width: 1,
        borders: [:bottom],
        border_color: "c9ced5",
        padding: [10, 15]
      }
    }

    pdf.table(data, style_options) do |table|
      table.row(0).background_color = "EDEFF5"
      table.row(1).text_color = "465579"
      table.row(1..-1).padding = [10, 15]
      table.row(1).size = 10
      table.row(0).padding = [7, 15]
    end
  end
end
