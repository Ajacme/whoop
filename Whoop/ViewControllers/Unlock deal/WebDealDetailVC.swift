//
//  WebDealDetailVC.swift
//  Whoop!
//
//  Created by Dilip manek on 03/11/17.
//  Copyright © 2017 Dilip manek. All rights reserved.
//

import UIKit


class CellForBoostTickets: UITableViewCell {
    
    @IBOutlet weak var cntrolTapImage: UIControl!
    @IBOutlet weak var btnTopIcon: UIButton!
    @IBOutlet weak var lblMainTitle: UILabel!
    @IBOutlet weak var lblUsesCredit: UILabel!
    @IBOutlet weak var lblUnlockBy: UILabel!
    @IBOutlet weak var lblDealBoosted: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblGetQuotes: UILabel!
    @IBOutlet weak var viewForBack: UIView!
   // @IBOutlet weak var viewForShadow: UIView!

    @IBOutlet weak var imgTopBG: UIImageView!
    @IBOutlet weak var imgMiddleblue: UIImageView!
    @IBOutlet var tapGetAQuote: UIButton!
}

class UnlockWebHeaderView: UIView {
    
   
    @IBOutlet weak var headerTitleLabel: UILabel!
    @IBOutlet weak var headerDescriptionLabel: UILabel!
    @IBOutlet weak var headerLogoImage: UIButton!
    
    
    
    override init(frame:CGRect) {
        super.init(frame:frame)
        //        setup()
    }
    required init(coder aDecoder:NSCoder) {
        super.init(coder:aDecoder)!
        //        setup()
    }
}
class WebDealDetailVC: UIViewController,CustomToolBarDelegate,UITextFieldDelegate,UIScrollViewDelegate {
    
    @IBOutlet var unlockHeaderView: UnlockWebHeaderView!
    @IBOutlet weak var tableViewMain: UITableView!
    @IBOutlet weak var viewForHeader: UIView!
    var arrScrollData = [[String : Any]]()
    var  arrInsuranceData = [Insurance_data]()
    var pulseEffect:PulsingHaloLayer!
    var objCodePopUp = ViewForPopUp()
    var objCodeSwipePopUp = ViewFor3xPopUp()
    var toolBar : CustomToolBar = CustomToolBar.init(frame: CGRect(x: 0, y: 0, width: ScreenSize.WIDTH, height: 40),isSegment: false)
    var cellTapTag = -1
    
    var headerViewData = [String : Any]()
    var headerData = Header_Data()
   // var strSelectedCode = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewMain.estimatedRowHeight = 401
        viewForHeader.frame = CGRect(x: 0, y: 0, width: ScreenSize.WIDTH, height: 190)
        tableViewMain.tableHeaderView = viewForHeader
        
        if arrScrollData.count <= 0{
            arrScrollData = [
                ["image" : "blue_plane","selected_image" :"gray_plane","title" : "Travel Insurance".localized,"desc":"This is your home's travel insurance deal".localized,"bgImage" : "bg_ins","message" : "Expires in 45 days".localized, "category":"Insurance"],
                
                
                ["image" : "blue_travel_medical","selected_image" :"gray_travel_medical","title" : "Travel Insurance\n( Medical conditions )".localized,"desc":"This is your home's travel insurance (Medical conditions) deal".localized,"bgImage" : "bg_ins","message" : "Expires in 45 days".localized, "category":"Insurance"],
                
                
                ["image" : "blue_car_break","selected_image" :"gray_car_break","title" : "Car breakdown".localized,"desc":"This is your home's Car breakdown deal".localized,"bgImage" : "bg_ins","message" : "Expires in 45 days".localized, "category":"Insurance"]]

        }
        
        for dic in arrScrollData
        {
            let tableData = Insurance_data()
            tableData.title = dic["title"] as! String
            tableData.imageName = dic["image"] as! String
            tableData.displayMessage = dic["message"] as! String
            tableData.desc = dic["desc"] as! String
            tableData.isGetQuotes = false
            tableData.selectedBGImage = dic["selected_image"] as! String
            tableData.bgImage = dic["bgImage"] as! String
            arrInsuranceData.append(tableData)
        }
        if headerViewData.count >= 0 {
            
            headerData.title = headerViewData["title"] as! String
            headerData.desc = headerViewData["desc"] as! String
            headerData.imageName = headerViewData["image"] as! String
            headerData.category = headerViewData["category"] as! String
            self.setUpHeader()
        }
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.isNavigationBarHidden = true
    }
    func setUpHeader(){
        let dic = headerData
        
        unlockHeaderView.headerTitleLabel.text = dic.title
        unlockHeaderView.headerDescriptionLabel.text = dic.desc
        unlockHeaderView.headerLogoImage.setImage(UIImage(named:dic.imageName), for: .normal)
        unlockHeaderView.headerDescriptionLabel.textColor = UIColor.colorWithHexString(hex: "FD5612")
        
        /*if dic.imageName == "info_tra" {
            unlockHeaderView.headerDescriptionLabel.textColor = UIColor.green
        }else{
            unlockHeaderView.headerDescriptionLabel.textColor = UIColor.colorWithHexString(hex: "FD5612")
        }*/
    }
//    override func viewDidDisappear(_ animated: Bool) {
//        self.navigationController?.isNavigationBarHidden = false
//    }
    //MARK: - Get Selected Code....
    func getSelectedCode(selectedCode : String?) {
        if selectedCode != nil && selectedCode != ""
        {
           objCodePopUp.txtEnterCode.text = selectedCode
        }
    }
    
    //MARK: - Shadow Method....
    func add_shadow(demoView : UIView,height : CGFloat){
        
        let radius: CGFloat = demoView.frame.width //change it to .height if you need spread for height
        let shadowPath = UIBezierPath(rect: CGRect(x: -1, y: 0, width: radius + 0.5 , height:height - 4.0))
        //Change 2.1 to amount of spread you need and for height replace the code for height
        
        demoView.layer.cornerRadius = height/2
        demoView.layer.shadowColor = UIColor.darkGray.cgColor
        demoView.layer.shadowOffset = CGSize(width: 0.1, height: 0.2)  //Here you control x and y
        demoView.layer.shadowOpacity = 1
        demoView.layer.shadowRadius = 20 //Here your control your blur
        demoView.layer.masksToBounds =  false
        demoView.layer.shadowPath = shadowPath.cgPath
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Click Events....
    @IBAction func tapInfoinsurance(_ sender: Any) {
        customCodeViewPopupSwipe()
    }
    @IBAction func tapToClose3xPopUp(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.5) {
            self.objCodeSwipePopUp.Cons_ViewTop.constant = 1000
            self.objCodeSwipePopUp.isWorking = false
            self.objCodeSwipePopUp.removeFromSuperview()
        }
        
    }
    
    
    @IBAction func tapToMiddleImage(_ sender: UIControl) {

    }
    @IBAction func tapToBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func tapToOpenPopUp(_ sender: UIButton) {
        cellTapTag = sender.tag
        self.customCodeView()
    }
    @IBAction func tapToClosePopUp(_ sender: UIButton) {
        self.objCodePopUp.removeFromSuperview()
        
        self.objCodePopUp.Cons_ViewMiddle.constant = 1000
    }
    @IBAction func tapToGetQuote(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let objSeeCodeVC = storyboard.instantiateViewController(withIdentifier: "WMHVC") as? WMHVC{
            let dic = headerData
            print(sender.tag)
            objSeeCodeVC.arrScrollData = BrandList().getDataForView(dealName: headerData.category, atIndex: sender.tag)
            objSeeCodeVC.headerViewData = BrandList().getDataForHeader(dealName: headerData.category, data: arrInsuranceData[sender.tag])
            self.navigationController?.pushViewController(objSeeCodeVC, animated: true)
        }
    }
    @IBAction func tapToSeeYouCode(_ sender: UIButton) {
        let objSeeCodeVC = self.storyboard?.instantiateViewController(withIdentifier: "SeeCodeVC") as! SeeCodeVC
        self.navigationController?.pushViewController(objSeeCodeVC, animated: true)
    }
    @IBAction func tapToUseCode(_ sender: UIControl) {
        
        let text =  objCodePopUp.txtEnterCode.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        if (text?.characters.count)! > 0
        {
            self.view.endEditing(true)
            self.objCodePopUp.removeFromSuperview()
            self.objCodePopUp.Cons_ViewMiddle.constant = 1000
            self.rippleEffectMethod(buttonTag: cellTapTag)
            arrSeeCodeData[selectedIndex].isSeeCodeUsedBefore = true
        }else
        {
            showAlert(title: "Alert", message: "Please enter code!")
        }
    }
    // MARK: - CustumeView Design For PopUp
    func customCodeView()  {
        objCodePopUp = Bundle.main.loadNibNamed("ViewForPopUp", owner: self, options: nil)?.first as! ViewForPopUp
        self.objCodePopUp.frame = CGRect(x: 0, y:89, width:ScreenSize.WIDTH, height:ScreenSize.HEIGHT - 89)
        objCodePopUp.backgroundColor = UIColor.clear
        self.view.addSubview(objCodePopUp)
        UIView.animate(withDuration: 0.5) {
            //self.objCodePopUp.alpha = 0.5
            self.objCodePopUp.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
            self.objCodePopUp.Cons_ViewMiddle.constant = 0
            self.view.layoutIfNeeded()
        }
        objCodePopUp.txtEnterCode.autocorrectionType = .no
        objCodePopUp.txtEnterCode.inputAccessoryView = toolbarInit(textField: objCodePopUp.txtEnterCode)
        objCodePopUp.txtEnterCode.delegate = self
        //Buttons Click Events..
        self.objCodePopUp.btnClose.addTarget(self, action: #selector(self.tapToClosePopUp(_:)), for: .touchUpInside)
        self.objCodePopUp.btnSeeYourCode.addTarget(self, action: #selector(self.tapToSeeYouCode(_:)), for: .touchUpInside)
        self.objCodePopUp.controlUseCode.addTarget(self, action: #selector(self.tapToUseCode(_:)), for: .touchUpInside)
    }
    
    
    // MARK: - CustumeView Design For PopUp 3x Swipe
    func customCodeViewPopupSwipe()  {
        objCodeSwipePopUp = Bundle.main.loadNibNamed("ViewFor3xPopUp", owner: self, options: nil)?.first as! ViewFor3xPopUp
        self.objCodeSwipePopUp.frame = CGRect(x: 0, y:89, width:ScreenSize.WIDTH, height:ScreenSize.HEIGHT - 89)
        objCodeSwipePopUp.scrollView.delegate = self
        objCodeSwipePopUp.isWorking = true
        objCodeSwipePopUp.backgroundColor = UIColor.clear
        
        self.view.addSubview(objCodeSwipePopUp)
        UIView.animate(withDuration: 0.5) {
            //self.objCodePopUp.alpha = 0.5
            self.objCodeSwipePopUp.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
            self.objCodeSwipePopUp.Cons_ViewTop.constant = 10
            self.view.layoutIfNeeded()
        }
        self.objCodeSwipePopUp.btnCancel.addTarget(self, action: #selector(self.tapToClose3xPopUp(_:)), for: .touchUpInside)

    }
    
    
    // MARK: - Toolbar Keyboard
    
    func toolbarInit(textField: UITextField) -> UIToolbar
    {
        toolBar.delegate1 = self
        toolBar.txtField = textField
        return toolBar;
    }
    // MARK: - Custom ToolBar Delegates
    func closeKeyBoard() {
        self.view.endEditing(true)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        objCodePopUp.Cons_ViewTop.isActive = true
        objCodePopUp.Cons_ViewTop.constant = 25
        objCodePopUp.Cons_ViewMiddle.isActive = false
        objCodePopUp.layoutIfNeeded()
        return true;
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        objCodePopUp.Cons_ViewTop.isActive = false
        objCodePopUp.Cons_ViewMiddle.constant = 0
        objCodePopUp.Cons_ViewMiddle.isActive = true
        //textField.text?.localized
        return true;
    }
    func rippleEffectMethod(buttonTag : Int) {
        
        let dic = arrInsuranceData[buttonTag]
        let indexPath = IndexPath(row: buttonTag, section: 0)
        
        if !dic.isGetQuotes{
            
            let cell = tableViewMain.cellForRow(at: indexPath) as! CellForBoostTickets
            if self.pulseEffect != nil {
                self.pulseEffect.removeFromSuperlayer()
            }
            self.pulseEffect = PulsingHaloLayer()
            self.pulseEffect.haloLayerNumber = 7
            self.pulseEffect.animationDuration = 3
            // self.pulseEffect.beginTime = 0.0
            self.pulseEffect.radius = 125.0
            self.pulseEffect.backgroundColor = UIColor.init(red: 75/255.0, green: 166/255.0, blue: 249/255.0, alpha: 1.0).cgColor
            self.pulseEffect.position = cell.cntrolTapImage.center
            cell.viewForBack.layer.addSublayer(self.pulseEffect)
            self.pulseEffect.start()
            cell.imgTopBG.backgroundColor = UIColor(red: 141.0 / 255.0, green: 142.0 / 255.0, blue: 143.0 / 255.0, alpha: 1.0)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                UIView.animate(withDuration: 1.5, animations: {
                    dic.isGetQuotes = true
                    dic.displayMessage = "Expires in 45 days".localized
                    self.setCellcolorAndImage(cell: cell, dic: dic)
                    self.pulseEffect.backgroundColor = UIColor.init(red: 75/255.0, green: 166/255.0, blue: 249/255.0, alpha: 0.0).cgColor
                }, completion: { (result) in
                    self.cellTapTag = -1
                    self.pulseEffect.removeFromSuperlayer()
                })
            }
        }
    }
    
    // MARK: - ScrollView Delegate
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        if self.objCodeSwipePopUp.isWorking{
             objCodeSwipePopUp.pageControl.currentPage = Int(floor((scrollView.contentOffset.x - scrollView.frame.size.width / 2) / scrollView.frame.size.width)) + 1
        }
    }
}
//MARK: - Tableview Delegates And Datasource

extension WebDealDetailVC: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrInsuranceData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellForBoostTickets") as! CellForBoostTickets
        let dic = arrInsuranceData[indexPath.row]
        cell.lblMainTitle.text = dic.title
        cell.lblDesc.text = dic.desc
        cell.btnTopIcon.tag = indexPath.row
        cell.lblUsesCredit.text = dic.displayMessage
        
        if dic.title == "Plumber" && indexPath.row == 0{
            cell.tapGetAQuote.isUserInteractionEnabled = true
        }else{
            cell.tapGetAQuote.isUserInteractionEnabled = false
        }
        
        if dic.isGetQuotes
        {
            self.setCellcolorAndImage(cell: cell, dic: dic)
        }else{
            cell.imgMiddleblue.image = UIImage(named: dic.imageName)
            cell.lblGetQuotes.text = "GET A QUOTE".localized
            cell.imgTopBG.image = UIImage(named:dic.bgImage)
            cell.btnTopIcon.isHidden = false
            cell.lblDealBoosted.text = ""
        }
        cell.tapGetAQuote.tag = indexPath.row
        cell.tapGetAQuote.addTarget(self, action: #selector(self.tapToGetQuote(_:)), for: .touchUpInside)
        return cell
    }
   
    func setCellcolorAndImage(cell : CellForBoostTickets ,dic : Insurance_data) {
        cell.btnTopIcon.isHidden = true
        UIView.transition(with: cell.lblUsesCredit,
                          duration: 0.25,
                          options: .transitionCrossDissolve,
                          animations: { [weak self] in
                            cell.lblUsesCredit.text = dic.displayMessage
            }, completion: nil)
        cell.lblDealBoosted.text = "Deal Boosted".localized
        cell.lblGetQuotes.text = "Get a Quote".localized
        cell.imgTopBG.image = UIImage(named:"orange_bg")
    }
}

class BrandList {
    
    // Header View Data
    public func getDataForHeader(dealName:String, data : Insurance_data) ->[String : Any]{
        var headerData = [String : Any]()
        print(dealName)
        switch dealName {
            
        case "Insurance":
            
            switch data.title {
                
            case "Travel Insurance":
                headerData = ["title" : "These brands can't wait to Whoop! You Happy", "category" : "Insurance", "subcategory" : "Travel Insurance"]
                
            case "Travel Insurance\n( Medical conditions )":
                headerData = ["title" : "These brands can't wait to Whoop! You Happy", "category" : "Insurance","subcategory" : "Travel Insurance\n( Medical conditions )"]
                
            case "Car breakdown":
                headerData = ["title" : "These brands can't wait to Whoop! You Happy", "category" : "Insurance","subcategory" : "Car breakdown"]
                
            default:
                return headerData
            }
            
//                headerData = ["title" : "These brands can't wait to Whoop! You Happy"]
            
        case "Tradespeople":

            switch data.title {
                
            case "Plumber":
                headerData = ["title" : "These brands can't wait to Whoop! You Happy", "category" : "Tradespeople","subcategory" : "Plumber"]
                
            default:
                return headerData
            }
            
//            headerData = ["title" : "These brands can't wait to Whoop! You Happy"]
            
        case "Technology":
            
            switch data.title {
                
            case "Broadband":
                headerData = ["title" : "These brands can't wait to Whoop! You Happy", "category" : "Technology", "subcategory" : "Broadband"]
                
            case "Mobile":
                headerData = ["title" : "These brands can't wait to Whoop! You Happy", "category" : "Technology", "subcategory" : "Mobile"]
                
            default:
                return headerData
            
            }
//            headerData = ["title" : "These brands can't wait to Whoop! You Happy"]
            
        case "Moving Home":

            switch data.title {
                
            case "Conveyancer Deal":
                headerData = ["title" : "These brands can't wait to Whoop! You Happy", "category" : "Moving Home", "subcategory" : "Conveyancer Deal"]
                
            case "Home Removal Deal":
                headerData = ["title" : "These brands can't wait to Whoop! You Happy", "category" : "Moving Home", "subcategory" : "Home Removal Deal"]
            default:
                return headerData
            }
//            headerData = ["title" : "These brands can't wait to Whoop! You Happy"]
        case "My Vehicle":
    
            switch data.title {
                
            case "Car MOT and Services Deal":
                headerData = ["title" : "These brands can't wait to Whoop! You Happy", "category" : "My Vehicle", "subcategory" : "Car MOT and Services Deal"]
                
            case "Car Tyres Deal":
                headerData = ["title" : "These brands can't wait to Whoop! You Happy", "category" : "My Vehicle", "subcategory" : "Car Tyres Deal"]
                break
                
            default:
                return headerData
            }
//            headerData = ["title" : "These brands can't wait to Whoop! You Happy"]
            
        default:
            return headerData
//            break
        }
        
        return headerData
    }
    public func getDataForView(dealName:String, atIndex:Int) ->[[String : Any]]{
        var arrScrollData = [[String : Any]] ()
        switch dealName {
        case "Insurance":
            
            switch atIndex {
                
            case 0:
                arrScrollData = [["image" : "coreforyoulogo", "title" : "Cover For You".localized,"desc":"Travel Insurance that is as unique as you are".localized,"bgImage" : "bg_brand_broad", "category":"Insurance"]]
                break
                
            case 1:
//                arrScrollData = [["image" : "coreforyoulogo", "title" : "Cover For You".localized,"desc":"Travel Insurance that is as unique as you are".localized,"bgImage" : "bg_brand_broad", "category":"Insurance"]]
                 arrScrollData = [["image" : "goodtogo", "title" : "Good Go Insurence".localized,"desc":"Travel Insurance with cover for medical conditions and no age limit".localized,"bgImage" : "goodtogo_bg", "category":"Insurance"]]
                break
                
            case 2:
                arrScrollData = [["image" : "Rescue_co_uk", "title" : "Start Rescue".localized,"desc":"We have five different levels of cheap breakdown cover for you to choose from".localized,"bgImage" : "orange_banner", "category":"Insurance"]]
               
                break
                
            default:
                break
            }
//            arrScrollData = [["image" : "whoop!_me_happy_face", "title" : "Start Rescue".localized,"desc":"We have five different levels of cheap breakdown cover for you to choose from".localized,"bgImage" : "orange_banner", "category":"Insurance"],
//                             
//                             ["image" : "coreforyoulogo", "title" : "Cover For You".localized,"desc":"Travel Insurance that is as unique as you are".localized,"bgImage" : "bg_brand_broad", "category":"Insurance"],
//                             
//                             ["image" : "goodtogo", "title" : "Good Go Insurence".localized,"desc":"Travel Insurance with cover for medical conditions and no age limit".localized,"bgImage" : "goodtogo_bg", "category":"Insurance"]
//            ]
            
        case "Tradespeople":
            
            arrScrollData = [
                ["image" : "aspect_co_uk", "title" : "Aspect Property".localized,"desc":"We’re proud to be your Whoop! Me Happy Plumber".localized,"bgImage" : "yellow_banner", "message" : "Uses 1 credit", "category":"Tradespeople"]]
            
        case "Technology":
            
            switch atIndex {
            case 0:
                arrScrollData = [
                    ["image" : "BT_home", "title" : "Broadband".localized,"desc":"".localized,"bgImage" : "bg_tec", "category":"Technology"]]
                break
                
            case 1:
                arrScrollData = [
                    ["image" : "vodafone", "title" : "Vodafone".localized,"desc":"".localized,"bgImage" : "bg_mobile", "category":"Technology"]]
                break
                
            default:
                break
            }
            
            
        case "My Vehicle":
            
            switch atIndex {
            case 0:
                arrScrollData = [
                    ["image" : "autoSaveGarage", "title" : "AutoSave Garage".localized,"desc":"We're your local and approved MOT mechanic ".localized,"bgImage" : "myVehicle_bg", "message" : "Expires in 45 days", "category":"My Vehicle"]]
                break
                
            case 1:
                arrScrollData = [
                    ["image" : "autoSaveGarage", "title" : "AutoSave Garage".localized,"desc":"We're your local and approved MOT mechanic ".localized,"bgImage" : "myVehicle_bg", "message" : "Expires in 45 days", "category":"My Vehicle"]]
                break
                
            default:
                break
            }
            /*arrScrollData = [
                ["image" : "myvehicles", "title" : "Car MOT and Services Deal".localized,"desc":"This is your home's local plumber deal".localized,"bgImage" : "bg_veh", "message" : "Expires in 45 days", "category":"My Vehicle"],
                ["image" : "cartyres", "title" : "Car Tyres Deal".localized,"desc":"You'll only use this credit/deal if you buy a policy".localized,"bgImage" : "bg_veh", "message" : "Uses 1 credit", "category":"My Vehicle"]]*/
            
        case "Moving Home":
            
            switch atIndex {
                
            case 0:
                arrScrollData = [
                    ["image" : "bright&co", "title" : "Bright&Co".localized,"desc":"We're proud to be your local Whoop! conveyancers ".localized,"bgImage" : "movingHome_bg", "message" : "Expires in 45 days", "category":"Moving Home"]]
                break
                
            case 1:
                arrScrollData = [
                    ["image" : "bright&co", "title" : "Bright&Co".localized,"desc":"We're proud to be your local Whoop! conveyancers ".localized,"bgImage" : "movingHome_bg", "message" : "Expires in 45 days", "category":"Moving Home"]]
                break
                
            default:
                break
            }
            
            
        default:
            return arrScrollData
            
        }
        return arrScrollData
    }
}
