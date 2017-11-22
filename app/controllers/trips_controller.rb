class TripsController < ApplicationController
  def index
    @trips = Trip.all

    render("trips/index.html.erb")
  end

  def show
    @trip = Trip.find(params[:id])

    render("trips/show.html.erb")
  end

  def new
    @trip = Trip.new

    render("trips/new.html.erb")
  end

  def create
    @trip = Trip.new

    @trip.length = params[:length]

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

    @trip.length = params[:length]

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
