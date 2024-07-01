module LeadsHelper
  def form_steps
    [
      {
        title: "Target Property",
        description: "Address, City, State, & Zip for your target property.",
        field: :address,
        field_type: :text_field,
        required: true,
        error_message: "Target Property is required."
      },
      {
        title: "Loan Term",
        description: "How many months do you want the loan for (up to 12)?",
        field: :loan_term,
        field_type: :number_field,
        required: true,
        error_message: "Loan Term is required."
      },
      {
        title: "Purchase Price",
        description: "What are you purchasing the property for? Please include any assignment fee.",
        note: "Our sample term sheet will set a maximum loan-to-cost of 90%.",
        field: :purchase_price,
        field_type: :number_field,
        required: true,
        error_message: "Purchase Price is required."
      },
      {
        title: "Estimated Repair Budget",
        description: "Full budget expected to rehab the property.",
        field: :repair_budget,
        field_type: :number_field,
        required: true,
        error_message: "Estimated Repair Budget is required."
      },
      {
        title: "After Repair Value",
        description: "What do you think the property's market value will be when you complete the rehab?",
        note: "Our sample term sheet will set a maximum loan-to-value of 70%.",
        field: :arv,
        field_type: :number_field,
        required: true,
        error_message: "After Repair Value is required."
      },
      {
        title: "Contact Information",
        description: "Please enter your contact information.",
        fields: [
          {field: :name, field_type: :text_field, required: true, error_message: "Name is required.", placeholder: "Please enter your name"},
          {field: :email, field_type: :email_field, required: true, error_message: "Email is required.", placeholder: "Please enter your email"},
          {field: :phone, field_type: :telephone_field, required: true, error_message: "Phone number is required.", placeholder: "Please enter your phone number"}
        ]
      }
    ]
  end

  def render_form_field(form, field_data)
    form.send(field_data[:field_type], field_data[:field],
      placeholder: field_data[:placeholder] || "Type your answer here...",
      class: "pt-3 pb-2 block w-full px-0 mt-0 bg-transparent border-0 border-b border-gray-400 appearance-none focus:outline-none focus:ring-0 focus:border-black focus:border-b-2",
      required: field_data[:required],
      data: {multi_step_form_target: "input"})
  end
end
