class CreateDrugs < ActiveRecord::Migration[7.0]
  def change
    create_table :drugs do |t|
      t.references :user, null: false, foreign_key: true
      t.string :hospital_name
      t.string :drug_name
      t.integer :number_of_tablets
      t.string :image_url
      t.date :start_time
      t.date :end_time

      t.timestamps
    end
  end
end
