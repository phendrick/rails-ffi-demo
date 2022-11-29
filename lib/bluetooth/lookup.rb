module Bluetooth
  module Lookup
    extend FFI::Library
    ffi_lib [File.join(Rails.root, "lib", "bluetooth", ".build", "debug", "libbluetooth-lookup.dylib")]
    
    attach_function :start_scan, [:pointer], :void, blocking: true
    
    class DeviceStruct < FFI::Struct
      layout :identifier, :string,
             :name, :string,
             :classOfDeviceCode, :uint
    end

    DEVICE_FOUND_CALLBACK = FFI::Function.new(:void, [DeviceStruct.by_value]) do |device|
      puts "[RUBY] Device found"
      identifier, name, deviceClassification = device.values

      Device.find_or_initialize_by(identifier: identifier) do
        _1.assign_attributes(
          name: name,
          classification: deviceClassification
        )

        _1.save
      end
    end
  end
end
