import Foundation
import libhello

// sayHello params are inferred from C types as:
// params: char name[], callback (hello_callback)(char value[])

@_cdecl("say_hello")
func sayHello(_ name: UnsafePointer<CChar>, _ yield: hello_callback) { 
    let fromName = String(cString: name)
    let value = strdup("Swift!")

    print("[SWIFT] Hello, \(fromName)")
    yield(value)
}
