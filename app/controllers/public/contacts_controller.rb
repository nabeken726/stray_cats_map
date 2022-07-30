class Public::ContactsController < ApplicationController

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      # メールを送信するための記述
      ContactMailer.contact_mail(@contact, current_user).deliver
      flash[:notice] = 'お問い合わせ内容を送信しました。'
      redirect_to root_path
    else
      flash[:alert] =  'お問合せ内容を送信できませんでした。'
      render :new
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :content)
  end
end