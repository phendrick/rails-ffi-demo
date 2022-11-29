class Device < ApplicationRecord
  broadcasts
  after_destroy_commit -> { broadcast_remove_to(:devices) }
end
