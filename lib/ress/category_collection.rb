module Ress

  class CategoryCollection

    attr_reader :canonical_version, :alternate_versions

    def initialize
      @alternate_versions = []
      @canonical_version  = CanonicalVersion.new
    end

    def set_canonical(options = {})
      @canonical_version = CanonicalVersion.new(options)
    end

    def add_alternate(options)
      category = AlternateVersion.new(options.delete(:name), options.delete(:media_type), options)
      categories << category
    end

    private

      def categories
        @alternate_versions
      end

  end

end