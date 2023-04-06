require 'mysql2'
require 'pg'

module DBConnect
  def self.InitConnection(param = {})
    case param.type
    when 'mysql'
      conn = Mysql2::Client.new(:host=> param.db_host, :username => param.db_user, :password => param.db_pass, :database => param.db_name)
      return conn
    when 'postgresql'

    end
  rescue
    nil
  end
end
