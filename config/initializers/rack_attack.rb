class Rack::Attack
  Rack::Attack.cache.store = ActiveSupport::Cache::MemoryStore.new

  # Allow all local traffic
  safelist('allow-localhost') do |req|
    '127.0.0.1' == req.ip || '::1' == req.ip
  end

  # Allow an IP address to make 5 requests every 5 seconds
  throttle('req/ip', limit: 5, period: 5) do |req|
    req.ip
  end

  # throttle('logins/email', limit: 5, period: 5.seconds) do |req|
  #   if req.path == 'users/sign_in' && req.post
  #     req.params['email'].presence
  #   end
  # end

end