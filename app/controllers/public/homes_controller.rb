class Public::HomesController < ApplicationController
  def top
    @user = current_user
    @top = "_top"
  end
end
