class CreateInvites < ActiveRecord::Migration[5.0]
  def change
    create_table :invites do |t|
      t.string :email
      t.integer :head_id, index: true
      t.integer :voter_id, index: true
      t.integer :organization_id, index: true
      t.timestamps
    end
  end
end
