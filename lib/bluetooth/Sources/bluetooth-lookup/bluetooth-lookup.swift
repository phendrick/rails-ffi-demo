import librubybluetooth
import Foundation
import IOBluetooth

enum BluetoothScannerState: Int32 {
    case idle = 0, scanning
}

struct BluetoothScanner {
    private let deviceInquiry: IOBluetoothDeviceInquiry
    private let dispatchGroup: DispatchGroup

    init?(deviceInquiry: IOBluetoothDeviceInquiry?) {
        guard let deviceInquiry = deviceInquiry else {
            return nil 
        } 

        self.deviceInquiry = deviceInquiry
        self.dispatchGroup = DispatchGroup()
    }

    func lookupDevices() {
        dispatchGroup.enter()
        deviceInquiry.start()

        DispatchQueue.main.asyncAfter(deadline: .now() + 30) {
            self.deviceInquiry.stop()
            dispatchGroup.leave()
        }

        dispatchGroup.notify(queue: DispatchQueue.main) {
            exit(EXIT_SUCCESS)
        }

        dispatchMain()
    }
}

class BluetoothConnectorDelegate : NSObject, IOBluetoothDeviceInquiryDelegate {
    let deviceFoundCallback: device_found_callback
    
    init(deviceFoundCallback: @escaping device_found_callback) {
        self.deviceFoundCallback = deviceFoundCallback
    }
    
    func deviceInquiryStarted(_ sender: IOBluetoothDeviceInquiry!) {
        print("START")
    }
    
    func deviceInquiryComplete(_ sender: IOBluetoothDeviceInquiry!, error: IOReturn, aborted: Bool) {
        print("Complete!")
    }

    func deviceInquiryDeviceFound(_ sender: IOBluetoothDeviceInquiry!, device: IOBluetoothDevice!) {
        let name   = strdup(device.nameOrAddress!)
        let identifier = strdup(device.addressString!)
        let device_details = BLUETOOTH_DEVICE(
            identifier: identifier, 
            name: name,
            classOfDeviceCode: device.classOfDevice
        )

        print("[SWIFT] Bluetooth device found")
        self.deviceFoundCallback(device_details)
    }
}

@_cdecl("start_scan")
func startScan(_ deviceFoundCallback: @escaping device_found_callback) {
    let delegate = BluetoothConnectorDelegate(
        deviceFoundCallback: deviceFoundCallback
    )

    let inquiry = IOBluetoothDeviceInquiry(delegate: delegate)
    guard let device_manager  = BluetoothScanner(deviceInquiry: inquiry) else {
        return
    }
    
    inquiry?.inquiryLength = 30
    device_manager.lookupDevices()
}
