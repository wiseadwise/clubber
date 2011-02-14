class PointsController < ApplicationController
  before_filter :authenticate_user!, :except => [:visit]
  # GET /points
  # GET /points.xml
  def index
    @points = current_user.points
    @points = @points.sort {|x,y| y.visit_number <=> x.visit_number } if params[:sort]

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @points }
    end
  end

  # GET /points/1
  # GET /points/1.xml
  def show
    @point = current_user.points.where(:id => params[:id]).first
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @point }
    end
  end

  def visit
    @point = current_user.points.where(:id => params[:id]).first
    @point.visit! if @point
    @chance = rand(2) > 0
  end

  # GET /points/new
  # GET /points/new.xml
  def new
    @point = current_user.points.build
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @point }
    end
  end

  # GET /points/1/edit
  def edit
    @point = current_user.points.where(:id => params[:id]).first
  end

  # POST /points
  # POST /points.xml
  def create
    @point = current_user.points.build(params[:point])

    respond_to do |format|
      if @point.save
        @point.create_qr_image(request)
        format.html { redirect_to(:action => :index) }
        format.xml  { render :xml => @point, :status => :created, :location => @point }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @point.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /points/1
  # PUT /points/1.xml
  def update
    @point = current_user.points.where(:id => params[:id]).first

    respond_to do |format|
      if @point.update_attributes(params[:point])
        format.html { redirect_to(:action => :index) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @point.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /points/1
  # DELETE /points/1.xml
  def destroy
    @point = current_user.points.where(:id => params[:id]).first
    @point.destroy

    respond_to do |format|
      format.html { redirect_to(points_url) }
      format.xml  { head :ok }
    end
  end
end
