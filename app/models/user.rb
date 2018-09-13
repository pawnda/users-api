# == Schema Information
#
# Table name: users
#
#  id           :bigint(8)        not null, primary key
#  name         :string
#  phone_number :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_users_on_phone_number  (phone_number)
#

# app/models/user.rb
class User < ApplicationRecord
  validates :phone_number, presence: true, uniqueness: true
end
