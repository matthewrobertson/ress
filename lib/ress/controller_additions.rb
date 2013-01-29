module Ress

  # This module is automatically included into all controllers.
  module ControllerAdditions

    def self.included(base)
      base.helper_method :canonical_request?
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

  end
end

if defined? ActionController::Base
  ActionController::Base.class_eval do
    include Ress::ControllerAdditions
  end
end