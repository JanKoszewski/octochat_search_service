require 'spec_helper'

describe MessagesController do
  describe "#index" do
    def app
      Api::V1::MessagesController.action(:index)
    end

    it "returns messages JSON" do
      body = get(api_v1_messages_path, "Hello, Test World!")
      raise body.inspect
      expect { JSON.parse(body) }.to_not raise_error      
    end

    context "when given a query" do
      context "when it matches a message" do
        before(:each) do
          Message.create(:content => "Hello, Test World!")
        end

        it "returns the match" do          
          body = get(messages_path, {:search => "Hello, Test World!"}).body
          messages = JSON.parse(body)["messages"]
          messages.count.should == 1
          messages.first["content"].should == "Hello, Test World!"
        end

        context "and there are other messages" do
          before(:each) do
            3.times{ Message.create(:content => "Filler message #{rand}") }
          end

          it "returns the match" do          
            body = get(messages_path, {:search => "Hello, Test World!"}).body
            messages = JSON.parse(body)["messages"]
            raise body.inspect
            messages.count.should == 1
            messages.first["content"].should == "Hello, Test World!"
          end
        end
      end

      context "when it matches multiple messages" do
        before(:each) do
          Message.create(:content => "Hello, Test World!")
          Message.create(:content => "Another Hello, Test World!")
        end

        it "returns the messages" do
          body = get(messages_path, {:search => "Well hi"}).body
          messages = JSON.parse(body)["messages"]
          messages.count.should == 2
          messages.each do |message|
            ["Hello, Test World!", "Another Hello, Test World!"].should include(message.content)
          end
        end    
      end

      context "when it does not match any messages" do
        it "returns an empty set" do
          body = get(messages_path, {:search => "Nada"}).body
          JSON.parse(body)["messages"].should be_empty
        end      
      end
    end
  end
end