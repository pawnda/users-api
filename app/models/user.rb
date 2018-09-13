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

# app/models/user.rb
class User < ApplicationRecord
  has_secure_password

  validates_length_of :password, minimum: 4, maximum: 72
  validates_confirmation_of :password, allow_nil: true, allow_blank: false

  validates :phone_number, presence: true, uniqueness: true

  def self.from_token_request(request)
    phone_number = request.params['auth'] && request.params['auth']['phone_number']
    find_by phone_number: phone_number
  end
end
