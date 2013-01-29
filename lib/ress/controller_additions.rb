module Ress

  # This module is automatically included into all controllers.
  module ControllerAdditions
    module ClassMethods
      # class methods go here
    end

    def self.included(base)
      base.extend ClassMethods
      base.helper_method :canonical_request?
      base.helper_method :force_canonical_url
      base.before_filter :prepend_category_view_path
    end

    def prepend_category_view_path
      Ress.alternate_versions.each do |cat|
        prepend_view_path(cat.view_path) if cat.matches?(request.subdomain)
      end
    end

    def canonical_request?
      Ress.canonical_version.matches?(request.subdomain)
    end

    def force_canonical_url
      path = "#{request.host_with_port}#{request.fullpath}"
      url = Ress.canonical_version.url(request.protocol, path, request.subdomain)
      sep = url.include?('?') ? '&' : '?'

      "#{url}#{sep}force=1"
    end

  end
end

if defined? ActionController::Base
  ActionController::Base.class_eval do
    include Ress::ControllerAdditions
  end
end