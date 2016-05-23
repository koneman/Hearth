//
//  HotspotTableViewController.swift
//  Hearth
//
//  Created by Sathvik Koneru on 5/22/16.
//  Copyright © 2016 Sathvik Koneru. All rights reserved.
//

import UIKit

var hotspotArr = [String]()

class HotspotTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        
        let heapList = PriorityQueue<[String:String]>()
        
        for (_, locationInfo) in hotSpotDict {
            
            heapList.push(((locationInfo["freq"]!  as NSString).integerValue), item:locationInfo)
        }
        
        var n = 0
        
        print(hotSpotDict.count)
        
        hotspotArr.removeAll()
        
        while (n < heapList.count){
            
            var (_, loc)  = heapList.pop()
            
            let hotSpot = loc["address"]
            
            hotspotArr.append(hotSpot!)
            
            n += 1
            
        }
        
        
        return hotspotArr.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //var hotSpotDict = [String:[String:Double]]()
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        
        
        cell.textLabel?.text = hotspotArr[indexPath.row]
        
        
        //print(heapList))
        
        //PriorityQueue().heap()
        //PriorityQueue<hotSpotDict[""]>()
        //PriorityQueue<hotSpotDict["freq"]>.push()
        
        
        //cell.textLabel?.text = hotSpotDict[]
        
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
     if editingStyle == .Delete {
     // Delete the row from the data source
     tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
     } else if editingStyle == .Insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
