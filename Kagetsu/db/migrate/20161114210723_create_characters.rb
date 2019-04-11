class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters do |t|
      t.string :image
      t.string :name
      t.string :skill
	  t.text :biography
      t.text :psycological
      t.integer :physical
      t.integer :magical
      t.integer :special
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
