//
//  MyView.swift
//  SwiftTemplet
//
//  Created by hsf on 2018/8/16.
//  Copyright © 2018年 BN. All rights reserved.
//

import UIKit

class MyView: UIView {

    var mblock:ViewClick?
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        self.backgroundColor = UIColor.purple;
        
        let tap = UITapGestureRecognizer(target: self, action:#selector(handActionTap(tap:)));
        self.isUserInteractionEnabled = true;
        
        self.addGestureRecognizer(tap);
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        fatalError("init(coder:) has not been implemented")

    }
    
    override func layoutSubviews() {
        super.layoutSubviews();
        
    }
    
    //假装我有一个button添加了点击事件
    @objc func handActionTap(tap:UITapGestureRecognizer) -> Void{
        if self.mblock != nil{
            self.mblock!(tap,self,self.tag);
            
        }
    }

    func block(action:@escaping(ViewClick)) -> Void {
        self.mblock = action;
    }
    
}
