import Foundation
import Neolith



public protocol Route {
  init?(request: NeolithRequest)
  func response(completion: (NeolithResponse) -> Void)
}
