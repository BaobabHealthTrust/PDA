json.extract! document, :id, :couchdb_id, :group_id, :date_added, :group_id2, :title, :content, :created_at, :updated_at
json.url document_url(document, format: :json)