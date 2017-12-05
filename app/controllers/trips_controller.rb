class TripsController < ApplicationController
  before_action :current_user_must_be_trip_user, :only => [:show, :edit, :update, :destroy]

  def current_user_must_be_trip_user
    trip = Trip.find(params[:id])

    unless current_user == trip.user
      redirect_to :back, :alert => "You are not authorized for that."
    end
  end

  def index
    @q = current_user.trips.ransack(params[:q])
      @trips = @q.result(:distinct => true).includes(:user, :itinerary_items, :activities).page(params[:page]).per(10)

    render("trips/index.html.erb")
  end

  def show
    @itinerary_item = ItineraryItem.new
    @trip = Trip.find(params[:id])

    render("trips/show.html.erb")
  end

  def new
    @trip = Trip.new

    render("trips/new.html.erb")
  end

  def create
    @trip = Trip.new

    @trip.category_id = params[:category_id]
    @trip.activity_id = params[:activity_id]
    @trip.beginning_date = params[:beginning_date]
    @trip.ending_date = params[:ending_date]
    @trip.user_id = params[:user_id]
    @trip.name = params[:name]

    save_status = @trip.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/trips/new", "/create_trip"
        redirect_to("/trips")
      else
        redirect_back(:fallback_location => "/", :notice => "Trip created successfully.")
      end
    else
      render("trips/new.html.erb")
    end
  end

  def edit
    @trip = Trip.find(params[:id])

    render("trips/edit.html.erb")
  end

  def update
    @trip = Trip.find(params[:id])

    @trip.category_id = params[:category_id]
    @trip.activity_id = params[:activity_id]
    @trip.beginning_date = params[:beginning_date]
    @trip.ending_date = params[:ending_date]
    @trip.user_id = params[:user_id]
    @trip.name = params[:name]

    save_status = @trip.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/trips/#{@trip.id}/edit", "/update_trip"
        redirect_to("/trips/#{@trip.id}", :notice => "Trip updated successfully.")
      else
        redirect_back(:fallback_location => "/", :notice => "Trip updated successfully.")
      end
    else
      render("trips/edit.html.erb")
    end
  end

  def destroy
    @trip = Trip.find(params[:id])

    @trip.destroy

    if URI(request.referer).path == "/trips/#{@trip.id}"
      redirect_to("/", :notice => "Trip deleted.")
    else
      redirect_back(:fallback_location => "/", :notice => "Trip deleted.")
    end
  end
end
