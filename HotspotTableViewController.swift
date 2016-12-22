//
//  HotspotTableViewController.swift
//  Hearth
//
//  Created by Sathvik Koneru on 5/22/16.
//  Copyright © 2016 Sathvik Koneru. All rights reserved.
//

import UIKit

//this global variable represents an array of all the addresses from hotSpotDict
var hotspotArr = [String]()

class HotspotTableViewController: UITableViewController {
    
    //default constructor
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        
    }
    
    //default memory warning method
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    //this method returns the 1 section that the Hotspot Table View controller needs
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    //this method is used to create the number of rows in
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        //creates an instance of a heap structure with a dictioanry passed in
        let heapList = PriorityQueue<[String:String]>()
        
        for (_, locationInfo) in hotSpotDict {
            
            //pushing in the freq as a priority item and the locationInformation
            heapList.push(((locationInfo["freq"]!  as NSString).integerValue), item:locationInfo)
        }
        
        var n = 0
        
        print(hotSpotDict.count)
        
        hotspotArr.removeAll()
        
        //adding the "hot" top 20 locations to the hotspotArr of addresses
        while (n < heapList.count){
            
            var (_, loc)  = heapList.pop()
            
            let hotSpot = loc["address"]
            
            hotspotArr.append(hotSpot!)
            
            n += 1
            
        }
        
        
        return hotspotArr.count
    }
    
    //sets the text of the cell to the corresponding address in hotspotArr
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //var hotSpotDict = [String:[String:Double]]()
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        cell.textLabel?.text = hotspotArr[indexPath.row]
        

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
