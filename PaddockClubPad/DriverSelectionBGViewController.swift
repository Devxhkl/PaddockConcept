//
//  DriverSelectionBGViewController.swift
//  PaddockClubPad
//
//  Created by Zel Marko on 23/01/15.
//  Copyright (c) 2015 Zel Marko. All rights reserved.
//

import UIKit


class DriverSelectionBGViewController: UIViewController, PopoverDelegate {
    
    
    @IBOutlet var placementSelectionButtons: [UIButton]!
    
    let popover: DriversPopoverViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("driversPopover") as DriversPopoverViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        popover.delegate = self
        
        
    }
    
    @IBAction func toDriversSelectionPopover(sender: AnyObject) {
        
        self.popover.delegate = self
        popover.modalPresentationStyle = .Popover
        
        if let popoverController = popover.popoverPresentationController {
            
            popoverController.sourceView = sender as UIView
            popoverController.sourceRect = sender.bounds
            popoverController.permittedArrowDirections = .Left
            popover.preferredContentSize = CGSizeMake(600, 600)
        }
        
        presentViewController(popover, animated: true, completion: nil)
        let senderBut = sender as UIButton
        for (index, button) in enumerate(placementSelectionButtons) {
            if senderBut == button {
                let placeText = getPlaceTextFromButton(index)
                popover.senderInfoRecieved(placeText, sender: senderBut)
            }
        }
        
    }
    
    
    @IBAction func done(sender: AnyObject) {
        
        var buttonsText = [String]()
        
        for (button) in placementSelectionButtons {
            if let text = button.titleLabel?.text {
                println(text)
                if countElements(text) <= 6 {
                    
                    let alert = UIAlertController(title: "", message: "You need to select a driver for every place.", preferredStyle: .Alert)
                    alert.addAction(UIAlertAction(title: "Okay", style: .Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                    break
                } else {
                    buttonsText.append(text)
                }
                
            }
            
        }
        println("array: \(buttonsText)")
        if buttonsText.count == 10 {
            
            let url = NSURL(string: "http://disobeythesystem.com/bets_upload.php")
            let data = "name=Gerald&A=\(buttonsText[0])&B=\(buttonsText[1])&C=\(buttonsText[2])&D=\(buttonsText[3])&E=\(buttonsText[4])&F=\(buttonsText[5])&G=\(buttonsText[6])&H=\(buttonsText[7])&I=\(buttonsText[8])&J=\(buttonsText[9])"
            let requestData = (data as NSString).dataUsingEncoding(NSUTF8StringEncoding)

            let request = NSMutableURLRequest(URL: url!)
            request.HTTPMethod = "POST"
            request.HTTPBody = requestData

            let connection = NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: nil)
            let returned = NSString(data: connection!, encoding: NSUTF8StringEncoding)
            
            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = mainStoryboard.instantiateViewControllerWithIdentifier("mainViewController") as UIViewController
            self.presentViewController(vc, animated: true, completion: nil)

        }
        
    }
    
    func driverInfo(driver: NSString, sender: UIButton) {
        println("Driver: \(driver) sender: \(sender)")
        
        for (index, button) in enumerate(placementSelectionButtons) {
            println("Index: \(index) Button: \(button.titleLabel?.text)")
            if button.titleLabel?.text == driver {
                let buttonTitle = getPlaceTextFromButton(index)
                button.setTitle(buttonTitle, forState: .Normal)
            }
        }
        sender.setTitle(driver, forState: .Normal)
    }
    
    func getPlaceTextFromButton(index: Int) -> NSString {
        var place = ""
        switch (index) {
            case 0:
                place = "Winner"
            case 1:
                place = "2nd"
            case 2:
                place = "3rd"
            case (3...9):
                let string = NSString(string: "\(index + 1)th")
                place = string
            default:
                break
            }
        return place
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation
/*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

*/
}
