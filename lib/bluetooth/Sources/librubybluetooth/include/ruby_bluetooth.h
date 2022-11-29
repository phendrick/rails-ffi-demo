typedef struct _BLUETOOTH_DEVICE {
    char* identifier;
    char* name;
    unsigned int classOfDeviceCode;
} BLUETOOTH_DEVICE;

typedef void (*device_found_callback)(BLUETOOTH_DEVICE);
