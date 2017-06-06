require 'redcarpet'

module CommentsHelper
  def comment_markdown(text)
    renderer = Redcarpet::Render::HTML.new(hard_wrap: true, filter_html: true)
    options = {
      autolink: true,
      no_intra_emphasis: true,
      fenced_code_blocks: true,
      lax_html_blocks: true,
      strikethrough: true,
      superscript: true,
      footnotes: false
    }
    Redcarpet::Markdown.new(renderer, options).render(text).html_safe
  end

  def commentables_for(obj)
    render partial: 'comments/list', locals: {obj: obj}
  end
end