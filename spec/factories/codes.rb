# == Schema Information
#
# Table name: codes
#
#  id         :integer          not null, primary key
#  uid        :string           default(""), not null
#  url        :string           default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :code do
    uid "MyString"
    url "MyString"
  end
end
