module Api
  module V1
class AccountsController < ApplicationController



  
  def index
    render plain: "Todos me pueden ver!"
  end
 
  def create
    
    account = Account.find_by(nocuenta:params[:nocuenta])


    if account.password == params[:password]
      account = Account.find_by(nocuenta:params[:nocuenta])
      

      if account.update(token_params)
        render json: { status:"Exitoso",
             message: 'Logueo exitoso',
             data:account
             },status: :ok
   else
        render json: { status:"Fallido",
             message: 'No logueado de forma correcta',
            data:account
           },status: :unprocessable_entity
      
   end
  
        else
        end
  
    

    
  end


  def set_auth_token
    return if auth_token.present? && token_expiry > Time.now
    self.auth_token = generate_auth_token
    self.token_expiry = Time.now + 1.day
  end


  def generate_auth_token
    SecureRandom.hex(90)  
  end

  private
    def authenticate
      authenticate_or_request_with_http_token do |token, options|
        Account.find_by(token: token)
      end
    end


    def authenticate_or_request_with_http_token(
      realm = "Application",
      message = nil,
      &login_procedure)
        authenticate_with_http_token(&login_procedure) ||
        request_http_token_authentication(realm, message)
      end


 def token_params
  params = ActionController::Parameters.new({
    token: {
      token: generate_auth_token
    }
  })
  params.require(:token).permit(:token)
   
 end



end
end
end
