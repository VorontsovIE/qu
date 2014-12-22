class QuestionDecorator < Draper::Decorator
  delegate_all
  decorates_association :answers
  decorates_association :game
  decorates_association :user_answers

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  def game_title
    object.game ? object.game.title : 'Не прикреплен ни к одной игре'
  end

  def game_link
    object.game ? h.link_to(object.game.title, object.game) : 'Не прикреплен ни к одной игре'
  end

  def short_text(length: 140)
    h.truncate(object.question_text, length: length)
  end

  def enumerated_short_text(length: 140)
    "#{object.position}. #{short_text(length: length)}".html_safe
  end

  def certain_user_answers(user)
    object.certain_user_answers(user).decorate
  end

end
