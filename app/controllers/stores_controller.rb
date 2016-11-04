class StoresController < ApplicationController
  before_action :authenticate_user!, except: [:index,:show]

  def index
    @stores = Store.all
    @hash = Gmaps4rails.build_markers(@stores) do |store, marker|
      marker.lat store.latitude
      marker.lng store.longitude
      marker.infowindow render_to_string(partial: "/stores/infowindow",locals: { store: store})
    end
  end

  def new
    @store = Store.new
  end

  def create
    @store = current_user.stores.new(store_params)
    if @store.save
      redirect_to stores_path, notice: "Successed!"
    else
      render :new
    end
  end

  def show
    @store = Store.find(params[:id])
    @reviews = @store.reviews
    @hash = Gmaps4rails.build_markers(@store) do |store, marker|
      marker.lat store.latitude
      marker.lng store.longitude
      marker.infowindow render_to_string(partial: "/stores/infowindow",locals: { store: store})
    end
  end

  def edit
    @store = current_user.stores.find(params[:id])
  end

  def update
    @store = current_user.stores.find(params[:id])
    if @store.update(store_params)
      redirect_to store_path(@store), notice: "Updated!"
    else
      render :edit
    end
  end

  def destroy
    @store = current_user.stores.find(params[:id])
    @store.destroy
    redirect_to stores_path, alert: "Deleted!"
  end

  private

  def store_params
    params.require(:store).permit(:name,:address,:description,:latitude,:longitude)
  end
end
