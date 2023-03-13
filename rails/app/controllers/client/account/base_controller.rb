class Client::Account::BaseController < Client::BaseController
  before_action :require_login
end
