require 'spec_helper'
describe 'host_pkgandsvc' do

  context 'with defaults for all parameters' do
    it { should contain_class('host_pkgandsvc') }
  end
end
