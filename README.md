## plu

A simple plist parser meant to present data in a more machine readable format.

Similar to `plutil(1)`'s -p switch.

Build with `make`

```sh
$ Usage: plu [-p] [path]
```

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

Running `plu -p` on the same file will get you an output like this:
```
{
    EnablePressuredExit = 1;
    Label = "com.apple.uikit.eyedropperd";
    MachServices =     {
        "com.apple.uikit.eyedropperd.service" = 1;
    };
    POSIXSpawnType = Interactive;
    ProgramArguments =     (
        "/System/Library/PrivateFrameworks/Eyedropper.framework/Support/eyedropperd"
    );
    ThrottleInterval = 1;
    UserName = mobile;
}
```

It currently supports printing all property types backed by Foundation

