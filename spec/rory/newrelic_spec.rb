require 'spec_helper'

describe Rory::NewRelic do
  class TestApp < Rory::Application
    Rory::NewRelic.configure do |c|
      c.application = Rory::Application.instance
      # c.controllers_folder = "#{Rory.root}/controllers"
      c.environments = %w(test)
    end
  end

  it 'has a version number' do
    expect(Rory::Newrelic::VERSION).not_to be nil
  end

  subject { described_class.instance }

  # it 'uses sane defaults from Rory' do
  #   expect(subject).to receive(:controllers_folder)
  # end
end
