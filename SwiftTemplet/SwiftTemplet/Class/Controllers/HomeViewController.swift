//
//  HomeViewController.swift
//  SwiftTemplet
//
//  Created by hsf on 2018/8/10.
//  Copyright © 2018年 BN. All rights reserved.
//

import UIKit

class HomeViewController: UITabBarController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tabBar.tintColor = kC_ThemeCOLOR;
        tabBar.barTintColor = UIColor.white;

        self.viewControllers = self.getControllers(itemList: itemList);

        self.selectedIndex = 1;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        self.configureCenterBtn();

    }
    
    func getControllers(itemList:Array<Array<Any>>) -> Array<UIViewController> {

        let marr = NSMutableArray.init();
        
        for obj in itemList {
            let controller = BN_ControllerFromString(obj.first! as! String);
            controller.title = obj[1] as? String;
            controller.tabBarItem.image = UIImage(named: obj[2] as! String)?.withRenderingMode(.alwaysOriginal);
            controller.tabBarItem.selectedImage = UIImage(named: obj[3] as! String)?.withRenderingMode(.alwaysOriginal);
            
            let navController = UINavigationController(rootViewController: controller);
            let dic:Dictionary = [NSAttributedStringKey.foregroundColor : UIColor.white,
                                  NSAttributedStringKey.font  : UIFont.boldSystemFont(ofSize: 17),
                                  ];
            
            navController.navigationBar.titleTextAttributes = dic;
            marr.add(navController);
            
        }
        return marr as! Array<UIViewController>;
    }
    
    lazy var btnCenter : UIButton = {
        let btn = UIButton();
        btn.backgroundColor = kC_ThemeCOLOR;
        btn.setImage(UIImage(named: "tabbar_add"), for:.normal);
        btn.addTarget(self, action: #selector(handleActionSender(_:)), for: .touchUpInside);
        
        return btn;
    }();
    
    func configureCenterBtn() -> Void {
        tabBar.addSubview(btnCenter);
        
        let width = tabBar.bounds.width / CGFloat(viewControllers!.count);
        let rect = CGRect(x: 0, y: 0, width: width, height:tabBar.bounds.height);
        btnCenter.frame = rect.offsetBy(dx: width*2, dy: 0);
        
    }
    
    @objc func handleActionSender(_ sender:UIButton){
        let navController = UINavigationController(rootViewController: CenterViewController());
        navController.navigationBar.tintColor = UIColor.white;
        navController.navigationBar.barTintColor = UIColor.orange;
        let dic:NSDictionary = [NSAttributedStringKey.foregroundColor:UIColor.white,
                                NSAttributedStringKey.font:UIFont.systemFont(ofSize: 18),
                                ];
        navController.navigationBar.titleTextAttributes = dic as? [NSAttributedStringKey : Any];
        self.present(navController, animated: true, completion: nil);
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    let itemList:Array = { () -> Array<[String]> in

        let list:Array = [
            ["FirstViewController", "首页", "Item_first_N", "Item_first_H"],
            ["SecondViewController", "圈子", "Item_second_N", "Item_second_H"],
//            ["CenterViewController", "概况",  "Item_center_N",  "Item_center_H"],
            ["FifthViewControlle", "概况",  "Item_center_N",  "Item_center_H"],
            ["ThirdViewController", "消息", "Item_third_N", "Item_third_H"],
            ["FourthViewController", "我的",  "Item_fourth_N",  "Item_fourth_H"],
            
            ];
        return list;
    }();
    
}