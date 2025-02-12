# blockchain-node-monitoring
Provides an automated solution for monitoring and managing a blockchain node service

## Step 1: Create a dummy service

This dummy service will be somewhat similar to a real-world example. it will mimic a continously running process and behave like an actual **systemd** service, allowing us to test monitoring, restarting and Ansible automation just like a real blockchain node.


### Basic format of **systemd** service file

```
[Unut]
#.....code here......

[Service]
#.....code here.....

[Install]
#.....code here.....
```
	1. `[Unit]` Basic info and when to start
		-  describes what the service does(e.g. `Description=`)
		- decides when it should start (`After=network.target` makes sure the network starts first)
	2. `[Service]` How the service runs
		- tells systemd what command to run (`Exec=bin/sleep infinity`)
		- sets restart rules (`Restart=always` means restart if it stops)
	3. `[Install]` auto-start on boot
		- controls if the service should start automatically (`WantedBy=multi-user.target)`

### Code:
```
[Unit]
Description=Fake Blockchain Node Service
After=network.target

[Service]
ExecStart=/bin/sleep infinity
Restart=always

[Install]
WantedBy=multi-user.target
```

	1. `[Unit]`
		- `Description` provides a short summary of what the service does
		- `After=network.target` makes sure the service starts only after the network is up

	2. `[Service]`
		- `ExecStart=/bin/sleep infinity`the command that will run when the service starts. `/bin/sleep infinity` runs the process indefinitely without doing anything
		- `Restart=always` if the service crashes, systemd will automatically restart it
	3. `[Install]`
		- `WantedBy=multi-user.target` specifies when the service should start, `multi-user.target` is the default target for most servers, meaning the service will start at system boot.
		

### Deploy the systemd service(Testing):
```
sudo cp blockchain-node.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable blockchain-node
sudo systemctl start blockchain-node
```

then Check its status:
`sudo systemctl status blockchain-node`

You should see something like:
```
● blockchain-node.service - Fake Blockchain Node Service
     Loaded: loaded (/etc/systemd/system/blockchain-node.service; disabled; preset: enabled)
     Active: active (running) since Wed 2025-02-12 10:27:41 GMT; 35s ago
   Main PID: 8871 (sleep)
      Tasks: 1 (limit: 18985)
     Memory: 228.0K (peak: 584.0K)
        CPU: 1ms
     CGroup: /system.slice/blockchain-node.service
             └─8871 /bin/sleep infinity

Feb 12 10:27:41 <username> systemd[1]: Started blockchain-node.service - Fake Blockchain Node Service.

```
