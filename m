From: "James Yonan" <jim@...41...>
Message-ID: <twig.1084169416.42219@...41...>
Subject: [Openvpn-devel] OpenVPN 1.6.0 Released
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Sun May  9 23:10:05 2004
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-users@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net, openvpn-announce@lists.sourceforge.net

Changes Since 1.5.0
-------------------

2004.05.09 -- Version 1.6.0
	
* Unchanged from 1.6-rc4 except for version number
  upgrade.

2004.04.01 -- Version 1.6-rc4

* Made minor customizations to devcon and
  renamed as tapinstall.exe for Windows version.
* Fixed "storage size of `iv' isn't known" build
  problem on FreeBSD.
* OpenSSL 0.9.7d bundled with Windows self-install.
	
2004.03.13 -- Version 1.6-rc3

* Minor Windows fixes for --ip-win32 dynamic, relating to
  the way the TAP-Win32 driver responds to a DHCP request
  from the Windows DHCP client.
* The net_gateway environmental variable wasn't being
  set correctly for called scripts (Paul Zuber).
* Added code to determine the default gateway on FreeBSD,
  allowing the --redirect-gateway option to work
  (Juan Rodriguez Hervella).
	
2004.03.04 -- Version 1.6-rc2

* Fixed bug in Windows version where the NetBIOS node-type
  DHCP option might have been passed even if it was not
  specified.
* Fixed bug in Windows version introduced in 1.6-rc1, where
  DHCP timeout would be set to 0 seconds if --ifconfig option
  was used and --ip-win32 option was not explicitly specified.
* Added some new --dhcp-option types for Windows version.

2004.03.02 -- Version 1.6-rc1

* For Windows, make "--ip-win32 dynamic" the default.
* For Windows, make "--route-delay 10" the default
  unless --ip-win32 dynamic is not used or --route-delay
  is explicitly specified.
* L_TLS mutex could have been left in a locked state
  for certain kinds of TLS errors.
	
2004.02.22 -- Version 1.6-beta7
	
* Allow scheduling priority increase (--nice) together
  with UID/GID downgrade (--user/--group).
* Code that causes SIGUSR1 restart on TLS errors in TCP
  mode was not activated in pthread builds.
* Save the certificate serial number in an environmental
  variable called tls_serial_{n} prior to calling the
  --tls-verify script.  n is the current cert chain level.
* Added NetBSD IPv6 tunnel capability (also requires
  a kernel patch) (Horst Laschinsky).
* Fixed bug in checking the return value of the nice()
  function (Ian Pilcher).
* Bug fix in new FreeBSD IPv6 over TUN code which was
  originally added in 1.6-beta5 (Nathanael Rensen).
* More Socks5 fixes -- extended the struct frame
  infrastructure to accomodate proxy-based encapsulation
  overhead.
* Added --dhcp-option to Windows version for setting
  adapter properties such as WINS & DNS servers.
* Use a default route-delay of 5 seconds when
  --ip-win32 dynamic is specified (only applicable when
  --route-delay is not explicitly specified).
* Added "log_append" registry variable to control
  whether the OpenVPN service wrapper on Windows
  opens log files in append (log_append="1") or
  truncate (log_append="0") mode.  The default
  is truncate.

2004.02.05 -- Version 1.6-beta6

* UDP over Socks5 fix to accomodate Socks5 encapsulation
  overhead (Christof Meerwald).
* Minor --ip-win32 dynamic tweaks (use long lease time,
  invalidate existing lease with DHCPNAK).

2004.02.01 -- Version 1.6-beta5

* Added Socks5 proxy support (Christof Meerwald).
* IPv6 tun support for FreeBSD (Thomas Glanzmann).
* Special TAP-Win32 debug mode for Windows self-install that was
  enabled in beta4 is now turned off.
* Added some new Solaris notes to INSTALL (Koen Maris).
* More work on --ip-win32 dynamic.

2004.01.27 -- Version 1.6-beta4

* For this beta, the Windows self-install is a debug version
  and will run slower -- use only for testing.
* Reverted the --ip-win32 default back to 'ipapi'
  from 'dynamic'.
* Added the offset parameter to '--ip-win32 dynamic' which
  can be used to control the address of the masqueraded
  DHCP server which replies to Windows DHCP requests.
* Added a wait/nowait option to --inetd (nowait can only
  be used with TCP sockets, TLS authentication, and over
  a bridged configuration -- see FAQ for more info)
  (Stefan `Sec` Zehl).
* Added a build-time capability where TAP-Win32 driver
  debug messages can be output by OpenVPN at --verb 6
  or higher.

2004.01.20 -- Version 1.6-beta2

* Added ./configure --enable-iproute2 flag which
  uses iproute2 instead of route + ifconfig --
  this is necessary for the LEAF Linux distro
  (Martin Hejl).
* Added renewal-time and rebind-time to set of
  DHCP options returned by the TAP-Win32 driver when
  "--ip-win32 dynamic" is used.
	
2004.01.14 -- Version 1.6-beta1

* Fixed --proxy bug that sometimes caused plaintext
  control info generated by the proxy prior to http
  CONNECT method establishment to be incorrectly
  parsed as OpenVPN data.
* For Windows version, implemented the
  "--ip-win32 dynamic" method and made it the default.
  This method sets the TAP-Win32 adapter IP address
  and netmask by replying to the kernel's DHCP queries.
  See the man page for more detailed info.
* Added --connect-retry parameter which controls
  the time interval (in seconds) between connect()
  retries when --proto tcp-client is used.  Previously,
  this value was hardcoded to 5 seconds, and still
  defaults as such.
* --resolv-retry can now be used with a parameter
  of "infinite" to retry indefinitely.
* Added SSL_CTX_use_certificate_chain_file() to ssl.c
  for support of multi-level certificate chains
  (Sten Kalenda).
* Fixed --tls-auth incompatibility with 1.4.x and earlier
  versions of OpenVPN when the passphrase file is an
  OpenVPN static key file (as generated by --genkey).
* Added shell-escape support in config files using
  the backslash character ("\") so that (for example)
  double quotes can be passed to the shell.
* Added "contrib" subdirectory on tarball, source zip,
  and CVS containing user-submitted contributions.
* Added an optional patch to the Redhat init script to
  allow the configuration file directory to be a
  multi-level directory hierarchy (Farkas Levente).
  See contrib/multilevel-init.patch
* Added some scripts and documentation on using
  Linux "fwmark" iptables rules to enable
  fine-grained routing control over the VPN
  (Sean Reifschneider, <jafo@...214...>).
  See contrib/openvpn-fwmarkroute-1.00





