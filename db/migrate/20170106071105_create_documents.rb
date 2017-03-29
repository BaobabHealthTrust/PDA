class CreateDocuments < ActiveRecord::Migration[5.0]
  def change

    drop_table :documents, if_exists: true
    
    create_table :documents do |t|
      t.string :couchdb_id
      t.string :group_id
      t.string :group_id2
      t.datetime :date_added
      t.text :title
      t.text :content
      t.timestamps
    end
  end
end
