class CreatePollOptions < ActiveRecord::Migration[7.1]
  def change
    create_table :poll_options, id: false do |t|
      t.integer :option_num
      t.string :option_text
    end
    add_reference :poll_options, :poll, foreign_key: true
    add_index :poll_options, [:poll_id, :option_num], unique: true
  end
end
