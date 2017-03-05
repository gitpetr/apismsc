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

FactoryGirl.define do
  factory :color do
    hex_code "MyString"
    uid 1
    name "MyString"
  end
end
