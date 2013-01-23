require "ress/version"
require "ress/device_category"

module Ress

  @@categories = []

  def self.register_category(options)
    category = DeviceCategory.new(options.delete(:name), options.delete(:media_type), options)
    @@categories << category
  end

  def self.categories
    @@categories
  end

  def self.configure
    yield(self)
  end
end
