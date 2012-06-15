class Message < ActiveRecord::Base
  attr_accessible :content, :room_id, :author_id, :provider, :branch, :actual_created_at, :foo_text

  belongs_to :user

  include Tire::Model::Search
  include Tire::Model::Callbacks
      

  def self.search(params)
    tire.search(load: true) do |s|
      s.query { string params[:query], default_operator: "AND" } if params[:query].present?
      s.sort { by :created_at, "desc" } if params[:query].blank?
    end
  end

  def self.test_search(params)
    tire.search(load: true) do
      query do
        string params[:query], default_operator: "AND"
        # filtered do
        # filtered do
        #   query { string params[:query], default_operator: "AND" } if params[:query].present?
        #   filter :or, { :terms => { :author_id => params[:author] },
        #               { :terms => { :room_id => params[:room] },
        #               { :terms => { :branch => params[:branch] }
        # end
      end
    end
  end

  # def self.search(params)
  #   tire.search(load: true) do |s|
  #     s.query { string params[:query], default_operator: "AND" } if params[:query].present?
  #     s.filter :terms, :author_id => params[:author] if params[:author].present?
  #     s.filter :terms, :room_id => params[:room] if params[:room].present?
  #     s.filter :terms, :branch => params[:branch] if params[:branch].present?
  #     s.sort { by :created_at, "desc" } if params[:query].blank?
  #   end
  # end
  
end
