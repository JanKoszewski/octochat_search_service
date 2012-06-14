class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :content
      t.integer :room_id
      t.string :author_id
      t.string :provider
      t.string :branch
      t.datetime :actual_created_at
      t.string :foo_text

      t.timestamps
    end
  end
end
