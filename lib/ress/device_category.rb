module Ress

  class DeviceCategory

    attr_reader :name, :subdomain

    def initialize(name, media_query,  options = {})
      @name        = name
      @media_query = media_query
      @subdomain   = options.fetch(:subdomain, name)
      @view_path   = options.fetch(:view_path, default_view_path)
    end

    def matches?(subdomain)
      self.subdomain == subdomain.split('.').first
    end

    def view_path
      @view_path || default_view_path
    end

    private

      def default_view_path
        File.join('app', "#{name}_views")
      end

  end

end