class CreateAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :accounts, id: false do |t|
      t.column :account_id, 'int(11) primary key auto_increment'
      t.string :account_name, null: false, limit: 32
      t.string :password, null: false, limit: 32

      t.timestamps
    end
  end
end
