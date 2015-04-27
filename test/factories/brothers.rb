# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  # sequence :email do |n|
  #   "matt#{n}@example.com"
  # end

  factory :user do
    name "Matt Schallert"
    phone_number "+19173093904"
  end
end
