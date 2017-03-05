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

require 'rails_helper'

RSpec.describe Color, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
