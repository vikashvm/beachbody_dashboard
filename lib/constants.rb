require 'yaml'
CONFIG = YAML.load_file(File.expand_path("../../constants.yml", __FILE__))
SETTINGS = YAML.load_file(File.expand_path("../../settings.yml", __FILE__))
