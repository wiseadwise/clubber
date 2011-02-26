class PointsController < ApplicationController
  before_filter :authenticate_user!, :except => [:visit]
  before_filter :set_points, :only => [:index, :create]
  # GET /points
  # GET /points.xml
  def index
    @point  = Point.new 
  end

  def edit
    @point = current_user.points.where(:id => params[:id]).first
  end

  def create
    @point = current_user.points.build(params[:point])
    if @point.save
      redirect_to(:action => :index)
    else
      render :action => "index"
    end
  end

  def update
    @point = current_user.points.where(:id => params[:id]).first
    if @point.update_attributes(params[:point])
      redirect_to(:action => :index)
    else
      render :action => "edit"
    end
  end

  def destroy
    @point = current_user.points.where(:id => params[:id]).first
    @point.destroy
    redirect_to(points_url)
  end

  protected

  def set_points
    @points = current_user.points(true).sort_by(&:address)
  end

end
