import Foundation
import UIKit
import AWSDynamoDB

class ReindeerData: AWSDynamoDBObjectModel, AWSDynamoDBModeling {
    
    var _userId: String?
    var _drop_location: String?
    var _drop_time: NSNumber?
    var _identity: String?
    static var _tableName: String = "ReindeerTable"
    static var _hashKeyAttribute: String = "time"
    static var _rangeKeyAttribute: String = "user_sub"
    
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
        "_userId" : _rangeKeyAttribute,
        "_drop_location" : "drop_location",
        "_drop_time" : _hashKeyAttribute,
        "_identity" : "identity"
        ]
    }
}
