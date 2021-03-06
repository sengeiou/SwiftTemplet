//
//  BNTableViewCellView.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2019/1/17.
//  Copyright © 2019 BN. All rights reserved.
//

import UIKit
import SnapKit

import SwiftExpand
/// 图片+文字+文字+图片
class NNContentCellView: UIView {
    var cellStyle: UITableViewCell.CellStyle = .default

    var inset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    var imageSize = CGSize.zero
    var btnSize = CGSize(width: 8, height: 13)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView);
        addSubview(textLabel);
        addSubview(detailTextLabel);
        addSubview(btn)

        textLabel.textColor = .textColor3
        detailTextLabel.textColor = .textColor3

        detailTextLabel.numberOfLines = 1;
        textLabel.numberOfLines = 1;
        btn.setTitle(">", for: .normal)
        btn.setTitleColor(.gray, for: .normal)
        
        imageView.layer.borderColor = UIColor.gray.cgColor
        imageView.layer.borderWidth = 0.5
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupConstraint()
    }
    
    func setupConstraint() {
        if bounds.height < 10 {
            return
        }
        
        let height = bounds.height - inset.top - inset.bottom
        let labStartX = imageView.isHidden ? inset.left : height + inset.left + kPadding
        let labEndX = btn.isHidden == false ? btnSize.width + inset.right + kPadding : inset.right

        if btn.isHidden == false {
            btn.snp.makeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.right.equalToSuperview().offset(-inset.right);
                make.size.equalTo(btnSize);
            }
        }
        
        if imageView.isHidden == false {
            imageView.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(inset.top);
                make.left.equalToSuperview().offset(inset.left);
                make.width.height.equalTo(height);
            }
        }
        
//        textLabel.snp.removeConstraints()
//        detailTextLabel.snp.removeConstraints()

        switch cellStyle {
        case .subtitle:
            detailTextLabel.textAlignment = .left;

            textLabel.snp.remakeConstraints { (make) in
                make.top.equalToSuperview().offset(inset.top)
                make.left.equalToSuperview().offset(labStartX)
                make.right.equalToSuperview().offset(-labEndX)
                make.height.equalTo((height - 5)/2.0)
            }

            detailTextLabel.snp.remakeConstraints { (make) in
                make.top.equalTo(textLabel.snp.bottom).offset(5)
                make.left.equalToSuperview().offset(labStartX)
                make.right.equalToSuperview().offset(-labEndX)
                make.height.equalTo(textLabel)
            }

        case .value1:
            let size = detailTextLabel.sizeThatFits(.zero)
            detailTextLabel.snp.remakeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.right.equalToSuperview().offset(-labEndX)
                make.width.lessThanOrEqualTo(size.width)
                make.height.equalTo(height)
            }
            
            textLabel.snp.remakeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.left.equalToSuperview().offset(labStartX)
                make.right.equalTo(detailTextLabel.snp.left).offset(-kPadding)
                make.height.equalTo(height)
            }
            
        default:
            let size = textLabel.sizeThatFits(.zero)
            textLabel.snp.remakeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.left.equalToSuperview().offset(labStartX)
                make.width.lessThanOrEqualTo(size.width)
                make.height.equalTo(height)
            }
            
            detailTextLabel.snp.remakeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.left.equalTo(textLabel.snp.right).offset(kPadding)
                make.right.equalToSuperview().offset(-labEndX)
                make.height.equalTo(height)
            }
        }
    }
  
    
    //MARK: -lazy
    
    lazy var imageView: UIImageView = {
        var view = UIImageView(frame: .zero);
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.isUserInteractionEnabled = true;
        view.contentMode = .scaleAspectFit;
        
        return view;
    }()
    
    lazy var btn: UIButton = {
        let view = UIButton(type: .custom);
        view.tag = 1;
        
        view.titleLabel?.font = UIFont.systemFont(ofSize: 16);
        view.setTitle(kTitleSure, for: .normal);
        view.setTitleColor(.systemBlue, for: .normal);
        view.addActionHandler({ (control) in
            DDLog(control)

        }, for: .touchUpInside)
        return view;
    }();
    
    lazy var textLabel: UILabel = {
        var view = UILabel(frame: .zero);
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.font = UIFont.systemFont(ofSize: 16);

        view.textAlignment = .left;
        view.numberOfLines = 0;
        view.lineBreakMode = .byCharWrapping;
        view.isUserInteractionEnabled = true;
  
        return view;
    }()
    
    lazy var detailTextLabel: UILabel = {
        var view = UILabel(frame: .zero);
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.font = UIFont.systemFont(ofSize: 16);

        view.textAlignment = .right;
        view.numberOfLines = 0;
        view.lineBreakMode = .byCharWrapping;
        view.isUserInteractionEnabled = true;
    
        return view;
    }()
    
}
