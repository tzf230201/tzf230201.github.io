# My Ultimate MiniPC Setup for Robotics Development

A MiniPC is a convenient computer for running robotics software. It is compact enough to mount on a robot while still providing a familiar Linux environment for development.

Although a MiniPC can run a desktop environment, I usually access it remotely through SSH, VS Code, or NoMachine. This reduces the need to carry a separate monitor, keyboard, and mouse.

During development, the MiniPC may spend most of its time on your desk. However, experiments and demonstrations often happen outside the lab. People are watching, time is limited, and troubleshooting becomes more stressful. A complicated connection setup makes the situation harder.

My recommendation is to prepare several ways to access your MiniPC and test them before you need them. For everyday work, boot into a terminal and use SSH or VS Code. Keep a desktop installed so you can start it through NoMachine when you need a graphical application, then stop it when you finish.

This guide uses a Windows laptop and an Ubuntu MiniPC whose network interfaces are managed by NetworkManager. On Ubuntu Server, check `nmcli device status` first. If Netplan uses a different renderer, configure that deliberately before following the NetworkManager commands; do not replace a working network configuration over your only SSH connection.

The Kria-specific desktop package below applies to the official Ubuntu 24.04 image for Kria K26 boards such as the KV260. Ordinary Intel/AMD MiniPCs use their distribution's normal desktop packages. The IP addresses in this guide are examples, not a record of your current configuration.

## 1. Prepare multiple connection options

After buying a MiniPC or reinstalling its operating system, configure these connections:

| Connection | Purpose |
|---|---|
| Direct Ethernet between laptop and MiniPC | A local fallback without requiring a router |
| Home or lab Wi-Fi | Convenient everyday development |
| Laptop or phone hotspot | A portable network outside the lab |
| Tailscale | Remote access when the devices are on different networks |

If the hotspot comes from your laptop, connect the MiniPC to that hotspot. If it comes from your phone, connect both the laptop and MiniPC to it.

Tailscale provides an additional access method over an existing network connection. It tries to connect devices directly and uses a relay when necessary; remote desktop traffic does not always pass through a central Tailscale server. [How Tailscale routes traffic](https://tailscale.com/docs/concepts/traffic-routing-through-tailscale)

The examples below use:

- Ubuntu username: `ubuntu`
- MiniPC hostname: `kria`
- Home/lab Wi-Fi: `RoboFI`
- Portable hotspot: `MSI_kublab`

Replace these names with your own. Wi-Fi names are case-sensitive.

## 2. Enable SSH and local hostname discovery

On the MiniPC, install the SSH server and Avahi:

```bash
sudo apt update
sudo apt install openssh-server avahi-daemon

sudo systemctl enable --now ssh
sudo systemctl enable --now avahi-daemon
```

OpenSSH provides terminal access, while Avahi supports local network discovery through mDNS. [Ubuntu OpenSSH documentation](https://ubuntu.com/server/docs/openssh-server/), [Avahi documentation](https://avahi.org/)

Check the hostname:

```bash
hostname
```

If necessary, set it:

```bash
sudo hostnamectl set-hostname kria
sudo systemctl restart avahi-daemon
```

From your laptop, try:

```powershell
ssh ubuntu@kria.local
```

This lets you connect by name even when a DHCP-assigned IP changes. It requires working mDNS support and a local network that allows the devices to communicate.

Use a unique hostname for each robot.

## 3. Save both Wi-Fi networks

First, identify the Wi-Fi interface:

```bash
nmcli device status
```

Its name might be `wlan0`, `wlp2s0`, or something such as `wlx6c1ff78a84b7`.

Enable Wi-Fi and scan:

```bash
sudo nmcli radio wifi on
nmcli device wifi list
```

Connect to each network once while it is available:

```bash
sudo nmcli --ask device wifi connect "RoboFI" name "RoboFI"
```

Then, with the hotspot turned on:

```bash
sudo nmcli --ask device wifi connect "MSI_kublab" name "MSI_kublab"
```

The `--ask` option prompts for the Wi-Fi password instead of putting it directly into the command. These commands create saved connection profiles. [NetworkManager command examples](https://networkmanager.pages.freedesktop.org/NetworkManager/NetworkManager/nmcli-examples.html)

If a profile already exists, activate it instead:

```bash
sudo nmcli --ask connection up "RoboFI"
```

Keep Ethernet connected or use a local terminal while configuring Wi-Fi, because changing networks can interrupt a remote session.

## 4. Enable automatic connection and set priorities

Give the home or lab network a higher priority:

```bash
sudo nmcli connection modify "RoboFI" \
    connection.autoconnect yes \
    connection.autoconnect-priority 200 \
    connection.autoconnect-retries 0
```

Give the hotspot a lower priority:

```bash
sudo nmcli connection modify "MSI_kublab" \
    connection.autoconnect yes \
    connection.autoconnect-priority 100 \
    connection.autoconnect-retries 0
```

These settings mean:

- Both saved networks are eligible for automatic connection.
- `RoboFI` is preferred when both profiles are available for selection.
- A retry value of `0` means automatic connection attempts are not limited to a fixed number.

NetworkManager scans for available networks; a separate scanning script is normally unnecessary. It can automatically join saved networks with valid credentials, rather than every Wi-Fi network it discovers.

**Priority does not force an immediate switch away from an already connected network.** If the MiniPC is connected to the hotspot and you want to switch to the lab network immediately, run:

```bash
sudo nmcli connection up "RoboFI"
```

These priority and retry behaviors are described in the [NetworkManager profile documentation](https://networkmanager.pages.freedesktop.org/NetworkManager/NetworkManager/nm-settings-nmcli.html).

## 5. Configure a direct Ethernet fallback

For a dedicated cable connection, put the laptop and MiniPC on the same unused subnet.

For example:

| Setting | Laptop Ethernet | MiniPC Ethernet |
|---|---|---|
| IPv4 address | `192.168.50.1` | `192.168.50.8` |
| Subnet mask | `255.255.255.0` | `255.255.255.0` |
| Gateway | Leave blank | Leave blank |
| DNS | Leave blank | Leave blank |

Choose another subnet if your existing network already uses `192.168.50.x`.

On Windows, press **Win + R**, enter:

```text
ncpa.cpl
```

Open **Ethernet → Properties → Internet Protocol Version 4 (TCP/IPv4)** and enter the laptop settings above.

On Ubuntu, identify the Ethernet interface:

```bash
nmcli device status
```

Assuming it is `eth0`, create a dedicated profile:

```bash
sudo nmcli connection add \
    type ethernet \
    ifname eth0 \
    con-name "Laptop-LAN" \
    ipv4.method manual \
    ipv4.addresses 192.168.50.8/24 \
    ipv4.never-default yes \
    connection.autoconnect yes \
    connection.autoconnect-priority 100
```

Activate it:

```bash
sudo nmcli connection up "Laptop-LAN"
```

If another Ethernet profile already exists, check its autoconnect priority so the intended profile is selected.

From Windows, connect with:

```powershell
ssh ubuntu@192.168.50.8
```

This connection provides local access. Internet access can still come from the MiniPC’s Wi-Fi.

## 6. Share the laptop’s internet over Ethernet when needed

Windows Internet Connection Sharing, or ICS, can forward the laptop’s internet connection to the MiniPC.

On Windows:

1. Connect the laptop to the internet.
2. Connect the Ethernet cable to the MiniPC.
3. Open `ncpa.cpl`.
4. Right-click the adapter that provides internet, usually **Wi-Fi**, and select **Properties**.
5. Open **Sharing**.
6. Enable **Allow other network users to connect through this computer’s Internet connection**.
7. Select the Ethernet adapter connected to the MiniPC.

The laptop must remain powered on to provide internet. [MSI’s Ethernet sharing guide](https://www.msi.com/faq/faq-1656)

ICS commonly sets the laptop’s Ethernet address to `192.168.137.1`, but **check the actual address**:

```powershell
Get-NetIPAddress -InterfaceAlias "Ethernet" -AddressFamily IPv4
```

Do not assume it will always be the same on every computer or configuration.

For ICS, create a separate DHCP profile on the MiniPC:

```bash
sudo nmcli connection add \
    type ethernet \
    ifname eth0 \
    con-name "Laptop-ICS" \
    ipv4.method auto \
    connection.autoconnect no
```

Activate it when using Ethernet sharing:

```bash
sudo nmcli connection up "Laptop-ICS"
```

Inspect the assigned address, gateway, and DNS:

```bash
nmcli device show eth0
```

To return to the dedicated static LAN setup, disable Ethernet sharing on Windows, restore the laptop’s `192.168.50.1` address, and activate:

```bash
sudo nmcli connection up "Laptop-LAN"
```

Avoid using the same subnet for separate Ethernet and hotspot interfaces simultaneously. Overlapping subnets can make routing confusing.

## 7. Configure Tailscale

Install Tailscale on both devices and sign them into the same tailnet.

Follow the official [Linux installation instructions](https://tailscale.com/docs/install/linux) for the MiniPC and install the Windows application on the laptop.

On Ubuntu, authenticate with:

```bash
sudo tailscale up
```

Then check:

```bash
tailscale status
tailscale ip -4
```

With MagicDNS enabled, you can use the MiniPC’s Tailscale device name instead of remembering its Tailscale IP. Use the exact name shown in your Tailscale device list. [MagicDNS documentation](https://tailscale.com/docs/features/magicdns)

For example:

```powershell
ssh ubuntu@kria
```

Here, ordinary SSH runs over the Tailscale network. Enabling the separate **Tailscale SSH** feature is optional.

## 8. Create SSH shortcuts

On Windows, edit:

```text
%USERPROFILE%\.ssh\config
```

Create the file if it does not exist, without a `.txt` extension. Back it up before editing, reuse existing aliases, and place specific entries before any general `Host *` block that sets the same options.

Add:

```sshconfig
Host kria_local
    HostName kria.local

Host kria_lan
    HostName 192.168.50.8

Host kria_tailscale
    HostName kria

Host kria_local kria_lan kria_tailscale
    User ubuntu
    ServerAliveInterval 30
    ServerAliveCountMax 3
```

Replace the Tailscale hostname if your device has a different name.

Now you can use:

```powershell
ssh kria_local
ssh kria_lan
ssh kria_tailscale
```

These aliases also work with VS Code Remote-SSH.

`kria_local` follows local hostname discovery; it does not explicitly select Ethernet or Wi-Fi. `kria_lan` targets the dedicated Ethernet address.

If you have already configured SSH key authentication, add the appropriate `IdentityFile` to the shared block.

Optionally, add a common host-key label to the shared block. If you already have a verified Kria key under another label, reuse that label and its known-hosts file instead of inventing a new trusted identity:

```sshconfig
    HostKeyAlias kria-device
```

This makes the aliases check the same stored SSH server identity. It does not change the destination address or select a network interface. Verify the server fingerprint when first trusting the device. [OpenSSH configuration documentation](https://man.openbsd.org/ssh_config)

For a shortcut dedicated to a particular Wi-Fi network, use a DHCP reservation in that router and put the reserved address in another `Host` entry. A shortcut containing an old DHCP address will not automatically discover the replacement.

## 9. Boot into server mode and start the desktop when needed

Here, **server mode** means booting Ubuntu into `multi-user.target`, without starting the local graphical login manager. It does not uninstall desktop packages or turn Ubuntu into a different operating system.

The setup uses two controls: Ubuntu boots without a local desktop, and NoMachine stays stopped until you start it over SSH. This gives you an explicit desktop on/off workflow.

| State | SSH and robot services | Local desktop | NoMachine desktop |
|---|---|---|---|
| After boot | Available if enabled | Not started | Not started |
| During remote GUI work | Available | Not required | Running |
| After ending GUI work and shutting down NoMachine | Available | Not started | Stopped |

### Install a desktop and NoMachine once

Keep the desktop packages installed. On the official Kria K26 Ubuntu Server 24.04 image, AMD provides:

```bash
sudo apt update
sudo apt install ubuntu-desktop-kria
```

Follow the image's AMD/Canonical repository setup instructions first. If the package is unavailable, check those instructions rather than adding unrelated repositories. AMD's desktop setup assumes a monitor is attached at power-up during initial enablement. Once configured, test NoMachine separately without a monitor. [AMD Kria Ubuntu 24.04 boot guide](https://xilinx.github.io/kria-apps-docs/kv260/2022.1/linux_boot/ubuntu_24_04/build/html/docs/boot.html)

If a desktop is already installed, keep it. On an ordinary Ubuntu MiniPC, use its supported desktop package instead of `ubuntu-desktop-kria`.

Install the official NoMachine package for your Ubuntu release and architecture:

```bash
dpkg --print-architecture
sudo apt install ./your-nomachine-package.deb
```

Replace the filename with the downloaded file. Kria KV260 uses `arm64`; most Intel/AMD MiniPCs use `amd64`. Install the NoMachine client on Windows as well.

NoMachine can provide its own display on a headless Linux host, but a desktop environment must already be installed. Its display is not the same feature as separate per-user virtual desktops offered by Terminal Server products. [NoMachine headless Linux guide](https://kb.nomachine.com/AR03P00973)

### Configure terminal boot and manual NoMachine startup

First confirm that SSH works and will start at boot. Run these commands from SSH or a local terminal, because shutting down NoMachine ends its sessions:

```bash
sudo systemctl enable --now ssh
sudo systemctl set-default multi-user.target
sudo /etc/NX/nxserver --shutdown --start-mode manual
```

Then save your work and reboot at a suitable time:

```bash
sudo reboot
```

The reboot disconnects SSH. Reconnect afterward and check:

```bash
systemctl get-default
systemctl is-active display-manager
sudo /etc/NX/nxserver --status
```

The expected state is `multi-user.target`, an inactive local display manager, and stopped NoMachine services. An `inactive` result gives `systemctl is-active` a nonzero exit status; that is expected here. A missing display-manager unit also means there is no local display manager to start.

If the local display manager is still active, inspect what started it before changing other services. Setting the default target changes the next boot; it does not stop an existing graphical session immediately. [systemd target documentation](https://www.freedesktop.org/software/systemd/man/latest/systemd.special.html)

### Start a desktop when needed

From Windows, open SSH:

```powershell
ssh kria_local
```

On the MiniPC, start NoMachine while keeping its boot mode manual:

```bash
sudo /etc/NX/nxserver --startup --start-mode manual
```

Now open your saved NoMachine connection on Windows. When asked to create a display because none is running, approve it. Depending on the edition and existing configuration, NoMachine may create the display as soon as its server starts, or after you connect. Both happen within this explicitly started GUI period.

Use `--start-mode manual` every time. A plain `--startup` can restore automatic service startup at the next boot. Use `/etc/NX/nxserver --help` to confirm the syntax on your installed version. [NoMachine service management](https://kb.nomachine.com/DT07X00328)

You do not need to start `graphical.target` or a physical display manager for this NoMachine workflow. Test the installed desktop session on your hardware before relying on it for a demo.

### Stop the desktop when finished

Save your work and select **Log Out** inside the remote desktop. Then, from a separate SSH terminal, run:

```bash
sudo /etc/NX/nxserver --shutdown --start-mode manual
```

This ends all NoMachine sessions and stops its services while leaving OpenSSH available. GUI applications in those sessions will close. Keep robot processes that must continue running in their own systemd services or suitable terminal sessions, rather than depending on a desktop terminal.

Closing the NoMachine window only disconnects the client; it does not guarantee that the desktop ends. Shutting down NoMachine explicitly also prevents its display service from keeping or recreating a desktop in the background. This workflow requires SSH to turn remote desktop access back on.

Check the result:

```bash
sudo /etc/NX/nxserver --status
systemctl is-active display-manager
ps -eo pid,user,comm | grep -E 'gnome-shell|gnome-session|xfce4-session|mate-session|Xorg|Xwayland|nxagent'
```

No desktop-session or display-server processes should remain for the stopped session. No matching process output is expected; a few unrelated user or system services may still exist. Investigate leftovers by session instead of killing every process owned by your Ubuntu user.

### Optional Windows commands for desktop on and off

After configuring `kria_local`, run these from PowerShell:

```powershell
# Turn remote desktop access on, then connect with NoMachine.
ssh -t kria_local 'sudo /etc/NX/nxserver --startup --start-mode manual'

# After saving and logging out, turn remote desktop access off.
ssh -t kria_local 'sudo /etc/NX/nxserver --shutdown --start-mode manual'
```

These commands prompt for sudo as required. Substitute `kria_lan` or `kria_tailscale` if that is the available SSH path.

### Return to automatic local desktop boot

If you later want a normal desktop on the attached monitor, restore graphical boot and reboot:

```bash
sudo systemctl set-default graphical.target
sudo reboot
```

This does not change NoMachine's manual startup policy. To restore its automatic startup too, use:

```bash
sudo /etc/NX/nxserver --startmode automatic
sudo /etc/NX/nxserver --startup
```

Automatic NoMachine startup is a different policy: on a headless system its configuration may create a desktop without an active client. Keep manual startup if you want explicit control over when the GUI can run.

## 10. Create matching NoMachine connections

Start NoMachine over SSH using Section 9 before connecting. Create separate saved connections in the Windows NoMachine client:

| Connection name | Host |
|---|---|
| `Kria - Local` | `kria.local` |
| `Kria - LAN` | `192.168.50.8` |
| `Kria - Tailscale` | The Kria’s Tailscale name or IP |

Use **NX** protocol and **port 4000**, unless you changed the server configuration.

Enter only the hostname or IP in **Host**:

```text
kria.local
```

Enter the username `ubuntu` and its password on the authentication screen. Do not put `ubuntu@kria.local` in the Host field.

NoMachine connections are configured separately from SSH aliases.

## 11. Test the setup before taking the robot outside

Test each connection independently while keeping a recovery path available. Change only the robot or your own test access point; do not turn off a shared lab network:

- Disconnect Ethernet and confirm Wi-Fi access works.
- Make the preferred Wi-Fi unavailable to the robot in a controlled test and confirm hotspot autoconnect works. Use a local console or Ethernet while doing this.
- Turn off Wi-Fi and confirm direct Ethernet access works.
- Put the laptop and MiniPC on different internet connections and test Tailscale.
- Reboot the MiniPC and check that SSH, required robot services, and a saved Wi-Fi connection start automatically.
- Before starting NoMachine, confirm the local display manager and NoMachine services are stopped.
- Start NoMachine over SSH and test an actual GUI application without a monitor.
- Log out, shut down NoMachine in manual mode, and confirm the desktop processes end while SSH and robot services remain available.
- Reboot again and confirm that NoMachine and the desktop stay off until explicitly requested.

Useful Ubuntu commands are:

```bash
nmcli device status
nmcli connection show --active
ip -4 address
ip route
```

If Wi-Fi is visible but cannot connect, inspect the logs:

```bash
journalctl -b -u NetworkManager --no-pager -n 80
journalctl -b -u wpa_supplicant --no-pager -n 80
```

A `WRONG_KEY` message points to an authentication problem. Fix the saved password before changing drivers or IP settings.

## 12. Ask an AI to configure the setup

Use the following prompt with an AI that has access to your Windows terminal and can SSH into the MiniPC. Edit the configuration values first. Account login, Windows administrator approval, and sudo authentication may still require your interaction. The prompt authorizes setup when you give it to that AI; it is not a command to execute while reading this tutorial.

```text
Configure my Windows laptop and Ubuntu MiniPC for reliable robotics development, with redundant remote-access paths and a desktop that runs only when explicitly needed.

Perform the setup, verify it, and document the results. Do not stop at a plan.

CONFIGURATION

- Laptop OS: Windows
- MiniPC OS: Ubuntu; detect its actual release and architecture
- MiniPC username: ubuntu
- MiniPC hostname: kria
- Existing SSH connection: kria-kv260
- Preferred home/lab Wi-Fi SSID: RoboFI
- Backup hotspot SSID: MSI_kublab
- Hotspot provider: this Windows laptop
- Remote terminal: OpenSSH and VS Code Remote-SSH
- Remote desktop: NoMachine
- Remote network access: Tailscale
- Default boot: multi-user.target, without a local desktop
- Default NoMachine state: stopped, with manual startup
- Desktop lifecycle: start NoMachine over SSH when needed; log out and shut it down afterward

Discover current addresses, interfaces, profiles, SSH keys, installed applications, and service configuration. Do not assume the example IPs or interface names are correct.

AUTHORIZATION AND CREDENTIALS

I authorize routine, reversible changes needed for this setup. Preserve unrelated settings and keep a working management connection.

You may copy saved Wi-Fi credentials from this laptop to the specified MiniPC only for the two named SSIDs. Do not display passwords in chat or logs. Store them in protected operating-system connection profiles and remove temporary transfer files afterward.

Do not save sudo passwords, private keys, or account tokens in scripts or documentation. Do not grant unrestricted passwordless sudo.

If authentication, account login, administrator approval, or a reboot requires my interaction, prepare the operation and explain what I need to do. Never treat silence as approval.

WORKFLOW

1. Inspect and back up

Inspect adapters, IPs, routes, DNS, saved profiles, NetworkManager ownership, SSH trust, and SSH/Avahi/Tailscale/NoMachine services. Back up configurations before changing them.

Reuse profiles and aliases so the setup is idempotent. If Netplan uses another renderer, plan a safe migration rather than replacing networking over the only SSH connection. Prepare rollback for changes that may interrupt access.

2. Configure local access

Enable OpenSSH and local mDNS discovery with a unique hostname. Test actual SSH through kria.local from Windows. Do not equate name resolution with successful service access.

3. Configure Wi-Fi

Save credentials for both specified networks for unattended use. Set autoconnect yes, preferred Wi-Fi priority 200, hotspot priority 100, and retries 0 (unlimited).

Preserve intentional static addresses. Use DHCP for new profiles unless a stable address is explicitly required. Do not add a scanning daemon unnecessarily. Explain that priority does not force a switch away from an already active profile.

If authentication fails, inspect NetworkManager and wpa_supplicant logs before changing drivers or addresses. Configure the laptop hotspot using its existing working mechanism when available.

4. Configure direct Ethernet

Provide a cable connection that works without a router or internet. Use an unused private subnet that does not overlap with Wi-Fi, the hotspot, or other active links. Prefer preserving a working setup; migrate only with a recovery path.

For the dedicated local profile, use compatible static addresses with no default gateway or DNS. Record the final addresses and test SSH.

5. Prepare optional Ethernet internet sharing

Prepare Windows ICS from the internet source to the Ethernet adapter. Verify its actual address instead of assuming 192.168.137.1. Use a separate Ubuntu DHCP Ethernet profile if necessary.

Keep the laptop's upstream Wi-Fi on DHCP. Do not run independent Ethernet and hotspot links on overlapping subnets. Document switching between sharing modes if simultaneous use is unsuitable; do not repeatedly reset networking to force it.

6. Configure Tailscale

Reuse the existing installation and tailnet when available. Ensure its background service starts at boot. Request login interaction when necessary. Verify MagicDNS, the actual device name/IP, and ordinary SSH over Tailscale. Tailscale SSH is optional.

7. Configure desktop on demand

Keep a supported desktop environment installed. On the official Kria K26 Ubuntu Server 24.04 image, follow AMD/Canonical setup guidance and use ubuntu-desktop-kria. On other platforms use their supported package. Install the correct official NoMachine package if missing.

Establish SSH recovery before changing graphical startup. Confirm the installed NoMachine command syntax with nxserver --help.

Configure terminal boot with:
    sudo systemctl set-default multi-user.target

Configure NoMachine to stay stopped and not start at boot:
    sudo /etc/NX/nxserver --shutdown --start-mode manual

Coordinate a reboot rather than doing it unexpectedly. After reboot, verify multi-user.target, working SSH and robot services, an inactive local display manager, and stopped NoMachine services.

Use this command when a desktop is explicitly requested:
    sudo /etc/NX/nxserver --startup --start-mode manual

Connect with the NoMachine client and create its display if prompted. Do not enable automatic graphical login, start graphical.target, or use automatic NoMachine startup for this workflow.

When finished, save work, log out of the desktop, and run from SSH:
    sudo /etc/NX/nxserver --shutdown --start-mode manual

Explain that closing the client can leave the desktop running. Shutdown ends all NoMachine sessions, so keep persistent robot processes independent of GUI terminals. Verify desktop processes end, NoMachine stays stopped, and SSH/robot services remain available. Do not kill all processes belonging to the Ubuntu user.

Do not claim the desktop starts only on client connection: depending on configuration it may start with the NoMachine server. Explicit server start/shutdown controls the allowed GUI period.

If headless graphics do not work, diagnose the installed desktop session, display server, and NoMachine logs. Do not assume this platform's headless GUI is verified merely because the port is open.

8. Create shortcuts

Create or reuse SSH aliases kria_local, kria_lan, and kria_tailscale. Add Wi-Fi/hotspot-specific aliases only with stable addresses or a verified discovery mechanism.

Reuse the working SSH key and trusted host identity. Use HostKeyAlias where appropriate. Do not disable host-key checking or blindly trust a changed key. Test each alias and make it available to VS Code Remote-SSH.

Document PowerShell commands that start and stop NoMachine over SSH using --start-mode manual.

Create clearly named Windows NoMachine connections for local, Ethernet, and Tailscale access. Use NX port 4000 unless configured otherwise. The Host field contains only a name or IP, not username@hostname. Explain that the client cannot connect until the server is started over SSH.

9. Verify and report

Test SSH through available paths, actual NoMachine login/GUI when possible, internet through the intended interface, and Wi-Fi autoconnect with a controlled radio cycle while preserving a recovery path. Do not use explicit manual disconnect as the sole autoconnect test.

Test the desktop off/on/off lifecycle and cold-boot behavior. Do not mistake installed desktop packages or idle background helpers for a running desktop session.

Separate completed tests from tests pending a reboot, a monitor-free run, another internet connection, or user interaction.

Do not disable the firewall, perform a blanket network reset, delete unrelated profiles, reinstall working drivers, or modify unrelated robot startup services without evidence and approval.

DELIVERABLES

- A concise summary of changes.
- A table of connection names, actual destinations, interfaces, address stability, and internet requirements.
- Working SSH commands and NoMachine settings.
- Desktop start/stop commands, verification, and rollback to graphical boot.
- Remaining limitations or required interaction.
- SETUP.md with final configuration, use, troubleshooting, and rollback.

Keep results separate from assumptions. Do not report an untested connection or desktop lifecycle as working.
```
