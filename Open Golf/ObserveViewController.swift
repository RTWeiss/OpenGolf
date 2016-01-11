//
//  ObserveViewController.swift
//  OpenGolf
//
//  Created by Christopher Cobar on 1/9/16.
//  Copyright © 2016 ChristopherCobar. All rights reserved.
//

import UIKit

class ObserveViewController: UIViewController {
    
    // MARK: Properties
    @IBOutlet weak var golfCourseLabel: UILabel!
    @IBOutlet weak var courseParLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var holesPlayedNumber: UILabel!
    @IBOutlet weak var totalShotsLabel: UILabel!
    @IBOutlet weak var totalPuttsLabel: UILabel!
    @IBOutlet weak var averagePuttsLabel: UILabel!
    @IBOutlet weak var averageFairwaysLabel: UILabel!
    @IBOutlet weak var finalScoresLabel: UILabel!
    
    var round:Round?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if round != nil {
            self.golfCourseLabel.text = round?.golfCourseRound
            self.courseParLabel.text = "\(Int((round?.shotsPar)!))"
            self.dateLabel.text = "\((round?.niceLookingDate())!)"
            self.holesPlayedNumber.text = "\(Int((round?.holesPlayed)!))"
            self.totalShotsLabel.text = "\(Int((round?.shotsRound)!))"
            self.totalPuttsLabel.text = "\(Int((round?.puttsRound)!))"
            self.averagePuttsLabel.text = "\(Int((round?.averagePuttsPerHole())!))"
            self.averageFairwaysLabel.text = "\(Int((round?.averageFairwayAccuracy())!))"
            if "\(Int((round?.scoreToPar())!))" == "nil" {
                self.finalScoresLabel.text = "Even"
            } else {
                self.finalScoresLabel.text = "\(Int((round?.averageFairwayAccuracy())!))"
            }

        }
        self.navigationItem.title = "Round Observer"
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
