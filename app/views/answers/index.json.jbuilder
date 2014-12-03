json.array!(@answers) do |answer|
  json.extract! answer, :id, :question_id, :answer_text, :mark_score, :answer_group
  json.url answer_url(answer, format: :json)
end
