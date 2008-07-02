# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '44f8cf8a0491c23ae99c031a900123cc'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
	
	before_filter :find_account
	around_filter :select_shard

	private
	def find_account
		aid = session[:account_id]
		@account = Account.find(Integer(aid)) if aid
	end

	def select_shard(&block)
		DataFabric.activate_shard(:shard, @account.shard, &block) if @account
	end

end
