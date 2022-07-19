class Public::HomesController < ApplicationController
  def top
    @user = current_user
    # top用のbackgroundにするための記述
    @top = "_top"
  end
end
