class CreateVotes < ActiveRecord::Migration[7.1]
  def change
    create_table :votes do |t|
      t.string :option_text
    end
    add_reference :votes, :poll_option
    add_foreign_key :votes, :poll_options
  end
end
