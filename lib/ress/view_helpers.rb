module Ress

  module ViewHelpers

    # Create a tag of this format:
    #  `<link rel="alternate" href="http://foo.com" id="desktop" media="only screen and (touch-enabled: 0)">`
    def ress_category_tag(category, base_url)
      href = "#{request.protocol}#{category.add_subdomain(base_url)}"
      tag :link, :rel => 'alternate', :href => href, :id => category.id, :media => category.media_query
    end

    def ress_link_tags
      Ress.categories.base_host_name(request.host_with_port)
      request.fullpath
      Ress.categories.each do |category|
        ress_category_tag(category)
      end
    end

  end

end

ActionView::Base.send :include, Ress::ViewHelpers