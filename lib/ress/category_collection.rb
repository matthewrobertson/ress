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
      version = AlternateVersion.new(options.delete(:name), options.delete(:media), options)
      define_helper_method(version) if defined? ActionController::Base
      alternate_versions << version
    end

    private

      def define_helper_method(version)
        method_name = "#{version.name}_request?".to_sym
        ActionController::Base.send(:define_method, method_name) do
          version.matches?(request.subdomain)
        end
        ActionController::Base.helper_method(method_name)
      end

  end

end