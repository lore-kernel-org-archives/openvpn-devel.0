From: James Yonan <jim@...41...>
MIME-Version: 1.0
Message-Id: <200407280336.07129.jim@...41...>
Subject: [Openvpn-devel] OpenVPN 2.0-beta8 released
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
Date: Wed Jul 28 01:36:16 2004
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

This release has some cool new stuff, most notably TCP support in server mode.  
While all OSes which OpenVPN supports should be able to run as a multi-client 
TCP server, I've added an optimization for Linux 2.6 which takes advantage of 
the new linearly scalable sys_epoll API.  If you plan on running an OpenVPN 
TCP server with a larger number of concurrent clients (>50), you will see a 
noticeable performance benefit by using Linux 2.6.

Also included in this release is PKCS #12 support thanks to Mathias Sundman.  
PKCS #12 is a certificate/key file format which allows you to encapsulate the 
TLS certificate, key, and root certificate all in a single file.

There are a bunch of smaller changes as well on the Windows client -- routes 
are now added without requiring a call to route.exe and the --route-delay 
feature has become smarter, only waiting as long as necessary for the 
TAP-Win32 adapter to come up before adding routes.

2004.07.27 -- Version 2.0-beta8

* Added TCP support in server mode.
* Added PKCS #12 support (Mathias Sundman).
* Added patch to make revoke-crt and make-crl work
  seamlessly within the easy-rsa environment (Jan Kiszka).
* Modified --mode server ethernet bridge code to forward
  special IEEE 802.1d MAC Groups, i.e. 01:80:C2:XX:XX:XX.
* Added --dhcp-renew and --dhcp-release flags to Windows
  version.  Normally DHCP renewal and release on the TAP
  adapter occurs automatically under Windows, however
  if you set the TAP-Win32 adapter Media Status property
  to "Always Connected", you may need these flags.
* Added --show-net standalone flag to Windows version to
  show OpenVPN's view of the system adapter and routing
  tables.
* Added --show-net-up flag to Windows version to output
  the system routing table and network adapter list to
  the log file after the TAP-Win32 adapter has been brought
  up and any routes have been added.
* Modified Windows version to add routes using the IP Helper
  API rather than by calling route.exe.
* Fixed bug where --route-up script was not being called
  if no --route options were specified.
* Added --mute-replay-warnings to suppress packet replay
  warnings.  This is a common false alarm on WiFi nets.
* Added "def1" flag to --redirect-gateway option to override
  the default gateway by using 0.0.0.0/1 and 128.0.0.0/1
  rather than 0.0.0.0/0.  This has the benefit of overriding
  but not wiping out the original default gateway.
  (Thanks to Jim Carter for pointing out this idea).
* You can now run OpenVPN with a single config file argument.
  For example, you can now say "openvpn config.conf"
  rather than "openvpn --config config.conf".
* On Windows, made --route and --route-delay more adaptive
  with respect to waiting for interfaces referenced by the
  route destination to come up.  Routes added by --route
  should now be added as soon as the interface comes up,
  rather than after an obligatory 10 second delay.  The
  way this works internally is that --route-delay now
  defaults to 0 on Windows.  Previous versions would
  wait for --route-delay seconds then add the routes.
  This version will wait --route-delay seconds and then
  test the routing table at one second intervals for the
  next 30 seconds and will not add the routes until they
  can be added without errors.
* On Windows, don't setsockopt SO_SNDBUF or SO_RCVBUF by
  default on TCP/UDP socket in light of reports that this
  action can have undesirable global side effects on the
  MTU settings of other adapters.  These parameters can
  still be set, but you need to explicitly specify
  --sndbuf and/or --rcvbuf.
* Added --max-clients option to limit the maximum number
  of simultaneously connected clients in server mode.
* Added error message to illuminate shell escape gotcha when
  single backslashes are used in Windows path names.
* Added optional netmask parm to --ifconfig-pool.
* Fixed bug where http-proxy connect retry attempts were
  incorrectly going to the remote OpenVPN server,
  not to the HTTP proxy server.

James

