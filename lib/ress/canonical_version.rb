module Ress

  class CanonicalVersion

    def initialize(options = {})
      @subdomain = Ress::Subdomain.create(options.fetch(:subdomain, nil))
    end

    def matches?(req_subdomain)
      subdomain.matches?(req_subdomain)
    end

    # Create a tag of this format:
    #  `<link rel="canonical" href="http://www.example.com/page-1" >`
    def link_tag(protocol, fullpath, req_subdomain, view)

      view.tag :link, :rel => 'canonical', :href => url(protocol, fullpath, req_subdomain)
    end

    def url(protocol, fullpath, req_subdomain)
      subdomain.url(protocol, fullpath, req_subdomain)
    end

    private

      def subdomain
        @subdomain
      end

  end

end