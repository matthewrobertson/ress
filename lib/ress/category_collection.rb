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
      version = AlternateVersion.new(options.delete(:name), options.delete(:media_type), options)
      alternate_versions << version
    end

  end

end