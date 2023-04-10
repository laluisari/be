require 'mysql2'
require 'pg'

module DbConnect
  extend ActiveSupport::Concern
  def self.GetData(db_param = {}, filter = {})
    conn = DbConnect.InitConnection(db_param)
    return nil if conn.nil?

    case db_param.connection_type
    when 'mysql'
      result = conn.query("SELECT * FROM information_schema.tables WHERE TABLE_TYPE = 'BASE TABLE'")
      conn.close
      result
    end
  end

  def self.GetTables(db_param = {})
    conn = DbConnect.InitConnection(db_param)
    return nil if conn.nil?

    case db_param.connection_type
    when 'mysql'
      result = conn.query("SELECT * FROM information_schema.tables WHERE TABLE_TYPE = 'BASE TABLE'")
      conn.close
      result
    when 'postgresql'
      # conn.exec("SELECT column_name, column_name, table_name FROM information_schema.columns WHERE table_schema='public' AND table_name = 'accounts'")
      result = conn.exec("SELECT * FROM information_schema.tables WHERE table_type = 'BASE TABLE' AND
        table_schema != 'pg_catalog' AND table_schema != 'information_schema'")
      conn.finish
      result
    end
  end

  def self.GetColumns(column, db_param = {})
    conn = DbConnect.InitConnection(db_param)
    # binding.pry
    case db_param.connection_type
    when 'mysql'
      result = conn.query("SELECT COLUMN_NAME FROM information_schema.columns WHERE TABLE_NAME = '#{column}'")
      conn.close
      result
    when 'postgresql'
      # conn.exec("SELECT column_name, column_name, table_name FROM information_schema.columns WHERE table_schema='public' AND table_name = 'accounts'")
      result = conn.exec("SELECT * FROM information_schema.tables WHERE table_type = 'BASE TABLE' AND
        table_schema != 'pg_catalog' AND table_schema != 'information_schema'")
      conn.finish
      result
    end

  end

  def self.InitConnection(param = {})
    conn = {}
    puts 'CONNECTING TO DATABASE...'
    case param.connection_type
    when 'mysql'
      conn = Mysql2::Client.new(:host=> param.db_host, :username => param.db_user, :password => param.db_pass, :database => param.db_name)
    when 'postgresql'
      conn = PG::Connection.open(:host=> param.db_host, :port => param.db_port, :user => param.db_user, :password => param.db_pass, :dbname => param.db_name)
    end
    puts 'CONNECTED'
    conn
  rescue
    puts 'CONNECTION FAILED'
    nil
  end
end
