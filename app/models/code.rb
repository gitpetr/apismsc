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

class Code < ApplicationRecord
  scope :ordered, -> { order('id ASC') }
  scope :uid_like, -> (start_uid) { where('uid LIKE ?', "#{start_uid}%") }

  validates_presence_of :uid, :url
  validates_uniqueness_of :uid, :url

  def do_hash
    return "" if new_record?
    result = {
        uid: uid,
        url: url
    }

    service = ::UidService.parse(uid)

    result[:color_uid] = service.color.to_i
    color = Color.where(uid: service.color).first
    if color
      result[:color_hex_code] = color.hex_code
      result[:color_name] = color.name
    end

    result[:icon_first_uid] = service.icon_first.to_i
    icon = Icon.where(uid: service.icon_first).first
    result[:color_name] = icon.name if icon

    result[:icon_second_uid] = service.icon_second.to_i
    icon = Icon.where(uid: service.icon_second).first
    result[:color_name] = icon.name if icon

    result[:number_uid] = service.number.to_i

    result
  end
end
