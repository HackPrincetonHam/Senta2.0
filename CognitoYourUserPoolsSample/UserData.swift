//
//  UserData.swift
//  CognitoYourUserPoolsSample
//
//  Created by 何幸宇 on 11/4/17.
//  Copyright © 2017 Dubal, Rohan. All rights reserved.
//

import Foundation
import AWSCore
import AWSCognito
import AWSCognitoIdentityProvider

func getUserInfo(user: AWSCognitoIdentityUser?){
    
user?.getDetails().continueOnSuccessWith { (task) -> AnyObject? in

    if let response = task.result
    {
        for info in response.userAttributes!{
            UserInfor[info.name!] =  info.value!
        }
    }
    return nil
    }
    
}

var UserInfor:[String:String] = [:]

