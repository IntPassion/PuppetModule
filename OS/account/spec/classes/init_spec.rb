require 'spec_helper'
describe 'os_user' do

  context 'with defaults for all parameters' do
    it { should contain_class('os_user') }
  end
end
