class CreateCodes < ActiveRecord::Migration[5.0]
  def change
    create_table :codes do |t|
      t.string :uid, default: '', null: false
      t.string :url, default: '', null: false

      t.timestamps
    end
  end
end
