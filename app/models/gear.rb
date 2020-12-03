# == Schema Information
#
# Table name: gears
#
#  id         :integer          not null, primary key
#  condition  :string
#  name       :string
#  photo      :string
#  size       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Gear < ApplicationRecord
  has_one(:rental, { :class_name => "Rental", :foreign_key => "gear_id", :dependent => :nullify })
end
