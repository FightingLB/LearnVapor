import Vapor
import Authentication

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "It works" example
    router.get { req in
        return "It works!"
    }
    
    // Basic "Hello, world!" example
    router.get("hello") { req in
        return "hello world!"
    }
    
    router.get("hello", String.parameter) { req -> String in
        let name = try req.parameters.next(String.self)
        guard name != "Bob" else {
            throw Abort(.forbidden, reason: "该昵称已被使用")
        }
        return "hello \(name)!"
    }
    
    router.post(UserInfo.self, at: "user-info") { req, data -> UserInfo in
//        return "hello \(data.name) you are \(data.age)!"
        return data
    }

    // Example of configuring a controller
    let todoController = TodoController()
    router.get("todos", use: todoController.index)
    router.post("todos", use: todoController.create)
    router.delete("todos", Todo.parameter, use: todoController.delete)
}

struct UserInfo: Content {
    let name: String
    let age: Int
}

struct UserInfoResponse: Content {
    let request: UserInfo
}
/*
struct User: Model {
    var id: Int?
    var name: String
    var email: String
    var passwordHash: String
    
    var tokens: Children<User, UserToken> {
        return children(\.userID)
    }
}

struct UserToken: Model {
    var id: Int?
    var string: String
    var userID: User.ID
    
    var user: Parent<UserToken, User> {
        return parent(\.userID)
    }
}

extension UserToken: Token {
    /// See `Token`.
    typealias UserType = User
    
    /// See `Token`.
    static var tokenKey: WritableKeyPath<UserToken, String> {
        return \.string
    }
    
    /// See `Token`.
    static var userIDKey: WritableKeyPath<UserToken, User.ID> {
        return \.userID
    }
}

extension User: TokenAuthenticatable {
    /// See `TokenAuthenticatable`.
    typealias TokenType = UserToken
 }
 */
