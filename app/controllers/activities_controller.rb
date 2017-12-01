class ActivitiesController < ApplicationController
  before_action :current_user_must_be_activity_user, :only => [:edit, :update, :destroy]

  def current_user_must_be_activity_user
    activity = Activity.find(params[:id])

    unless current_user == activity.user
      redirect_to :back, :alert => "You are not authorized for that."
    end
  end

  def index
    @q = Activity.ransack(params[:q])
    @activities = @q.result(:distinct => true).includes(:user, :trip, :category).page(params[:page]).per(10)
    @location_hash = Gmaps4rails.build_markers(@activities.where.not(:location_latitude => nil)) do |activity, marker|
      marker.lat activity.location_latitude
      marker.lng activity.location_longitude
      marker.infowindow "<h5><a href='/activities/#{activity.id}'>#{activity.created_at}</a></h5><small>#{activity.location_formatted_address}</small>"
    end

    render("activities/index.html.erb")
  end

  def show
    @activity = Activity.find(params[:id])

    render("activities/show.html.erb")
  end

  def new
    @activity = Activity.new

    render("activities/new.html.erb")
  end

  def create
    @activity = Activity.new

    @activity.category_id = params[:category_id]
    @activity.trip_id = params[:trip_id]
    @activity.name = params[:name]
    @activity.location = params[:location]
    @activity.user_id = params[:user_id]

    save_status = @activity.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/activities/new", "/create_activity"
        redirect_to("/activities")
      else
        redirect_back(:fallback_location => "/", :notice => "Activity created successfully.")
      end
    else
      render("activities/new.html.erb")
    end
  end

  def edit
    @activity = Activity.find(params[:id])

    render("activities/edit.html.erb")
  end

  def update
    @activity = Activity.find(params[:id])

    @activity.category_id = params[:category_id]
    @activity.trip_id = params[:trip_id]
    @activity.name = params[:name]
    @activity.location = params[:location]
    @activity.user_id = params[:user_id]

    save_status = @activity.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/activities/#{@activity.id}/edit", "/update_activity"
        redirect_to("/activities/#{@activity.id}", :notice => "Activity updated successfully.")
      else
        redirect_back(:fallback_location => "/", :notice => "Activity updated successfully.")
      end
    else
      render("activities/edit.html.erb")
    end
  end

  def destroy
    @activity = Activity.find(params[:id])

    @activity.destroy

    if URI(request.referer).path == "/activities/#{@activity.id}"
      redirect_to("/", :notice => "Activity deleted.")
    else
      redirect_back(:fallback_location => "/", :notice => "Activity deleted.")
    end
  end
end
