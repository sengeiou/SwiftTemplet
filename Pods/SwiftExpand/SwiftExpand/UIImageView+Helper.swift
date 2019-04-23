//
//  UIImageView+Helper.swift
//  SwiftExpand
//
//  Created by Bin Shang on 2018/12/27.
//

import UIKit

extension UIImageView{

    ///MARK:默认渲染AlwaysTemplate方式
    @objc public func renderTintColor(_ tintColor:UIColor) -> Void {
        renderTintColor(tintColor, mode: .alwaysTemplate);
    }
    
    ///MARK:渲染
    @objc public func renderTintColor(_ tintColor:UIColor, mode: UIImage.RenderingMode) -> Void {
        self.tintColor = tintColor
        self.image = self.image!.withRenderingMode(mode)
//        self.image = self.image!.withRenderingMode( .alwaysTemplate)
        
    }
    
}


