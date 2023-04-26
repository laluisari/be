class DbConnectionController < ApplicationController
  include DbConnect


  before_action :authenticate_request
  before_action :set_db_connection, only: %i[show update destroy]
  load_and_authorize_resource

  def index
    @dbs = DbConnection.accessible_by(current_ability)
    render json: { status: 200, message: 'Success', data: @dbs.map(&:new_attr) }, status: :ok
  end

  def show
    authorize! :show, @db
    render json: { status: 200, message: 'Success', data: @db.new_attr }, status: :ok
  end

  def create
    @db = DbConnection.new(db_connection_params)
    @db.user_id = @current_user.id
    return render json: { status: 422, message: 'Create Record Failed', error: @db.errors }, status: :unprocessable_entity unless @db.save

    render json: { status: 200, message: 'Success', data: @db.new_attr }, status: :ok
  end

  def update
    authorize! :update, @db
    unless @db.update(db_connection_params)
      render json: { status: 442, message: 'Update Failed', error: @db.errors }, status: :unprocessable_entity
      return
    end
    render json: {
      status: 200,
      data: @db.new_attr
    }, status: :ok
  end

  def destroy
    authorize! :destroy, @db
    unless @db.destroy
      render json: { status: 442, message: 'Delete Failed', error: @db.errors }, status: :unprocessable_entity
      return
    end
    render json: {
      status: 200,
      data: @db.new_attr
    }, status: :ok
  end

  def connection_check
    @db = DbConnection.new(db_connection_params)
    @check = DbConnect::InitConnection(@db)
    if @check.nil?
      render json:
      {
        status: 400,
        message: 'Connection Failed',
        error: 'Please Check your Configuration'
      }, status: :bad_request
      return
    end
    render json: { status: 200, message: 'Success' }, status: :ok
  end

  def db
    @db = DbConnection.find_by_id(9)
    # binding.pry
    # @data = DbConnect::GetColumns('user', @db)
    @data = DbConnect::GetTables(@db)
    return render json: { message: 'Connection Failed' }, status: :not_found if @data.nil?

    render json: { status: 200, message: 'Success', data: @data }, status: :ok
  end

  private

  def db_connection_params
    params.require(:db_connection).permit(
      :user_id, :display_name, :connection_type, :db_host, :db_port, :db_name, :db_user,
      :db_pass, :analytics_account_id, :json_file, :csv_file
    )
  end

  def set_db_connection
    @db = DbConnection.find_by_id(params[:id])
    return render json: { status: 404, message: 'Failed', error: 'No record found' }, status: :not_found if @db.nil?
  end
end
