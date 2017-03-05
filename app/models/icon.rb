# == Schema Information
#
# Table name: icons
#
#  id         :integer          not null, primary key
#  name       :string           default(""), not null
#  uid        :string           default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Icon < ApplicationRecord
  scope :ordered, -> { order('id ASC') }

  validates_presence_of :uid, :name
  validates_uniqueness_of :uid, :name
end
