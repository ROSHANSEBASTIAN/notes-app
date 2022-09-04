# notes_never_forget

A sample flutter app to learn CRUD operations via API.

The server is local host at http://127.0.0.1:3000/. But while running on emulator, the ip should be changed to 10.0.2.2:8000 instead of 127.0.0.1:3000. When running in real device, the 3000 port of local host should be connected to the real device's 3000.
For that use the command : adb reverse tcp:3000 tcp:3000

Once the server is closed, all the created notes will be removed.
