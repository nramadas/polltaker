class AddTeamIdToPoll < ActiveRecord::Migration
  def change
    add_column :polls, :team_id, :integer
  end
end
