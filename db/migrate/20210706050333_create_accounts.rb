class CreateAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :accounts do |t|
      t.string :nocuenta
      t.string :password
      t.string :token

      t.timestamps
    end
  end
end
