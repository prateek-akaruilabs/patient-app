class HomeController < ApplicationController

    skip_before_action :authenticate

    def index
        redirect_to patients_path if current_user
    end
end
