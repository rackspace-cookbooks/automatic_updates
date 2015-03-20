# Encoding: utf-8
#
# Cookbook Name:: automatic_updates
# Recipe:: default
#
# Copyright 2014, Rackspace
#
node.default['example']['attribute'] = 'lions, tigers'
node.override['example']['attribute'] = 'lions, tigers and bears'
log node['example']['attribute']
