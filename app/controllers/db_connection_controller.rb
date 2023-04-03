class DbConnectionController < ApplicationController
  private

  def db_connection_params
    params.require(:db_connection).permit(:user_id, :display_name, :connection_type, :db_port, :db_name, :db_user,
      :db_pass, :analytics_account_id, :json_file, :csv_file)
  end
end
