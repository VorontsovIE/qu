class GameDecorator < Draper::Decorator
  delegate_all
  decorates_association :questions
  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  def game_link
    h.link_to object.title, object
  end

  def time_from_now
    if !started?
      "До начала игры осталось #{h.distance_of_time_in_words(Time.now, start)}"
    elsif !finished?
      "До окончания игры осталось #{h.distance_of_time_in_words(Time.now, finish)}"
    else
      "Игра окончена"
    end
  end
end
