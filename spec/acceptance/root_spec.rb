require 'acceptance_helper'
 
resource "Tasks" do
  header "Accept", "application/hal+json"
  header "Content-Type", "application/json"

  get "/" do
    example "Get all links" do
      do_request
 
      actual = {
        _links: {
          self: {href: '/'},
          auth: {href: '/auth'},
          lists: {href: '/lists'},
          tasks: {href: '/tasks'},
          users: {href: '/users'}
        }
      }
      expect(response_body).to be_json_eql(actual.to_json)
      expect(status).to eq(200)
    end
  end

end
