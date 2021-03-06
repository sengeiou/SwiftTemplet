//
//  NNClockView.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2018/9/6.
//  Copyright © 2018年 BN. All rights reserved.
//

import UIKit

class NNClockView: UIImageView {
    
    var aniDuration: Double = 12
       
    //1 声明变量
    var itemList: [String]? {
        willSet {
            newValue?.forEach { (obj: String) in
                
                let btn = UIButton(type: .custom);
                btn.setBackgroundImage(UIImage(color: .theme), for: .normal)
//                btn.setImage(UIImage(named: "tabbar_add"), for:.normal);
                btn.setTitle(obj, for: .normal);
                btn.titleLabel?.adjustsFontSizeToFitWidth = true;
                btn.addTarget(self, action: #selector(handleAction(_:)), for: .touchUpInside);
                
                addSubview(btn);
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        // 圆心
        let center = CGPoint(x: bounds.width * 0.5, y: bounds.height * 0.5);
        // 圆半径
        let radius: CGFloat = bounds.height/2.3;
        let rect = CGRect(x: 0, y: 0, width: bounds.height*0.15, height: bounds.height*0.15);
        
        //2 初始化视图
        for i in 0..<subviews.count {
            guard let view = subviews[i] as? UIButton else { return }
            view.tag = i;
            
            let angle = 2 * CGFloat(Double.pi) * CGFloat(i) / CGFloat(self.subviews.count);
            view.frame = rect;
            view.center = CGPoint(x: center.x + radius*cos(angle), y: center.y + radius*sin(angle));
            //附属效果
            view.animRotation(isClockwise: false, duration: aniDuration, repeatCount: MAXFLOAT, key: nil);
            
            view.layer.cornerRadius = view.frame.width/2.0;
            view.layer.masksToBounds = true;
        }
    }
    
    @objc func handleAction(_ sender:UIButton){
        print("tag_",sender.tag);
        
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
//    override func draw(_ rect: CGRect) {
//        let frame = self.bounds;
//        // 圆心
//        let center = CGPoint(x: Double(frame.width * 0.5), y: Double(frame.height * 0.5));
//        // 圆半径
//        let radius: CGFloat = frame.height/2.3;
//        let rect = CGRect(x: 0, y: 0, width: frame.height*0.15, height: frame.height*0.15);
//
//
//        //2 初始化视图
//        for i in 0..<self.subviews.count {
//            let view = self.subviews[i]
//            view.tag = i;
//
//            let angle = 2 * CGFloat(Double.pi) * CGFloat(i) / CGFloat(self.subviews.count);
//            view.frame = rect;
//            view.center =  CGPoint(x: center.x + radius*cos(angle), y: center.y + radius*sin(angle));
//            view.aniRotation(isClockwise: false, kDurationRotation, MAXFLOAT, nil);
//
//            view.layer.cornerRadius = view.frame.width/2.0;
//            view.layer.masksToBounds = true;
//        }
//    }
    
    
    

}
