class PreferencesController < ApplicationController
  before_action :current_user_must_be_preference_user, :only => [:show, :edit, :update, :destroy]

  def current_user_must_be_preference_user
    preference = Preference.find(params[:id])

    unless current_user == preference.user
      redirect_to :back, :alert => "You are not authorized for that."
    end
  end

  def index
    @q = current_user.preferences.ransack(params[:q])
      @preferences = @q.result(:distinct => true).includes(:user, :category).page(params[:page]).per(10)

    render("preferences/index.html.erb")
  end

  def show
    @preference = Preference.find(params[:id])

    render("preferences/show.html.erb")
  end

  def new
    @preference = Preference.new

    render("preferences/new.html.erb")
  end

  def create
    @preference = Preference.new

    @preference.category_id = params[:category_id]
    @preference.user_id = params[:user_id]
    @preference.name = params[:name]

    save_status = @preference.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/preferences/new", "/create_preference"
        redirect_to("/preferences")
      else
        redirect_back(:fallback_location => "/", :notice => "Preference created successfully.")
      end
    else
      render("preferences/new.html.erb")
    end
  end

  def edit
    @preference = Preference.find(params[:id])

    render("preferences/edit.html.erb")
  end

  def update
    @preference = Preference.find(params[:id])

    @preference.category_id = params[:category_id]
    @preference.user_id = params[:user_id]
    @preference.name = params[:name]

    save_status = @preference.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/preferences/#{@preference.id}/edit", "/update_preference"
        redirect_to("/preferences/#{@preference.id}", :notice => "Preference updated successfully.")
      else
        redirect_back(:fallback_location => "/", :notice => "Preference updated successfully.")
      end
    else
      render("preferences/edit.html.erb")
    end
  end

  def destroy
    @preference = Preference.find(params[:id])

    @preference.destroy

    if URI(request.referer).path == "/preferences/#{@preference.id}"
      redirect_to("/", :notice => "Preference deleted.")
    else
      redirect_back(:fallback_location => "/", :notice => "Preference deleted.")
    end
  end
end
