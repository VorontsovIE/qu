module ApplicationHelper

  def admin_only
    yield if current_user && current_user.admin?
    nil
  end

  def player_only
    yield if current_user && current_user.player?
    nil
  end

  def forward_link_icon(path)
    link_to path, class: 'forward-link' do
      content_tag :div, '', class: 'forward-link'
    end
  end

  def add_link_icon(path)
    link_to path, class: 'add-link' do
      content_tag :div, '', class: 'add-link'
    end
  end

  def edit_link_icon(path)
    link_to path, class: 'edit-link' do
      content_tag :div, '', class: 'edit-link'
    end
  end

  def delete_link_icon(path)
    link_to path, class: 'delete-link', method: :delete, data: {confirm: 'Вы уверены, что хотите это удалить?'} do
      content_tag :div, '', class: 'delete-link'
    end
  end

  def backward_link_icon(path)
    link_to path, class: 'backward-link' do
      content_tag :div, '', class: 'backward-link'
    end
  end

  def up_link_icon(path)
    content_tag :div, '', class: 'up-link ajax_post', data: {url: path}
  end

  def down_link_icon(path)
    content_tag :div, '', class: 'down-link ajax_post', data: {url: path}
  end
end
