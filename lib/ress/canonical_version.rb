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
        subdomain.empty?
      end
    end

    # Create a tag of this format:
    #  `<link rel="canonical" href="http://www.example.com/page-1" >`
    def link_tag(protocol, fullpath, subdomain, view)
      view.tag :link, :rel => 'canonical', :href => href(protocol, fullpath, subdomain)
    end

    private

      def href(protocol, fullpath, subdomain)
        fullpath = fullpath[(subdomain.length + 1)..-1] unless subdomain.empty?
        if self.subdomain
          "#{protocol}#{self.subdomain}.#{fullpath}"
        else
          "#{protocol}#{fullpath}"
        end
      end

  end

end