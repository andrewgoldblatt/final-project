# == Schema Information
#
# Table name: club_members
#
#  id              :integer          not null, primary key
#  email           :string
#  first_name      :string
#  last_name       :string
#  password_digest :string
#  phone_number    :integer
#  rentals_count   :integer
#  year            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class ClubMember < ApplicationRecord
  validates :email, :uniqueness => { :case_sensitive => false }
  validates :email, :presence => true
  has_secure_password
  has_many(:rentals, { :class_name => "Rental", :foreign_key => "member_id", :dependent => :nullify })
end
