class CreateSubscribeMembers < ActiveRecord::Migration[5.0]
  def change
    create_table :subscribe_members do |t|
      t.references :subscribers_list, foreign_key: true
      t.hstore :data

      t.timestamps
    end
  end
end
