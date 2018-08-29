//
//  FirstViewController.swift
//  SwiftTemplet
//
//  Created by hsf on 2018/8/10.
//  Copyright © 2018年 BN. All rights reserved.
//

import UIKit


class FirstViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        title = NSStringFromSelector(#function);
        view.backgroundColor = UIColor.green;
        
        self.view.addSubview(self.tableView);
        
        print(self);
        DDLog(NSStringFromClass(self.classForCoder));

        title = self.controllerName;
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        for _ in 0...5{
            let marr : NSMutableArray = [];
            for j in 0...3{
                marr.add(j);
                
            }
            self.dataList.add(marr);
        }
//        print(self.dataList);
        self.tableView.reloadData();
    }

    
    //    MARK: - tableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataList.count;
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let arraySection : NSArray = self.dataList[section] as! NSArray;
        return arraySection.count;
    };
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60;
    };
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCellOne = UITableViewCellOne.cellWithTableView(tableView) as! UITableViewCellOne;

        cell.labelLeft.text = String.init(format: "section_%d,row_%d", indexPath.section,indexPath.row);
        cell.labelRight.text = "990" + "\(indexPath.row)";
        cell.imgViewLeft.image = UIImage(named: "dragon.png");
        cell.imgViewRight.isHidden = false;

//        cell.type = 1;
        
        cell.getViewLayer();
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45;
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel(frame: CGRect(x:0,y:0,width:0,height:0));
        label.backgroundColor = UIColor.green;
        label.text = "header";
        return label;
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 45;
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let label = UILabel(frame: CGRect(x:0,y:0,width:0,height:0));
        label.backgroundColor = UIColor.yellow;
        
        label.text = "footer";
        return label;
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - layz
    //    lazy var tableView: UITableView = {
    //        let table = UITableView(frame:self.view.bounds, style:UITableViewStyle.grouped);
    //        table.dataSource = self;
    //        table.delegate = self;
    //
    //        return table;
    //    }();
    
}

