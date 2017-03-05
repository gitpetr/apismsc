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

FactoryGirl.define do
  factory :icon do
    name "MyString"
    uid 1
  end
end
