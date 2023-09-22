class LandingsController < ApplicationController
  before_action :authenticate_login!

  def index; end

  def show; end

  def authenticate_login!
    return unless user_signed_in?

    redirect_to categories_path
  end
end
