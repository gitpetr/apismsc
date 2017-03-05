class SubscribersList < ApplicationRecord
  has_many :subscribe_members, -> { order('id DESC') }, dependent: :destroy
end
