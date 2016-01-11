//
//  Round.swift
//  OpenGolf
//
//  Created by Christopher Cobar on 1/8/16.
//  Copyright © 2016 ChristopherCobar. All rights reserved.
//

import UIKit

class Round: NSObject, NSCoding {
    
    // MARK: Properties
    var golfCourseRound:String
    var datePlayed: NSDate
    var holesPlayed:Double
    var fairwayAccuracyRound:Int
    var shotsRound:Double
    var shotsPar:Double
    var puttsRound:Double
    
    // MARK: Archiving paths for persistent storage
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("rounds")
    
    // MARK: Types
    struct PropertyKey {
        static let courseKey = "course"
        static let dateKey = "date"
        static let holesKey = "holes"
        static let fwaKey = "fwaKey"
        static let shotsKey = "shots"
        static let parKey = "par"
        static let puttsKey = "putts"
    }
    
    // MARK: Initializer
    init(golfCourse: String, date: NSDate, holesPlayed: Double,fairwaysHit:Int, shots: Double, par: Double, putts:Double) {
        
        self.golfCourseRound = golfCourse
        self.datePlayed = date
        self.holesPlayed = holesPlayed
        self.fairwayAccuracyRound = fairwaysHit
        self.shotsRound = shots
        self.shotsPar = par
        self.puttsRound = putts
        
        super.init()
        
    }
    
    // MARK: Methods
    func averagePuttsPerHole() -> Double {
        
        return self.puttsRound/self.holesPlayed
        
    }
    
    func averageFairwayAccuracy() -> Int {
        
        return fairwayAccuracyRound
        
    }
    
    func scoreToPar() -> String {
        
        if (shotsRound - shotsPar) == 0.0 {
            return "Even"
        } else if (shotsRound - shotsPar) > 0.0 {
            return "+\(Int(shotsRound - shotsPar))"
        } else {
            return "-\(abs(Int(shotsRound - shotsPar)))"
        }
            
    }
    
    func niceLookingDate() -> String {
        
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.ShortStyle
        formatter.timeStyle = .ShortStyle
        
        return formatter.stringFromDate(self.datePlayed)
        
    }
    
    // MARK: NSCoding protocals for persistent storage
    func encodeWithCoder(aCoder: NSCoder) {
        
        aCoder.encodeObject(self.golfCourseRound, forKey: PropertyKey.courseKey)
        aCoder.encodeObject(self.datePlayed, forKey: PropertyKey.dateKey)
        aCoder.encodeObject(self.holesPlayed, forKey: PropertyKey.holesKey)
        aCoder.encodeObject(self.fairwayAccuracyRound, forKey: PropertyKey.fwaKey)
        aCoder.encodeObject(self.shotsRound, forKey: PropertyKey.shotsKey)
        aCoder.encodeObject(self.shotsPar, forKey: PropertyKey.parKey)
        aCoder.encodeObject(self.puttsRound, forKey: PropertyKey.puttsKey)

    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        let name = aDecoder.decodeObjectForKey(PropertyKey.courseKey) as! String
        let date = aDecoder.decodeObjectForKey(PropertyKey.dateKey) as! NSDate
        let holes = aDecoder.decodeObjectForKey(PropertyKey.holesKey) as! Double
        let fwa = aDecoder.decodeObjectForKey(PropertyKey.fwaKey) as! Int
        let shots = aDecoder.decodeObjectForKey(PropertyKey.shotsKey) as! Double
        let par = aDecoder.decodeObjectForKey(PropertyKey.parKey) as! Double
        let putts = aDecoder.decodeObjectForKey(PropertyKey.puttsKey) as! Double
        
        self.init(golfCourse: name, date: date, holesPlayed: holes,fairwaysHit:fwa, shots: shots, par: par, putts:putts)
        
    }
    
}
