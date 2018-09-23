class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.references :user, foreign_key: true
      t.references :artwork, foreign_key: true

      t.timestamps
      
      t.index [:user_id, :artwork_id], unique: true
    end
  end
end
