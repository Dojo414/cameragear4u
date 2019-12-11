require './config/environment'

use Rack::MethodOverride
use CameraBodiesController
use TripodsController
use LensesController
use BagsController
use UsersController
run ApplicationController