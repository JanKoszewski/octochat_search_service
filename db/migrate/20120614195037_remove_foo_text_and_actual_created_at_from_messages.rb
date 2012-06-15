class RemoveFooTextAndActualCreatedAtFromMessages < ActiveRecord::Migration
  def change
    remove_column :messages, :foo_text
    remove_column :messages, :actual_created_at
  end
end
