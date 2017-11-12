
import Foundation
import UIKit
import AWSDynamoDB

class Roles: AWSDynamoDBObjectModel, AWSDynamoDBModeling {
    
    var _userId: String?
    var _role: String?
    static var _tableName: String = "RoleTable"
    static var _hashKeyAttribute: String = "user_sub"
    static var _rangeKeyAttribute: String = "role"
    
    
    
    class func dynamoDBTableName() -> String {

        return _tableName
    }
    
    class func hashKeyAttribute() -> String {

        return _hashKeyAttribute
    }
    
    class func rangeKeyAttribute() -> String {
        
        return _rangeKeyAttribute
    }
    
    override class func jsonKeyPathsByPropertyKey() -> [AnyHashable: Any] {
        return [
                "_role" : _rangeKeyAttribute,
               "_userId" : _hashKeyAttribute,
        ]
    }
}


