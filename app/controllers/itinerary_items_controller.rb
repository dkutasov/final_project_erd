class ItineraryItemsController < ApplicationController
  def index
    @q = ItineraryItem.ransack(params[:q])
    @itinerary_items = @q.result(:distinct => true).includes(:trip, :activity).page(params[:page]).per(10)
    @location_hash = Gmaps4rails.build_markers(@itinerary_items.where.not(:location_latitude => nil)) do |itinerary_item, marker|
      marker.lat itinerary_item.location_latitude
      marker.lng itinerary_item.location_longitude
      marker.infowindow "<h5><a href='/itinerary_items/#{itinerary_item.id}'>#{itinerary_item.name}</a></h5><small>#{itinerary_item.location_formatted_address}</small>"
    end

    render("itinerary_items/index.html.erb")
  end

  def show
    @itinerary_item = ItineraryItem.find(params[:id])

    render("itinerary_items/show.html.erb")
  end

  def new
    @itinerary_item = ItineraryItem.new

    render("itinerary_items/new.html.erb")
  end

  def create
    @itinerary_item = ItineraryItem.new

    @itinerary_item.activity_id = params[:activity_id]
    @itinerary_item.trip_id = params[:trip_id]
    @itinerary_item.name = params[:name]
    @itinerary_item.location = params[:location]

    save_status = @itinerary_item.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/itinerary_items/new", "/create_itinerary_item"
        redirect_to("/itinerary_items")
      else
        redirect_back(:fallback_location => "/", :notice => "Itinerary item created successfully.")
      end
    else
      render("itinerary_items/new.html.erb")
    end
  end

  def edit
    @itinerary_item = ItineraryItem.find(params[:id])

    render("itinerary_items/edit.html.erb")
  end

  def update
    @itinerary_item = ItineraryItem.find(params[:id])

    @itinerary_item.activity_id = params[:activity_id]
    @itinerary_item.trip_id = params[:trip_id]
    @itinerary_item.name = params[:name]
    @itinerary_item.location = params[:location]

    save_status = @itinerary_item.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/itinerary_items/#{@itinerary_item.id}/edit", "/update_itinerary_item"
        redirect_to("/itinerary_items/#{@itinerary_item.id}", :notice => "Itinerary item updated successfully.")
      else
        redirect_back(:fallback_location => "/", :notice => "Itinerary item updated successfully.")
      end
    else
      render("itinerary_items/edit.html.erb")
    end
  end

  def destroy
    @itinerary_item = ItineraryItem.find(params[:id])

    @itinerary_item.destroy

    if URI(request.referer).path == "/itinerary_items/#{@itinerary_item.id}"
      redirect_to("/", :notice => "Itinerary item deleted.")
    else
      redirect_back(:fallback_location => "/", :notice => "Itinerary item deleted.")
    end
  end
end
