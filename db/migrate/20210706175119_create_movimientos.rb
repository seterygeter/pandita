class CreateMovimientos < ActiveRecord::Migration[6.1]
  def change
    create_table :movimientos do |t|
      t.integer :nomov
      t.decimal :importe
      t.string :tipomov
      t.string :concepto
      t.string :idus
      t.string :idustr
      t.timestamps
    end
  end
end
