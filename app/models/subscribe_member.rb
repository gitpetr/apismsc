class SubscribeMember < ApplicationRecord
  belongs_to :subscribers_list

  def data_with_system_info
    data["_id"] = id
    data["_created_at"] = created_at.to_i
    data
  end
end
