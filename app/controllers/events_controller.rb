class EventsController < ApplicationController
  before_filter :authenticate_user!, :except => [:visit_point]
  before_filter :set_event

  def index
    @events = current_user.events.sort_by(&:event_date)
  end

  def show
    @points = Point.all - @event.points
  end

  def new
    @event = current_user.events.build 
  end

  def edit
  end

  def create
    @event = current_user.events.build(params[:event])
    if @event.save
      redirect_to(@event, :notice => 'Event was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    if @event.update_attributes(params[:event])
      redirect_to(@event, :notice => 'Event was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @event.destroy
    redirect_to(events_url)
  end

  def add_point
    event_point = @event.event_points.create(:point_id => params[:points])
    event_point.create_qr_image(:host => request.host, :protocol => request.protocol) if event_point.valid?
    redirect_to :action => :show
  end

  def delete_point
    @event.event_points.destroy(params[:event_point_id])
    redirect_to :action => :show
  end

  def visit_point
    @unique = cookies[:visit] ? false : true
    cookies[:visit] = true
    @event_point = EventPoint.where(:id => params[:event_point_id]).first
    @event_point.visit! if @event_point
    @chance = rand(2) > 0
    render :layout => 'mobile'
  end

  protected

  def set_event
    @event = current_user.events.find(params[:id]) if params[:id]
  end
end
