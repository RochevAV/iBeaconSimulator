//
//  BeaconSimulator.swift
//  iBeaconCreator
//
//  Created by Aleksey Rochev on 29.09.2019.
//  Copyright © 2019 Aleksey Rochev. All rights reserved.
//

import CoreLocation
import CoreBluetooth

final class BeaconSimulator: NSObject {
    
    // MARK: - Constants
    
    enum Constants {
        static let uuid = "1E75D047-5A38-4152-9FA5-F95EFB7DEBAF"
        static let identifier = "com.example.myDeviceRegion"
    }
    
    enum State {
        case enabled
        case disabled
    }
    
    // MARK: - Public Properties
    
    var didChangeState: ((CBManagerState) -> Void)?
    
    // MARK: - Private Properties
    
    private var state: State = .disabled
    private var peripheral: CBPeripheralManager?

    // MARK: - Public Methods
    
    func toggle() {
        if state == .disabled {
            if let region = createBeaconRegion() {
                advertiseDevice(region: region)
            }
        }
        else {
            peripheral?.stopAdvertising()
        }
    }
    
    // MARK: - Private Methods
    
    private func createBeaconRegion() -> CLBeaconRegion? {
        let proximityUUID = UUID(uuidString: Constants.uuid)
        let major: CLBeaconMajorValue = 16808
        let minor: CLBeaconMinorValue = 16809
        let identifier = Constants.identifier
            
        return CLBeaconRegion(proximityUUID: proximityUUID!,
                              major: major,
                              minor: minor,
                              identifier: identifier)
    }
    
    func advertiseDevice(region : CLBeaconRegion) {
        peripheral = CBPeripheralManager(delegate: self, queue: nil)
        let peripheralData = region.peripheralData(withMeasuredPower: nil)
        peripheral?.startAdvertising(((peripheralData as NSDictionary) as! [String : Any]))
    }
}

extension BeaconSimulator: CBPeripheralManagerDelegate {
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        didChangeState?(peripheral.state)
    }
}
