//
//  EntryViewController.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2019/1/11.
//  Copyright © 2019 BN. All rights reserved.
//

import UIKit
import SwiftExpand
import NNPopoverButton
import SDWebImage
import IQKeyboardManagerSwift

class EntryViewController: UIViewController {
    
    var dataModel = NSObject()
    
    var weekIdxList: [Int] = [0]
    var timeIdxList: [Int] = [0]

    //MARK: -lazy
    lazy var tableView: UITableView = {
        let view: UITableView = UITableView.create(self.view.bounds, style: .plain, rowHeight: 50)
        view.dataSource = self
        view.delegate = self

        return view
    }()
        
    lazy var btn: NNPopoverButton = {
        let button = NNPopoverButton(type: .custom)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setTitle("Left", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.sizeToFit()
        button.parentVC = self
        button.contentWidth = 160
        button.list = ["优惠券样式", "文本框样式", "九宫格视图"]
        button.setTitle(button.list.first, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.sizeToFit()

        button.delegate = self
        return button
    }()
    
    lazy var uploadImagesView: NNUploadImagesView = {
        let view = NNUploadImagesView()
        view.frame = CGRectMake(0, 0, self.view.bounds.width, 110)
        view.currrentVC = self
        view.images = [view.imageDefault]
        view.maxCount = 9
        view.rowHeight = view.frame.height
        view.delegate = self

        view.tag = 1000
        return view
    }()
    
    lazy var instructionView: NNInstructionView = {
        let view = NNInstructionView(frame: .zero)
        return view
    }()
    
    // MARK: -life cycle
    deinit {
        DDLog(1111)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: btn)

        tableView.rowHeight = UITableView.automaticDimension;
        tableView.estimatedRowHeight = 70;

//        _ScrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
        tableView.tableFooterView = footerView
        view.addSubview(tableView);

        view.addSubview(suspendBtn)
        
//        DDLog(view.responderChain())
        IQKeyboardManager.shared.enable = true;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        navigationController?.navigationBar.shadowImage = UIImage()
//        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
//        navigationController?.navigationBar.shadowImage = nil
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
        
        _ = textField.addGestureTap { (recognizer) in
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
        _ = view.asoryView(true, image: image!)
        return view
    }()
    
    //MARK: -lazy
    lazy var alertCtrl: UIAlertController = {
        var alertController = UIAlertController.createSheet("请选择", message: nil, items:nil, handler: { (controller: UIAlertController, action:UIAlertAction) in
            DDLog("完成取消")
            
            UIView.animate(withDuration: 0.5, animations: {
                self.textField.rightView?.transform = .identity
                
            }, completion: nil)
            
        })
        return alertController
    }()
        
    lazy var list: [[[String]]] = {
        var array: [[[String]]] = [
            [
            ["更多内容", "UITableViewCellArticle", "135", "", "recharge", ],
            ["车场标签", "UITableViewCellParkType", "30", "", "recharge", ],
            ["Excel", "UITableViewCellExcel", "155", "", "recharge", ],
            ["标题", "UITableViewCellTitle", "50.0", "", "recharge", ],
            ["标签", "UITableViewCellTags", "70.0", "", "recharge", ],
            ["优惠券充值", "UITableViewCellCouponRecharge", "100.0", "", "recharge", ],
            ["停车统计", "UITableViewCellStatistics", "110.0", "", "recharge", ],
            ["操作日志", "UITableViewCellSixLable", "90.0", "", "recharge", ],
            ["操作日", "UITableViewCellLog", "120.0", "", "recharge", ],
            ["车场支付记录", "UITableViewCellAfford", "70.0", "", "recharge", ],
            ["停车记录类型", "IOPTableViewCellGroupView", "55.0", "", "recharge", ],
            ["星期选择", "UITableViewCellChoice", "110.0", "", "recharge", ],
            ["停车记录类型", "UITableViewCellGoodsDuration", "110.0", "", "recharge", ],
            ["停车费用", "UITableViewCellFee", "90.0", "", "recharge", ],
            ["停车记录", "UITableViewCellPark", "90.0", "", "recharge", ],
            ["订单记录", "UITableViewCellPayBill", "40.0", "", "recharge", ],
            ],
            [["上传文件", "UITableViewCell", "50.0", "\(kTitleLook),\(kTitleUpload)", "etc_project_report", ],
            ["上传照片", "UITableViewCell", "50.0", "\(kTitleLook),\(kTitleUpload)", "id_just_img",],
            ["*图片选择:", "UITableViewCellPhotoPicker", "110", "", "recharge", ],
            ["用户头像", "UITableViewCellRightAvart", "60.0", "", "recharge", ],
            ["圆形进度:", "UITableViewCellProgressView", "90.0", "", "cardName", ],
            ["*商品名称:", "UITableViewCellOne", "60.0", "", "cardName", ],
            ["Subtitle", "UITableViewCellSubtitle", "70.0", "", "recharge", ],
            ["*default:", "UITableViewCellDefault", "60.0", "", "recharge", ],
            ["*商品数量:", "UITableViewCellStep", "60.0", "", "validEndTime", ],
            ["*上架时间:", "UITableViewCellDatePicker", "60.0", "", "balance", ],
            ["*有效时间:", "UITableViewCellDateRange", "60.0", "0", "validbtime,validetime", ],
            ["有效时段1:", "UITableViewCellDateRange", "60.0", "1", "btime,etime", ],
            ["有效时段2:", "UITableViewCellDateRange", "60.0", "2", "btime,etime", ],
            ["有效时段3:", "UITableViewCellDateRange", "60.0", "3", "btime,etime", ],
            ["商品价格:", "UITableViewCellTextField", "60.0", "", "recharge", "元"],
            ["商品种类:", "UITableViewCellSegment", "60.0", "", "recharge", "一代,二代,三代,四代",],
            ["商品种类:", "UITableViewCellSegmentLine", "60.0", "", "recharge", "一代,二代,三代,四代",],
            ["库存周期:", "UITableViewCellSlider", "60.0", "", "recharge", ],
            ["继续生产:", "UITableViewCellSwitch", "60.0", "", "recharge", "生产,不生产",],
            ["品牌列表:", "UITableViewCellSheet", "60.0", "", "recharge", ],
            ["生产厂家:", "UITableViewCellPickerView", "60.0", "", "recharge", ],
            ["验 证 码:", "UITableViewCellCode", "60.0", "", "recharge", ],
            ["*备注信息:", "UITableViewCellTextView", "160.0", "", "recharge", ],
            ["PhotoShow", "UITableViewCellPhotoShow", "216.0", "", "recharge", ],
            ["Banner", "UITableViewCellBanner", "216.0", "", "recharge", ],
            ["Cycle", "UITableViewCellCycle", "70.0", "", "recharge", ],
            ["WebView", "UITableViewCellWebView", "90.0", "", "recharge", ],
            ["水平排布", "UITableViewCellHorizontal", " 50.0", "", "recharge", ],
            ["垂直排布", "UITableViewCellVertical", " 120.0", "", "recharge", ],
            ["九宫格", "UITableViewCellSudokuLabel", "80.0", "", "recharge", ],
            ["九宫格2", "UITableViewCellSudokuButton", " 180.0", "", "recharge", ],
            ["九宫格T", "UITableViewCellSudokuButtonNew", " 180.0", "", "recharge", ],
//            ["确认提交", "UITableViewCellButton", "60.0", "", "recharge", ],
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
                        
//            let controller = CCSCouponRecordController()
//            self.navigationController?.present(controller, animated: true, completion: nil)
          }, for: .touchUpInside)
          return view
      }()
    
    // MARK: -funtions
    /// 跳转相册类
    func jumpXiangce(_ itemList: [String]) {
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
    
    @objc func handleAction() {
        DDLog("test")
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
            return UITableView.automaticDimension;
        }
        if itemList[1] == "UITableViewCellPhotoPicker" {
            return uploadImagesView.totalHeight
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
        case "UITableViewCellParkType":
            let cell = UITableViewCellParkType.dequeueReusableCell(tableView)
            cell.isHidden = value2.cgFloatValue <= 0.0
            
            cell.parkType = "非经营性车场"
            cell.parkTags = ["全部", "路侧", "地上", "地下", "停车楼", ]

            cell.getViewLayer()
            return cell
        
            
        case "UITableViewCellExcel":
            let cell = UITableViewCellExcel.dequeueReusableCell(tableView)
            cell.isHidden = value2.cgFloatValue <= 0.0
            
            let width = (kScreenWidth - cell.inset.left - cell.inset.right)/3.0
            cell.excelView.layout.itemSize = CGSize(width: width, height: 45)
            cell.excelView.label.text = "    全天"
            cell.excelView.xGap = 0
            cell.excelView.label.backgroundColor = UIColor.hexValue(0xF5F5F5)
            cell.excelView.headerBackgroudColor = .white
            cell.excelView.dataList = [["08:00 - 20:00", "2元/小时", "封顶20元",],
                                       ["08:00 - 20:00", "2元/小时", "封顶20元",],
                                        ]
            cell.getViewLayer()
            return cell
            
        case "UITableViewCellOne":
            let cell = UITableViewCellOne.dequeueReusableCell(tableView)
            cell.labelLeft.font = UIFont.systemFont(ofSize: 14)
            cell.labelLeft.textColor = UIColor.textColor3
            cell.isHidden = value2.cgFloatValue <= 0.0
            cell.hasAsterisk = value0.contains("*")
            
            cell.imgViewLeft.isHidden = true
            cell.labelLeft.text = value0
            cell.labelRight.text = dataModel.valueText(forKeyPath: value4, defalut: "-")
            cell.accessoryType = .disclosureIndicator
            
            cell.labelRight.text = "99+"
            cell.getViewLayer()
            return cell
            
        case "UITableViewCellTitle":
            let cell = UITableViewCellTitle.dequeueReusableCell(tableView)
            cell.labelLeft.font = UIFont.systemFont(ofSize: 14)
            cell.labelLeft.textColor = .textColor3
            cell.isHidden = value2.cgFloatValue <= 0.0
            
            cell.labelLeft.text = "这是一个标题"
//            btn.addActionHandler({ (control) in
//                UIAlertController.showAlert("温馨提示", message: "亲爱的客户请检查........")
//            }, for: .touchUpInside)
            cell.getViewLayer()
            return cell
            
        case "UITableViewCellRightAvart":
            let cell = UITableViewCellRightAvart.dequeueReusableCell(tableView)
            cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
            cell.textLabel?.textColor = .textColor3
            cell.isHidden = value2.cgFloatValue <= 0.0

            cell.textLabel?.text = value0
            cell.btn.setBackgroundColor(.systemBlue, for: .normal)
            cell.accessoryType = .disclosureIndicator
            
            cell.getViewLayer()
            return cell
                                  
        case "UITableViewCellProgressView":
            let cell = UITableViewCellProgressView.dequeueReusableCell(tableView)
            cell.labelLeft.font = UIFont.systemFont(ofSize: 14)
            cell.labelLeft.textColor = .textColor3
            cell.isHidden = value2.cgFloatValue <= 0.0
            cell.hasAsterisk = value0.contains("*")
            
            cell.labelLeft.text = value0
            cell.progressView.value = 0.88
//            cell.accessoryType = .disclosureIndicator
            cell.progressView.block = { progressView in
                DDLog(progressView.value)
            }
            
            cell.progressView.blockTap = { progressView in
                DDLog(progressView.value)
            }
            
            cell.getViewLayer()
            return cell
            
        case "UITableViewCellDatePicker":
            let cell = UITableViewCellDatePicker.dequeueReusableCell(tableView)
            cell.labelLeft.font = UIFont.systemFont(ofSize: 14)
            cell.labelLeft.textColor = UIColor.textColor3
            cell.isHidden = value2.cgFloatValue <= 0.0
            cell.hasAsterisk = value0.contains("*")

            cell.labelLeft.text = value0
            cell.textfield.text = dataModel.valueText(forKeyPath: value4, defalut: "请选择")
            cell.textfield.textAlignment = .right

            cell.datePicker.block { (datePicker, idx) in
                let time = DateFormatter.stringFromDate(datePicker.datePicker.date)
                DDLog(time, idx)
                if idx == 1 {
                    cell.textfield.text = time
                }
            }

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
            cell.segmentCtl.items = titles
            cell.segmentCtl.addActionHandler({ (sender: UIControl) in
                if let control = sender as? UISegmentedControl {
                    DDLog(control.selectedSegmentIndex)
                }
            }, for: .valueChanged)
     
//            cell.getViewLayer()
            return cell
            
        case "UITableViewCellSegmentLine":
            let cell = UITableViewCellSegmentLine.dequeueReusableCell(tableView)
            cell.labelLeft.font = UIFont.systemFont(ofSize: 14)
            cell.labelLeft.textColor = UIColor.textColor3
            cell.isHidden = value2.cgFloatValue <= 0.0
            cell.hasAsterisk = value0.contains("*")
            
            cell.labelLeft.isHidden = true
            cell.inset = UIEdgeInsetsMake(15, 10, 15, 10)
            
            cell.labelLeft.text = value0
            let titles = itemList.last!.components(separatedBy: ",")
            cell.segmentCtl.items = titles
            cell.segmentCtl.addActionHandler({ (sender: UIControl) in
                if let control = sender as? UISegmentedControl {
                    DDLog(control.selectedSegmentIndex)
                }
            }, for: .valueChanged)
            ///
            cell.segmentCtl.showStyle = .seprateLine
            cell.segmentCtl.layer.borderColor = UIColor.clear.cgColor

            let image0 = UIImage.textEmbededImage(image: UIImage(named: "img_dialog_inquiry")!, string: titles[0], color: .systemRed)
            let image1 = UIImage.textEmbededImage(image: UIImage(named: "img_dialog_warning")!, string: titles[1], color: .systemOrange)
            let image2 = UIImage.textEmbededImage(image: UIImage(named: "btn_selected_NO")!, string: titles[2], color: .systemYellow)
            let image3 = UIImage.textEmbededImage(image: UIImage(named: "icon_password")!, string: titles[3], color: .systemGreen)
            
            cell.segmentCtl.setImage(image0.withRenderingMode(.alwaysOriginal), forSegmentAt: 0)
            cell.segmentCtl.setImage(image1.withRenderingMode(.alwaysOriginal), forSegmentAt: 1)
            cell.segmentCtl.setImage(image2.withRenderingMode(.alwaysOriginal), forSegmentAt: 2)
            cell.segmentCtl.setImage(image3.withRenderingMode(.alwaysOriginal), forSegmentAt: 3)


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
            
            cell.block { (textField) in
                DDLog(textField.text as Any)
            }
            cell.getViewLayer()
            return cell
            
        case "UITableViewCellTextView":
            let cell = UITableViewCellTextView.dequeueReusableCell(tableView)
            cell.type = 1;
            cell.labelLeft.text = "备注信息"
            cell.textView.placeHolderLabel.text = "最多140字"
            cell.block { ( view:UITableViewCellTextView, text:String) in
                DDLog(text)
            }
            
            cell.getViewLayer()
            return cell
            
        case "UITableViewCellPhotoShow":
            let cell = UITableViewCellPhotoShow.dequeueReusableCell(tableView)
            cell.labelLeft.text = "进场图片"
            
            cell.getViewLayer()
            return cell
            
        case "UITableViewCellBanner":
            let cell = UITableViewCellBanner.dequeueReusableCell(tableView)
            
            cell.getViewLayer()
            return cell
            
        case "UITableViewCellCycle":
            let cell = UITableViewCell.dequeueReusableCell(tableView, identifier: "UITableViewCellCycle")
            
            let inset = UIEdgeInsetsMake(10, 10, 10, 10)
            cell.contentView.createSubTypeView(NNCycleScrollView.self, tag: 100, inset: inset) { (view) in
                view.direction = .vertical
                view.list =  ["我们对权限控制做了升级，现在可以精准控制app端的权限了","由管理员在网页端设置。如果您发现您原来“运营”菜单中有的功能不见了，请联系集团管理员添加，给您带来不便敬请谅解。", "qqqqqqqqqqqqqqqq"]

        //        view.pageControl.isHidden = true
                view.timeInterval = 5
                view.didSelectedBlock = { sender, idx in
                    DDLog(idx)
                }
            }
            
//            cell.getViewLayer()
            return cell
            
        case "UITableViewCellDateRange":
            
//            let cell = tableView.dequeueReuCell(for: UITableViewCellDateRange())
//            let cell = tableView.dequeueReuCell(for: UITableViewCellDateRange.self)
//            let cell = tableView.dequeueReusableCell(for: UITableViewCellDateRange())
            let cell = UITableViewCellDateRange.dequeueReusableCell(tableView)
            cell.dateRangeView.labTitle.font = UIFont.systemFont(ofSize: 14)
            cell.dateRangeView.labTitle.textColor = UIColor.textColor3
            cell.isHidden = value2.cgFloatValue <= 0.0
            cell.hasAsterisk = value0.contains("*")
            
            cell.dateRangeView.datePicker.datePicker.datePickerMode = UIDatePicker.Mode(rawValue: value3.intValue)!
            cell.dateRangeView.isEmptyDate = true
            cell.dateRangeView.rangeDay = 0
            cell.dateRangeView.isFuture = true
            cell.dateRangeView.labTitle.text = value0
            let dateTimeKeys = itemList.last!.components(separatedBy: ",")

            let beginTime: String = dataModel.valueText(forKeyPath: dateTimeKeys.first!)
            let endTime: String = dataModel.valueText(forKeyPath: dateTimeKeys.last!)
            if beginTime.count == 19 && endTime.count == 19 {
               cell.dateRangeView.beginDate = DateFormatter.dateFromString(beginTime)
               cell.dateRangeView.endDate = DateFormatter.dateFromString(endTime)
           
            }
            cell.dateRangeView.block { (dateRangeView) in
                DDLog(dateRangeView.beginTime, dateRangeView.endTime)
                if dateRangeView.endTime.isBig(dateRangeView.beginTime) == false {
                    NNProgressHUD.showText("结束时间必须大于开始时间")
                    return
                }
                self.dataModel.setValue(dateRangeView.beginTime, forKey: dateTimeKeys.first!)
                self.dataModel.setValue(dateRangeView.endTime, forKey: dateTimeKeys.last!)
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
            cell.textfield.rightViewMode = .never
            cell.accessoryType = .disclosureIndicator
            
            cell.labelLeft.text = value0
            cell.block { (view, title, obj) in
                DDLog(title,obj)
            }
            
            cell.getViewLayer()
            return cell
            
        case "UITableViewCellCode":
            let cell = UITableViewCellCode.dequeueReusableCell(tableView)
            cell.labelLeft.font = UIFont.systemFont(ofSize: 14)
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
            cell.defaultView.textLabel.text = value0
            cell.defaultView.detailTextLabel.text = value4
            cell.getViewLayer()
            return cell
            
        case "UITableViewCellSubtitle":
            let cell = UITableViewCellSubtitle.dequeueReusableCell(tableView);
//            cell.imgViewLeft.isHidden = true
            cell.labelRightSub.text = DateFormatter.stringFromDate(Date());
            cell.accessoryType = .disclosureIndicator
//            cell.btnSize = CGSize(width: 45, height: 45)
            
            cell.btn.setBackgroundImage(UIImage(named: "btn_selected_NO"), for: .normal)
            cell.btn.setBackgroundImage(UIImage(named: "btn_selected_YES"), for: .selected)
            cell.btn.addActionHandler({ (control) in
              guard let sender = control as? UIButton else { return }
              sender.isSelected = !sender.isSelected
//                  self.handleChooseAction(sender, model: model)
              
            }, for: .touchUpInside)
            
            cell.getViewLayer();
            return cell;
            
        case "UITableViewCellWebView":
            let cell = UITableViewCellWebView.dequeueReusableCell(tableView);
             cell.loadContent = "WebView"

             cell.getViewLayer();
             return cell;
            
        case "UITableViewCellButton":
            let cell = UITableViewCellButton.dequeueReusableCell(tableView);
            
             cell.getViewLayer();
             return cell;
                    
        case "UITableViewCellTags":
            let cell = UITableViewCellTags.dequeueReusableCell(tableView);
            cell.tagView.tags = ["默认标签", "默认标签1", "默认标签2", "默认标签3", "默认标签4", "默认标签5", ]

             cell.getViewLayer();
             return cell;
            
        case "UITableViewCellAfford":
            let cell = UITableViewCellAfford.dequeueReusableCell(tableView);
            cell.labelRightSub.text = DateFormatter.stringFromDate(Date());

            cell.getViewLayer();
            return cell;
            
        case "IOPTableViewCellGroupView":
            let cell = IOPTableViewCellGroupView.dequeueReusableCell(tableView);
            cell.parkGroupView.items = ["异常出车", "无入场记录", "长时为出", ]
//            cell.parkGroupView.items = ["异常出车", "无入场记录", "长时为出", "全部", "自定义", "预定义"]
            cell.parkGroupView.selectedIdxList = [0]
//            cell.parkGroupView.hideImage = true
            
            cell.parkGroupView.block { (groupView, sender) in
                DDLog(groupView.selectedIdxList)
            }
            
            return cell;
                                    
        case "UITableViewCellSixLable":
            let cell = UITableViewCellSixLable.dequeueReusableCell(tableView);
//            cell.imgViewLeft.isHidden = true
            cell.accessoryType = .disclosureIndicator

            cell.labelTop.text = "标准服务套餐包"
            cell.labelMid.text = "\("¥106.00")／通道／年"
            cell.labelBom.text = "优惠价：\("¥599")   原价：\("¥799")"
            
//            if let imageURL = URL(string: "http://api.3rd.parkingwang.com/goods/img/get?img=goods/2020-02-18/1582006542_产品标志.png") {
//                cell.imgViewLeft.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "bug.png"))
//            }
            cell.getViewLayer();
            return cell;
            
        case "UITableViewCellLog":
            let cell = UITableViewCellLog.dequeueReusableCell(tableView);
            cell.imgViewLeft.isHidden = true
            cell.accessoryType = .disclosureIndicator

//            cell.labelTop.text = "标准服务套餐包"
//            cell.labelMid.text = "\("¥106.00")／通道／年"
//            cell.labelBom.text = "优惠价：\("¥599")   原价：\("¥799")"
            
//            if let imageURL = URL(string: "http://api.3rd.parkingwang.com/goods/img/get?img=goods/2020-02-18/1582006542_产品标志.png") {
//                cell.imgViewLeft.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "bug.png"))
//            }
            cell.getViewLayer();
            return cell;
            
        case "UITableViewCellHorizontal":
            let cell = UITableViewCellHorizontal.dequeueReusableCell(tableView);
//            cell.accessoryType = .disclosureIndicator
            cell.labelFour.isHidden = true

            cell.labelOne.text = "标准服务套餐包"
            cell.labelTwo.text = "\("¥106.00")／通道／年"
            cell.labelThree.text = "优惠价：\("¥599")"
            cell.labelFour.text = "优惠价：\("¥599")   原价：\("¥799")"
            
            cell.getViewLayer();
            return cell;
            
        case "UITableViewCellVertical":
            let cell = UITableViewCellVertical.dequeueReusableCell(tableView);
            cell.accessoryType = .disclosureIndicator
            cell.imageViewSize = CGSize(width: 70, height: 70)
            cell.labelFour.isHidden = true

            cell.labelOne.text = "标准服务套餐包"
            cell.labelTwo.text = "\("¥106.00")／通道／年"
            cell.labelThree.text = "优惠价：\("¥599")"
            cell.labelFour.text = "优惠价：\("¥599")   原价：\("¥799")"

            cell.getViewLayer();
            return cell
            
        case "UITableViewCellSudokuLabel":
            let cell = UITableViewCellSudokuLabel.dequeueReusableCell(tableView);
//            cell.accessoryType = .disclosureIndicator
            cell.numOfRow = 3
            cell.row = 2
            cell.items.forEach {
                $0.textColor = .systemBlue
                $0.textAlignment = .center
            }

//            cell.getViewLayer();
            return cell;

        case "UITableViewCellSudokuButton":
            let cell = UITableViewCellSudokuButton.dequeueReusableCell(tableView);
//            cell.accessoryType = .disclosureIndicator
            cell.numOfRow = 3
            cell.row = 3
            cell.itemType = NNButton.self
//            cell.items.forEach { $0.setTitleColor(.systemBlue, for: .normal)}
            cell.items.forEach {

                guard let sender = $0 as? NNButton else { return }
                sender.direction = .top
                sender.setImage(UIImage(named: "btn_selected_YES"), for: .normal)

                sender.addActionHandler({ control in
                    guard let sender = control as? UIButton else { return }
                    DDLog(sender.tag)
                    
                    self.instructionView.show(sender, message: "一场仍在持续的大流行病，陡然提升了医疗产业的重要性。")
                }, for: .touchUpInside)
            }
            
            cell.dividerColor = .red
            cell.dividerWidth = 2
            cell.dividerSpacing = 10
            
            cell.getViewLayer();
            return cell;
            
        case "UITableViewCellSudokuButtonNew":
            let cell = UITableViewCellSudokuButtonNew.dequeueReusableCell(tableView);
//            cell.accessoryType = .disclosureIndicator
            cell.numOfRow = 4
            cell.row = 2
            cell.count = 6

            cell.itemType = NNButton.self
//            cell.items.forEach { $0.setTitleColor(.systemBlue, for: .normal)}
            cell.items.forEach {
                guard let sender = $0 as? NNButton else { return }
                sender.direction = .top
                sender.setImage(UIImage(named: "btn_selected_YES"), for: .normal)
                sender.iconBtn.setTitle("价值100", for: .normal)
//                sender.iconBtn.setImage(UIImage(named: "icon_discount_orange"), for: .normal)
                sender.iconBtn.setBackgroundColor(UIColor.theme, for: .normal)
//                sender.iconBtn.sizeToFit()
                sender.iconSize = CGSize(width: 50, height: 20)
                sender.setNeedsLayout()
                
                sender.addActionHandler({ control in
                    guard let sender = control as? UIButton else { return }
                    DDLog(sender.tag)
                }, for: .touchUpInside)
            }
            
//            cell.items.filter { $0.tag >= 5 }.forEach({ $0.isHidden = true })

            cell.getViewLayer();
            return cell;
                        
        case "UITableViewCellChoice":
            let cell = UITableViewCellChoice.dequeueReusableCell(tableView);
            cell.groupView.items = ["周一", "周二", "周三", "周四", "周五", "周六", "周日"]
            cell.groupView.selectedIdxList = weekIdxList
            
            cell.groupView.enableIdxList = [1,2,3,4,5]
            cell.groupView.selectedIdxList = cell.groupView.enableIdxList

            cell.groupView.block { (groupView, btn) in
                DDLog(groupView.selectedIdxList)
                self.weekIdxList = groupView.selectedIdxList
            }
            
            cell.getViewLayer();
            return cell;
            
        case "UITableViewCellGoodsDuration":
            let cell = UITableViewCellGoodsDuration.dequeueReusableCell(tableView);
            cell.groupView.items = ["1个月", "2个月", "半年", "1年", "2年", "3年"]

//            let items = ["1个月", "2个月", "半年", "1年", "2年", "3年"]
            cell.groupView.selectedIdxList = timeIdxList

            DDLog(cell.groupView.selectedList.map({ $0.currentTitle ?? "-" }))
            cell.groupView.block { (groupView, btn) in
                DDLog(groupView.selectedIdxList)
                self.timeIdxList = groupView.selectedIdxList
            }
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
               
        case "UITableViewCellStatistics":
            let cell = UITableViewCellStatistics.dequeueReusableCell(tableView);
            cell.labelLeft.text = "西安凯德停车场A区";
            cell.labelRight.text = "临时车";
            cell.labelLeftSub.text = "总次数";
            cell.labelMidSub.text = "总时长(小时)";
            cell.labelRightSub.text = "总费用";
            cell.labelLeftSubValue.text = "35";
            cell.labelMidSubValue.text = "60";
            cell.labelRightSubValue.text = "¥180.00";
             
//            cell.getViewLayer();
            return cell;

        case "UITableViewCellCouponRecharge":
            let cell = UITableViewCellCouponRecharge.dequeueReusableCell(tableView);
            cell.btnName.setTitle("重庆老火锅", for: .normal)
            cell.btn.setTitle("详情", for: .normal)
            cell.labelMidLeft.text = "缴费金额 100元";
            cell.labelMidRight.text = "面额 100小时";

            cell.labelBottomLeft.text = "张数 100张";
            cell.labelBottomRight.text = "充值时间 2019-12-10 12:0";
            cell.getViewLayer();
            return cell;
            
        case "UITableViewCellPhotoPicker":
            let cell = UITableViewCell.dequeueReusableCell(tableView, identifier: value1)
            if let view = cell.contentView.viewWithTag(1000) as? NNUploadImagesView {
                DDLog(view.self)
            } else {
                cell.contentView.addSubview(uploadImagesView)
            }
            
            cell.getViewLayer()
            return cell
            
        case "UITableViewCellArticle":
            let cell = UITableViewCellArticle.dequeueReusableCell(tableView)
            cell.labelLeft.text = "爱车里需要购置什么常用需的实用物品，配置哪些车购置什么常用购置什么常用购置什么常用…"
            cell.labelLeftSub.text = "有些车型可能会不适合,副驾驶遮阳板上的抽纸在后视镜上的雨眉。"
            
            cell.fromImgView.image = UIApplication.appIcon
            cell.fromLabel.text = "艾润停车王"
            
            cell.imgViewRight.isHidden = true
            cell.imgViewRight.image = UIImage(color: .systemGreen)
            
            cell.getViewLayer()
            return cell
            
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
        label.backgroundColor = .background;
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
    //编辑菜单
    func tableView(_ tableView: UITableView, shouldShowMenuForRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, canPerformAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, performAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) {
        DDLog(action)
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

extension EntryViewController: NNPopoverButtonDelegate {
    public func popoverButton(_ popoverBtn: NNPopoverButton, tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as UITableViewCell? else { return }
        popoverBtn.setTitle(cell.textLabel?.text ?? "--", for: .normal)
        popoverBtn.sizeToFit()

        switch indexPath.row {
        case 1:
            let controller = TextFieldStyleController()
            self.navigationController?.pushViewController(controller, animated: true)
            
        case 2:
            let controller = NNSudokuViewController()
            self.navigationController?.pushViewController(controller, animated: true)
            
        default:
            let controller = CCSCouponRecordController()
            self.navigationController?.pushViewController(controller, animated: true)
        }

    }
}

extension EntryViewController: NNUploadImagesViewDelegate {
    func didFinishPicker(_ images: [UIImage], isSelectOriginalPhoto: Bool) {
        DDLog(images.count)
    }
}
