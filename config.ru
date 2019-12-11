require './config/environment'

use Rack::MethodOverride
use CameraBodiesController
use LensesController
use BagsController
use UsersController
run ApplicationController