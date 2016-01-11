//
//  PlayingViewController.swift
//  OpenGolf
//
//  Created by Christopher Cobar on 1/8/16.
//  Copyright © 2016 ChristopherCobar. All rights reserved.
//

import UIKit

class PlayingViewController: UIViewController {
    
    // MARK: Mutable properties to store in CoreData after round
    var fairwayAccuracyTotal:Int = 0
    var shotRoundTotal:Double = 0.0
    var parCourseTotal:Double = 0.0
    var puttCountTotal:Double = 0.0
    var golfCourse:String = ""
    var didEnterGolfCourse:Bool = false
    
    var round:Round?
    
    // MARK: Mutable properties within round
    //nav title customizing
    var holeNumber:Double = 1.0 {
        didSet {
            if holeNumber <= 18.0 {
            navigationItem.title = "Hole \(Int(holeNumber))"
            } else {
                navigationItem.title = "complete round ->"
            }
        }
    }
    
    var holePutt:Double = 0.0
    var holeFairwayAccuracy:Int = 0
    var holeShotCount:Double = 0.0
    var holePar:Double = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        parSegmentControllerOutlet.selectedSegmentIndex = -1
        fairwayAccuracySegmentControlerOutlet.selectedSegmentIndex = -1
        puttSegmentControllerOutlet.selectedSegmentIndex = -1
        navigationItem.title = "Hole \(Int(holeNumber))"
        
        //Gathering GC name
        if self.didEnterGolfCourse == false {
            
            let alert = UIAlertController(title: "Greetings!", message: "Where will you be playing today?", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addTextFieldWithConfigurationHandler ({
                (textField) -> Void in
            })
            alert.addAction(UIAlertAction(title: "Okay", style: .Default, handler: {
                (action) -> Void in
                
                let textField = alert.textFields![0] as UITextField
                self.golfCourse = "\(textField.text!)"
                
                self.didEnterGolfCourse = true
                
            }))
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: {
                (UIAlertAction) -> Void in
                
                //perform cancel action to fly back to RTVC
                self.dismissViewControllerAnimated(true, completion: nil)
                
            }))
            self.presentViewController(alert, animated: true, completion: nil)
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: View outlets
    @IBOutlet weak var shotLabel: UILabel!
    @IBOutlet weak var parSegmentControllerOutlet: UISegmentedControl!
    @IBOutlet weak var fairwayAccuracySegmentControlerOutlet: UISegmentedControl!
    @IBOutlet weak var puttSegmentControllerOutlet: UISegmentedControl!
    @IBOutlet weak var stepperOutlet: UIStepper!
    @IBOutlet weak var completeButton: UIBarButtonItem!
    @IBOutlet weak var nextHoleButtonOutlet: UIButton!
    @IBOutlet weak var shotStepperOutlet: UIStepper!
    
    // MARK: Navigation controls
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if completeButton === sender {
            
            if self.golfCourse == "" {
                self.golfCourse = "no course specified"
            }
            let golfCourseName = self.golfCourse
            let roundFairwayAccuracy = self.fairwayAccuracyTotal
            let roundShotTotal = self.shotRoundTotal
            let roundCoursePar = self.parCourseTotal
            let roundPutts = self.puttCountTotal
            let roundHoles = self.holeNumber
            
            round = Round(golfCourse: golfCourseName, date: NSDate.init(), holesPlayed: roundHoles, fairwaysHit: roundFairwayAccuracy, shots: roundShotTotal, par: roundCoursePar, putts: roundPutts)
            
        }
    }
    
    @IBAction func cancelButton(sender: UIBarButtonItem) {
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    // MARK: View methods for recording stats
    @IBAction func shotStepper(sender: UIStepper) {
        
        let shotVal:Double = sender.value
        holeShotCount = shotVal
        shotLabel.text = "\(Int(shotVal))"
        
    }

    @IBAction func parSegmentController(sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            holePar = 3.0
        } else if sender.selectedSegmentIndex == 1 {
            holePar = 4.0
        } else {
            holePar = 5.0
        }
        
    }
    
    @IBAction func fairwaySegmentController(sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            holeFairwayAccuracy = -1
        } else if sender.selectedSegmentIndex == 1 {
            holeFairwayAccuracy = 0
        } else {
            holeFairwayAccuracy = 1
        }
        
    }
    
    @IBAction func puttSegmentController(sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            holePutt = 1.0
        } else if sender.selectedSegmentIndex == 1 {
            holePutt = 2.0
        } else {
            holePutt = 3.0
        }
        
    }
    
    
    
    // MARK: Button to reset view to progress to next hole
    @IBAction func nextButton(sender: UIButton) {
        
        //making sure all fields are selected before progressing
        if holeShotCount < 1 ||
        parSegmentControllerOutlet.selectedSegmentIndex < 0 ||
        fairwayAccuracySegmentControlerOutlet.selectedSegmentIndex < 0 ||
        puttSegmentControllerOutlet.selectedSegmentIndex < 0 {
            
            let alert = UIAlertController(title: "Missing Information", message: "Please enter all hole information correctly", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
        } else {
            
            //add mutable hole info final round variables
            self.parCourseTotal += self.holePar
            self.shotRoundTotal += self.holeShotCount
            self.fairwayAccuracyTotal += self.holeFairwayAccuracy
            self.puttCountTotal += self.holePutt
            
            //resetting outlets, shot label, and progressing hole number
            parSegmentControllerOutlet.selectedSegmentIndex = -1
            fairwayAccuracySegmentControlerOutlet.selectedSegmentIndex = -1
            puttSegmentControllerOutlet.selectedSegmentIndex = -1
        
            if self.holeNumber <= 18.0 {
                self.holeNumber += 1.0
                stepperOutlet.value = 0.0
                shotLabel.text = "0"
                self.holeShotCount = 0.0
            }
            if self.holeNumber == 18.0 {
                nextHoleButtonOutlet.setTitle("finish round", forState: .Normal)
            }
            if self.holeNumber > 18.0 {
                shotStepperOutlet.enabled = false
                parSegmentControllerOutlet.enabled = false
                fairwayAccuracySegmentControlerOutlet.enabled = false
                puttSegmentControllerOutlet.enabled = false
                nextHoleButtonOutlet.hidden = true
            }
        }
        
    }
    
}

