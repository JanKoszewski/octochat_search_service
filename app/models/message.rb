class Message < ActiveRecord::Base
  attr_accessible :content, :room_id, :author_id, :provider, :branch

  belongs_to :user

  include Tire::Model::Search
  include Tire::Model::Callbacks
      

  def self.search(params)
    s = Tire.search 'messages' do
      query do
        string "content:#{params[:query]}"
      end

      filter :terms, :author_id => [params[:author]] if params[:author]
      filter :terms, :room_id => [params[:room]] if params[:room]
      filter :terms, :branch => [params[:branch]] if params[:branch]
    end
    s.results
  end
end