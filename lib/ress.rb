require "ress/version"
require "ress/device_category"
require "ress/category_collection"

module Ress
  extend self

  def categories
    @categories ||= CategoryCollection.new
  end

  def configure
    yield(categories)
  end

end
