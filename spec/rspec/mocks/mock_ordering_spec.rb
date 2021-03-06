require 'spec_helper'

module Rspec
  module Mocks

    describe "ordering" do

      before do
        @double = double("test double")
      end
      
      after do
        @double.rspec_reset
      end

      it "should pass two calls in order" do
        @double.should_receive(:one).ordered
        @double.should_receive(:two).ordered
        @double.one
        @double.two
        @double.rspec_verify
      end

      it "should pass three calls in order" do
        @double.should_receive(:one).ordered
        @double.should_receive(:two).ordered
        @double.should_receive(:three).ordered
        @double.one
        @double.two
        @double.three
        @double.rspec_verify
      end

      it "should fail if second call comes first" do
        @double.should_receive(:one).ordered
        @double.should_receive(:two).ordered
        lambda do
          @double.two
        end.should raise_error(Rspec::Mocks::MockExpectationError, "Double \"test double\" received :two out of order")
      end

      it "should fail if third call comes first" do
        @double.should_receive(:one).ordered
        @double.should_receive(:two).ordered
        @double.should_receive(:three).ordered
        @double.one
        lambda do
          @double.three
        end.should raise_error(Rspec::Mocks::MockExpectationError, "Double \"test double\" received :three out of order")
      end
      
      it "should fail if third call comes second" do
        @double.should_receive(:one).ordered
        @double.should_receive(:two).ordered
        @double.should_receive(:three).ordered
        @double.one
        lambda do
          @double.three
        end.should raise_error(Rspec::Mocks::MockExpectationError, "Double \"test double\" received :three out of order")
      end

      it "should ignore order of non ordered calls" do
        @double.should_receive(:ignored_0)
        @double.should_receive(:ordered_1).ordered
        @double.should_receive(:ignored_1)
        @double.should_receive(:ordered_2).ordered
        @double.should_receive(:ignored_2)
        @double.should_receive(:ignored_3)
        @double.should_receive(:ordered_3).ordered
        @double.should_receive(:ignored_4)
        @double.ignored_3
        @double.ordered_1
        @double.ignored_0
        @double.ordered_2
        @double.ignored_4
        @double.ignored_2
        @double.ordered_3
        @double.ignored_1
        @double.rspec_verify
      end
      
      it "should pass when duplicates exist" do
        @double.should_receive(:a).ordered
        @double.should_receive(:b).ordered
        @double.should_receive(:a).ordered
        
        @double.a
        @double.b
        @double.a
      end
            
    end
  end
end
