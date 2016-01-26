class ItemsController < ApplicationController
  before_action :logged_in_user , except: [:show]
  before_action :set_item, only: [:show]

  def new
    if params[:q]
      response = Amazon::Ecs.item_search(params[:q] , 
                                  :search_index => 'All' , 
                                  :response_group => 'Medium' , 
                                  :country => 'jp')
      @amazon_items = response.items
    end
  end

  def show
    @item_haves_users = @item.have_users
    @item_wants_users = @item.want_users
  end

  def item_image
    @item_image = item.get("LargeImage/URL")
  end

  private
  def set_item
    @item = Item.find(params[:id])
  end
end
