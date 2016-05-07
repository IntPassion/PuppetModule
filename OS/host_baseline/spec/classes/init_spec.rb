require 'spec_helper'
describe 'baseline' do

  context 'with defaults for all parameters' do
    it { should contain_class('baseline') }
  end
end
