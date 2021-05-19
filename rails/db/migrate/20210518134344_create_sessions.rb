class CreateSessions < ActiveRecord::Migration[6.0]
  def change
    create_table :sessions, id: false do |t|
      t.string :session_key, primary_key: true
      t.integer :account_id, null: false
      t.datetime :expiration, null: false

      t.timestamps
    end
    # 外部キーを設定
    add_foreign_key :sessions, :accounts, column: :account_id , primary_key: :account_id

    reversible do |dir|
      dir.up do
        # expirationカラムにデフォルト値をセットする
        # Rails側にバグの可能性あり => https://tech.actindi.net/2019/12/06/090000
        execute <<-SQL
          alter table chat_development.sessions
          alter column expiration
          set default (now() + interval 2 hour);
        SQL
      end
    end
  end
end
