bind "tcp://0.0.0.0:#{ENV.fetch('SERVER_PORT', 1323)}"
environment 'production'
