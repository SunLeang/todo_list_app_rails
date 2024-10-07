class ChangeIsCompletedToStatusInTasks < ActiveRecord::Migration[7.2]
  def change
    remove_column :tasks, :is_completed, :boolean
    add_column :tasks, :status, :integer, default: 0, null: false
  end
end
