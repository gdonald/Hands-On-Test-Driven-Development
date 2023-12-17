class CreatePageTags < ActiveRecord::Migration[7.0]
  def change
    create_table :page_tags do |t|
      t.references :page, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true
      t.timestamps
    end
    add_index :page_tags, %i[page_id tag_id], unique: true
  end
end
