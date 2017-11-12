//
//  AWSDynamoDB.swift
//  CognitoYourUserPoolsSample
//
//  Created by 何幸宇 on 11/3/17.
//  Copyright © 2017 Dubal, Rohan. All rights reserved.
//

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

//func save_gift_DDB(likes: Array<String>, dislikes: Array<String>, price_range: String, completion: ()->Void) {
//
//    let dynamoDBObjectMapper = AWSDynamoDBObjectMapper.default()
//    let GiftDataItem : GiftData = GiftData()
//
//    GiftDataItem._userId = UserInfor["sub"]!
//    GiftDataItem._likes = likes
//    GiftDataItem._dislikes = dislikes
//    GiftDataItem._price_range = price_range
//
//    dynamoDBObjectMapper.save(GiftDataItem) { (error) in
//
//        if error != nil {
//            print(error!)
//            return
//        } else {
//            print("SAVED!")
//        }
//    }
//    completion()
//}

//func save_reindeer_DDB(drop_date: String, drop_location: String, drop_time_range: String, identity: String, completion: ()->Void) {
//
//    let dynamoDBObjectMapper = AWSDynamoDBObjectMapper.default()
//    let ReindeerDataItem : ReindeerData = ReindeerData()
//
//    ReindeerDataItem._userId = UserInfor["sub"]!
//    ReindeerDataItem._drop_date = drop_date
//    ReindeerDataItem._drop_location = drop_location
//    ReindeerDataItem._drop_time_range = drop_time_range
//    ReindeerDataItem._identity = identity
//
//    dynamoDBObjectMapper.save(ReindeerDataItem) { (error) in
//
//        if error != nil {
//            print(error!)
//            return
//        } else {
//            print("SAVED!")
//        }
//    }
//    completion()
//}


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
func query_DDB(completion:@escaping (Roles)->Void){
    
    // 1) Configure the query
    
    let queryExpression = AWSDynamoDBQueryExpression()
    
    //you can only put rangeKey and partition key here
    queryExpression.keyConditionExpression = "#otherID = :otherID"
    
    //to use filter expression, you need to user # and in combination with attributeValues
    queryExpression.filterExpression = "#text = :text"
    
    //the otherID needs to be the name of the attribute or the name of the with the addition of "#" in the front and in combination with expressionAttributeNames. add "#attributeionName" = "attributionName"
    //    queryExpression.expressionAttributeNames = [
    //        "abcd" : "otherID"
    //    ]
    
    queryExpression.expressionAttributeNames = [
        "#text" : "text",
        "#otherID" : "otherID"
    ]
    
    queryExpression.expressionAttributeValues = [
        ":otherID" : "4c9c7d6e-9df1-4696-b4da-ecfd55cb1b52",
        ":text" : "a"
    ]
    
    // 2) Make the query
    
    let dynamoDbObjectMapper = AWSDynamoDBObjectMapper.default()
    
    dynamoDbObjectMapper.query(Roles.self, expression: queryExpression) { (output: AWSDynamoDBPaginatedOutput?, error: Error?) in
        if error != nil {
            print("The request failed. Error: \(String(describing: error))")
        }
        if output != nil {
            for news in output!.items {
                let newsItem = news as? Roles
                completion(newsItem!)
            }
        }
    }
}
