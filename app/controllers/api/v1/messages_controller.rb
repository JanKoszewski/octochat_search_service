class Api::V1::MessagesController < ApplicationController
  respond_to :json

  def index
    @messages = Message.search(params)
    if @messages.results.size > 0
      render :json => { :messages => @messages.results }
    else
      render :json => {:error => "Messages not found"}, :status => :not_acceptable
    end
  end

  def show
    message = Message.where(:id => params[:id]).first
    if message
      respond_with ({ :content => message.content })
    else
      render :json => {:error => "Message not found"}, :status => :not_acceptable
    end
  end
end
