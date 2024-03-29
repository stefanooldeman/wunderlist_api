require 'acceptance_helper'
 
resource "Tasks" do
  header "Accept", "application/hal+json"
  header "Content-Type", "application/json"

  get "/" do
    example "Get all links" do
      do_request
 
      actual = {
        _links: {
          self: {href: 'http://test.com/'},
          auth: {href: 'http://test.com/auth'},
          archive: {href: 'http://test.com/archive'},
          tasks: {href: 'http://test.com/tasks'},
          users: {href: 'http://test.com/users'}
        }
      }
      expect(response_body).to be_json_eql(actual.to_json)
      expect(status).to eq(200)
    end
  end

end
