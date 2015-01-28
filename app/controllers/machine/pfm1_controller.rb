class Machine::Pfm1Controller < ApplicationController

  skip_before_filter :verify_authenticity_token, :only => [:srv_from_plu]


  def index
  end



  def srv_from_plu

    render nothing: true

  end
end




