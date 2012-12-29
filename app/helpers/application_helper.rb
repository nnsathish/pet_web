module ApplicationHelper

  # Returns content for title tag, like
  # PET: Login
  #
  def app_title
    # Custom title can be set via controller actions.
    return @app_title unless @app_title.blank?

    title = 'PET'
    if params[:action] != 'index'
      title << ": #{params[:action].humanize}"
    end
    title
  end

  def brand_header
    brand = 'PET'
    unless logged_in?
      brand << ' - Your favourite Personal Expense Tracker'
    end
    brand
  end

  def flash_notices
    cnt = "".html_safe
    flash_class = "alert"

    [:notice, :alert].each do |k|
      next unless flash.key?(k)
      flash_class << (k == :alert ? ' alert-error' : ' alert-success')
      cnt << content_tag(:div, flash[k], :class => flash_class)
    end
    cnt
  end

  def nav_links
    nav_items = [
      ['Home', root_path, :home],
      ['Budget', show_budget_path, :budget],
      ['Expenses', '#', :expenses],
      ['Reports', '#', :reports]
    ]

    content = nav_items.collect do |nav_item|
      active_class = (nav_item.last == @current_nav ? 'active' : '')
      content_tag :li, :class => active_class do
        content_tag :a, nav_item.first, :href => nav_item[1]
      end
    end
    content.join.html_safe
  end

  def error_tag(modal, attr, opts={})
    return concat("") if modal.nil?
    tag_opts = opts.reverse_merge(:class => 'text-error')
    err = modal.errors[attr]

    unless err.blank?
      # err can be String or Array
      content_tag :p, [err].flatten.join('<br />'), tag_opts
    end
  end

  def input_with_label(f, colmn, lbl = nil)
    inline_label = lbl || colmn.to_s.humanize
    if colmn.to_s.include?('password')
      f.password_field(colmn, :placeholder => inline_label)
    else
      f.text_field(colmn, :placeholder => inline_label)
    end
  end

  def errors_for(obj)
    errs = obj.errors.collect do |k, v|
      k = '' if k == :base # don't add Base
      msg = k.to_s.humanize + ' ' + v
      content_tag(:p, msg)
    end.join.html_safe
    content_tag(:div, errs, :class => 'alert alert-error') unless errs.blank?
  end
end
