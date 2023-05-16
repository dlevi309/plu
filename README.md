## plu

A simple plist parser meant to present data in a more machine readable format.

Similar to `plutil(1)`'s -p switch.

Build with `make`

Running `plu /System/Library/LaunchDaemons/com.apple.uikit.eyedropperd.plist` will get you an output like this:
```
Dictionary[7]
   ThrottleInterval => 1
   POSIXSpawnType => "Interactive"
   MachServices => Dictionary[1]
      com.apple.uikit.eyedropperd.service => true
   ProgramArguments => Array[1]
      [0]: "/System/Library/PrivateFrameworks/Eyedropper.framework/Support/eyedropperd"
   UserName => "mobile"
   EnablePressuredExit => true
   Label => "com.apple.uikit.eyedropperd"
```

It currently supports printing all property types backed by Foundation

