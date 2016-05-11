require 'spec_helper'
describe 'host_profile' do

  context 'with defaults for all parameters' do
    it { should contain_class('host_profile') }
  end
end
