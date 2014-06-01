class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.text :feed_title
      t.integer :feed_id
      t.text :title
      t.text :url
      #t.string :summary
      t.text :summary
      t.timestamp :published_at

      t.timestamps
    end
  end
end
