class CreateClassrooms < ActiveRecord::Migration[7.2]
  def change
    create_table :classrooms do |t|
      t.string :name

      t.timestamps
    end
  end
end
