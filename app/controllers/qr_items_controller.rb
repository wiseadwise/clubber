class QrItemsController < ApplicationController
  before_filter :authenticate_user!, :except => [:visit]

  def item
    @klass = params[:type] ? params[:type].classify.constantize : QrItem
    @item = @klass.find_by_id(params[:id]) || @klass.new 
    @item.user = current_user
    @item.prepare
    if request.post?
      @item.save_properties!(params[params[:type]]) 
      redirect_to qr_items_list_url(:type => params[:type])
      return true
    end
    render :action => :form
  end

  def list
    @klass = params[:type] ? params[:type].classify.constantize : QrItem
    @items = @klass.where(:user_id => current_user.id)
  end

  def visit
    @item = QrItem.find(params[:id])
    @item.increment!(:visit)
    @item.prepare
    case @item.type
      when 'Vcard' 
        then send_data(
          @item.qr_data,
          :filename => 'vcard.vcf', 
          :type => 'text/x-vcard',
          :disposition => 'attachment')
      when 'WebUrl' then redirect_to @item.get_url
      when 'SimpleText' then render :simple_text, :layout => 'mobile'
      when 'SmsMessage' then render :sms_message, :layout => 'mobile'
    end
  end

  def destroy
    item = QrItem.find(params[:id])
    item.destroy
    redirect_to :action => :list, :type => item.type.underscore
  end

end
