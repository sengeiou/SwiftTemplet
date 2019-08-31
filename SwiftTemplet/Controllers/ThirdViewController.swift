
//
//  ThirdViewController.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2018/8/10.
//  Copyright © 2018年 BN. All rights reserved.
//

import UIKit
import SwiftExpand
import HandyJSON
import Moya

class ThirdViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        tableView.tableFooterView = footerView
//        view.addSubview(tableView)
        view.addSubview(plainView)
        
        
        if title == nil {
            title = self.controllerName;
        }
        
        createBarItem( .action, isLeft: true) { (sender: AnyObject) in
            self.goController("FleetDetailControllerNew", obj: nil, objOne: nil)
        }
        
        createBarItem( .done, isLeft: false) { (sender: AnyObject) in
            self.goController("IOPAuthDetailController", obj: nil, objOne: nil)
            
        }
        
//        view.addSubview(dateRangeView)
        
        let layout = UICollectionViewLayout()
        layout.minimumInteritemSpacing = 0.3
        layout.minimumLineSpacing = 0.5
        layout.headerReferenceSize = CGSize(width: 33, height: 54)
        layout.sectionInset = UIEdgeInsets(top: 1, left: 2, bottom: 3, right: 4)
        DDLog(layout.minimumInteritemSpacing,layout.minimumLineSpacing,layout.headerReferenceSize,layout.sectionInset)
        
//        UIApplication.updateVersion(appStoreID: kAppStoreID, isForce: false);
        view.getViewLayer()
     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
//        list = allList.randomElement()!;
//        tableView.reloadData()
        
        var controller = "CustomViewController"
        controller = "PickerViewController"
//        return
//        goController(controller, obj: nil, objOne: nil)
        let updateAPi = NNCheckVersApi()
        updateAPi.startRequest(success: { (manager, dic, error) in
            
            let data: Data! = try? JSONSerialization.data(withJSONObject: dic as Any, options: []);
            let jsonString: String! = String(data: data, encoding: .utf8);
            let string: String! = jsonString.replacingOccurrences(of: "\\", with: "")
//            DDLog(string)
            if let response = ESCheckVersRootClass.deserialize(from: dic) {
//                DDLog(response)
            }

        }) { (manager, dic, error) in
            DDLog(error! as Any)
            
        }
        
        updateAPi.startRequest { (manager, dic, error) in
            let data: Data! = try? JSONSerialization.data(withJSONObject: dic as Any, options: []);
            let jsonString: String! = String(data: data, encoding: .utf8);
            let string: String! = jsonString.replacingOccurrences(of: "\\", with: "")
            
//            DDLog(string)
//            if let response = NNCheckVersRootClass.deserialize(from: dic) {
//                DDLog(response)
//
//            }
            if let response = ESCheckVersRootClass.deserialize(from: dic) {
//                DDLog(response)
                
            }         
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tbView.frame = view.bounds
    }
    
    //    MARK: - tableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count;
    };
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    };
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let itemList = list[indexPath.row]
        
//        let cell = UITableViewCellZero.cellWithTableView(tableView) as! UITableViewCellZero;
        let cell = UITableViewCell.cellWithTableView(tableView, identifier: "cell1", style: .subtitle) as? UITableViewCell;
        cell!.accessoryType = .disclosureIndicator;

        cell!.textLabel!.text = itemList[0]
        cell!.textLabel?.textColor = UIColor.theme;
        cell!.detailTextLabel?.text = itemList[1];
        cell!.detailTextLabel?.textColor = UIColor.gray;
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let itemList = list[indexPath.row]
        DDLog(itemList);
        goController(itemList.last, obj: nil, objOne: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10;
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView();
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01;
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let label = UILabel(frame: .zero);
        //        label.backgroundColor = .green;
        //        label.text = "header\(section)";
        return label;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: -lazy
    lazy var dateRangeView: NNDateRangeView = {
        let frame = CGRect(x: 20, y: 20, width: kScreenWidth - 40, height: 60)
        var view = NNDateRangeView(frame: .zero)
        view.autoresizingMask = UIView.AutoresizingMask(rawValue: UIView.AutoresizingMask.flexibleWidth.rawValue | UIView.AutoresizingMask.flexibleHeight.rawValue)
        view.backgroundColor = .green
        return view
    }()
    
    lazy var allList: [[[String]]] = {
        var array: [[[String]]] = [
            [["通用录入界面", "EntryViewController"],
             ["导航栏下拉菜单", "TitleViewController"],
             ["UICollectionView展示", "UICollectionDispalyController"],
             ["自定义View", "CustomViewController"],
             ["CalenderView", "CalendarViewController"],
             ["Timer", "TimerViewController"],
             ["PickerView", "PickerViewController"],
             ["PictureView", "PhotosViewController"],
             ["KeyBoardView", "KeyBoardViewController"],
             ["函数响应型编程", "BNUserLogInController"],
             ["滚动分段组件", "ScrollHorizontalController"],
             ["分段组件", "ScrollViewController"],             
             ["新想法测试", "TestViewController"],
             ],
        ]
        return array
    }()
    
    lazy var list:[[String]] = {
        return self.allList.first!;
    }()
    
    //MARK: -Lazy Property
    lazy var footerView: NNTableFooterView = {
        var view = NNTableFooterView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 150))
        view.label.text = ""
        view.label.textAlignment = .center
        view.btn.setTitle("提交", for: .normal)
        view.btn.addActionHandler({[weak self] (sender:UIControl) in
            let obj = sender as! UIButton
            DDLog(obj.tag)
            
            }, for: .touchUpInside)
        return view
    }()
    
    lazy var plainView: UIView = {
        var view = NNTablePlainView(frame: self.view.bounds)
        view.list = allList.first
        view.blockCellForRow({ (tableView, indexPath) -> UITableViewCell in
            let itemList = view.list![indexPath.row] as! [String]
            
//            let cell = UITableViewCellZero.cellWithTableView(tableView) as! UITableViewCellZero;
//            cell.textLabel!.text = itemList[0]
            
//            let cell = UITableViewCell.cellWithTableView(tableView, identifier: "cell1", style: .subtitle) as UITableViewCell;
            let cell = UITableViewCell.dequeueCell(tableView, identifier: "cell1", style: .subtitle) as UITableViewCell;

            cell.accessoryType = .disclosureIndicator;
            
            cell.textLabel!.text = itemList[0]
            cell.textLabel!.textColor = UIColor.theme;
            cell.detailTextLabel?.text = itemList[1];
            cell.detailTextLabel?.textColor = UIColor.gray;
            return cell
        })
        
        view.blockDidSelectRow({ (tableView, indexPath) in
            let itemList = view.list![indexPath.row] as! [String]
            DDLog(itemList);
            self.goController(itemList.last, obj: itemList.first as AnyObject?, objOne: nil)
        })
        
        return view
    }()
}
