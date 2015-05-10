require 'acceptance_helper'
 
resource "Tasks" do
  header "Accept", "application/json"
  header "Content-Type", "application/json"
 
  get "/tasks" do
    example "Getting all tasks" do
      FactoryGirl.create(:task_item, title: 'Watch TV')
      FactoryGirl.create(:task_item, title: 'Read a book')
      do_request
 
      expect(response_body).to be_json_eql({
        :tasks => [
          { title: 'Watch TV', archived: false },
          { title: 'Read a book', archived: false }
        ]
      }.to_json)
      expect(status).to eq(200)
    end
  end

end
