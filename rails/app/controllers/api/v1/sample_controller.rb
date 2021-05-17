module Api
  module V1
    class SampleController < ApplicationController
      def index
        # user_name が存在しなければ、cookie に david を付与して render
        unless cookies[:account_id]
          cookies.signed[:account_id] = {
            value: 1,
            httponly: true,
            secure: true,
            expires: 2.hours.from_now,
            same_site: :strict
          }

          return render json: { status: 'SUCCESS', message: 'success' }
        end

        # model側の処理
        @account = Account.find_by(account_id: cookies.signed[:account_id])

        # cookie を削除する場合は、以下のような記載を行う
        # value = cookies.signed[:value]
        # cookies.delete(:account_id)
        render json: { status: 'SUCCESS', message: 'your david', value: @account.account_name }
      end
    end
  end
end