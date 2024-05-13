class CreatePolls < ActiveRecord::Migration[7.1]
  def change
    create_table :polls do |t|
      t.string :title
      t.references :creator, null: false, foreign_key: {to_table: :users}
    end
  end
end
