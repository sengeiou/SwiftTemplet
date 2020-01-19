//
//  UICTViewCellOne.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2018/12/23.
//  Copyright © 2018 BN. All rights reserved.
//

import UIKit

import SnapKit
import SwiftExpand

class UICTViewCellOne: UICollectionViewCell {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imgView)
        contentView.addSubview(label)
        
        label.textAlignment = .center
        imgView.image = UIImage(named: kIMG_defaultFailed_S);
//        label.backgroundColor = UIColor.random
//        imgView.backgroundColor = UIColor.random
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if label.isHidden == true {
            imgView.snp.makeConstraints { (make) in
                make.edges.equalToSuperview()
            }
            return;
        }
        
        if imgView.isHidden == true {
            label.snp.makeConstraints { (make) in
                make.edges.equalToSuperview()
            }
            return;
        }
        
        imgView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(0)
            make.left.right.equalToSuperview();
            make.bottom.equalToSuperview().offset(-kH_LABEL)
        }
        
        label.snp.makeConstraints { (make) in
            make.top.equalTo(imgView.snp.bottom).offset(0)
            make.left.right.equalTo(imgView)
            make.height.equalTo(kH_LABEL)
        }
    }
    
}
