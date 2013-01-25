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

    private

      def categories
        @categories
      end

  end

end