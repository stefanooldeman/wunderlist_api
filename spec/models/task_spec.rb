require 'spec_helper'
 
RSpec.describe Task, type: :model do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:archived) }

  context 'on loaded object' do
    subject { FactoryGirl.build(:task, _id: '555') }

    it 'maps mongo ObjectId to :id' do
      expect(subject.id).to eq('555')
    end
  end
end
