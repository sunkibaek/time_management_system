module Helpers
  def authorize_with(token)
    controller.request.env['HTTP_AUTHORIZATION'] = 'Token ' + token
  end

  def request_header_with(token)
    page.driver.add_headers 'Authorization' => "Token #{token}"
  end
end
