## Setup
* `podman-compose up` or `docker-compose -f podman-compose.yml up` should get you a Redis service
* `bundle`
* `rails db:create`
* In `lib/bluethooth`:
  * Run `swift build` - this should give you a `.build/debug/libbluetooth-lookup.dylib` library
* In the project root, run `bin/dev`, go to [http://localhost:3000](http://localhost:3000) 
* Run `rails runner scan.rb` to scan for devices and watch them appear in your browser 🤞

### Compiling the `hello_*` examples

#### hello and hello_again
```
cd lib/hello # or hello_again
gcc -dynamiclib hello.c -o hello.dylib
ruby hello.rb
```

#### hello_swift
```
cd lib/hello_swift
swift build
ruby hello.rb
```