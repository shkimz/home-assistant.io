module Jekyll
  class NoneLinkTag < Liquid::Tag
    def initialize(tag_image, text, token)
      super
      parts = text.split(' ', 2)
      @href = parts[0]
      @title = parts[1]
    end

    def render(context)
      href = Liquid::Template.parse(@href).render context
      title = Liquid::Template.parse(@title).render context
      cls = href == context.registers[:page]["url"] ? "class='active'" : ''
      "<a #{cls} href='#{href}'>#{title}</a>"
    end
  end
end

Liquid::Template.register_tag('none_link', Jekyll::NoneLinkTag)
