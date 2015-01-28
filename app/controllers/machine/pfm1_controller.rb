class Machine::Pfm1Controller < ApplicationController

  skip_before_filter :verify_authenticity_token, :only => [:srv_from_plu]


  def index
  end



  def srv_from_plu

    str = params[:data].gsub(/[^0-9\*]/, '').to_s.split('*')

    if Pfm1.where('id_in_plu = ? and is_check = ?', str[0], 'NULL').length == 0
      Pfm1.create(
           id_in_plu: str[0],
           width: str[1],
           height: str[2],
           l1: str[3],
           l2: str[4],
           l3: str[5],
           k1: str[6],
           k2: str[7],
           k3: str[8],
           is_check: str[9]
      )
     end

    render nothing: true

  end
end




