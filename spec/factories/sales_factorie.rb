# == Schema Information
#
# Table name: sales
#
#  id          :integer          not null, primary key
#  customer    :string
#  description :string
#  unit_price  :decimal(12, 2)
#  amount      :integer
#  address     :string
#  supplier    :string
#  upload_id   :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryGirl.define do
  factory :sale do
    customer "João da Silva"
    description "10% OFF VPS Hosting 512mb RAM"
    unit_price 9.99
    amount 1
    address "Rua Agostinho de Paiva, 32, São Paulo - SP"
    supplier "Cloud at Home LLC"
  end
end
