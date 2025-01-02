class CreateSections < ActiveRecord::Migration[7.2]
  def change
    create_table :sections do |t|
      t.references :teacher, null: false, foreign_key: true
      t.references :subject, null: false, foreign_key: true
      t.references :classroom, null: false, foreign_key: true
      t.time :start_time
      t.time :end_time
      t.string :days, array: true, default: []

      t.timestamps
    end
  end
end
