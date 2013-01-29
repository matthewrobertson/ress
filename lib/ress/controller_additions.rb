module Ress

  # This module is automatically included into all controllers.
  module ControllerAdditions

    def self.included(base)
      base.helper_method :canonical_request?
      base.helper_method :force_canonical_url
      base.before_filter :set_force_canonical_cookie
      base.before_filter :prepend_alternate_view_path
    end

    def set_force_canonical_cookie
      if params[:force_canonical]
         cookies[:force_canonical] = 'true'
      end
    end

    def prepend_alternate_view_path
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

      "#{url}#{sep}force_canonical=1"
    end

  end
end

if defined? ActionController::Base
  ActionController::Base.class_eval do
    include Ress::ControllerAdditions
  end
end