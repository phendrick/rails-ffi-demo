require "ffi"

module HelloWorld
  extend FFI::Library
  ffi_lib ["hello.dylib"]
  
  attach_function :say_hello, [], :void
end

HelloWorld.say_hello
