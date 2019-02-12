# frozen_string_literal: true

module Spree
  class PagesController < StoreController
    rescue_from ActiveRecord::RecordNotFound, with: :render_404

    helper 'spree/blogs/posts'
    helper 'spree/products'

    def show
      @page = Spree::Page.joins(:translations).by_store(current_store).visible.find_by_path(request.path)
      raise ActionController::RoutingError, "No route matches [GET] #{request.path}" if @page.nil?
      if @page.root?
        @posts = Spree::Post.live.limit(5)
        render template: 'spree/pages/home'
      end
    end

    private

    def accurate_title
      @page ? (@page.meta_title.present? ? @page.meta_title : @page.title) : nil
    end
  end
end