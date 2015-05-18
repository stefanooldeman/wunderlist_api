require 'acceptance_helper'
 
resource "Tasks" do
  header "Accept", "application/hal+json"
  header "Content-Type", "application/json"

  context 'User unauthorized' do
    context 'Resources do not exist' do
      get "/tasks" do
        example_request 'gives not found' do
          expect(status).to eq(404)
        end
      end

      get "/tasks/1a0" do
        example_request 'gives not found' do
          expect(status).to eq(404)
        end
      end
    end

    context 'Resources exist' do
      before :all do
        FactoryGirl.create(:task_item, title: 'Watch TV', id: '1a0')
        FactoryGirl.create(:task_item, title: 'Read a book', id: '1b0')
      end

      get "/tasks" do
        example_request "Get all tasks" do
          actual = { _embedded: { tasks: [
                { title: 'Watch TV', archived: false, _links: { self: {href: 'http://test.com/tasks/1a0'} } },
                { title: 'Read a book', archived: false, _links: { self: {href: 'http://test.com/tasks/1b0'} } }
              ]
            },
            _links: { self: {href: 'http://test.com/tasks'} }
          }
          expect(response_body).to be_json_eql(actual.to_json)
          expect(status).to eq(200)
        end
      end

      get "/tasks/1b0" do
        example_request "Get one task" do
          actual = { title: 'Read a book', archived: false, _links: { self: {href: 'http://test.com/tasks/1b0'} } }
          expect(response_body).to be_json_eql(actual.to_json)
          expect(status).to eq(200)
        end
      end
    end

    post "/tasks" do
      parameter :title, 'Your summary here'

      let(:title) { "So more much todo" }
      let(:raw_post) { params.to_json }
      example_request "Creating a task" do
        expect(response_body).to eq('')
        location = response_headers["Location"]
        expect(location).to match(/\/tasks\/[a-z0-9]+$/)
        expect(status).to eq(201)

        client.get(location)
        actual = JSON.parse(response_body)
        expect(actual['title']).to eq("So more much todo")
        expect(actual['archived']).to be_falsy
      end
    end
  end

end
