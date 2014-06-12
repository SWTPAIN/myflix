class CreateTableRelationships < ActiveRecord::Migration
  def change
    create_table :table_relationships do |t|
      t.integer :leader_id, :follower_id
      t.timestamp
    end
  end
end
