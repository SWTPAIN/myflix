class CreateTableInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.string :recipient_name, :recipient_email
      t.text :message
      t.integer :inviter_id
      
      t.timestamp
    end
  end
end
