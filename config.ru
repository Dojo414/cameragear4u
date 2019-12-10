require './config/environment'

use Rack::MethodOverride
use BagsController
use UsersController
run ApplicationController