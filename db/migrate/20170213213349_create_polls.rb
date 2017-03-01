class CreatePolls < ActiveRecord::Migration[5.0]
  def change
    create_table :polls do |t|
      t.string :title
      t.integer :yes_votes, :default => 0
      t.integer :no_votes, :default => 0
      t.integer :undefined_votes, :default => 0
      t.integer :organization_id, index: true
      t.timestamps
    end
  end
end
