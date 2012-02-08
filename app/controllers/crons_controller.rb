class CronsController < ApplicationController

  def index
    #Values for filter
    Suite
    @projects     = Project.all
    @users        = User.all   
    @project_id   = params[:project_id] = (params[:filter] && params[:filter][:project_id])? params[:filter][:project_id].to_i : params[:project_id].to_i
    #Suites
    #One project selected
    if @project_id != 0 
      #Read suites ids from cache
      suites_ids = Rails.cache.read("project_suites_#{@project_id}")
      suites_ids = Project.find(@project_id).suite_ids if !suites_ids
      @suites    = Suite.find(suites_ids)
    end
  
    #TODO: in model
    number_per_page=10
    number_per_page= params[:filter][:paginate].to_i if params[:filter] && params[:filter].include?(:paginate)
    @crons = Cron.all.paginate :page => params[:page], :per_page => number_per_page
  end
  
  def create
    Cron.regenerate
    redirect_to crons_path
  end

  def destroy
    Cron.remove(params[:id])
    redirect_to crons_path(:filter=>params[:filter])
  end

end
