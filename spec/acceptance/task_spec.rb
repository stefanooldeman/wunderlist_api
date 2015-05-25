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

      head '/tasks' do
        example_request 'gives GET and POST' do
          expect(response_headers['Allow']).to eq("GET\nPOST\nOPTIONS")
        end
      end

      get "/tasks" do
        example_request "Get all tasks" do
          actual = {
            _links: {
              back: { href: 'http://test.com/' },
              self: { href: 'http://test.com/tasks' },
              tasks: [
                { name: 'Watch TV', href: 'http://test.com/tasks/1a0' },
                { name: 'Read a book', href: 'http://test.com/tasks/1b0' }
              ]
            }
          }
          expect(response_body).to be_json_eql(actual.to_json)
          expect(status).to eq(200)
        end
      end

      head '/tasks/1b0' do
        example_request 'gives GET, POST and DELETE' do
          expect(response_headers['Allow']).to eq("GET\nDELETE\nOPTIONS")
        end
      end

      get "/tasks/1b0" do
        example_request "Get one task" do
          actual = { title: 'Read a book', archived: false, _links: { self: {href: 'http://test.com/tasks/1b0'}, back: {href: 'http://test.com/tasks'} } }
          expect(response_body).to be_json_eql(actual.to_json)
          expect(status).to eq(200)
        end
      end

      delete "/tasks/1b0" do
        example_request "Remove one task" do
          actual = {
            id: '1bo',
            title: 'Read a book',
            archived: false,
          }
          expect(response_body).to be_json_eql(actual.to_json).excluding('_links')
          expect(status).to eq(200)

          client.get('/tasks/1b0', {}, headers)
          expect(status).to eq(404)
        end
      end
    end

    post "/tasks" do
      parameter :title, 'Your summary here'

      let(:title) { "So more much todo" }
      let(:raw_post) { params.to_json }
      example_request "Creating a task" do
        actual = {
          archived: false,
          created_at: '2015-05-25T12:04:53.929+02:00',
          title: 'So more much todo',
        }
        expect(response_body).to be_json_eql(actual.to_json).excluding('_links')
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
