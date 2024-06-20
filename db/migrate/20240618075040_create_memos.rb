class CreateMemos < ActiveRecord::Migration[7.0]
  def change
    create_table :memos do |t|
      t.bigint :drug_id, null: false, foreign_key: true
      t.text :body
      t.date :create_time, null: false

      t.timestamps
    end
  end
end
