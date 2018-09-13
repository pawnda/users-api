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

require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validations' do
    subject(:user) { build(:user) }

    it { should validate_length_of(:password).is_at_least(4) }
    it { should validate_length_of(:password).is_at_most(72) }
    it { should validate_confirmation_of(:password) }

    it { is_expected.to validate_presence_of(:phone_number) }
    it { is_expected.to validate_uniqueness_of(:phone_number).case_insensitive }
  end
end
