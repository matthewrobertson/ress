module Ress

  module ViewHelpers

    def ress_annotation_tags(options={})
      options = { :fullpath => nil }.merge(options)
      fullpath = options[:fullpath]
      fullpath ||= request.fullpath

      path = "#{request.host_with_port}#{fullpath}"
      html = if canonical_request?
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