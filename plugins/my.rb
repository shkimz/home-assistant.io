require 'uri'

module Jekyll
  module HomeAssistant
    class My < Liquid::Tag

      def initialize(tag_name, args, tokens)
        super
        if args.strip =~ SYNTAX
          @redirect = Regexp.last_match(1).downcase
          @options = Regexp.last_match(2)
        else
          raise SyntaxError, <<~MSG
            Syntax error in tag 'my' while parsing the following options:

            #{args}

            Valid syntax:
              {% my <redirect> [title="Link name"] [badge] [icon[="icon-puzzle-piece"]] [addon="core_ssh"] [blueprint_url="http://example.com/blueprint.yaml"] [domain="hue"] [brand="philips"] [service="light.turn_on"] %}
          MSG
        end
      end

      def render(context)
        # We parse on render, as we now have context
        options = parse_options(@options, context)

        # Base URI
        uri =  URI.join("https://my.home-assistant.io/redirect/", @redirect)

        # Build query string
        query = []
        query += [["addon", options[:addon]]] if options.include? :addon
        query += [["service", options[:service]]] if options.include? :service
        unless query.empty?
            uri.query = URI.encode_www_form(query)
        end

        if options[:badge]
          raise ArgumentError, "Badges cannot have custom titles" if options[:title]
          "<a href='#{uri}' class='my badge' target='_blank'>"\
          "<img src='https://my.home-assistant.io/badges/#{@redirect}.svg' />"\
          "</a>"
        else
          title = @redirect.gsub(/_/, ' ').titlecase
          icon = ""

          if options[:title]
            # Custom title
            title = options[:title]
          elsif @redirect == "developer_call_service"
            
            title = "`#{options[:service]}`" if options.include? :service
          elsif DEFAULT_TITLES.include?(@redirect)
            # Lookup defaults
            title = DEFAULT_TITLES[@redirect]
          end


          "#{icon}<a href='#{uri}' class='my' target='_blank'>#{title}</a>"
        end
      end

      private

      SYNTAX = %r!^([a-z_]+)((\s+\w+(=([\w\.]+?|".+?"))?)*)$!.freeze
      OPTIONS_REGEX = %r!(?:\w="[^"]*"|\w=[\w\.]+|\w)+!.freez
      DEFAULT_ICONS = {
        "config_flow_start" => "icon-plus-sign",
        "config" => "icon-cog",
      }

      # Default title used for in-line text
      DEFAULT_TITLES = 
      def parse_options(output,  context)
        options = {}
        return options if output.empty?
        # Split along 3 possible forms: key="value", key=value, or just key
        input.scan(OPTIONS_REGEX) do |opt|
          key, value = opt.split("=")
          if !value.nil?
            if value&.include?('"')
              value.delete!('"')
            else
              value = context[value]
            end
          end
          options[key.to_sym] = value || true
        end
        options
      end
    end
  end
end

Liquid::Template.register_tag('my', Jekyll::HomeAssistant::My)
