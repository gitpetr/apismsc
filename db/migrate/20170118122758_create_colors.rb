class CreateColors < ActiveRecord::Migration[5.0]
  def change
    create_table :colors do |t|
      t.string :hex_code, default: '', null: false
      t.string :uid, default: '', null: false
      t.string :name, default: '', null: false

      t.timestamps
    end
  end
end
