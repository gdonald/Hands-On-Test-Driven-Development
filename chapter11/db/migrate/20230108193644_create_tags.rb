class CreateTags < ActiveRecord::Migration[7.0]
  def change
    create_table :tags do |t|
      t.string :name
      t.integer :page_tags_count

      t.timestamps
    end
    add_index :tags, :name, unique: true
    add_index :tags, :page_tags_count
  end
end
