class AddTokenToInvites < ActiveRecord::Migration[5.0]
  def change
    add_column :invites, :token, :string
  end
end
