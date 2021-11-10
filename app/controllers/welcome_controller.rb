class WelcomeController < ApplicationController
  def index
    #cookies[:curso] = "Curso de Ruby On Rails"
    session[:curso] = "Paulo Castrp"
  end
end
