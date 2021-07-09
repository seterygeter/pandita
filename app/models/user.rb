class User < ApplicationRecord
    validates:nombre,presence:true
    validates:email,presence:true
    validates:telefono,presence:true
    validates:nocuenta,presence:true
end
