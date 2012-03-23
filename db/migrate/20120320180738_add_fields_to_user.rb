class AddFieldsToUser < ActiveRecord::Migration
  def up
    add_column :users, :invitation_token, :string
    add_column :users, :invitation_sent_at, :datetime
    add_column :users, :invitation_limit, :integer
    add_column :users, :invited_by_id, :integer
    add_column :users, :invited_by_type, :string
    add_column :users, :practice_id, :integer
    add_index :users, :invitation_token
    change_column :users, :encrypted_password, :string, {:null => true}
  end
  def down
    change_column :users, :encrypted_password, :string, {:null => false}
    remove_column :users, :practice_id
    remove_column :users, :invited_by_type
    remove_column :users, :invited_by_id
    remove_column :users, :invitation_limit
    remove_column :users, :invitation_sent_at
    remove_column :users, :invitation_token
  end
end
