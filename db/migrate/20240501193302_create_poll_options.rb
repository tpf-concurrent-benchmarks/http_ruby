class CreatePollOptions < ActiveRecord::Migration[7.1]
  def change
    create_table :options, id: false do |t|
      t.integer :option_num
      t.string :option_text
    end
    add_reference :options, :poll, foreign_key: true
    add_index :options, [:poll_id, :option_num], unique: true
  end
end
