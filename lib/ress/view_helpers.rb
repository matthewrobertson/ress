module Ress

  module ViewHelpers

    def ress_link_tags
      path = "#{request.host_with_port}#{request.fullpath}"
      if canonical_request?
        Ress.alternate_versions.map do |category|
          category.link_tag(request.protocol, path, self)
        end.join.html_safe
      else
        Ress.canonical_version.link_tag(request.protocol, path, request.subdomain, self)
      end

    end

  end

end

ActionView::Base.send :include, Ress::ViewHelpers