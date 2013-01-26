class RemovePollIdFromAnswer < ActiveRecord::Migration
  def up
    remove_column :answers, :poll_id
  end

  def down
    add_column :answers, :poll_id, :integer
  end
end
