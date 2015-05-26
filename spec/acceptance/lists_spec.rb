require 'acceptance_helper'
 
resource "Lists" do
  header "Accept", "application/hal+json"
  header "Content-Type", "application/json"

  head '/lists' do
    example_request 'gives GET and POST' do
      expect(response_headers['Allow']).to eq("GET\nPOST\nOPTIONS")
    end
  end

  get "/lists" do
    example_request "Get all lists (archive is a default)" do

      actual = {
        _links: {
          back: {href: 'http://test.com/'},
          self: {href: 'http://test.com/lists'},
          lists: [ { name: 'archive', href: 'http://test.com/lists/archive' } ]
        }
      }
      expect(response_body).to be_json_eql(actual.to_json)
      expect(status).to eq(200)
    end
  end

  head '/lists/archive' do
    example_request 'gives GET and POST' do
      expect(response_headers['Allow']).to eq("GET\nDELETE\nOPTIONS")
    end
  end
  context 'no tasks exist' do
    before do
      FactoryGirl.create(:task_list, name: 'foo', public: true, tasks: [])
    end
    get '/lists/foo' do
      example_request 'Get all tasks in a list' do
        actual = {
          name: 'foo',
          public: true,
          _links: {
            self: {href: 'http://test.com/lists/foo'},
            back: {href: 'http://test.com/lists'},
            tasks: []
          }
        }
        expect(response_body).to be_json_eql(actual.to_json)
        expect(status).to eq(200)
      end
    end
  end

  context 'tasks exist' do
    before :all do
      task_1 = FactoryGirl.build(:task, title: 'Be someone', id: '2a0')
      task_2 = FactoryGirl.build(:task, title: 'Mean something', id: '2b0')
      list = FactoryGirl.create(:task_list, name: 'shit-grownups-say', public: true)
      list.tasks << task_1
      list.tasks << task_2

    end
    get '/lists/shit-grownups-say' do
      example_request 'Get all tasks in a list' do
        actual = {
          name: 'shit-grownups-say',
          public: true,
          _links: {
            self: {href: 'http://test.com/lists/shit-grownups-say'},
            back: {href: 'http://test.com/lists'},
            tasks: [
              { name: 'Be someone', href: 'http://test.com/lists/shit-grownups-say/tasks/2a0' },
              { name: 'Mean something', href: 'http://test.com/lists/shit-grownups-say/tasks/2b0' }
            ]
          }
        }
        expect(response_body).to be_json_eql(actual.to_json)
        expect(status).to eq(200)
      end
    end

    get '/lists/shit-grownups-say/tasks/2b0' do
      example_request 'Get a task that belongs to a list' do
        actual = {
          id: "2a0",
          archived: false,
          created_at: "2015-05-27T00:32:21.125+02:00",
          title: "Be someone",
          _links: {
            self: {href: "http://test.com/lists/shit-grownups-say/tasks/2a0"},
            back: {href: "http://test.com/lists/shit-grownups-say/tasks"}
          }
        }
        expect(response_body).to be_json_eql(actual.to_json)
        expect(status).to eq(200)
      end
    end

    get "/lists/archive/tasks" do
      example_request "Get all tasks" do
        actual = {
          _links: {
            back: { href: 'http://test.com/lists' },
            self: { href: 'http://test.com/lists/archive' },
            tasks: []
          }
        }
        expect(response_body).to be_json_eql(actual.to_json)
        expect(status).to eq(200)
      end
    end
  end

end
