FactoryBot.define do
  factory :lead do
    address { "123 Main St" }
    loan_term { 12 }
    purchase_price { 100000 }
    repair_budget { 20000 }
    arv { 150000 }
    name { "John Doe" }
    email { "john.doe@example.com" }
    phone { "123-456-7890" }
  end
end
