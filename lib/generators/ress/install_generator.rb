module Ress
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)

      desc "Creates a Ress initializer for your application."

      def copy_initializer
        template "ress.rb", "config/initializers/ress.rb"
      end

      def show_readme
        readme "README" if behavior == :invoke
      end
    end
  end
end
