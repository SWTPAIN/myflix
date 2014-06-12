class RenameRelationships < ActiveRecord::Migration
  def change
    rename_table :table_relationships, :relationships
  end
end
