class PointsController < ApplicationController
  before_filter :authenticate_user!, :except => [:visit]
  # GET /points
  # GET /points.xml
  def index
    @points = current_user.points
    @points = @points.sort {|x,y| y.visit_number <=> x.visit_number } if params[:sort]
  end

  def show
    @point = current_user.points.where(:id => params[:id]).first
  end

  def new
    @point = current_user.points.build
  end

  def edit
    @point = current_user.points.where(:id => params[:id]).first
  end

  def create
    @point = current_user.points.build(params[:point])
    if @point.save
      redirect_to(:action => :index)
    else
      render :action => "new"
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

end
