//
//  ArrivalViewController.swift
//  West Campus
//
//  Created by Tom Chu on 11/30/15.
//  Copyright © 2015 ENAS118. All rights reserved.
//

import UIKit

class ArrivalViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        summaryLabel.text = "Congratulations, you've finished the scavenger hunt! Tap the home button to return to the main menu."
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
