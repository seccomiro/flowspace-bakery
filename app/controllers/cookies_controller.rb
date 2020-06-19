# frozen_string_literal: true

class CookiesController < ApplicationController
  before_action :authenticate_user!

  def new
    @oven = current_user.ovens.find_by!(id: params[:oven_id])
    if @oven.cookie
      redirect_to @oven, alert: 'A cookie is already in the oven!'
    else
      @cookie = @oven.build_cookie
    end
  end

  def create
    @oven = current_user.ovens.find_by!(id: params[:oven_id])
    @cookie = @oven.create_cookie!(cookie_params)
    redirect_to oven_path(@oven)
  end

  private

  def cookie_params
    result_params = params.require(:cookie).permit(:fillings)
    result_params.delete(:fillings) if result_params[:fillings].empty?
    result_params
  end
end
