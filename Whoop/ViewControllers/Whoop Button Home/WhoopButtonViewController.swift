//
//  WhoopButtonViewController.swift
//  Whoop
//
//  Created by ZaeemZafar on 11/8/17.
//  Copyright © 2017 Abdul Baseer. All rights reserved.
//

import UIKit
import JHChainableAnimations

class WhoopButtonViewController: UIViewController {

    @IBOutlet weak var dealsStackView: UIStackView!
    @IBOutlet weak var whoopButtonImageView: UIImageView!
    @IBOutlet weak var descriptionStackView: UIStackView!
    @IBOutlet var yourHomeLabel: UILabel!
    @IBOutlet var secondLineLabel: UILabel!
    @IBOutlet weak var buttonsStackView: UIStackView!
    @IBOutlet var notificationView: UIView!
    
    @IBOutlet var lockedUnlockedLabel: UILabel!
    @IBOutlet var circleViews: [UIView]!
    var objCodePopUp = ViewForCodePopUp()
    
    @IBOutlet var boostDealLbl: UILabel!
    @IBOutlet var unlockedDealLbl: UILabel!
    @IBOutlet var secondLabelHeight: NSLayoutConstraint!
    @IBOutlet var dealLeftToUnlocklbl: UILabel!
    var isRed = false
    var isGreen = false
    var isYellow = false
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
     
    }
    func setUpView(){
        // Do any additional setup after loading the view.
        whoopButtonImageView.alpha = 0
        dealsStackView.alpha = 0
        buttonsStackView.alpha = 0
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            self.customChatView()
        })
        
        
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .center
        
         let attributedString    = NSMutableAttributedString(string: "16, Westway, London, SW1 1AW")
         let range               = ("16, Westway, London, SW1 1AW" as NSString).range(of: "16, Westway, London, SW1 1AW")
        
        attributedString.addAttribute(NSAttributedStringKey.underlineStyle, value: NSNumber(value: 1), range: range)
        
        
        attributedString.addAttributes([NSAttributedStringKey.paragraphStyle: paragraph], range: range)
        
        var labelText = ""
        attributedString.addAttribute(NSAttributedStringKey.underlineColor, value: UIColor.white, range: range)
        
        if isRed{
            notificationView.backgroundColor = UIColor.colorWithHexString(hex: "F52404")
            lockedUnlockedLabel.text = "Locked"
            
            labelText = "Verify your address to unlock all your deals"
            yourHomeLabel.textColor = UIColor.white
            secondLineLabel.textColor = UIColor.white
            attributedString.addAttribute(NSAttributedStringKey.underlineColor, value: UIColor.white, range: range)
            yourHomeLabel.text = labelText
            secondLineLabel.attributedText = attributedString
            
            boostDealLbl.text = "0"
            unlockedDealLbl.text = "0"
            dealLeftToUnlocklbl.text = "3"
        }
        if isGreen{
            notificationView.backgroundColor = UIColor.colorWithHexString(hex: "61B64F")
            lockedUnlockedLabel.text = "Unlocked"
            
            yourHomeLabel.textColor = UIColor.white
            secondLineLabel.textColor = UIColor.white
            labelText = "Your home's Whoop! Button is unlocked at"
            attributedString.addAttribute(NSAttributedStringKey.underlineColor, value: UIColor.white, range: range)
            yourHomeLabel.text = labelText
            secondLineLabel.attributedText = attributedString
            
           
        }
        if isYellow{
            boostDealLbl.text = "0"
            unlockedDealLbl.text = "0"
            dealLeftToUnlocklbl.text = "3"
            
            lockedUnlockedLabel.text = "Locked"
            notificationView.backgroundColor = UIColor.colorWithHexString(hex: "FBEB32")
            secondLabelHeight.constant = -5
            yourHomeLabel.textColor = UIColor.red
            labelText = "You've requested a unique code to unlock your home's button at 16, Westway, London, SW1 1AW"
            let attributedStringYellow    = NSMutableAttributedString(string: labelText)
            let rangeYellow               = (labelText as NSString).range(of: "16, Westway, London, SW1 1AW")

            attributedStringYellow.addAttribute(NSAttributedStringKey.underlineStyle, value: NSNumber(value: 1), range: rangeYellow)
            attributedStringYellow.addAttribute(NSAttributedStringKey.underlineColor, value: UIColor.red, range: rangeYellow)
            attributedStringYellow.addAttributes([NSAttributedStringKey.paragraphStyle: paragraph], range: rangeYellow)

            yourHomeLabel.attributedText = attributedStringYellow
        }
        
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        for circleView in circleViews {
            circleView.layer.cornerRadius = circleView.frame.width/2
        }
        
        let animator1 = JHChainableAnimator(view: whoopButtonImageView)
        animator1?.moveY()(300)?.thenAfter()(0.01)?.moveY()(-300)?.makeOpacity()(1)?.animate()(0.37)
        
        let animator2 = JHChainableAnimator(view: dealsStackView)
        animator2?.moveY()(200)?.thenAfter()(0.1)?.moveY()(-200)?.makeOpacity()(1)?.animate()(0.37)
        
//        let animator3 = JHChainableAnimator(view: descriptionStackView)
//        animator3?.moveY()(200)?.thenAfter()(0.15)?.moveY()(-200)?.makeOpacity()(1)?.animate()(0.37)
        
        let animator4 = JHChainableAnimator(view: buttonsStackView)
        animator4?.moveY()(200)?.thenAfter()(0.2)?.moveY()(-200)?.makeOpacity()(1)?.animate()(0.37)
        
    }
    
    // MARK: - Click events..
    @IBAction func tapRedNotificationBar(_ sender: Any) {
        if isRed
        {
            if let objHomeVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeWhoopOnBoardingVC") as?   HomeWhoopOnBoardingVC{
                self.navigationController?.pushViewController(objHomeVC, animated: true)
            }
        }
        
    }
    
    @IBAction func tapToPopupClose(_ sender: UIButton) {
        self.objCodePopUp.removeFromSuperview()
        self.objCodePopUp.Cons_ViewTop.constant = 1000
    }
    
    @IBAction func tapUnlockButton(_ sender: Any) {
        if lockedUnlockedLabel.text == "Locked"{
            if let objHomeVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeWhoopOnBoardingVC") as?   HomeWhoopOnBoardingVC{
                self.navigationController?.pushViewController(objHomeVC, animated: true)
            }
        }
    }
    @IBAction func settingsButtonTapped(_ sender: Any) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - CustumeView Design For PopUp
    func customChatView()  {
        objCodePopUp = Bundle.main.loadNibNamed("ViewForCodePopUp", owner: self, options: nil)?.first as! ViewForCodePopUp
        self.objCodePopUp.frame = CGRect(x: 0, y:0, width:ScreenSize.WIDTH, height:ScreenSize.HEIGHT)
        
        objCodePopUp.lblTitle.textAlignment = NSTextAlignment.center
        if isGreen {
            objCodePopUp.lblTitle.text = "Unlocked!"
            objCodePopUp.lblDesc.text = "Your home's button is now unlocked. You can now access all of your home’s deals and invite the people you live with.\nRemember to add a photo to your button so the people you live with know it's you. Tap a profile to start. "
        }else{
            
            if isYellow{
                objCodePopUp.lblTitle.text = "Unique code"
                objCodePopUp.lblDesc.text = "You've just requested a unique code to verify your address. It will arrive in 2 or 3 days. In the meantime you can use the deals we've added to your button."
            }else{
                objCodePopUp.lblTitle.text = "Your home's Whoop! Button."
                 objCodePopUp.lblDesc.text = "Verify your address to finishing unlocking your home's button and access all of your deals. If you've received an invite code enter it to join. For a quick start we’ve added 3 deals now to use straight away."
            }
           
        }
        
        objCodePopUp.backgroundColor = UIColor.clear
        self.view.addSubview(objCodePopUp)
        UIView.animate(withDuration: 0.5) {
            //self.objCodePopUp.alpha = 0.5
            self.objCodePopUp.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
            self.objCodePopUp.Cons_ViewTop.constant = 40
            self.view.layoutIfNeeded()
        }
        self.objCodePopUp.btnClose.addTarget(self, action: #selector(self.tapToPopupClose(_:)), for: .touchUpInside)
        self.objCodePopUp.btnCancel.addTarget(self, action: #selector(self.tapToPopupClose(_:)), for: .touchUpInside)
    }

}

