class CreateAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :accounts do |t|
      t.integer :account_id
      t.varchar :account_name
      t.varchar :password

      t.timestamps
    end
  end
end
