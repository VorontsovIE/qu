class UserAnswerDecorator < Draper::Decorator
  delegate_all
  decorates_association :user
  decorates_association :question

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  def question_text(length: 140)
    question.short_text(length: length)
  end

  def user_link
    user.user_link
  end

  def answer_colored
    if object.correct?
      h.content_tag :span, "#{object.answer_text} (#{object.mark_score})", class: 'correct-answer'
    else
      h.content_tag :span, "#{object.answer_text}", class: 'incorrect-answer'
    end
  end

end
