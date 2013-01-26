module Ress

  module ViewHelpers


    def ress_category_tag(category, base_url)
      category.link_tag(request.protocol, base_url, self)
    end

  end

end

ActionView::Base.send :include, Ress::ViewHelpers