class CreateTakeTimes < ActiveRecord::Migration[7.0]
  def change
    create_table :take_times do |t|
      t.references :drug, null: false, foreign_key: true
      t.integer :take_time

      t.timestamps
    end
  end
end
