import Foundation
import AWSCore
import AWSDynamoDB

//to update, you need to have the same sort key. Even if you have different partition key, save method would update.
func save_role_DDB(role: String, completion: @escaping ()->Void){
    
    let dynamoDBObjectMapper = AWSDynamoDBObjectMapper.default()
    let roleItem : Roles = Roles()
    roleItem._userId = UserInfor["sub"]!
    roleItem._role = role
    
    dynamoDBObjectMapper.save(roleItem) { (error) in
        if error != nil{
            print(error!)
            return
        }else{
            print("SAVED!")
            completion()
        }
    }
    
}

func delete_role_DDB(role: String, completion: @escaping ()->Void){
    
    let dynamoDBObjectMapper = AWSDynamoDBObjectMapper.default()
    let roleItem : Roles = Roles()
    roleItem._userId = UserInfor["sub"]!
    roleItem._role = role
    
    dynamoDBObjectMapper.remove(roleItem) { (error) in
        if error != nil{
            print(error!)
            return
        }else{
            print("SAVED!")
            completion()
        }
    }
}

func save_gift_DDB(likes: Array<String>, dislikes: Array<String>, price_range: String, completion: ()->Void) {

    let dynamoDBObjectMapper = AWSDynamoDBObjectMapper.default()
    let GiftDataItem : GiftData = GiftData()

    GiftDataItem._userId = UserInfor["sub"]!
    GiftDataItem._likes = likes
    GiftDataItem._dislikes = dislikes
    GiftDataItem._price_range = price_range

    dynamoDBObjectMapper.save(GiftDataItem) { (error) in

        if error != nil {
            print(error!)
            return
        } else {
            print("SAVED!")
        }
    }
    completion()
}

func save_reindeer_DDB(drop_date: NSNumber, drop_location: String, identity: String, completion: ()->Void) {

    let dynamoDBObjectMapper = AWSDynamoDBObjectMapper.default()
    let ReindeerDataItem : ReindeerData = ReindeerData()

    ReindeerDataItem._userId = UserInfor["sub"]!
    ReindeerDataItem._drop_time = drop_date
    ReindeerDataItem._drop_location = drop_location
    ReindeerDataItem._identity = identity

    dynamoDBObjectMapper.save(ReindeerDataItem) { (error) in

        if error != nil {
            print(error!)
            return
        } else {
            print("SAVED!")
        }
    }
    completion()
}


func read_DDB( completion:@escaping (Roles)->Void){
    let dynamoDBObjectMapper = AWSDynamoDBObjectMapper.default()
    
    dynamoDBObjectMapper.load(Roles.self, hashKey: UserInfor["sub"]!, rangeKey: "11/4/17, 11:55 PM") { (item, Error) in
        if Error != nil{
            print(Error!)
        }else{
            if let roleItem = item as? Roles{
                completion(roleItem)
            }
        }
    }
}

//query is for viewing multiple items.
func query_DDB(completion:@escaping (Roles?)->Void){
    print(UserInfor["sub"])
    
    // 1) Configure the query
    
    let queryExpression = AWSDynamoDBQueryExpression()
    
    //you can only put rangeKey and partition key here
    queryExpression.keyConditionExpression = "#user_sub = :user_sub"
    
    //to use filter expression, you need to user # and in combination with attributeValues
//    queryExpression.filterExpression = "#text = :text"
    
    //the otherID needs to be the name of the attribute or the name of the with the addition of "#" in the front and in combination with expressionAttributeNames. add "#attributeionName" = "attributionName"
    //    queryExpression.expressionAttributeNames = [
    //        "abcd" : "otherID"
    //    ]
    
    queryExpression.expressionAttributeNames = [
//        "#text" : "text",
        "#user_sub" : "user_sub"
    ]
    
    queryExpression.expressionAttributeValues = [
        ":user_sub" : UserInfor["sub"]!
    ]
    
    // 2) Make the query
    
    let dynamoDbObjectMapper = AWSDynamoDBObjectMapper.default()
    
    dynamoDbObjectMapper.query(Roles.self, expression: queryExpression) { (output: AWSDynamoDBPaginatedOutput?, error: Error?) in
        if error != nil {
            print("The request failed. Error: \(String(describing: error))")
            completion(nil)
        }
        if output != nil {
            if output!.items.count != 0{
            for news in output!.items {
                guard let newsItem = news as? Roles else {
                    completion(nil)
                    return
                }
                completion(newsItem)
            }
            }else{
                completion(nil)
            }
        }
    }
}
