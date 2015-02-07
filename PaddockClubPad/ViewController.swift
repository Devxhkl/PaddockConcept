//
//  ViewController.swift
//  PaddockClubPad
//
//  Created by Zel Marko on 20/12/14.
//  Copyright (c) 2014 Zel Marko. All rights reserved.
//

import UIKit

var externalScreen: UIScreen?
var externalWindow: UIWindow?

var externalViewController = ExternalViewController()

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UIScreen.screens().count > 1 {
            externalScreenRecognized()
        }
    }
    
    func externalScreenRecognized() {
        let screens: [AnyObject] = UIScreen.screens()
        
        externalScreen = (screens[1] as UIScreen)
        //println(externalScreen)
        let externalScreenFrame = externalScreen?.bounds
        
        externalWindow = UIWindow(frame: externalScreenFrame!)
        externalWindow?.screen = externalScreen!
        let externalStoryboard = UIStoryboard(name: "ExternalStoryboard", bundle: nil)
        externalViewController = externalStoryboard.instantiateViewControllerWithIdentifier("ExternalViewController") as ExternalViewController
        externalWindow?.rootViewController = externalViewController
        
        externalWindow?.hidden = false
        externalWindow?.makeKeyAndVisible()
        println("Externi")
    }

    @IBAction func refresh(sender: AnyObject) {
        
        externalViewController.tweetFeedTable.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

