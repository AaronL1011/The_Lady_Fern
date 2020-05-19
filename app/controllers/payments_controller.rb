class PaymentsController < ApplicationController
  before_action :authenticate_user!

  # Destroy user cart on successful purchase, render success page.
  def success
    @user = current_user
    @cart = Cart.where("user_id": @user.id).destroy_all
  end
end