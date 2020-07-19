//
//  UITableViewCellSudokuButton.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2020/6/19.
//  Copyright © 2020 BN. All rights reserved.
//

import UIKit
import SwiftExpand
///九宫格

@objcMembers class UITableViewCellSudokuButton: UITableViewCell {

    var numOfRow: Int = 3
    
    var row: Int = 3
    
    var lineSpacing: CGFloat = 10{
        willSet{
            setNeedsLayout()
        }
    }

    var interitemSpacing: CGFloat = 10{
        willSet{
            setNeedsLayout()
        }
    }

    var inset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10){
        willSet{
            setNeedsLayout()
        }
    }

    var itemType: UIButton.Type = UIButton.self{
        willSet{
            setNeedsLayout()
        }
    }

    // MARK: -lazy
    lazy var items: [UIButton] = {
        return self.contentView.updateItems(self.row*self.numOfRow, type: self.itemType) {
            $0.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            $0.setTitle("\(self.itemType)\($0.tag)", for: .normal)
            $0.setTitleColor(.systemBlue, for: .normal)
        }
    }()
    
    // MARK: -life cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
  
    }
        
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews();
        
        setupConstraint()
    }
    
    func setupConstraint() {
        if bounds.height <= 10.0 {
            return;
        }
        
        if row == 1 {
            items.snp.distributeViewsAlong(axisType: .horizontal, fixedSpacing: interitemSpacing, leadSpacing: inset.left, tailSpacing: inset.right)
            items.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(inset.top)
                make.bottom.equalToSuperview().offset(-inset.bottom)
            }
            return
        }
        
        items.snp.distributeSudokuViews(fixedLineSpacing: lineSpacing, fixedInteritemSpacing: interitemSpacing, warpCount: numOfRow, edgeInset: inset)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    // MARK: -funtions
    
}
