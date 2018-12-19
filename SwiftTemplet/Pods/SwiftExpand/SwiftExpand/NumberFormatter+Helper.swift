//
//  NumberFormatter+Helper.swift
//  SwiftTemplet
//
//  Created by dev on 2018/12/11.
//  Copyright © 2018年 BN. All rights reserved.
//

import Foundation

public extension NumberFormatter{
    
    public static func numberFormat(identify:String) -> NumberFormatter {
        
        let dic = Thread.current.threadDictionary;
        if dic.object(forKey: identify) != nil {
            return dic.object(forKey: identify) as! NumberFormatter;
        }
        
        let fmt = NumberFormatter();
        fmt.locale = .current;
        dic.setObject(fmt, forKey: identify as NSCopying)
        return fmt;
    }
    
}