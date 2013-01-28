module Ress

  class CanonicalVersion

    attr_reader :subdomain

    def initialize(options = {})
      @subdomain = options.fetch(:subdomain, false)
    end

    def matches?(subdomain)
      if self.subdomain
        self.subdomain == subdomain.split('.').first
      else
        subdomain.blank?
      end
    end

    def view_path
      @view_path || default_view_path
    end

    # Create a tag of this format:
    #  `<link rel="canonical" href="http://www.example.com/page-1" >`
    def link_tag(protocol, base_url, view)
      view.tag :link, :rel => 'canonical', :href => href(protocol, base_url)
    end

    private

      def href(protocol, base_url)
        if subdomain
          "#{protocol}#{subdomain}.#{base_url}"
        else
          "#{protocol}#{base_url}"
        end
      end

  end

end