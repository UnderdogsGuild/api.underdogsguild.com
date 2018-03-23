class CreateForumThreads < ActiveRecord::Migration[5.1]
  def change
    create_table :forum_threads do |t|

      t.timestamps
    end
  end
end
