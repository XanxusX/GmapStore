class StoresController < ApplicationController
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
    @store = Store.new(store_params)
    if @store.save
      redirect_to stores_path, notice: "Successed!"
    else
      render :new
    end
  end

  def show
    @store = Store.find(params[:id])
    @hash = Gmaps4rails.build_markers(@store) do |store, marker|
      marker.lat store.latitude
      marker.lng store.longitude
      marker.infowindow render_to_string(partial: "/stores/infowindow",locals: { store: store})
    end
  end

  def edit
    @store = Store.find(params[:id])
  end

  def update
    @store = Store.find(params[:id])
    if @store.update(store_params)
      redirect_to store_path(@store), notice: "Updated!"
    else
      render :edit
    end
  end

  def destroy
    @store = Store.find(params[:id])
    @store.destroy
    redirect_to stores_path, alert: "Deleted!"
  end

  private

  def store_params
    params.require(:store).permit(:name,:address,:description,:latitude,:longitude)
  end
end
