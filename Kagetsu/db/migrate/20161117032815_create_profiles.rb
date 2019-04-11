class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.references :user, index: true, unique: true, foreign_key: true
      t.references :character, index: true, unique: true, foreign_key: true
      t.string :image
      t.string :nickname
      t.date :dob
      t.boolean :is_dob_public
      t.integer :gender
      t.boolean :is_gender_public
      t.text :comment

      t.timestamps null: false
    end
  end
end
