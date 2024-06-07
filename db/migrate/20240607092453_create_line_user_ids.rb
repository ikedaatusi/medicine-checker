class CreateLineUserIds < ActiveRecord::Migration[7.0]
  def change
    create_table :line_user_ids do |t|
      t.string :uid, null: false
      t.timestamps
    end

    add_index :line_user_ids, :uid, unique: true
  end
end
