require 'spec_helper'

describe process('influxd') do
  it { should be_running }
end

describe port(8086) do
  it { should be_listening }
end

describe 'initializing' do

  describe file('/docker-entrypoint-initdb.d/test.influxql') do
    it { should exist }
  end

  describe command("influx -execute 'SHOW DATABASES'") do
    its('stdout') { should match /telegraf/ }
    its('exit_status') { should eq 0 }
  end

end
