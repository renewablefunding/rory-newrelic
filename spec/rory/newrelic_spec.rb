require 'spec_helper'

describe Rory::NewRelic do
  class TestApp < Rory::Application
    Rory::NewRelic.configure do |c|
      c.application = Rory::Application.instance
      c.environments = %w(test)
    end
  end

  it 'has a version number' do
    expect(Rory::Newrelic::VERSION).not_to be nil
  end

  subject { described_class.instance }
end
