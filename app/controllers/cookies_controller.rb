# frozen_string_literal: true

class CookiesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_oven, only: %i[new create]

  def new
    if @oven.cookies.any?
      redirect_to @oven, alert: 'One or more cookies are already in the oven!'
    else
      @cookie = @oven.cookies.build
    end
  end

  def create
    begin
      quantity = params[:quantity].to_i
    rescue StandardError
      quantity = 0
    end

    if quantity.positive?
      quantity.times do
        @cookie = @oven.cookies.create!(cookie_params)
      end
      redirect_to oven_path(@oven)
    else
      redirect_to new_oven_cookies_path, alert: 'You must enter a valid quantity!'
    end
  end

  private

  def set_oven
    @oven = current_user.ovens.find_by!(id: params[:oven_id])
  end

  def cookie_params
    result_params = params.require(:cookie).permit(:fillings)
    result_params.delete(:fillings) if result_params[:fillings].empty?
    result_params
  end
end
