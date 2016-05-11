require 'spec_helper'
describe 'host_kernel' do

  context 'with defaults for all parameters' do
    it { should contain_class('host_kernel') }
  end
end
