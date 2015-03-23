# Encoding: utf-8
require 'serverspec'

set :backend, :exec

RSpec.configure do |c|
  c.before :all do
    c.path = '/sbin:/usr/sbin:/bin:/usr/bin'
  end
end

def rhel?
  ['redhat', 'centos'].include?(os[:family])
end

def rhel6?
  rhel? && os[:release].to_f < 7
end

def rhel7?
  rhel? && os[:release].to_f >= 7
end

def ubuntu? # no debian support
  ['ubuntu'].include?(os[:family])
end
