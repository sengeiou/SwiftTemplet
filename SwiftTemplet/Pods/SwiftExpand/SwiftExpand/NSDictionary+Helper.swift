//
//  NSDictionary+Helper.swift
//  SwiftTemplet
//
//  Created by hsf on 2018/9/4.
//  Copyright © 2018年 BN. All rights reserved.
//

import UIKit


public extension Dictionary{
    

}

public extension NSDictionary{
    
    public func toJsonString() -> String! {
        let jsonString = self.jsonValue().removingPercentEncoding!;
        return jsonString;
    }
    
    
    
}