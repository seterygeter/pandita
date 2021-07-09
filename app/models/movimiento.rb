class Movimiento < ApplicationRecord
    validates:nomov,presence:true
    validates:importe,presence:true
    validates:tipomov,presence:true
    validates:concepto,presence:true
    validates:idus,presence:true
end
