class Machine::Pfm1Controller < ApplicationController

  skip_before_filter :verify_authenticity_token, :only => [:srv_from_plu]


  def index
  end



  def srv_from_plu

    str = params[:data].gsub(/[^0-9\*]/, '').to_s.split('*')

    if Pfm1.where('id_in_plu = ? and is_check = ?', str[0], 0).size == 0
      Pfm1.create(
           id_in_plu: str[0],
           type_of: str[1],
           width: str[2],
           height: str[3],
           l1: str[4],
           l2: str[5],
           l3: str[6],
           k1: str[7],
           k2: str[8],
           k3: str[9],
           is_check: 0
      )
     end

    render nothing: true

  end

  def srv_get_one_uncheck

    @form_data = {
        pfml1: Pfm1.where('is_check = ?', 0)[0]
    }

    render xml: @form_data

  end


  def srv_get_all_uncheck

    @form_data = {
        pfml1: Pfm1.where('is_check = ?', 0)
    }

    render xml: @form_data

  end


  def srv_one_one_check

    Pfm1.update(
        params[:id_in_plu],
        is_check: 1,
    )

  end




end




