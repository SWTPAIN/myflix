class ChangeContentToText < ActiveRecord::Migration
  def change
    remove_column :reviews, :content, :string
    add_column :reviews, :content, :text
  end
end
