class CreatePages < ActiveRecord::Migration[7.0]
  def change
    create_table :pages do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title, null: false
      t.string :slug, null: false
      t.text :summary, null: false
      t.text :content, null: false
      t.boolean :published, null: false, default: false
      t.timestamps
    end
    add_index :pages, :title, unique: true
    add_index :pages, :slug, unique: true
    add_index :pages, :published
    add_index :pages, :created_at
  end
end
