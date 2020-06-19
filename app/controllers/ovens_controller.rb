class OvensController < ApplicationController
  before_action :authenticate_user!
  before_action :set_oven, only: %i[show empty]

  def index
    @ovens = current_user.ovens
  end

  def show
  end

  def empty
    if @oven.cookies.any?
      @oven.cookies.each do |cookie|
        cookie.update_attributes!(storage: current_user)
      end
    end
    redirect_to @oven, alert: 'Oven emptied!'
  end

  def set_oven
    @oven = current_user.ovens.find_by!(id: params[:id])
  end
end
