class CreateMedicationChecks < ActiveRecord::Migration[7.0]
  def change
    create_table :medication_checks do |t|
      t.references :drug, null: false, foreign_key: true
      t.references :take_time, null: false, foreign_key: true
      t.boolean :check
      t.date :check_time

      t.timestamps
    end
  end
end
