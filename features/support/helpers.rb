module Helpers
  def capybara_host_and_port
    "%s:%s" % [Capybara.current_session.server.host, Capybara.current_session.server.port]
  end
end

World Helpers
