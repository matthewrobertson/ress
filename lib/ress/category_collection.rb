module Ress

  class CategoryCollection
    extend Forwardable

    def_delegators :categories, :size, :each, :last

    def initialize
      @categories = []
    end

    def register_category(options)
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
        @categories
      end

  end

end