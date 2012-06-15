class Api::V1::MessagesController < ApplicationController
  respond_to :json

  def index
    @messages = Message.interesting_search(params)
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

  def create
    body = JSON.parse(params[:body])
    message = Message.new(:content => body["content"],
                          :room_id => body["room_id"],
                          :author_id => body["author_id"],
                          :provider => body["provider"],
                          :branch => body["branch"] )

    if message.save
      respond_with message, :status => :created,
                            :location => api_v1_room_path(message.room_id)
    else
      render :json => {errors: [message.errors]}, :status => :not_acceptable
    end
  end
end
