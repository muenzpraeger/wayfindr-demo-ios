//
//  DemoBeaconInterface.swift
//  Wayfindr Demo
//
//  Created by Wayfindr on 21/12/2015.
//  Copyright © 2015 Wayfindr.org Limited. All rights reserved.
//

import Foundation
import UIKit

private var displayDemoInterfaceWarning = true

final class DemoBeaconInterface: NSObject, BeaconInterface {
    
    
    // MARK: - Properties
    
    var needsFullBeaconData = false
    
    var monitorBeacons = true
    
    weak var delegate: BeaconInterfaceDelegate?
    
    weak var stateDelegate: BeaconInterfaceStateDelegate?
    
    var validBeacons: [BeaconIdentifier]?
    
    private(set) var interfaceState = BeaconInterfaceState.Initializing {
        didSet {
            stateDelegate?.beaconInterface(self, didChangeState: interfaceState)
        }
    }
    
    /// API Key used by Beacon manufacturer
    private let apiKey: String
    
    
    // MARK: - Initializers
    
    init(apiKey: String, monitorBeacons: Bool = true) {
        self.apiKey = apiKey
        
        super.init()

        // Salesforce App Cloud - modification
        //
        // René Winkelmeyer
        //
        // - Removed demo warning message
        // - Sample setup for connecting to the Estimote Cloud
        //
        // Will be removed later as data will be provided through Force.com.
        
        ESTConfig.setupAppID("dreamforce-test1-cll", andAppToken: "ae8d960ba55500798dafacac63aae3c5")
        
        interfaceState = .Operating
    }

    
    // MARK: - GET
    
    func getBeacons(completionHandler completionHandler: ((Bool, [WAYBeacon]?, BeaconInterfaceAPIError?) -> Void)?) {
        
        // Salesforce App Cloud - modification
        //
        // René Winkelmeyer
        //
        // - Calling the Estimote API to read all available beacons from their cloud interface.
        // - Populate a list of WAYBeacons with the loaded Estimote beacons
        //
        // Will be removed later as data will be provided through Force.com.
        
        var wayBeacons = [WAYBeacon]()
        
        let beaconsRequest = ESTRequestGetBeacons()
        beaconsRequest.sendRequestWithCompletion { ( beacons: [ESTBeaconVO]?, error: NSError?) in
            for beacon in beacons! {
                let wayBeacon = WAYBeacon(major: beacon.major as Int, minor: beacon.minor as Int, UUIDString: beacon.proximityUUID)
                wayBeacons.append(wayBeacon)
                
            }
        }
        
        completionHandler?(true, wayBeacons, nil)
    }
}
