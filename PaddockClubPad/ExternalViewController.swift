//
//  ExternalViewController.swift
//  PaddockClubPad
//
//  Created by Zel Marko on 20/12/14.
//  Copyright (c) 2014 Zel Marko. All rights reserved.
//

import UIKit
import TwitterKit


let mySpecialNotificationKey = "com.disobeythesystem.specialNotificationKey"

class ExternalViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var tweetFeedTable: UITableView!
    @IBOutlet weak var gameTable: UITableView!
    
    var images: [UIImage] = []
    var imageIsIn = false

    override func viewDidLoad() {
        
        super.viewDidLoad()

        externalWindow?.addSubview(mainView);
        let externalScreenFrame = externalScreen?.bounds
        mainView.frame = externalScreenFrame!
        
        gameTable.delegate = self
        gameTable.dataSource = self
        
        tweetFeedTable.delegate = self
        tweetFeedTable.dataSource = self
        //tweetFeedTable.estimatedRowHeight = 80
        tweetFeedTable.rowHeight = UITableViewAutomaticDimension
        tweetFeedTable.reloadData()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "imageDownloaded", name: mySpecialNotificationKey, object: nil)
        
        Twitter.sharedInstance().logInGuestWithCompletion { (session: TWTRGuestSession!, error: NSError!) in
            Twitter.sharedInstance().APIClient.loadTweetWithID("20") { (tweet: TWTRTweet!, error: NSError!) in
                self.view.addSubview(TWTRTweetView(tweet: tweet))
            }
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var num = 0
        
        if tableView == tweetFeedTable {
            
            num = 0
            
        } else {
            
            num = bets.count
            
        }
        
        return num
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 40.0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if tableView == tweetFeedTable {
            var cell = tableView.dequeueReusableCellWithIdentifier("tweetCell", forIndexPath: indexPath) as TweetFeedCell
            
                        
            return cell

        } else {
            
            let cell = gameTable.dequeueReusableCellWithIdentifier("gameCell", forIndexPath: indexPath) as GameTableCell
            
            cell.guestName.text = bets[indexPath.row]["Name"] as? String
            
            var keys = [String]()
            
            for (key, data) in bets[indexPath.row] {
                
                if key as NSString != "Name" {
                    
                    keys.append(key as String)
                    
                }
                
            }
            
            var sortedKeys = keys.sorted { $0 < $1 }
            
            for index in 0...9 {
                
                let label = cell.driverLabels[index]
                let rawString = bets[indexPath.row]["\(sortedKeys[index])"] as? String
                let arr: [String] = rawString!.componentsSeparatedByString(" ")
                
                var n = 0
                
                for (i, object) in enumerate(arr) {
                    
                    if n == 1 {
                        
                        let lastName = object
                        let inx = advance(lastName.startIndex, 3)
                        let shortLast = lastName.substringToIndex(inx).uppercaseString
                        println("Final: \(shortLast)")
                        
                        label.text = shortLast
                    }
                    
                    n++
                }
                
            }
            
            return cell
        }
        
    }
    
    func imageDownloaded() {
        tweetFeedTable.reloadData()
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
