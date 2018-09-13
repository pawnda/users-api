# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  name            :string
#  password        :string
#  password_digest :string
#  phone_number    :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_phone_number  (phone_number)
#

FactoryBot.define do
  factory :user do
    phone_number { FFaker::PhoneNumber.short_phone_number }
    name { FFaker::Name.name }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
