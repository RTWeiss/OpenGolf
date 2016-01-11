//
//  RoundsTableViewController.swift
//  OpenGolf
//
//  Created by Christopher Cobar on 1/9/16.
//  Copyright © 2016 ChristopherCobar. All rights reserved.
//

import UIKit

class RoundsTableViewController: UITableViewController {
    
    // MARK: Properties
    var rounds = [Round]()
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Edit button for deletion and navcustomization
        navigationItem.leftBarButtonItem = editButtonItem()
        
        //68,132,90
        
        if let savedRounds = loadRounds() {
            rounds += savedRounds
        } else {
            //TEST SAMPLE ROUNDS
            loadSampleRounds()
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadSampleRounds() {
        let round1 = Round(golfCourse: "MidlandHills", date: NSDate.init(), holesPlayed: 12.0, fairwaysHit: 3, shots: 69.0, par: 72.0, putts: 36.0)
        
        rounds += [round1]
    }

    // MARK: Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return 1
        
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return rounds.count
        
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "RoundTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! RoundTableViewCell
        let round = rounds[indexPath.row]

        cell.golfCoursePlayedLabel.text = round.golfCourseRound
        cell.datePlayedLabel.text = round.niceLookingDate()
        cell.scoreLabel.text = round.scoreToPar()
        cell.puttsPerHoleLabel.text = "\(round.averagePuttsPerHole())"
        cell.fairwayAccuracyLabel.text = "\(round.averageFairwayAccuracy())"

        return cell
    }
    
    //Receiver for new completed round to add to tableview and saves it
    @IBAction func unwindToRounds(sender: UIStoryboardSegue) {
        
        if let sourceController = sender.sourceViewController as? PlayingViewController, round = sourceController.round {
            
            let newIndexPath = NSIndexPath(forRow: rounds.count, inSection: 0)
            rounds.append(round)
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            saveRounds()
        }
    
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */
    
    // To support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source and save it
            rounds.removeAtIndex(indexPath.row)
            saveRounds()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

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

    
    // MARK: Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "ShowRound" {
            
            let roundObservingViewController = segue.destinationViewController as! ObserveViewController
            if let selectedRoundCell = sender as? RoundTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedRoundCell)!
                let selectedRound = rounds[indexPath.row]
                roundObservingViewController.round = selectedRound
                
            }
        }
    }
    
    // MARK: NSCoding for displaying persistent round storage
    //saving rounds
    func saveRounds() {
        
        let successfullySaved = NSKeyedArchiver.archiveRootObject(rounds, toFile: Round.ArchiveURL.path!)
        if !successfullySaved {
            let alert = UIAlertController(title: "Error", message: "There has been an error saving your round", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
    }
    
    //loading rounds from archiveurl path to controller
    func loadRounds() -> [Round]? {
        
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Round.ArchiveURL.path!) as? [Round]
        
    }

}
