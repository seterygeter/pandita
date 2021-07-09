class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :nombre
      t.string :email
      t.string :telefono
      t.decimal :saldo
      t.integer :movimientos
      t.string :nocuenta

      t.timestamps
    end
  end
end
