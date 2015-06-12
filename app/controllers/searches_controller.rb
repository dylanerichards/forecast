class SearchesController < ApplicationController
  before_action :set_search, only: [:show, :edit, :update, :destroy]

  def index
    @searches = Search.all
  end

  def show
    forecast = ForecastIO.forecast(@search.latitude, @search.longitude).daily.data.first(3)
    days = ["Today", "Tomorrow", "Day After Tomorrow"]

    @daily_forecast = days.zip(forecast)
  end

  def new
    @most_recent = Search.all.last(5).reverse

    @search = Search.new
  end

  def edit
  end

  def create
    geocoder = Geocoder.search(params[:search][:name])[0]
    coordinates = geocoder.coordinates

    @search = Search.find_or_create_by(name: params[:search][:name]).tap do |s|
      s.latitude = coordinates[0]
      s.longitude = coordinates[1]
    end

    respond_to do |format|
      if @search.save
        format.html { redirect_to @search, notice: 'Search was successfully created.' }
        format.json { render :show, status: :created, location: @search }
      else
        format.html { render :new }
        format.json { render json: @search.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @search.update(search_params)
        format.html { redirect_to @search, notice: 'Search was successfully updated.' }
        format.json { render :show, status: :ok, location: @search }
      else
        format.html { render :edit }
        format.json { render json: @search.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @search.destroy
    respond_to do |format|
      format.html { redirect_to searches_url, notice: 'Search was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def set_search
    @search = Search.find(params[:id])
  end

  def search_params
    params.require(:search).permit(:name, :latitude, :longitude)
  end
end
