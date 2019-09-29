//
//  ViewController.swift
//  iBeaconCreator
//
//  Created by Aleksey Rochev on 28.09.2019.
//  Copyright © 2019 Aleksey Rochev. All rights reserved.
//

import UIKit
import CoreLocation
import CoreBluetooth


class ViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet private weak var button: UIButton!
    
    // MARK: - Private Properties
    
    private var beaconService = BeaconSimulator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        beaconService.didChangeState = { state in
            if state == .poweredOn {
                self.button.titleLabel?.text = "Stop"
            } else {
                self.button.titleLabel?.text = "Start"
            }
        }
    }

    @IBAction func onClickButton(_ sender: Any) {
        beaconService.toggle()
    }
    
    // MARK: - Private Methods

    private func beacon(isEnabled: Bool) {
        
    }
    
}
