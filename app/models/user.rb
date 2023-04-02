class User < ApplicationRecord
  #roles
  enum role: {
    admin: 0,
    member: 1,
    data_expert: 2
  }
end
