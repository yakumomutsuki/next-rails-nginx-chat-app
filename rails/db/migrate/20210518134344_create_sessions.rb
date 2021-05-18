class CreateSessions < ActiveRecord::Migration[6.0]
  def change
    create_table :sessions, id: false do |t|
      t.string :session_key, primary_key: true
      t.integer :account_id, null: false
      t.datetime :expiration, default: -> { '(now() + interval 2 hour)' }

      t.timestamps
    end
    # 外部キーを設定
    add_foreign_key :sessions, :accounts, column: :account_id , primary_key: :account_id
  end
end
