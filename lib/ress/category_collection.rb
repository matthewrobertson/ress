module Ress

  class CategoryCollection
    extend Forwardable

    def_delegators :categories, :size, :each, :last, :map

    attr_reader :canonical_version

    def initialize
      @alternate_versions = []
      @canonical_version  = CanonicalVersion.new
    end

    def set_cannonical(options = {})
      @canonical_version = CanonicalVersion.new(options)
    end

    def add_alternate(options)
      category = DeviceCategory.new(options.delete(:name), options.delete(:media_type), options)
      categories << category
    end

    def base_host_name(host_with_port)
      if categories.any? { |cat| cat.matches?(host_with_port) }
        host_with_port.gsub(/^[^\.]+\./, '')
      else
        host_with_port
      end
    end

    private

      def categories
        @alternate_versions
      end

  end

end