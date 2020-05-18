class PaymentsController < ApplicationController
    def success
        @user = current_user
        @cart = Cart.where("user_id": @user.id).destroy_all
    end
end