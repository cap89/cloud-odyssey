class CloudsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_cloud, only: [:show, :edit, :update, :destroy, :accept, :reject]

  def index
    @clouds = Cloud.all
  end

  def show
    @booking = Booking.new

#    @clouds = Cloud.all
#    @markers = @clouds.geocoded.map do |cloud|
#       {
#         lat: cloud.latitude,
#         lng: cloud.longitude
#       }
#     end
  end

  def new
    @cloud = Cloud.new
  end

  def create
    @cloud = Cloud.new(cloud_params)
    @cloud.user = current_user

    if @cloud.save
      redirect_to cloud_path(@cloud), notice: 'Cloud was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @cloud.update(cloud_params)
      redirect_to cloud_path(@cloud), notice: 'Cloud was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @cloud.destroy
    redirect_to clouds_path, notice: 'Cloud was successfully destroyed.'
  end

  def accept
    @booking.update(status: :accepted)
    redirect_to user_profile_path, notice: 'Booking accepted.'
  end

  def reject
    @booking.update(status: :rejected)
    redirect_to user_profile_path, notice: 'Booking rejected.'
  end

  private

  def set_cloud
    @cloud = Cloud.find(params[:id])
  end

  def cloud_params
    params.require(:cloud).permit(:name, :category, :description, :address, :picture_url, :latitude, :longitude, :available_from, :available_until)
  end
end
