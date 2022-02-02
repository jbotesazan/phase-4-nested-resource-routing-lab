class ItemsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  def index
    if params[:user_id]
      user = User.find(params[:user_id])
      items = user.items
    else
      items = Item.all
    end
    render json: items, include: :user, status: :ok
  end

  def show
    item = Item.find(params[:id])
    render json: item, status: :ok
  end

  def create
      user = User.find(params[:user_id])
      render json: user.items.create(item_params), status: :created
  end

  private

  def item_params
    params.permit(:name, :description, :price)
  end

  def render_not_found_response
    render json: { error: "Not found" }, status: :not_found
  end

end
