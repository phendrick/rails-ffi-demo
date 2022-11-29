require "ffi"

module HelloWorld
  extend FFI::Library
  ffi_lib [File.join(".build", "debug", "libhello-swift.dylib")]

  callback :hello_callback, [:string], :void # FFI stores our callback as a pointer...
  attach_function :say_hello, [:string, :hello_callback], :void

  SAY_HELLO_CALLBACK = Proc.new do |value|
    puts "[RUBY] Hello, #{value}"
  end
end

HelloWorld.say_hello("Ruby", HelloWorld::SAY_HELLO_CALLBACK)
