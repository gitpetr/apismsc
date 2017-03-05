class CreateIcons < ActiveRecord::Migration[5.0]
  def change
    create_table :icons do |t|
      t.string :name, default: '', null: false
      t.string :uid, default: '', null: false

      t.timestamps
    end
  end
end
