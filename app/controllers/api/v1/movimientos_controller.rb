module Api
  module V1
class MovimientosController < AccountsController

  before_action :authenticate, except: [ :index,:show ]
  def index
    movimiento = Movimiento.order('id');
    render json: { status:"Exitoso",
    message: 'usuarios cargados',
    data:movimiento
    },status: :ok
  end

  def show

    
    idus = params[:id]
    sql = "SELECT * FROM `movimientos` WHERE idus= '"+idus+"'"
    movimiento = ActiveRecord::Base.connection.execute(sql)

    render json: { status:"Exitoso",
      message: 'usuarios cargados',
      data:movimiento
      },status: :ok
end

  def create
    
      movimiento = Movimiento.create(movimientosc_params)
      if movimiento.save
        render json: { status:"Exitoso",
             message: 'transferencia existosa',
             data:movimiento
             },status: :ok
   else
        render json: { status:"Fallido",
             message: 'no creado',
            data:movimiento
           },status: :unprocessable_entity
      
   end

      movimiento = Movimiento.create(movimientosa_params)
      movimiento.save

      ustr = ""
      authenticate_or_request_with_http_token do |token, options|
        ustr=Account.find_by(token: token)
      end
  
    user = User.find_by(ustr.nocuenta)
    user.update(userc_params)

    user = User.find_by(nocuenta:params[:idustr])
    user.update(usera_params)


end

def movimientosc_params
  ustr = ""
  authenticate_or_request_with_http_token do |token, options|
    ustr=Account.find_by(token: token)
  end
   idustr = params[:idustr]
   importe = params[:importe]
  
 
   sql = "SELECT MAX(nomov)+1 FROM `movimientos` WHERE idus= '"+ustr.nocuenta+"'"
   records_array = ActiveRecord::Base.connection.execute(sql)
   movimiento = records_array.first[0]
  params = ActionController::Parameters.new({
    person: {
      nomov: movimiento,
      importe: importe ,  
      tipomov: "C",
      concepto: "Transferencia a usuario",
      idus:ustr.nocuenta,
      idustr:idustr
    }
  })
  
  params.require(:person).permit(:nomov,:importe, :tipomov, :concepto, :idus,:idustr)
end

def movimientosa_params
  idus = params[:idus]
  idustr = params[:idustr]
  importe = params[:importe]
  ustr = ""
  authenticate_or_request_with_http_token do |token, options|
    ustr=Account.find_by(token: token)
  end


  sql = "SELECT MAX(nomov)+1 FROM `movimientos` WHERE idus= '"+idustr+"'"
  records_array = ActiveRecord::Base.connection.execute(sql)
  movimiento = records_array.first[0]
 params = ActionController::Parameters.new({
   person: {
     nomov: movimiento,
     importe: importe ,  
     tipomov: "A",
     concepto: "Transferencia de usuario",
     idus:idustr,
     idustr:ustr.nocuenta
   }
 })
 
 params.require(:person).permit(:nomov,:importe, :tipomov, :concepto, :idus,:idustr)
end

def userc_params
  ustr = ""
  authenticate_or_request_with_http_token do |token, options|
    ustr=Account.find_by(token: token)
  end
  user = User.find_by(nocuenta:ustr.nocuenta)
  saldo = user.saldo
  importe = params[:importe]
  total=saldo-importe
  movimientos=user.movimientos+1
  params = ActionController::Parameters.new({
    person: {
      saldo: total,
      movimientos: movimientos 
   
    }
  })
   params.require(:person).permit(:saldo,:movimientos)
end

def usera_params
  user = User.find_by(nocuenta:params[:idustr])
  saldo = user.saldo
  importe = params[:importe]
  total=saldo+importe
  movimientos=user.movimientos+1
  params = ActionController::Parameters.new({
    person: {
      saldo: total,
      movimientos: movimientos 
   
    }
  })
   params.require(:person).permit(:saldo,:movimientos)
end


end
end
end
