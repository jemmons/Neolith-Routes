import Foundation
import Neolith



// MARK: - INIT
public class Routes {
  private let routes: [Route.Type]

  
  lazy public var pipe: InputPipe = { request, fileIO, completion in
    for routeFactory in self.routes {
      if let route = routeFactory.init(request: request) {
        route.response(completion: completion)
        return
      }
    }
    completion(nil)
  }

  
  init(_ someRoutes: [Route.Type]) {
    routes = someRoutes
  }
}
