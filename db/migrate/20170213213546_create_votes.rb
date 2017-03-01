class CreateVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :votes do |t|
      t.integer :kind
      t.integer :voter_id, index: true
      t.integer :poll_id, index: true
      t.timestamps
    end
  end
end
