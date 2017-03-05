class CreateSubscribersLists < ActiveRecord::Migration[5.0]
  def change
    create_table :subscribers_lists do |t|
      t.string :uid
      t.string :name

      t.timestamps
    end
  end
end
