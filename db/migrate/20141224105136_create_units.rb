class CreateUnits < ActiveRecord::Migration
  def change
    create_table :units do |t|
      t.string :university_code, null: false
      t.string :code, null: false, key: true, unique: false
      t.string :name, null: false
      t.string :short_name, null: false

      t.timestamps
    end
  end
end
