if defined?(ChefSpec)
  # service
  def enable_automatic_updates(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:automatic_updates, :enable, resource_name)
  end

  def disable_automatic_updates(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:automatic_updates, :disable, resource_name)
  end
end
