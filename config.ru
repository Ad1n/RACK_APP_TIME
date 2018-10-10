require_relative 'middleware/checker'
require_relative 'app'

use Checker
run App.new
