class CreateSectionStudents < ActiveRecord::Migration[7.2]
  def change
    create_table :sections_students, id: false do |t|
      t.references :section, null: false, foreign_key: true
      t.references :student, null: false, foreign_key: true

      t.timestamps
    end

    add_index :sections_students, [ :section_id, :student_id ], unique: true
  end
end
