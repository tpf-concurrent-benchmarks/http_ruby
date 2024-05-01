class CreatePollOptions < ActiveRecord::Migration[7.1]
  def change
    create_table :poll_options do |t|
      t.string :option_text
    end
    add_reference :poll_options, :poll
    add_foreign_key :poll_options, :polls
  end
end
