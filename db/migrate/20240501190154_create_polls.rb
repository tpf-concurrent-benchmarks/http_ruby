class CreatePolls < ActiveRecord::Migration[7.1]
  def change
    create_table :polls do |t|
      t.string :poll_topic
    end
    add_reference :polls, :creator
    add_foreign_key :polls, :users, column: :creator_id
  end
end
