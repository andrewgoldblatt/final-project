# == Schema Information
#
# Table name: rentals
#
#  id             :integer          not null, primary key
#  check_out_date :date
#  checkout_note  :string
#  return_date    :date
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  gear_id        :integer
#  member_id      :integer
#

class Rental < ApplicationRecord
  belongs_to(:gear, { :required => false, :class_name => "Gear", :foreign_key => "gear_id" })
  belongs_to(:member, { :required => false, :class_name => "ClubMember", :foreign_key => "member_id", :counter_cache => true })
end
