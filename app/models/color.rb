# == Schema Information
#
# Table name: colors
#
#  id         :integer          not null, primary key
#  hex_code   :string           default(""), not null
#  uid        :string           default(""), not null
#  name       :string           default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Color < ApplicationRecord
  scope :ordered, -> { order('id ASC') }

  validates_presence_of :hex_code, :uid
  validates_uniqueness_of :hex_code, :uid
end
