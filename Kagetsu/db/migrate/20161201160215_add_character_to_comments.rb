class AddCharacterToComments < ActiveRecord::Migration
  def change
    add_reference :comments, :character, index: true, foreign_key: true
  end
end
