class Machine::Pfm1Controller < ApplicationController




  def index
  end



  def srv_from_plu

    protect_from_forgery with: :null_session

    render nothing: true

  end
end




