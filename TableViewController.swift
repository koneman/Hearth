//
//  TableViewController.swift
//  Hearth
//
//  Created by Sathvik Koneru on 5/16/16.
//  Copyright © 2016 Sathvik Koneru. All rights reserved.
//

import UIKit

//this class is used to organize the second view controller
//which is a table view of multiple cells to hold all the pins the user adds
class TableViewController: UITableViewController {
    @IBOutlet var doen: UINavigationBar!
    
    //this method is similar to a constructor and creates the table view object
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if allPlaces.count == -1 {
            
            allPlaces.removeAtIndex(0)
            
            allPlaces.append(["name":"Taj Mahal","lat":"27.175277","lon":"78.042128"])
        }
    }
    
    //default memory warning method
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    //this method returns the number of sections the Table View has
    //our app only needs 1 sectiosn
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    
    //this method reutrns the total number of entries in the dictionary to create
    //a cell for each pin and entry
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return allPlaces.count
    }
    
    
    //this method edits the text of each cell
    //it is set to the corresponding value in the allPlaces dictionary
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        cell.textLabel?.text = allPlaces[indexPath.row]["name"]
        
        return cell
    }
    
    //this method returns the corresponding index of the row
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        
        activePlace = indexPath.row
        
        return indexPath
    }
    
    //this method reloads the data so that each time new pins are added, they will 
    //show up in the Table View
    override func viewWillAppear(animated: Bool) {
        
        tableView.reloadData()
    }
    
    //this method in invoked when the user presses the "+" or "back" button
    //the view controller
    //when this happens activePlace is reset
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if ((segue.identifier == "newPlace") || (segue.identifier == "done")){
            
            activePlace = -1
            
        }
        
    }
    
    
    //extra methods for TableViewController
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
