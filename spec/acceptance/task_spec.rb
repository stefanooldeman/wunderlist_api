require 'acceptance_helper'
 
resource "Tasks" do
  header "Accept", "application/json"
  header "Content-Type", "application/json"

  before :all do
    FactoryGirl.create(:task_item, title: 'Watch TV', id: '1a0')
    FactoryGirl.create(:task_item, title: 'Read a book', id: '1b0')
  end
 
  get "/tasks" do
    example "Get all tasks" do
      do_request
 
      actual = [
        { title: 'Watch TV', archived: false, _links: { self: {href: '/tasks/1a0'} } },
        { title: 'Read a book', archived: false, _links: { self: {href: '/tasks/1b0'} } }
      ]
      expect(response_body).to be_json_eql(actual.to_json)
      expect(status).to eq(200)
    end
  end

  get "/tasks/1b0" do
    example "Get one task" do
      do_request
 
      actual = { title: 'Read a book', archived: false, _links: { self: {href: '/tasks/1b0'} } }
      expect(response_body).to be_json_eql(actual.to_json)
      expect(status).to eq(200)
    end
  end

end
