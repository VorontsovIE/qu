class UserDecorator < Draper::Decorator
  delegate_all
  decorates_association :user_answers

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end
  def user_link
    h.link_to(h.user_path(object), class: 'hover-emphasis user-link') do
      (h.content_tag(:div, '', class: 'user-icon inlined') + object.username)
    end
  end
end
