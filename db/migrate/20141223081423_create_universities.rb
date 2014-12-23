class CreateUniversities < ActiveRecord::Migration
  def change
    create_table :universities do |t|
      t.string :code,               null: false
      t.string :name,               null: false
      t.string :short_name,         null: false

      t.timestamps
    end

    add_index :universities, :code, unique: true
  end
end
