//
//  EntryViewController.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2019/1/11.
//  Copyright © 2019 BN. All rights reserved.
//

import UIKit
import SwiftExpand
import SDWebImage

class EntryViewController: UIViewController {
    
    var dataModel = NSObject()

    //MARK: -lazy
    lazy var tableView: UITableView = {
        let view: UITableView = UITableView.create(self.view.bounds, style: .plain, rowHeight: 50)
        view.dataSource = self
        view.delegate = self

        return view
    }()
        
    // MARK: -life cycle
    deinit {
        DDLog(1111)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableView.automaticDimension;
        tableView.estimatedRowHeight = 70;

//        _ScrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
        tableView.tableFooterView = footerView
        view.addSubview(tableView);

    
        view.addSubview(suspendBtn)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
//        tableView.frame = view.bounds
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
        //MARK: -func
    func titleViewTap() {
        textField.text = "闭包的回调方法"
        
        let _ = textField.addGestureTap { (recognizer) in
            UIApplication.shared.keyWindow?.endEditing(true)
            UIApplication.shared.keyWindow?.rootViewController?.present(self.alertCtrl, animated: true, completion: nil)
            
            if let view = recognizer.view as? UITextField {
                UIView.animate(withDuration: 0.5, animations: {
                    view.rightView?.transform = (view.rightView?.transform.rotated(by:  CGFloat(Double.pi)))!
                    
                }, completion: nil)
            }
        }
        navigationItem.titleView = textField
    }
    
    lazy var textField: UITextField = {
        var view = UITextField(frame: .zero);
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.textAlignment = .left;
        view.contentVerticalAlignment = .center;
        view.autocapitalizationType = .none;
        view.autocorrectionType = .no;
        view.clearButtonMode = .whileEditing;
        view.backgroundColor = .clear;
        view.returnKeyType = .done
        
        view.textColor = .white
        view.textAlignment = .center;
        let image = UIImage.image(named: kIMG_arrowDown, podClassName: "SwiftExpand")
        view.asoryView(true, image: image)
        return view
    }()
    
    //MARK: -lazy
    lazy var alertCtrl: UIAlertController = {
        var alertController = UIAlertController.createSheet("请选择", msg: nil, items:nil, handler: { (controller: UIAlertController, action:UIAlertAction) in
            DDLog("完成取消")
            
            UIView.animate(withDuration: 0.5, animations: {
                self.textField.rightView?.transform = .identity
                
            }, completion: nil)
            
        })
        return alertController
    }()
    
    //MARK: -Lazy Property
    
    lazy var list: [[[String]]] = {
        var array: [[[String]]] = [
            [["服务包价格", "UITableViewCellThreeLable", "95.0", "", "recharge", ],
            ["车场支付记录", "UITableViewCellAfford", "70.0", "", "recharge", ],
            ["停车记录类型", "IOPTableViewCellGroupView", "55.0", "", "recharge", ],
            ["停车记录类型", "UITableViewCellGoodsDuration", "110.0", "", "recharge", ],
            ["停车费用", "UITableViewCellFee", "90.0", "", "recharge", ],
            ["停车记录", "UITableViewCellPark", "90.0", "", "recharge", ],
            ["订单记录", "UITableViewCellPayBill", "40.0", "", "recharge", ],
            ],
            [["上传文件", "UITableViewCell", "50.0", "\(kTitleLook),\(kTitleUpload)", "etc_project_report", ],
            ["上传照片", "UITableViewCell", "50.0", "\(kTitleLook),\(kTitleUpload)", "id_just_img",],
            ["起止时间:", "UITableViewCellDateRange", "60.0", "", "recharge", ],
            ["商品名称:", "UITableViewCellOne", "60.0", "", "cardName", ],
            ["*商品数量:", "UITableViewCellStep", "60.0", "", "validEndTime", ],
            ["*上架时间:", "UITableViewCellDatePicker", "60.0", "", "balance", ],
            ["商品价格:", "UITableViewCellTextField", "60.0", "", "recharge",  "  元    "],
            ["商品种类:", "UITableViewCellSegment", "60.0", "", "recharge",  "一代,二代,三代",],
            ["库存周期:", "UITableViewCellSlider", "60.0", "", "recharge", ],
            ["继续生产:", "UITableViewCellSwitch", "60.0", "", "recharge",  "生产,不生产",],
            ["品牌列表:", "UITableViewCellSheet", "60.0", "", "recharge", ],
            ["生产厂家:", "UITableViewCellPickerView", "60.0", "", "recharge", ],
            ["验 证 码:", "UITableViewCellCode", "60.0", "", "recharge", ],
            ["*备注信息:", "UITableViewCellTextView", "160.0", "", "recharge", ],
            ["*default:", "UITableViewCellDefault", "60.0", "", "recharge", ],
            ["Subtitle", "UITableViewCellSubtitle", "70.0", "", "recharge", ],
            ["WebView", "UITableViewCellWebView", "90.0", "", "recharge", ],
//            ["*图片选择:", "UITableViewCellPhotoPicker", "", "", "recharge", ],

             ],

        ]
        return array
    }()
    
 
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
    
    lazy var suspendBtn: NNSuspendButton = {
          var view = NNSuspendButton(frame: CGRectMake(kScreenWidth - 60, 80, 60, 60))
          view.insets = UIEdgeInsets(top: 40, left: 0, bottom: 80, right: 0)
//          view.parController = self
          view.addActionHandler({ (sender) in
              DDLog(sender.center)
          }, for: .touchUpInside)
          return view
      }()
    
    // MARK: -funtions
    /// 跳转相册类
    func jumpXiangce(_ itemList:[String]) {
//        let controller = UIStoryboard.storyboard(with: "ParkRecord", identifier: "IOPParkRecordImageViewController") as! UIViewController
//        controller.title = itemList[0].replacingOccurrences(of: "*", with: "")
//        if let url = URL(string: dataModel.value(forKeyPath: itemList[4]) as! String) {
//            controller.inImageUrlArray = [url]
//        }
//        navigationController?.pushViewController(controller, animated: true)
    }
    
    func jumpUploadPicture(_ itemList: [String]) {
//        DDLog(itemList)
        
        let controller = IOPImageUploadController()
        controller.delegate = self

        controller.title = itemList[0].replacingOccurrences(of: "*", with: "")
        controller.key = itemList[4]
        
        let imgUrl = dataModel.valueText(forKeyPath: itemList[4], defalut: "")
        controller.imgUrl = imgUrl
        controller.isFromPickerVC = false
        controller.showImageDefault = true
        navigationController?.pushViewController(controller, animated: true)
    }
    
    
    func jumpUploadFile(_ itemList: [String]) {
//        DDLog(itemList)

        let urlString = dataModel.valueText(forKeyPath: itemList[4], defalut: "")
        if itemList[0].contains("上传") == false && urlString.hasPrefix("http") == false {
            NNProgressHUD.showText("文件链接无效")
            return
        }
        
        let controller = IOPFileUploadController()
        controller.delegate = self
        controller.title = itemList[0].replacingOccurrences(of: "*", with: "")
        controller.key = itemList[4]
        
        controller.isUpload = urlString == ""
        controller.fileUrl = urlString == "" ? nil : NSURL(string: urlString)
        DDLog("isUpload:\(controller.isUpload)_fileUrl:\(controller.fileUrl)")
        navigationController?.pushViewController(controller, animated: true);
    }
}

extension EntryViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return list.count;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionList = list[section]
        return sectionList.count;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let sectionList = list[indexPath.section]
        let itemList = sectionList[indexPath.row]
        if itemList[2] == "" {
            return  UITableView.automaticDimension;
        }
        let height = itemList[2].cgFloatValue
        return height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionList = list[indexPath.section]
        let itemList = sectionList[indexPath.row]
        let value0 = itemList[0]
        let value1 = itemList[1]
        let value2 = itemList[2]
        let value3 = itemList[3]
        let value4 = itemList[4]
        
        switch value1 {
        case "UITableViewCellOne":
            let cell = UITableViewCellOne.dequeueReusableCell(tableView)
            cell.labelLeft.font = UIFont.systemFont(ofSize: 14)
            cell.labelLeft.textColor = UIColor.textColor3
            cell.isHidden = value2.cgFloatValue <= 0.0
            cell.hasAsterisk = value0.contains("*")
            
            cell.imgViewLeft.isHidden = true
            cell.labelLeft.text = value0
            cell.labelRight.text = value4
            cell.accessoryType = .disclosureIndicator
            
            cell.getViewLayer()
            return cell
            
        case "UITableViewCellDatePicker":
            let cell = UITableViewCellDatePicker.dequeueReusableCell(tableView)
            cell.labelLeft.font = UIFont.systemFont(ofSize: 14)
            cell.labelLeft.textColor = UIColor.textColor3
            cell.isHidden = value2.cgFloatValue <= 0.0
            cell.hasAsterisk = value0.contains("*")
            
            cell.labelLeft.text = value0
            cell.textfield.text = value4
            cell.textfield.textAlignment = .right
            cell.getViewLayer()

            return cell
            
        case "UITableViewCellSegment":
            let cell = UITableViewCellSegment.dequeueReusableCell(tableView)
            cell.labelLeft.font = UIFont.systemFont(ofSize: 14)
            cell.labelLeft.textColor = UIColor.textColor3
            cell.isHidden = value2.cgFloatValue <= 0.0
            cell.hasAsterisk = value0.contains("*")
            
            cell.labelLeft.text = value0
            let titles = itemList.last!.components(separatedBy: ",")
            cell.segmentCtl.itemList = titles
            cell.segmentCtl.addActionHandler({ (sender: UIControl) in
                if let control = sender as? UISegmentedControl {
                    DDLog(control.selectedSegmentIndex)
                }
            }, for: .valueChanged)
     
//            cell.getViewLayer()
            
            return cell
            
        case "UITableViewCellStep":
            let cell = UITableViewCellStep.dequeueReusableCell(tableView)
            cell.labelLeft.font = UIFont.systemFont(ofSize: 14)
            cell.labelLeft.textColor = UIColor.textColor3
            cell.isHidden = value2.cgFloatValue <= 0.0
            cell.hasAsterisk = value0.contains("*")
            
            cell.labelLeft.text = value0
            cell.ppBtn.minValue = 0
            cell.ppBtn.maxValue = 10
            //            cell.ppBtn.currentNumber = value4
            cell.ppBtn.currentNumber = "6"
            
            cell.textfield.textAlignment = .right
            cell.getViewLayer()
            return cell
            
        case "UITableViewCellTextField":
            let cell = UITableViewCellTextField.dequeueReusableCell(tableView)
            cell.labelLeft.font = UIFont.systemFont(ofSize: 14)
            cell.labelLeft.textColor = UIColor.textColor3
            cell.isHidden = value2.cgFloatValue <= 0.0
            cell.hasAsterisk = value0.contains("*")
            
            cell.textfield.rightViewMode = .never;
            cell.textfield.textAlignment = .left
            
            cell.labelLeft.text = value0
            cell.textfield.asoryView(true, text: itemList.last!)

//            cell.textfield.rightView = nil;
            
            cell.textfield.textAlignment = .right
            
            cell.block { (sender:AnyObject) in
                if let textField = sender as? UITextField {
                    DDLog(textField.text as Any)
                }
            }
            cell.getViewLayer()
            return cell
            
        case "UITableViewCellTextView":
            let cell = UITableViewCellTextView.dequeueReusableCell(tableView)
            cell.type = 1;
            cell.textView.placeHolderTextView.text = "最多140字"
            cell.block { ( view:UITableViewCellTextView, text:String) in
                DDLog(text)
            }
            
            cell.getViewLayer()
            return cell
        case "UITableViewCellDateRange":
            
//            let cell = UITableViewCellDateRange.dequeueReusableCell(tableView) as! UITableViewCellDateRange
//            let cell = UITableViewCellDateRange.dequeueReusableCell(tableView) as! UITableViewCellDateRange
//            let cell = tableView.dequeueReuCell(for: UITableViewCellDateRange())
//            let cell = tableView.dequeueReuCell(for: UITableViewCellDateRange.self)
//            let cell = tableView.dequeueReusableCell(for: UITableViewCellDateRange())
            let cell:UITableViewCellDateRange = UITableViewCellDateRange.dequeueReusableCell(tableView)
                cell.dateRangeView.labTitle.font = UIFont.systemFont(ofSize: 14)
                cell.dateRangeView.labTitle.textColor = UIColor.textColor3
                cell.isHidden = value2.cgFloatValue <= 0.0
                cell.hasAsterisk = value0.contains("*")
            
            cell.dateRangeView.labTitle.text = value0
            cell.dateRangeView.block { (dateRangeView) in
                DDLog(dateRangeView.dateStart, dateRangeView.dateEnd)
                
            }
            cell.getViewLayer()
            return cell
            
        case "UITableViewCellSlider":
            let cell = UITableViewCellSlider.dequeueReusableCell(tableView)
            cell.labelLeft.font = UIFont.systemFont(ofSize: 14)
            cell.labelLeft.textColor = UIColor.textColor3
            cell.isHidden = value2.cgFloatValue <= 0.0
//            cell.hasAsterisk = value0.contains("*")
            
            cell.labelLeft.text = value0
            cell.sliderCtl.value = 50
            cell.sliderCtl.addActionHandler({ (sender: UIControl) in
                if let control = sender as? UISlider {
                    DDLog(control.value)
                }
            }, for: .valueChanged)

            cell.getViewLayer()
            
            return cell
            
        case "UITableViewCellSwitch":
            let cell = UITableViewCellSwitch.dequeueReusableCell(tableView)
            cell.labelLeft.font = UIFont.systemFont(ofSize: 14)
            cell.labelLeft.textColor = UIColor.textColor3
            cell.isHidden = value2.cgFloatValue <= 0.0
            cell.hasAsterisk = value0.contains("*")
            
            cell.labelLeft.text = value0
//            cell.switchCtl.isOn = false
//            cell.layoutType = 1
            cell.switchCtl.addActionHandler({ (sender: UIControl) in
                if let control = sender as? UISwitch {
                    DDLog(control.isOn)
                }
            }, for: .valueChanged)
            
//            cell.getViewLayer()
            
            return cell
            
        case "UITableViewCellSheet":
            let cell = UITableViewCellSheet.dequeueReusableCell(tableView)
            cell.labelLeft.font = UIFont.systemFont(ofSize: 14)
            cell.labelLeft.textColor = UIColor.textColor3
            cell.isHidden = value2.cgFloatValue <= 0.0
            cell.hasAsterisk = value0.contains("*")
            
            cell.labelLeft.text = value0
            cell.itemList = ["阿里","腾讯","百度","谷歌",]
            cell.block { (title) in
                DDLog(title)
            }
            cell.getViewLayer()
            return cell
            
        case "UITableViewCellPickerView":
            let cell = UITableViewCellPickerView.dequeueReusableCell(tableView)
            cell.labelLeft.font = UIFont.systemFont(ofSize: 14)
            cell.labelLeft.textColor = UIColor.textColor3
            cell.isHidden = value2.cgFloatValue <= 0.0
            cell.hasAsterisk = value0.contains("*")
            
            cell.labelLeft.text = value0
            cell.block { (view, title, obj) in
                DDLog(title,obj)
            }
            
            cell.getViewLayer()
            return cell
            
        case "UITableViewCellPhotoPicker":
            let cell = UITableViewCellPhotoPicker.dequeueReusableCell(tableView)
            
            cell.defaultView.block { (view, list) in
                DDLog(list.count)
            }
            
            cell.getViewLayer()
            return cell
            
        case "UITableViewCellCode":
            let cell = UITableViewCellCode.dequeueReusableCell(tableView)
            cell.btnCode.addActionHandler({ (control) in
                DDLog(self.list.count)
                if let sender: UIButton = control as? UIButton {
                    sender.timerStart(60)
                }
            }, for: .touchUpInside)
          
            cell.getViewLayer()
            return cell
            
        case "UITableViewCellDefault":
            let cell = UITableViewCellDefault.dequeueReusableCell(tableView)
            cell.isHidden = value2.cgFloatValue <= 0.0
            cell.defaultView.labelLeft.text = value0
            cell.defaultView.labelRight.text = value4
            cell.getViewLayer()
            return cell
            
        case "UITableViewCellSubtitle":
            let cell = UITableViewCellSubtitle.dequeueReusableCell(tableView);
//            cell.imgViewLeft.isHidden = true
            cell.labelRightSub.text = DateFormatter.stringFromDate(Date());
            cell.accessoryType = .disclosureIndicator
            
            cell.getViewLayer();
            return cell;
            
        case "UITableViewCellWebView":
            let cell = UITableViewCellWebView.dequeueReusableCell(tableView);
             cell.loadContent = "asdfasdfasdf"

             cell.getViewLayer();
             return cell;
            
        case "UITableViewCellAfford":
            let cell = UITableViewCellAfford.dequeueReusableCell(tableView);
            cell.labelRightSub.text = DateFormatter.stringFromDate(Date());

            cell.getViewLayer();
            return cell;
            
        case "IOPTableViewCellGroupView":
            let cell = IOPTableViewCellGroupView.dequeueReusableCell(tableView);
            cell.parkGroupView.items = ["异常出车", "无入场记录", "长时为出"]
            cell.parkGroupView.selectedIdxList = [0]
            return cell;
                        
        case "UITableViewCellThreeLable":
            let cell = UITableViewCellThreeLable.dequeueReusableCell(tableView);
            cell.labelTop.text = "标准服务套餐包"
            cell.labelMid.text = "\("¥106.00")／通道／年"
            cell.labelBom.text = "优惠价：\("¥599")   原价：\("¥799")"
            
//            if let imageURL = URL(string: "http://api.3rd.parkingwang.com/goods/img/get?img=goods/2020-02-18/1582006542_产品标志.png") {
//                cell.imgViewLeft.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "bug.png"))
//            }
            
//            cell.accessoryType = .disclosureIndicator
//            cell.imgViewLeft.isHidden = true
            cell.getViewLayer();
            return cell;
            
        case "UITableViewCellGoodsDuration":
            let cell = UITableViewCellGoodsDuration.dequeueReusableCell(tableView);
            cell.groupView.items = ["1个月", "2个月", "半年", "1年", "2年", "3年"]
            cell.groupView.itemList.last?.iconImageView.image = UIImage(named: "icon_discout_orange")
            cell.groupView.selectedIdxList = [0]
            
            cell.getViewLayer();
            return cell;
            
        case "UITableViewCellFee":
            let cell = UITableViewCellFee.dequeueReusableCell(tableView)
            
            cell.isPositive = true;

            cell.labelTop.text = "临时车"
            cell.labelRight.text = "计费: ¥ 23.00"
            cell.labelMid.text = "异常出车异常出车异常出车异常出车异常出车异常出车"
            cell.labelBom.text = DateFormatter.stringFromDate(Date()) + DateFormatter.stringFromDate(Date())
            
            cell.getViewLayer();
            return cell;
            
        case "UITableViewCellPark":
            let cell = UITableViewCellPark.dequeueReusableCell(tableView);
            cell.getViewLayer();
            return cell;
                        
        case "UITableViewCellPayBill":
            let cell = UITableViewCellPayBill.dequeueReusableCell(tableView);
             cell.labelLeft.text = "¥5000.00"
             cell.pay_status = "2"

             cell.getViewLayer();
             return cell;
                        
        default:
            break
        }
        let cell = UITableViewCell.dequeueReusableCell(tableView, identifier: "UITableViewCellValue1", style: .value1)
        cell.textLabel?.font = UIFont.systemFont(ofSize: 15)
        cell.textLabel?.textColor = UIColor.textColor3;

        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 15)
        cell.detailTextLabel?.textColor = UIColor.theme
        cell.accessoryType = .disclosureIndicator;
        
        cell.textLabel?.text = value0
        
        cell.textLabel?.highlightedTextColor = UIColor.red
        cell.textLabel?.isHighlighted = false
        
        let fileTitles: [String] = value3.components(separatedBy: ",")
        cell.detailTextLabel?.text = fileTitles.first!
        
        if value0.contains("上传") {
            let result: String = dataModel.valueText(forKeyPath: value4, defalut: "")
            let validUrl = result.hasPrefix("http")
            cell.detailTextLabel?.text = validUrl ? fileTitles.first : fileTitles.last
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sections = list[indexPath.section]
        let itemList = sections[indexPath.row]
        if itemList[0].contains("上传文件") {
            jumpUploadFile(itemList)

        } else if itemList[0].contains("上传照片") {
            jumpUploadPicture(itemList)
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30;
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel(frame: .zero);
//        label.backgroundColor = .green;
        label.textColor = UIColor.orange
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "header\(section)";
        
        switch section {
        case 1:
            label.text = kBlankOne + "通用Cell视图"
        default:
            label.text = kBlankOne + "定制Cell视图"
        }
        return label;
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01;
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView();
    }
        
}

extension EntryViewController: IOPUploadImageControllerDelegate{
    func uploadImage(_ url: String, forKey key: String) {
        DDLog("\(key)_\(url)")
        dataModel.setValue(url, forKeyPath: key)
        tableView.reloadData()
    }
}

extension EntryViewController: IOPFileUploadControllerDelegate{
    func fileUpload(_ url: String, forKey key: String) {
        DDLog(key, url)
        dataModel.setValue(url, forKeyPath: key)
        tableView.reloadData()
    }
}
