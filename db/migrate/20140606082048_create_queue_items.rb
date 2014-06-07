class CreateQueueItems < ActiveRecord::Migration
  def change
    create_table :queue_items do |t|
      t.integer :position
      t.integer :user_id, :video_id
      t.timestamps
    end
  end
end
