require 'spec_helper'

describe "An RSpec Mock" do
  it "should hide internals in its inspect representation" do
    m = double('cup')
    m.inspect.should =~ /#<Rspec::Mocks::Mock:0x[a-f0-9.]+ @name="cup">/
  end
end
