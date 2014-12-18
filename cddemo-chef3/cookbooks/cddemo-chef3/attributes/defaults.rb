# Java Version
override['java']['jdk_version'] = '7'

# Tomcat Version
override['tomcat']['base_version'] = 7

# Workaround for Chef 11 Bug, necessary to overwrite tomcat version
# https://tickets.opscode.com/browse/CHEF-4234
node.from_file(run_context.resolve_attribute(*parse_attribute_file_spec("tomcat")))

