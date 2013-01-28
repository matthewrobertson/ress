module Ress

  module ViewHelpers

    def ress_link_tags
      path = Ress.categories.base_host_name(request.host_with_port)
      path = "#{path}#{request.fullpath}"
      if canonical_request?
        Ress.categories.canonical_version.link_tag(request.protocol, path, self)
      else
        Ress.categories.map do |category|
          category.link_tag(request.protocol, path, self)
        end.join.html_safe
      end

    end

  end

end

ActionView::Base.send :include, Ress::ViewHelpers