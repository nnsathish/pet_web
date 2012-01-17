module ApplicationHelper

  def input_with_label(f, colmn)
    output = f.label colmn, colmn.to_s.humanize
    if colmn.to_s.include?('password')
      output << f.password_field(colmn)
    else
      output << f.text_field(colmn)
    end
    output << content_tag(:div, '&nbsp;'.html_safe)
  end

  def errors_for(obj)
    errs = obj.errors.collect do |k, v|
      k = '' if k == :base # don't add Base
      msg = k.to_s.humanize + ' ' + v
      content_tag(:li, msg)
    end.join.html_safe
    content_tag(:ul, errs, :id => 'errors') unless errs.blank?
  end
end
