//
//  DriversPopoverViewController.swift
//  PaddockClubPad
//
//  Created by Zel Marko on 23/01/15.
//  Copyright (c) 2015 Zel Marko. All rights reserved.
//

import UIKit

protocol PopoverDelegate {
    
    func driverInfo(driver: NSString, sender: UIButton)
}

class DriversPopoverViewController: UIViewController {
    
    var delegate: PopoverDelegate?
    
    var placeSender: UIButton?
    
    @IBOutlet weak var placeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    func senderInfoRecieved(place: NSString, sender: UIButton) {
        println("place: \(place)")
        println("sender: \(sender)")
        placeSender = sender
        
        placeLabel.text = place
        
    }
    
    @IBAction func driverSelected(sender: UIButton) {
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
        println(placeSender!)
        if let text = sender.titleLabel?.text {
            delegate?.driverInfo(text, sender: placeSender!)
        }
        
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
