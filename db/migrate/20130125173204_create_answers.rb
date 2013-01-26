class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.integer :option_id
      t.integer :user_id
      t.integer :poll_id

      t.timestamps
    end
  end
end
