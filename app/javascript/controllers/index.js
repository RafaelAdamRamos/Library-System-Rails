// app/javascript/controllers/index.js
import { application } from "controllers/application"
import CoverController from "controllers/cover_controller"
import HelloController from "controllers/hello_controller"

application.register("cover", CoverController)
application.register("hello", HelloController)
