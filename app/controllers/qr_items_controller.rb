class QrItemsController < ApplicationController
  before_filter :authenticate_user!

  def item
    klass = params[:type].classify.constantize
    @item = klass.find_by_id(params[:id]) || klass.new 
    @item.user = current_user
    @item.prepare
    @item.save_properties!(params[params[:type]]) if request.post?
    render :action => :form
  end

  def list
    klass = params[:type] ? params[:type].classify.constantize : QrItem
    @items = klass.where(:user_id => current_user.id)
  end

  def visit

  end

end
