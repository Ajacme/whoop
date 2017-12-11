//
//  PreferredDataTimeViewController.swift
//  Whoop
//
//  Created by ACMEUNIVERSE MAC-2 on 11/12/17.
//  Copyright © 2017 Abdul Baseer. All rights reserved.
//

import UIKit

class WayToBookingViewController: UIViewController {

    @IBOutlet var shadowView: ShadowView!
    override func viewDidLoad() {
        super.viewDidLoad()

        shadowView.layer.shadowColor = UIColor.groupTableViewBackground.cgColor
        shadowView.layer.shadowOpacity = 1
        shadowView.layer.shadowOffset = CGSize.zero
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tapByPhone(_ sender: Any) {
    }
    
    
    @IBAction func tapBookOnline(_ sender: Any) {
        if let initVC = self.storyboard?.instantiateViewController(withIdentifier: "WriteForJobViewController") as? WriteForJobViewController{
        self.navigationController?.pushViewController(initVC, animated: true)
        }
    }
    @IBAction func tapBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
