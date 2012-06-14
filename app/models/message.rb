class Message < ActiveRecord::Base
  attr_accessible :content, :room_id, :author_id, :provider, :branch, :actual_created_at, :foo_text

  belongs_to :user

  include Tire::Model::Search
  include Tire::Model::Callbacks

  def self.search(params)
    tire.search(load: true) do |s|
      s.query { string params[:query], default_operator: "AND" } if params[:query].present?
      s.filter :range, created_at: {lte: Time.zone.now}
      s.sort { by :created_at, "desc" } if params[:query].blank?
    end
  end
end
