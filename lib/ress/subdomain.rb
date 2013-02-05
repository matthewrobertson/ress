module Ress

  class Subdomain

    # this class is a factory, don't instantiate it directly
    private_class_method :new

    def self.create(subdomain)
      case subdomain
      when String
        StringSubdomain.new(subdomain)
      when Regexp
        RegexpSubdomain.new(subdomain)
      else
        NilSubdomain.new
      end
    end

    class NilSubdomain
      def matches?(subdomain)
        subdomain.empty?
      end

      def url(protocol, fullpath, subdomain)
        fullpath = fullpath[(subdomain.length + 1)..-1] unless subdomain.empty?
        "#{protocol}#{fullpath}"
      end
    end

    class StringSubdomain

      attr_reader :subdomain

      def initialize(subdomain)
        @subdomain = subdomain
      end

      def matches?(subdomain)
        self.subdomain == subdomain
      end

      def url(protocol, fullpath, subdomain)
        fullpath = fullpath[(subdomain.length + 1)..-1] unless subdomain.empty?
        "#{protocol}#{self.subdomain}.#{fullpath}"
      end

    end

    # The main inspiration for this class is to match xip.io
    # subdomains for many devs working in development mode with
    # the same configuration.
    class RegexpSubdomain

      attr_reader :subdomain

      def initialize(subdomain)
        @subdomain = subdomain
      end

      def matches?(subdomain)
        self.subdomain =~ subdomain
      end

      def url(protocol, fullpath, subdomain)

        fullpath = fullpath[(subdomain.length + 1)..-1] unless subdomain.empty?
        begin
          if matches?(subdomain)
            if subdomain.empty?
              return "#{protocol}#{fullpath}"
            else
              return "#{protocol}#{subdomain}.#{fullpath}"
            end

          end
          subdomain = subdomain.split('.')[1..-1].join('.')
        end while(!subdomain.empty?)
      end

    end

  end

end
