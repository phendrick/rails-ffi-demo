class PerformBluetoothLookupJob
  include Sidekiq::Job
  include Bluetooth::Lookup

  def perform(*args)
    Rails.logger.info("\n\nPERFORMING....")
    Device.destroy_all

    Bluetooth::Lookup.start_scan(
      Bluetooth::Lookup::DEVICE_FOUND_CALLBACK
    )

    Rails.logger.info("\n\nDONE\n\n")
  end
end
