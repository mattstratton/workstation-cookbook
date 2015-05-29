require 'spec_helper'

describe file('/Users/vagrant/.gitconfig') do
  it { should be_file }
  it { should contain 'matt.stratton@gmail.com' }
end
