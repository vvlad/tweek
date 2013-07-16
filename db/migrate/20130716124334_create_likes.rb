class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.belongs_to :movie
      t.belongs_to :user

      t.timestamps
    end
    add_index :likes, :movie_id
    add_index :likes, :user_id
  end
end
