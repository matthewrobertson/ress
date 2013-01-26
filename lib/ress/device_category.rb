module Ress

  class DeviceCategory

    attr_reader :name, :subdomain, :media_query

    def initialize(name, media_query,  options = {})
      @name        = name
      @media_query = media_query
      @subdomain   = options.fetch(:subdomain, name)
      @view_path   = options.fetch(:view_path, default_view_path)
    end

    def matches?(subdomain)
      self.subdomain == subdomain.split('.').first
    end

    def view_path
      @view_path || default_view_path
    end

    # Create a tag of this format:
    #  `<link rel="alternate" href="http://foo.com" id="desktop" media="only screen and (touch-enabled: 0)">`
    def link_tag(protocol, base_url, view)
      view.tag :link, :rel => 'alternate', :href => href(protocol, base_url), :id => id, :media => media_query
    end

    private

      def default_view_path
        File.join('app', "#{name}_views")
      end

      def href(protocol, base_url)
        "#{protocol}#{subdomain}.#{base_url}"
      end

      def id
        name
      end

  end

end