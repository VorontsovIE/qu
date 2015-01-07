json.array!(@documents) do |document|
  json.extract! document, :id, :file, :question_id
  json.url document_url(document, format: :json)
end
