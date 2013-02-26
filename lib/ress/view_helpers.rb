module Ress

  module ViewHelpers

    def ress_annotation_tags
      path = "#{request.host_with_port}#{request.fullpath}"
      html = if canonical_request?
        path.gsub!("#{request.subdomain}.", '') if Ress.replace_canonical_subdomain?
        Ress.alternate_versions.map do |category|
          category.link_tag(request.protocol, path, self)
        end.join
      else
        Ress.canonical_version.link_tag(request.protocol, path, request.subdomain, self)
      end

      # Append the modernizr script tag if need be.
      if Ress.include_modernizr?
        html << self.javascript_include_tag("ress_modernizr_build")
      end

      html.html_safe

    end

  end

end

ActionView::Base.send :include, Ress::ViewHelpers