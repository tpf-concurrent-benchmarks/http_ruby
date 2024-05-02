class CreateVotes < ActiveRecord::Migration[7.1]
  def change
    create_table :votes, id: false do |t|
      t.integer :option_num
    end
    add_reference :votes, :user, foreign_key: true
    add_reference :votes, :poll, foreign_key: true
    add_index :votes, [:user_id, :poll_id], unique: true
    add_reference :votes, :poll_option
    
  end
end
