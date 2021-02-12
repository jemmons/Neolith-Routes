import Foundation



// MARK: - INIT
public class PathMatcher {
  private let pathComponents: [PathComponent]
  
  
  public init(_ somePathComponents: [PathComponent]) {
    pathComponents = somePathComponents
  }
}



// MARK: - PUBLIC
public extension PathMatcher {
  enum Error: LocalizedError {
    case notFound
    case sizeMismatch
    
    public var errorDescription: String? {
      switch self {
      case .notFound:
        return "Matching path not found."
      case .sizeMismatch:
        return "There are more matching components than there are components in the path."
      }
    }
  }
  
  enum PathComponent {
    /// A path component that matches other path components by string comparison.
    case text(String)
    /// A path component that matches any non-nil path component.
    case wildcard
    /// A path component that matches any non-nill path component and assigns the value to the given name.
    case bind(String)
  }
  
  
  func matches(path: String) -> Bool {
    return (try? bind(path: path)) != nil
  }
  
  
  func bind(path: String) throws -> (captures: [String: String], rest: [String]) {
    let matchComponents = path.components(separatedBy: "/").compactMap { $0.isEmpty ? nil : $0 }
    guard matchComponents.count >= pathComponents.count else {
      throw PathMatcher.Error.sizeMismatch
    }
    
    let matchPrefix = matchComponents.prefix(pathComponents.count)
    let rest = Array(matchComponents.dropLast(pathComponents.count))
    var captures: [String: String] = [:]

    let matches = zip(matchPrefix, pathComponents).allSatisfy { toMatch, component in
      switch component {
      case .text(let s):
        return toMatch == s
      case .wildcard:
        return true
      case .bind(let key):
        captures[key] = toMatch
        return true
      }
    }
    
    guard matches else {
      throw PathMatcher.Error.notFound
    }
    
    return (captures: captures, rest: rest)
  }
}



// MARK: - STRING LITERAL
extension PathMatcher.PathComponent: ExpressibleByStringLiteral {
  public init(stringLiteral value: String) {
    self = .text(value)
  }
}

