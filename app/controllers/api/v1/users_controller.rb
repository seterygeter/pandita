module Api
   module V1
    class UsersController < ApplicationController
         def index
                users = User.order('id');
                render json: { status:"Exitoso",
                message: 'usuarios cargados',
                data:users
                },status: :ok
         end

         def show
             user = User.find(params[:id])
             render json: { status:"Exitoso",
               message: 'usuarios cargados',
               data:user
               },status: :ok
         end




         def create
          user = User.create(user_params)
          user.save
      
          if user.save
               render json: { status:"Exitoso",
                    message: 'usuarios creado',
                    data:user
                    },status: :ok
          else
               render json: { status:"Fallido",
                    message: 'no creado',
                    data:user
                    },status: :unprocessable_entity
               
          end
      
      
          account = Account.create(account_params)
          account.save
          movimiento = Movimiento.create(movimiento_params)
          movimiento.save
            
      
      
       
      
              end
      
      
             
      
           
      
      




def destroy
     user = User.find(params[:id])

     if user.destroy
          render json: { status:"Exitoso",
               message: 'usuarios creado',
               data:user
               },status: :ok
     else
          render json: { status:"Fallido",
               message: 'no borrado',
               data:user
               },status: :unprocessable_entity
          end
end
def update
     user = User.find(params[:id])

     if user.update(user_params)
          render json: { status:"Exitoso",
               message: 'usuarios actualizado',
               data:user
               },status: :ok
     else
          render json: { status:"Fallido",
               message: 'no actualizado',
               data:user
               },status: :unprocessable_entity
          
     end
     
end

         private 

             def user_params
         
                  params.permit(:nombre, :email, :telefono, :nocuenta)
             end
             def movimiento_params
         
               params.permit(1,1000,"A","inicial",1)
          end

          def user_params
               nombre = params[:nombre]
               email = params[:email]
               telefono = params[:telefono]
               numero = %w{ 1 2 3 4 5 6 7 8 9 10}
               nocuenta =""
               10.times do 
                 nocuenta = nocuenta + rand(numero.length).to_s
               end
     
     
               user = User.exists?(nocuenta: nocuenta)
             
               if user
                 10.times do 
                   nocuenta = nocuenta + rand(numero.length).to_s
                 end
               end
             
     
               params = ActionController::Parameters.new({
                 person: {
                   nombre: nombre,
                   email: email,
                   telefono: telefono,
                   saldo:1000.00,
                   movimientos:0,
                   nocuenta: nocuenta
                 }
               })
     
               params.require(:person).permit(:nombre, :email, :telefono,:saldo,:movimientos, :nocuenta)
             
          end
     
          def account_params
           value = ""; 8.times{value << ((rand(2)==1?65:97) + rand(25)).chr}
           user= User.find(User.maximum(:id))
     
     
           
           params = ActionController::Parameters.new({
             account: {
               nocuenta: user.nocuenta ,
               password: value ,
               token: ""
             }
           })
           params.require(:account).permit(:nocuenta, :password)
      end
     
      def movimiento_params
       user= User.find(User.maximum(:id))
       params = ActionController::Parameters.new({
         person: {
           nomov: 1,
           importe: 1000.00 ,
           tipomov: "A",
           concepto: "Abono inicial de regalo",
           idus:user.nocuenta
         }
       })
       
       params.require(:person).permit(:nomov, :importe,:tipomov,:concepto, :idus)
       
     end
     
        
    
    end
   
end

end