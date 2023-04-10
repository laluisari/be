class DbConnectionController < ApplicationController
  include DbConnect

  before_action :set_db_connection, only: %i[show update destroy]

  def index
    @dbs = DbConnection.all
    render json: @dbs.map(&:new_attr), status: :ok
  end

  def show
    render json: @db.new_attr, status: :ok
  end

  def create
    @db = DbConnection.new(db_connection_params)
    return render json: { message: 'Failed' }, status: :unprocessable_entity unless @db.save

    render json: @db.map(&:new_attr), status: :ok
  end

  def update
    unless @db.update(db_connection_params)
      render json: { message: 'Update Failed' }, status: :unprocessable_entity
      return
    end
    render json: @db, status: :ok
  end

  def destroy
    unless @db.destroy
      render json: { message: 'Delete Failed' }, status: :unprocessable_entity
      return
    end
    render json: @db, status: :ok
  end

  def db
    @db = DbConnection.find_by_id(2)
    @data = DbConnect::GetColumns('user', @db)
    # binding.pry
    return render json: { message: 'Connection Failed' }, status: :not_found if @data.nil?

    render json: @data, status: :ok
  end

  private

  def db_connection_params
    params.require(:db_connection).permit(:user_id, :display_name, :connection_type, :db_port, :db_name, :db_user,
      :db_pass, :analytics_account_id, :json_file, :csv_file)
  end

  def set_db_connection
    @db = DbConnection.find_by_id(params[:id])
    return render json: { message: 'record not found' }, status: :not_found if @db.nil?
  end
end
 