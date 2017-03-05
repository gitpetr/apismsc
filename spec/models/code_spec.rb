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

require 'rails_helper'

RSpec.describe Code, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
