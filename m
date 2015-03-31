From: samuli@...515...
Date: Tue, 31 Mar 2015 09:44:54 +0300
Message-Id: <1427784294-22175-1-git-send-email-samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Remove useless dash escapes from the
	man-page
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

From: Samuli Sepp=C3=A4nen <samuli@...515...>

This patch is against the release/2.3 branch

Trac: 512
Signed-off-by: Samuli Sepp=C3=A4nen <samuli@...515...>
---
 doc/openvpn.8 | 1800 ++++++++++++++++++++++++++++-------------------------=
----
 1 file changed, 900 insertions(+), 900 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index a95d353..bcd2d76 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -37,7 +37,7 @@
 .TH openvpn 8 "17 November 2008"
 .\"*********************************************************
 .SH NAME
-openvpn \- secure IP tunnel daemon.
+openvpn - secure IP tunnel daemon.
 .\"*********************************************************
 .SH SYNOPSIS
 .ft 3
@@ -97,25 +97,25 @@ with a relatively lightweight footprint.
 .SH OPTIONS
 OpenVPN allows any option to be placed either on the command line
 or in a configuration file.  Though all command line options are preceded
-by a double-leading-dash ("\-\-"), this prefix can be removed when
+by a double-leading-dash ("--"), this prefix can be removed when
 an option is placed in a configuration file.
 .\"*********************************************************
 .TP
-.B \-\-help
+.B --help
 Show options.
 .\"*********************************************************
 .TP
-.B \-\-config file
+.B --config file
 Load additional config options from
 .B file
 where each line corresponds to one command line option,
-but with the leading '\-\-' removed.
+but with the leading '--' removed.
=20
 If
-.B \-\-config file
+.B --config file
 is the only option to the openvpn command,
 the
-.B \-\-config
+.B --config
 can be removed, and the command can be given as
 .B openvpn file
=20
@@ -187,25 +187,25 @@ secret static.key
 .\"*********************************************************
 .SS Tunnel Options:
 .TP
-.B \-\-mode m
+.B --mode m
 Set OpenVPN major mode.  By default, OpenVPN runs in
 point-to-point mode ("p2p").  OpenVPN 2.0 introduces
 a new mode ("server") which implements a multi-client
 server capability.
 .\"*********************************************************
 .TP
-.B \-\-local host
+.B --local host
 Local host name or IP address for bind.
 If specified, OpenVPN will bind to this address only.
 If unspecified, OpenVPN will bind to all interfaces.
 .\"*********************************************************
 .TP
-.B \-\-remote host [port] [proto]
+.B --remote host [port] [proto]
 Remote host name or IP address.  On the client, multiple
-.B \-\-remote
+.B --remote
 options may be specified for redundancy, each referring
 to a different OpenVPN server.  Specifying multiple
-.B \-\-remote
+.B --remote
 options for this purpose is a special case of the more
 general connection-profile feature.  See the
 .B <connection>
@@ -214,7 +214,7 @@ documentation below.
 The OpenVPN client will try to connect to a server at
 .B host:port
 in the order specified by the list of
-.B \-\-remote
+.B --remote
 options.
=20
 .B proto
@@ -229,18 +229,18 @@ one server.
=20
 Note that since UDP is connectionless, connection failure
 is defined by the
-.B \-\-ping
+.B --ping
 and
-.B \-\-ping-restart
+.B --ping-restart
 options.
=20
 Note the following corner case:  If you use multiple
-.B \-\-remote
+.B --remote
 options, AND you are dropping root privileges on
 the client with
-.B \-\-user
+.B --user
 and/or
-.B \-\-group,
+.B --group,
 AND the client is running a non-Windows OS, if the client needs
 to switch to a different server, and that server pushes
 back different TUN/TAP or route settings, the client may lack
@@ -248,7 +248,7 @@ the necessary privileges to close and reopen the TUN/TA=
P interface.
 This could cause the client to exit with a fatal error.
=20
 If
-.B \-\-remote
+.B --remote
 is unspecified, OpenVPN will listen
 for packets from any IP address, but will not act on those packets unless
 they pass all authentication tests.  This requirement for authentication
@@ -257,7 +257,7 @@ trusted IP addresses (it is very easy to forge a source=
 IP address on
 a UDP packet).
=20
 When used in TCP mode,=20
-.B \-\-remote
+.B --remote
 will act as a filter, rejecting connections from any host which does
 not match
 .B host.
@@ -270,7 +270,7 @@ chosen, providing a sort of basic load-balancing and
 failover capability.
 .\"*********************************************************
 .TP
-.B \-\-remote-random-hostname
+.B --remote-random-hostname
 Prepend a random string (6 bytes, 12 hex characters) to hostname to prevent
 DNS caching.  For example, "foo.bar.gov" would be modified to
 "<random-chars>.foo.bar.gov".
@@ -289,7 +289,7 @@ and
 An OpenVPN client will try each connection profile sequentially
 until it achieves a successful connection.=20=20
=20
-.B \-\-remote-random
+.B --remote-random
 can be used to initially "scramble" the connection
 list.
=20
@@ -393,22 +393,22 @@ were declared in all
 blocks below it.
 .\"*********************************************************
 .TP
-.B \-\-proto-force p
+.B --proto-force p
 When iterating through connection profiles,
 only consider profiles using protocol
 .B p
 ('tcp'|'udp').=20
 .\"*********************************************************
 .TP
-.B \-\-remote-random
+.B --remote-random
 When multiple
-.B \-\-remote
+.B --remote
 address/ports are specified, or if connection profiles are being
 used, initially randomize the order of the list
 as a kind of basic load-balancing measure.
 .\"*********************************************************
 .TP
-.B \-\-proto p
+.B --proto p
 Use protocol
 .B p
 for communicating with remote host.
@@ -422,17 +422,17 @@ or
 The default protocol is
 .B udp
 when
-.B \-\-proto
+.B --proto
 is not specified.
=20
 For UDP operation,
-.B \-\-proto udp
+.B --proto udp
 should be specified on both peers.
=20
 For TCP operation, one peer must use
-.B \-\-proto tcp-server
+.B --proto tcp-server
 and the other must use
-.B \-\-proto tcp-client.
+.B --proto tcp-client.
 A peer started with
 .B tcp-server
 will wait indefinitely for an incoming connection.  A peer
@@ -440,9 +440,9 @@ started with
 .B tcp-client
 will attempt to connect, and if that fails, will sleep for 5
 seconds (adjustable via the
-.B \-\-connect-retry
+.B --connect-retry
 option) and try again infinite or up to N retries (adjustable via the
-.B \-\-connect-retry-max
+.B --connect-retry-max
 option).  Both TCP client and server will simulate
 a SIGUSR1 restart signal if either side resets the connection.
=20
@@ -462,9 +462,9 @@ application-level UDP protocols, or tunneling protocols=
 which don't
 possess a built-in reliability layer.
 .\"*********************************************************
 .TP
-.B \-\-connect-retry n
+.B --connect-retry n
 For
-.B \-\-proto tcp-client,
+.B --proto tcp-client,
 take
 .B n
 as the
@@ -472,29 +472,29 @@ number of seconds to wait
 between connection retries (default=3D5).
 .\"*********************************************************
 .TP
-.B \-\-connect-timeout n
+.B --connect-timeout n
 For
-.B \-\-proto tcp-client,
+.B --proto tcp-client,
 set connection timeout to
 .B n
 seconds (default=3D10).
 .\"*********************************************************
 .TP
-.B \-\-connect-retry-max n
+.B --connect-retry-max n
 For
-.B \-\-proto tcp-client,
+.B --proto tcp-client,
 take
 .B n
 as the
 number of retries of connection attempt (default=3Dinfinite).
 .\"*********************************************************
 .TP
-.B \-\-show-proxy-settings
+.B --show-proxy-settings
 Show sensed HTTP or SOCKS proxy settings. Currently, only Windows clients
 support this option.
 .\"*********************************************************
 .TP
-.B \-\-http-proxy server port [authfile|'auto'|'auto-nct'] [auth-method]
+.B --http-proxy server port [authfile|'auto'|'auto-nct'] [auth-method]
 Connect to remote host through an HTTP proxy at address
 .B server
 and port
@@ -529,32 +529,32 @@ determine the authentication method, but to reject we=
ak
 authentication protocols such as HTTP Basic Authentication.
 .\"*********************************************************
 .TP
-.B \-\-http-proxy-retry
+.B --http-proxy-retry
 Retry indefinitely on HTTP proxy errors.  If an HTTP proxy error
 occurs, simulate a SIGUSR1 reset.
 .\"*********************************************************
 .TP
-.B \-\-http-proxy-timeout n
+.B --http-proxy-timeout n
 Set proxy timeout to
 .B n
 seconds, default=3D5.
 .\"*********************************************************
 .TP
-.B \-\-http-proxy-option type [parm]
+.B --http-proxy-option type [parm]
 Set extended HTTP proxy options.
 Repeat to set multiple options.
=20
-.B VERSION version \-\-
+.B VERSION version --
 Set HTTP version number to
 .B version
 (default=3D1.0).
=20
-.B AGENT user-agent \-\-
+.B AGENT user-agent --
 Set HTTP "User-Agent" string to
 .B user-agent.
 .\"*********************************************************
 .TP
-.B \-\-socks-proxy server [port] [authfile]
+.B --socks-proxy server [port] [authfile]
 Connect to remote host through a Socks5 proxy at address
 .B server
 and port
@@ -565,14 +565,14 @@ and port
 "stdin" to prompt from console.
 .\"*********************************************************
 .TP
-.B \-\-socks-proxy-retry
+.B --socks-proxy-retry
 Retry indefinitely on Socks proxy errors.  If a Socks proxy error
 occurs, simulate a SIGUSR1 reset.
 .\"*********************************************************
 .TP
-.B \-\-resolv-retry n
+.B --resolv-retry n
 If hostname resolve fails for
-.B \-\-remote,
+.B --remote,
 retry resolve for
 .B n
 seconds before failing.
@@ -582,18 +582,18 @@ Set
 to "infinite" to retry indefinitely.
=20
 By default,
-.B \-\-resolv-retry infinite
+.B --resolv-retry infinite
 is enabled.  You can disable by setting n=3D0.
 .\"*********************************************************
 .TP
-.B \-\-float
+.B --float
 Allow remote peer to change its IP address and/or port number, such as due=
 to
 DHCP (this is the default if
-.B \-\-remote
+.B --remote
 is not used).
-.B \-\-float
+.B --float
 when specified with
-.B \-\-remote
+.B --remote
 allows an OpenVPN session to initially connect to a peer
 at a known address, however if packets arrive from a new
 address and pass all authentication tests, the new address
@@ -602,14 +602,14 @@ you are connecting to a peer which holds a dynamic ad=
dress
 such as a dial-in user or DHCP client.
=20
 Essentially,
-.B \-\-float
+.B --float
 tells OpenVPN to accept authenticated packets
 from any address, not only the address which was specified in the
-.B \-\-remote
+.B --remote
 option.
 .\"*********************************************************
 .TP
-.B \-\-ipchange cmd
+.B --ipchange cmd
 Run command
 .B cmd
 when our remote ip-address is initially authenticated or
@@ -629,11 +629,11 @@ is executed two arguments are appended after any argu=
ments specified in
 .B cmd ip_address port_number
=20
 Don't use
-.B \-\-ipchange
+.B --ipchange
 in
-.B \-\-mode server
+.B --mode server
 mode.  Use a
-.B \-\-client-connect
+.B --client-connect
 script instead.
=20
 See the "Environmental Variables" section below for
@@ -660,41 +660,41 @@ reestablish a connection with its most recently authe=
nticated
 peer on its new IP address.
 .\"*********************************************************
 .TP
-.B \-\-port port
+.B --port port
 TCP/UDP port number for both local and remote.  The current
 default of 1194 represents the official IANA port number
 assignment for OpenVPN and has been used since version 2.0-beta17.
 Previous versions used port 5000 as the default.
 .\"*********************************************************
 .TP
-.B \-\-lport port
+.B --lport port
 TCP/UDP port number for bind.
 .\"*********************************************************
 .TP
-.B \-\-rport port
+.B --rport port
 TCP/UDP port number for remote.
 .\"*********************************************************
 .TP
-.B \-\-bind
+.B --bind
 Bind to local address and port. This is the default unless any of=20
-.B \-\-proto tcp-client
+.B --proto tcp-client
 ,
-.B \-\-http-proxy
+.B --http-proxy
 or
-.B \-\-socks-proxy
+.B --socks-proxy
 are used.
 .\"*********************************************************
 .TP
-.B \-\-nobind
+.B --nobind
 Do not bind to local address and port.  The IP stack will allocate
 a dynamic port for returning packets.  Since the value of the dynamic port
 could not be known in advance by a peer, this option is only suitable for
 peers which will be initiating connections by using the
-.B \-\-remote
+.B --remote
 option.
 .\"*********************************************************
 .TP
-.B \-\-dev tunX | tapX | null
+.B --dev tunX | tapX | null
 TUN/TAP virtual network device (
 .B X
 can be omitted for a dynamic device.)
@@ -712,7 +712,7 @@ devices encapsulate IPv4 or IPv6 (OSI Layer 3) while
 devices encapsulate Ethernet 802.3 (OSI Layer 2).
 .\"*********************************************************
 .TP
-.B \-\-dev-type device-type
+.B --dev-type device-type
 Which device type are we using?
 .B device-type
 should be
@@ -722,60 +722,60 @@ or
 .B tap
 (OSI Layer 2).
 Use this option only if the TUN/TAP device used with
-.B \-\-dev
+.B --dev
 does not begin with
 .B tun
 or
 .B tap.
 .\"*********************************************************
 .TP
-.B \-\-topology mode
+.B --topology mode
 Configure virtual addressing topology when running in
-.B \-\-dev tun
+.B --dev tun
 mode.  This directive has no meaning in
-.B \-\-dev tap
+.B --dev tap
 mode, which always uses a
 .B subnet
 topology.
=20
 If you set this directive on the server, the
-.B \-\-server
+.B --server
 and
-.B \-\-server-bridge
+.B --server-bridge
 directives will automatically push your chosen topology setting to clients
 as well.  This directive can also be manually pushed to clients.  Like the
-.B \-\-dev
+.B --dev
 directive, this directive must always be compatible between client and ser=
ver.
=20
 .B mode
 can be one of:
=20
-.B net30 \-\-
+.B net30 --
 Use a point-to-point topology, by allocating one /30 subnet per client.
 This is designed to allow point-to-point semantics when some
 or all of the connecting clients might be Windows systems.  This is the
 default on OpenVPN 2.0.
=20
-.B p2p \-\-
+.B p2p --
 Use a point-to-point topology where the remote endpoint of the client's
 tun interface always points to the local endpoint of the server's tun inte=
rface.
 This mode allocates a single IP address per connecting client.
 Only use
 when none of the connecting clients are Windows systems.  This mode
 is functionally equivalent to the
-.B \-\-ifconfig-pool-linear
+.B --ifconfig-pool-linear
 directive which is available in OpenVPN 2.0 and is now deprecated.
=20
-.B subnet \-\-
+.B subnet --
 Use a subnet rather than a point-to-point topology by
 configuring the tun interface with a local IP address and subnet mask,
 similar to the topology used in
-.B \-\-dev tap
+.B --dev tap
 and ethernet bridging mode.
 This mode allocates a single IP address per connecting client and works on
 Windows as well.  Only available when server and clients are OpenVPN 2.1 or
 higher, or OpenVPN 2.0.x which has been manually patched with the
-.B \-\-topology
+.B --topology
 directive code.  When used on Windows, requires version 8.2 or higher
 of the TAP-Win32 driver.  When used on *nix, requires that the tun
 driver supports an
@@ -785,38 +785,38 @@ command which sets a subnet instead of a remote endpo=
int IP address.
 This option exists in OpenVPN 2.1 or higher.
 .\"*********************************************************
 .TP
-.B \-\-tun-ipv6
+.B --tun-ipv6
 Build a tun link capable of forwarding IPv6 traffic.
 Should be used in conjunction with
-.B \-\-dev tun
+.B --dev tun
 or
-.B \-\-dev tunX.
+.B --dev tunX.
 A warning will be displayed
 if no specific IPv6 TUN support for your OS has been compiled into OpenVPN.
=20
 See below for further IPv6-related configuration options.
 .\"*********************************************************
 .TP
-.B \-\-dev-node node
+.B --dev-node node
 Explicitly set the device node rather than using
 /dev/net/tun, /dev/tun, /dev/tap, etc.  If OpenVPN
 cannot figure out whether
 .B node
 is a TUN or TAP device based on the name, you should
 also specify
-.B \-\-dev-type tun
+.B --dev-type tun
 or
-.B \-\-dev-type tap.
+.B --dev-type tap.
=20
 Under Mac OS X this option can be used to specify the default tun
 implementation. Using
-.B \-\-dev\-node utun
+.B --dev-node utun
 forces usage of the native Darwin tun kernel support. Use
-.B \-\-dev\-node utunN
+.B --dev-node utunN
 to select a specific utun instance. To force using the tun.kext (/dev/tunX=
) use
-.B \-\-dev\-node tun\fR.
+.B --dev-node tun\fR.
 When not specifying a
-.B \-\-dev\-node
+.B --dev-node
 option openvpn will first try to open utun, and fall back to tun.kext.
=20
 On Windows systems, select the TAP-Win32 adapter which
@@ -825,24 +825,24 @@ is named
 in the Network Connections Control Panel or the
 raw GUID of the adapter enclosed by braces.
 The
-.B \-\-show-adapters
+.B --show-adapters
 option under Windows can also be used
 to enumerate all available TAP-Win32
 adapters and will show both the network
 connections control panel name and the GUID for
 each TAP-Win32 adapter.
 .TP
-.B \-\-lladdr address
+.B --lladdr address
 Specify the link layer address, more commonly known as the MAC address.
 Only applied to TAP devices.
 .\"*********************************************************
 .TP
-.B \-\-iproute cmd
+.B --iproute cmd
 Set alternate command to execute instead of default iproute2 command.
 May be used in order to execute OpenVPN in unprivileged environment.
 .\"*********************************************************
 .TP
-.B \-\-ifconfig l rn
+.B --ifconfig l rn
 Set TUN/TAP adapter parameters.=20
 .B l
 is the IP address of the local VPN endpoint.
@@ -857,7 +857,7 @@ which is being created or connected to.
 For TUN devices, which facilitate virtual
 point-to-point IP connections,
 the proper usage of
-.B \-\-ifconfig
+.B --ifconfig
 is to use two private IP addresses
 which are not a member of any
 existing subnet which is in use.
@@ -871,7 +871,7 @@ you will be pinging across the VPN.
 For TAP devices, which provide
 the ability to create virtual
 ethernet segments,
-.B \-\-ifconfig
+.B --ifconfig
 is used to set an IP address and
 subnet mask just as a physical
 ethernet adapter would be
@@ -892,42 +892,42 @@ standard interface to the different
 ifconfig implementations on different
 platforms.
=20
-.B \-\-ifconfig
+.B --ifconfig
 parameters which are IP addresses can
 also be specified as a DNS or /etc/hosts
 file resolvable name.
=20
 For TAP devices,
-.B \-\-ifconfig
+.B --ifconfig
 should not be used if the TAP interface will be
 getting an IP address lease from a DHCP
 server.
 .\"*********************************************************
 .TP
-.B \-\-ifconfig-noexec
+.B --ifconfig-noexec
 Don't actually execute ifconfig/netsh commands, instead
 pass
-.B \-\-ifconfig
+.B --ifconfig
 parameters to scripts using environmental variables.
 .\"*********************************************************
 .TP
-.B \-\-ifconfig-nowarn
+.B --ifconfig-nowarn
 Don't output an options consistency check warning
 if the
-.B \-\-ifconfig
+.B --ifconfig
 option on this side of the
 connection doesn't match the remote side.  This is useful
 when you want to retain the overall benefits of the
 options consistency check (also see
-.B \-\-disable-occ
+.B --disable-occ
 option) while only disabling the ifconfig component of
 the check.
=20
 For example,
 if you have a configuration where the local host uses
-.B \-\-ifconfig
+.B --ifconfig
 but the remote host does not, use
-.B \-\-ifconfig-nowarn
+.B --ifconfig-nowarn
 on the local host.
=20
 This option will also silence warnings about potential
@@ -935,7 +935,7 @@ address conflicts which occasionally annoy more experie=
nced
 users by triggering "false positive" warnings.
 .\"*********************************************************
 .TP
-.B \-\-route network/IP [netmask] [gateway] [metric]
+.B --route network/IP [netmask] [gateway] [metric]
 Add route to routing table after connection is established.
 Multiple routes can be specified.  Routes will be
 automatically torn down in reverse order prior to
@@ -949,20 +949,20 @@ while at the same time providing portable semantics
 across OpenVPN's platform space.
=20
 .B netmask
-default \-\- 255.255.255.255
+default -- 255.255.255.255
=20
 .B gateway
-default \-\- taken from
-.B \-\-route-gateway
+default -- taken from
+.B --route-gateway
 or the second parameter to
-.B \-\-ifconfig
+.B --ifconfig
 when
-.B \-\-dev tun
+.B --dev tun
 is specified.
=20
 .B metric
-default \-\- taken from
-.B \-\-route-metric
+default -- taken from
+.B --route-metric
 otherwise 0.
=20
 The default can be specified by leaving an option blank or setting
@@ -977,37 +977,37 @@ also be specified as a DNS or /etc/hosts
 file resolvable name, or as one of three special keywords:
=20
 .B vpn_gateway
-\-\- The remote VPN endpoint address
+-- The remote VPN endpoint address
 (derived either from
-.B \-\-route-gateway
+.B --route-gateway
 or the second parameter to
-.B \-\-ifconfig
+.B --ifconfig
 when
-.B \-\-dev tun
+.B --dev tun
 is specified).
=20
 .B net_gateway
-\-\- The pre-existing IP default gateway, read from the routing
+-- The pre-existing IP default gateway, read from the routing
 table (not supported on all OSes).
=20
 .B remote_host
-\-\- The
-.B \-\-remote
+-- The
+.B --remote
 address if OpenVPN is being run in client mode, and is undefined in server=
 mode.
 .\"*********************************************************
 .TP
-.B \-\-max-routes n
+.B --max-routes n
 Allow a maximum number of n
-.B \-\-route
+.B --route
 options to be specified, either in the local configuration file,
 or pulled from an OpenVPN server.  By default, n=3D100.
 .\"*********************************************************
 .TP
-.B \-\-route-gateway gw|'dhcp'
+.B --route-gateway gw|'dhcp'
 Specify a default gateway
 .B gw
 for use with
-.B \-\-route.
+.B --route.
=20
 If
 .B dhcp
@@ -1016,14 +1016,14 @@ the gateway address will be extracted from a DHCP
 negotiation with the OpenVPN server-side LAN.
 .\"*********************************************************
 .TP
-.B \-\-route-metric m
+.B --route-metric m
 Specify a default metric
 .B m
 for use with
-.B \-\-route.
+.B --route.
 .\"*********************************************************
 .TP
-.B \-\-route-delay [n] [w]
+.B --route-delay [n] [w]
 Delay
 .B n
 seconds (default=3D0) after connection
@@ -1031,16 +1031,16 @@ establishment, before adding routes. If
 .B n
 is 0, routes will be added immediately upon connection
 establishment.  If
-.B \-\-route-delay
+.B --route-delay
 is omitted, routes will be added immediately after TUN/TAP device
 open and
-.B \-\-up
+.B --up
 script execution, before any
-.B \-\-user
+.B --user
 or=20
-.B \-\-group
+.B --group
 privilege downgrade (or
-.B \-\-chroot
+.B --chroot
 execution.)
=20
 This option is designed to be useful in scenarios where DHCP is
@@ -1049,18 +1049,18 @@ tap adapter addresses.  The delay will give the DHC=
P handshake
 time to complete before routes are added.
=20
 On Windows,
-.B \-\-route-delay
+.B --route-delay
 tries to be more intelligent by waiting
 .B w
 seconds (w=3D30 by default)
 for the TAP-Win32 adapter to come up before adding routes.
 .\"*********************************************************
 .TP
-.B \-\-route-up cmd
+.B --route-up cmd
 Run command
 .B cmd
 after routes are added, subject to
-.B \-\-route-delay.
+.B --route-delay.
=20
 .B cmd
 consists of a path to script (or executable program), optionally
@@ -1071,7 +1071,7 @@ See the "Environmental Variables" section below for
 additional parameters passed as environmental variables.
 .\"*********************************************************
 .TP
-.B \-\-route-pre-down cmd
+.B --route-pre-down cmd
 Run command
 .B cmd
 before routes are removed upon disconnection.
@@ -1085,17 +1085,17 @@ See the "Environmental Variables" section below for
 additional parameters passed as environmental variables.
 .\"*********************************************************
 .TP
-.B \-\-route-noexec
+.B --route-noexec
 Don't add or remove routes automatically.  Instead pass routes to
-.B \-\-route-up
+.B --route-up
 script using environmental variables.
 .\"*********************************************************
 .TP
-.B \-\-route-nopull
+.B --route-nopull
 When used with
-.B \-\-client
+.B --client
 or
-.B \-\-pull,
+.B --pull,
 accept options pushed by server EXCEPT for routes and dhcp options
 like DNS servers.
=20
@@ -1105,16 +1105,16 @@ however note that this option still allows the serv=
er
 to set the TCP/IP properties of the client's TUN/TAP interface.
 .\"*********************************************************
 .TP
-.B \-\-allow-pull-fqdn
+.B --allow-pull-fqdn
 Allow client to pull DNS names from server (rather than being limited
 to IP address) for
-.B \-\-ifconfig,
-.B \-\-route,
+.B --ifconfig,
+.B --route,
 and
-.B \-\-route-gateway.
+.B --route-gateway.
 .\"*********************************************************
 .TP
-.B \-\-client-nat snat|dnat network netmask alias
+.B --client-nat snat|dnat network netmask alias
 This pushable client option sets up a stateless one-to-one NAT
 rule on packet addresses (not ports), and is useful in cases
 where routes or ifconfig settings pushed to the client would
@@ -1134,12 +1134,12 @@ Use
 (destination NAT) for remote resources.
=20
 Set
-.B \-\-verb 6
+.B --verb 6
 for debugging info showing the transformation of src/dest
 addresses in packets.
 .\"*********************************************************
 .TP
-.B \-\-redirect-gateway flags...
+.B --redirect-gateway flags...
 Automatically execute routing commands to cause all outgoing IP traffic
 to be redirected over the VPN.  This is a client-side option.
=20
@@ -1147,7 +1147,7 @@ This option performs three steps:
=20
 .B (1)
 Create a static route for the
-.B \-\-remote
+.B --remote
 address which forwards to the pre-existing default gateway.
 This is done so that
 .B (3)
@@ -1158,11 +1158,11 @@ Delete the default gateway route.
=20
 .B (3)
 Set the new default gateway to be the VPN endpoint address (derived either=
 from
-.B \-\-route-gateway
+.B --route-gateway
 or the second parameter to
-.B \-\-ifconfig
+.B --ifconfig
 when
-.B \-\-dev tun
+.B --dev tun
 is specified).
=20
 When the tunnel is torn down, all of the above steps are reversed so
@@ -1170,7 +1170,7 @@ that the original default route is restored.
=20
 Option flags:
=20
-.B local \-\-
+.B local --
 Add the
 .B local
 flag if both OpenVPN servers are directly connected via a common subnet,
@@ -1180,48 +1180,48 @@ flag will cause step
 .B 1
 above to be omitted.
=20
-.B autolocal \-\-
+.B autolocal --
 Try to automatically determine whether to enable
 .B local
 flag above.
=20
-.B def1 \-\-
+.B def1 --
 Use this flag to override
 the default gateway by using 0.0.0.0/1 and 128.0.0.0/1
 rather than 0.0.0.0/0.  This has the benefit of overriding
 but not wiping out the original default gateway.=20
=20
-.B bypass-dhcp \-\-
+.B bypass-dhcp --
 Add a direct route to the DHCP server (if it is non-local) which
 bypasses the tunnel
 (Available on Windows clients, may not be available
 on non-Windows clients).
=20
-.B bypass-dns \-\-
+.B bypass-dns --
 Add a direct route to the DNS server(s) (if they are non-local) which
 bypasses the tunnel
 (Available on Windows clients, may not be available
 on non-Windows clients).
=20
-.B block-local \-\-
+.B block-local --
 Block access to local LAN when the tunnel is active, except for
 the LAN gateway itself.  This is accomplished by routing the local
 LAN (except for the LAN gateway address) into the tunnel.
 .\"*********************************************************
 .TP
-.B \-\-link-mtu n
+.B --link-mtu n
 Sets an upper bound on the size of UDP packets which are sent
 between OpenVPN peers.  It's best not to set this parameter unless
 you know what you're doing.
 .\"*********************************************************
 .\"*********************************************************
 .TP
-.B \-\-redirect-private [flags]
-Like \-\-redirect-gateway, but omit actually changing the default
+.B --redirect-private [flags]
+Like --redirect-gateway, but omit actually changing the default
 gateway.  Useful when pushing private subnets.
 .\"*********************************************************
 .TP
-.B \-\-tun-mtu n
+.B --tun-mtu n
 Take the TUN device MTU to be
 .B n
 and derive the link MTU
@@ -1237,17 +1237,17 @@ MTU problems often manifest themselves as connectio=
ns which
 hang during periods of active usage.
=20
 It's best to use the
-.B \-\-fragment
+.B --fragment
 and/or
-.B \-\-mssfix
+.B --mssfix
 options to deal with MTU sizing issues.
 .\"*********************************************************
 .TP
-.B \-\-tun-mtu-extra n
+.B --tun-mtu-extra n
 Assume that the TUN/TAP device might return as many as
 .B n
 bytes more than the
-.B \-\-tun-mtu
+.B --tun-mtu
 size on read.  This parameter defaults to 0, which is sufficient for
 most TUN devices.  TAP devices may introduce additional overhead in excess
 of the MTU size, and a setting of 32 is the default when TAP devices are u=
sed.
@@ -1255,34 +1255,34 @@ This parameter only controls internal OpenVPN buffe=
r sizing,
 so there is no transmission overhead associated with using a larger value.
 .\"*********************************************************
 .TP
-.B \-\-mtu-disc type
+.B --mtu-disc type
 Should we do Path MTU discovery on TCP/UDP channel?  Only supported on OSe=
s such
 as Linux that supports the necessary system call to set.
=20
 .B 'no'
-\-\- Never send DF (Don't Fragment) frames
+-- Never send DF (Don't Fragment) frames
 .br
 .B 'maybe'
-\-\- Use per-route hints
+-- Use per-route hints
 .br
 .B 'yes'
-\-\- Always DF (Don't Fragment)
+-- Always DF (Don't Fragment)
 .br
 .\"*********************************************************
 .TP
-.B \-\-mtu-test
+.B --mtu-test
 To empirically measure MTU on connection startup,
 add the
-.B \-\-mtu-test
+.B --mtu-test
 option to your configuration.
 OpenVPN will send ping packets of various sizes
 to the remote peer and measure the largest packets
 which were successfully received.  The
-.B \-\-mtu-test
+.B --mtu-test
 process normally takes about 3 minutes to complete.
 .\"*********************************************************
 .TP
-.B \-\-fragment max
+.B --fragment max
 Enable internal datagram fragmentation so
 that no UDP datagrams are sent which
 are larger than
@@ -1292,24 +1292,24 @@ bytes.
 The
 .B max
 parameter is interpreted in the same way as the
-.B \-\-link-mtu
+.B --link-mtu
 parameter, i.e. the UDP packet size after encapsulation
 overhead has been added in, but not including
 the UDP header itself.
=20
 The
-.B \-\-fragment
+.B --fragment
 option only makes sense when you are using the UDP protocol (
-.B \-\-proto udp
+.B --proto udp
 ).
=20
-.B \-\-fragment
+.B --fragment
 adds 4 bytes of overhead per datagram.
=20
 See the
-.B \-\-mssfix
+.B --mssfix
 option below for an important related option to
-.B \-\-fragment.
+.B --fragment.
=20
 It should also be noted that this option is not meant to replace
 UDP fragmentation at the IP stack level.  It is only meant as a
@@ -1322,7 +1322,7 @@ internal fragmentation capability may be your only op=
tion, such
 as tunneling a UDP multicast stream which requires fragmentation.
 .\"*********************************************************
 .TP
-.B \-\-mssfix max
+.B --mssfix max
 Announce to TCP sessions running over the tunnel that they should limit
 their send packet sizes such that after OpenVPN has encapsulated them,
 the resulting UDP packet size that OpenVPN sends to its peer will not
@@ -1334,33 +1334,33 @@ bytes. The default value is
 The
 .B max
 parameter is interpreted in the same way as the
-.B \-\-link-mtu
+.B --link-mtu
 parameter, i.e. the UDP packet size after encapsulation
 overhead has been added in, but not including
 the UDP header itself.
=20
 The
-.B \-\-mssfix
+.B --mssfix
 option only makes sense when you are using the UDP protocol
 for OpenVPN peer-to-peer communication, i.e.
-.B \-\-proto udp.
+.B --proto udp.
=20
-.B \-\-mssfix
+.B --mssfix
 and
-.B \-\-fragment
+.B --fragment
 can be ideally used together, where
-.B \-\-mssfix
+.B --mssfix
 will try to keep TCP from needing
 packet fragmentation in the first place,
 and if big packets come through anyhow
 (from protocols other than TCP),
-.B \-\-fragment
+.B --fragment
 will internally fragment them.
=20
 Both
-.B \-\-fragment
+.B --fragment
 and
-.B \-\-mssfix
+.B --mssfix
 are designed to work around cases where Path MTU discovery
 is broken on the network path between OpenVPN peers.
=20
@@ -1369,41 +1369,41 @@ connection which successfully starts, but then stal=
ls
 during active usage.
=20
 If
-.B \-\-fragment
+.B --fragment
 and
-.B \-\-mssfix
+.B --mssfix
 are used together,
-.B \-\-mssfix
+.B --mssfix
 will take its default
 .B max
 parameter from the
-.B \-\-fragment max
+.B --fragment max
 option.
=20
 Therefore, one could lower the maximum UDP packet size
 to 1300 (a good first try for solving MTU-related
 connection problems) with the following options:
=20
-.B \-\-tun-mtu 1500 \-\-fragment 1300 \-\-mssfix
+.B --tun-mtu 1500 --fragment 1300 --mssfix
 .\"*********************************************************
 .TP
-.B \-\-sndbuf size
+.B --sndbuf size
 Set the TCP/UDP socket send buffer size.
 Currently defaults to 65536 bytes.
 .\"*********************************************************
 .TP
-.B \-\-rcvbuf size
+.B --rcvbuf size
 Set the TCP/UDP socket receive buffer size.
 Currently defaults to 65536 bytes.
 .\"*********************************************************
 .TP
-.B \-\-mark value
+.B --mark value
 Mark encrypted packets being sent with value. The mark value can be
 matched in policy routing and packetfilter rules. This option is
 only supported in Linux and does nothing on other operating systems.
 .\"*********************************************************
 .TP
-.B \-\-socket-flags flags...
+.B --socket-flags flags...
 Apply the given flags to the OpenVPN transport socket.
 Currently, only
 .B TCP_NODELAY
@@ -1420,12 +1420,12 @@ This option is pushable from server to client, and =
should be used
 on both client and server for maximum effect.
 .\"*********************************************************
 .TP
-.B \-\-txqueuelen n
+.B --txqueuelen n
 (Linux only) Set the TX queue length on the TUN/TAP interface.
 Currently defaults to 100.
 .\"*********************************************************
 .TP
-.B \-\-shaper n
+.B --shaper n
 Limit bandwidth of outgoing tunnel data to
 .B n
 bytes per second on the TCP/UDP port.
@@ -1462,7 +1462,7 @@ OpenVPN allows
 to be between 100 bytes/sec and 100 Mbytes/sec.
 .\"*********************************************************
 .TP
-.B \-\-inactive n [bytes]
+.B --inactive n [bytes]
 Causes OpenVPN to exit after
 .B n
 seconds of inactivity on the TUN/TAP device. The time length of
@@ -1486,18 +1486,18 @@ internally by OpenVPN and are not an indication of =
actual user
 activity.
 .\"*********************************************************
 .TP
-.B \-\-ping n
+.B --ping n
 Ping remote over the TCP/UDP control channel
 if no packets have been sent for at least
 .B n
 seconds (specify
-.B \-\-ping
+.B --ping
 on both peers to cause ping packets to be sent in both directions since
 OpenVPN ping packets are not echoed like IP ping packets).
 When used in one of OpenVPN's secure modes (where
-.B \-\-secret, \-\-tls-server,
+.B --secret, --tls-server,
 or
-.B \-\-tls-client
+.B --tls-client
 is specified), the ping packet
 will be cryptographically secure.
=20
@@ -1510,33 +1510,33 @@ pass will not time out.
=20
 (2) To provide a basis for the remote to test the existence
 of its peer using the
-.B \-\-ping-exit
+.B --ping-exit
 option.
 .\"*********************************************************
 .TP
-.B \-\-ping-exit n
+.B --ping-exit n
 Causes OpenVPN to exit after
 .B n
 seconds pass without reception of a ping
 or other packet from remote.
 This option can be combined with
-.B \-\-inactive, \-\-ping,
+.B --inactive, --ping,
 and
-.B \-\-ping-exit
+.B --ping-exit
 to create a two-tiered inactivity disconnect.
=20
 For example,
=20
-.B openvpn [options...] \-\-inactive 3600 \-\-ping 10 \-\-ping-exit 60
+.B openvpn [options...] --inactive 3600 --ping 10 --ping-exit 60
=20
 when used on both peers will cause OpenVPN to exit within 60
 seconds if its peer disconnects, but will exit after one
 hour if no actual tunnel data is exchanged.
 .\"*********************************************************
 .TP
-.B \-\-ping-restart n
+.B --ping-restart n
 Similar to
-.B \-\-ping-exit,
+.B --ping-exit,
 but trigger a
 .B SIGUSR1
 restart after
@@ -1555,13 +1555,13 @@ as
=20
 If the peer cannot be reached, a restart will be triggered, causing
 the hostname used with
-.B \-\-remote
+.B --remote
 to be re-resolved (if
-.B \-\-resolv-retry
+.B --resolv-retry
 is also specified).
=20
 In server mode,
-.B \-\-ping-restart, \-\-inactive,
+.B --ping-restart, --inactive,
 or any other type of internally generated signal will always be
 applied to
 individual client instance objects, never to whole server itself.
@@ -1570,14 +1570,14 @@ which would normally cause a restart, will cause th=
e deletion
 of the client instance object instead.
=20
 In client mode, the
-.B \-\-ping-restart
+.B --ping-restart
 parameter is set to 120 seconds by default.  This default will
 hold until the client pulls a replacement value from the server, based on
 the
-.B \-\-keepalive
+.B --keepalive
 setting in the server configuration.
 To disable the 120 second default, set
-.B \-\-ping-restart 0
+.B --ping-restart 0
 on the client.
=20
 See the signals section below for more information
@@ -1587,23 +1587,23 @@ on
 Note that the behavior of
 .B SIGUSR1
 can be modified by the
-.B \-\-persist-tun, \-\-persist-key, \-\-persist-local-ip,
+.B --persist-tun, --persist-key, --persist-local-ip,
 and
-.B \-\-persist-remote-ip
+.B --persist-remote-ip
 options.
=20
 Also note that
-.B \-\-ping-exit
+.B --ping-exit
 and
-.B \-\-ping-restart
+.B --ping-restart
 are mutually exclusive and cannot be used together.
 .\"*********************************************************
 .TP
-.B \-\-keepalive n m
+.B --keepalive n m
 A helper directive designed to simplify the expression of
-.B \-\-ping
+.B --ping
 and
-.B \-\-ping-restart
+.B --ping-restart
 in server mode configurations.
=20
 The server timeout is set twice the value of the second argument.
@@ -1611,7 +1611,7 @@ This ensures that a timeout is detected on client side
 before the server side drops the connection.
=20
 For example,
-.B \-\-keepalive 10 60
+.B --keepalive 10 60
 expands as follows:
=20
 .nf
@@ -1630,24 +1630,24 @@ expands as follows:
 .fi
 .\"*********************************************************
 .TP
-.B \-\-ping-timer-rem
+.B --ping-timer-rem
 Run the
-.B \-\-ping-exit
+.B --ping-exit
 /
-.B \-\-ping-restart
+.B --ping-restart
 timer only if we have a remote address.  Use this option if you are
 starting the daemon in listen mode (i.e. without an explicit
-.B \-\-remote
+.B --remote
 peer), and you don't want to start clocking timeouts until a remote
 peer connects.
 .\"*********************************************************
 .TP
-.B \-\-persist-tun
+.B --persist-tun
 Don't close and reopen TUN/TAP device or run up/down scripts
 across
 .B SIGUSR1
 or
-.B \-\-ping-restart
+.B --ping-restart
 restarts.
=20
 .B SIGUSR1
@@ -1657,14 +1657,14 @@ but which offers finer-grained control over
 reset options.
 .\"*********************************************************
 .TP
-.B \-\-persist-key
+.B --persist-key
 Don't re-read key files across
 .B SIGUSR1
 or
-.B \-\-ping-restart.
+.B --ping-restart.
=20
 This option can be combined with
-.B \-\-user nobody
+.B --user nobody
 to allow restarts triggered by the
 .B SIGUSR1
 signal.
@@ -1677,29 +1677,29 @@ This option solves the problem by persisting keys a=
cross
 resets, so they don't need to be re-read.
 .\"*********************************************************
 .TP
-.B \-\-persist-local-ip
+.B --persist-local-ip
 Preserve initially resolved local IP address and port number
 across
 .B SIGUSR1
 or
-.B \-\-ping-restart
+.B --ping-restart
 restarts.
 .\"*********************************************************
 .TP
-.B \-\-persist-remote-ip
+.B --persist-remote-ip
 Preserve most recently authenticated remote IP address and port number
 across
 .B SIGUSR1
 or
-.B \-\-ping-restart
+.B --ping-restart
 restarts.
 .\"*********************************************************
 .TP
-.B \-\-mlock
+.B --mlock
 Disable paging by calling the POSIX mlockall function.
 Requires that OpenVPN be initially run as root (though
 OpenVPN can subsequently downgrade its UID using the
-.B \-\-user
+.B --user
 option).
=20
 Using this option ensures that key material and tunnel
@@ -1711,22 +1711,22 @@ would not be able to scan the system swap file to
 recover previously used
 ephemeral keys, which are used for a period of time
 governed by the
-.B \-\-reneg
+.B --reneg
 options (see below), then are discarded.
=20
 The downside
 of using
-.B \-\-mlock
+.B --mlock
 is that it will reduce the amount of physical
 memory available to other applications.
 .\"*********************************************************
 .TP
-.B \-\-up cmd
+.B --up cmd
 Run command
 .B cmd
 after successful TUN/TAP device open
 (pre
-.B \-\-user
+.B --user
 UID change).
=20
 .B cmd
@@ -1740,13 +1740,13 @@ private subnets which exist at the other
 end of the VPN connection into the tunnel.
=20
 For
-.B \-\-dev tun
+.B --dev tun
 execute as:
=20
 .B cmd tun_dev tun_mtu link_mtu ifconfig_local_ip ifconfig_remote_ip [ ini=
t | restart ]
=20
 For
-.B \-\-dev tap
+.B --dev tap
 execute as:
=20
 .B cmd tap_dev tap_mtu link_mtu ifconfig_local_ip ifconfig_netmask [ init =
| restart ]
@@ -1769,62 +1769,62 @@ In this context, the last command line parameter pa=
ssed to the script
 will be
 .I init.
 If the
-.B \-\-up-restart
+.B --up-restart
 option is also used, the up script will be called for restarts as
 well.  A restart is considered to be a partial reinitialization
 of OpenVPN where the TUN/TAP instance is preserved (the
-.B \-\-persist-tun
+.B --persist-tun
 option will enable such preservation).  A restart
 can be generated by a SIGUSR1 signal, a
-.B \-\-ping-restart
+.B --ping-restart
 timeout, or a connection reset when the TCP protocol is enabled
 with the
-.B \-\-proto
+.B --proto
 option.  If a restart occurs, and
-.B \-\-up-restart
+.B --up-restart
 has been specified, the up script will be called with
 .I restart
 as the last parameter.
=20
 The following standalone example shows how the
-.B \-\-up
+.B --up
 script can be called in both an initialization and restart context.
 (NOTE: for security reasons, don't run the following example unless UDP po=
rt
 9999 is blocked by your firewall.  Also, the example will run indefinitely,
 so you should abort with control-c).
=20
-.B openvpn \-\-dev tun \-\-port 9999 \-\-verb 4 \-\-ping-restart 10 \-\-up=
 'echo up' \-\-down 'echo down' \-\-persist-tun \-\-up-restart
+.B openvpn --dev tun --port 9999 --verb 4 --ping-restart 10 --up 'echo up'=
 --down 'echo down' --persist-tun --up-restart
=20
 Note that OpenVPN also provides the
-.B \-\-ifconfig
+.B --ifconfig
 option to automatically ifconfig the TUN device,
 eliminating the need to define an
-.B \-\-up
+.B --up
 script, unless you also want to configure routes
 in the
-.B \-\-up
+.B --up
 script.
=20
 If
-.B \-\-ifconfig
+.B --ifconfig
 is also specified, OpenVPN will pass the ifconfig local
 and remote endpoints on the command line to the
-.B \-\-up
+.B --up
 script so that they can be used to configure routes such as:
=20
 .B route add -net 10.0.0.0 netmask 255.255.255.0 gw $5
 .\"*********************************************************
 .TP
-.B \-\-up-delay
+.B --up-delay
 Delay TUN/TAP open and possible
-.B \-\-up
+.B --up
 script execution
 until after TCP/UDP connection establishment with peer.
=20
 In
-.B \-\-proto udp
+.B --proto udp
 mode, this option normally requires the use of
-.B \-\-ping
+.B --ping
 to allow connection initiation to be sensed in the absence
 of tunnel data, since UDP is a "connectionless" protocol.
=20
@@ -1833,14 +1833,14 @@ transitioning to "connected" until connection estab=
lishment,
 i.e. the receipt of the first authenticated packet from the peer.
 .\"*********************************************************
 .TP
-.B \-\-down cmd
+.B --down cmd
 Run command
 .B cmd
 after TUN/TAP device close
 (post
-.B \-\-user
+.B --user
 UID change and/or
-.B \-\-chroot
+.B --chroot
 ).
 .B cmd
 consists of a path to script (or executable program), optionally
@@ -1849,42 +1849,42 @@ and/or escaped using a backslash, and should be sep=
arated by one or more spaces.
=20
 Called with the same parameters and environmental
 variables as the
-.B \-\-up
+.B --up
 option above.
=20
 Note that if you reduce privileges by using
-.B \-\-user
+.B --user
 and/or
-.B \-\-group,
+.B --group,
 your
-.B \-\-down
+.B --down
 script will also run at reduced privilege.
 .\"*********************************************************
 .TP
-.B \-\-down-pre
+.B --down-pre
 Call
-.B \-\-down
+.B --down
 cmd/script before, rather than after, TUN/TAP close.
 .\"*********************************************************
 .TP
-.B \-\-up-restart
+.B --up-restart
 Enable the
-.B \-\-up
+.B --up
 and
-.B \-\-down
+.B --down
 scripts to be called for restarts as well as initial program start.
 This option is described more fully above in the
-.B \-\-up
+.B --up
 option documentation.
 .\"*********************************************************
 .TP
-.B \-\-setenv name value
+.B --setenv name value
 Set a custom environmental variable
 .B name=3Dvalue
 to pass to script.
 .\"*********************************************************
 .TP
-.B \-\-setenv FORWARD_COMPATIBLE 1
+.B --setenv FORWARD_COMPATIBLE 1
 Relax config file syntax checking so that unknown directives
 will trigger a warning but not a fatal error,
 on the assumption that a given unknown directive might be valid
@@ -1906,10 +1906,10 @@ Versions prior to OpenVPN 2.3.3 will always ignore =
options set with the
 directive.
=20
 See also
-.B \-\-ignore-unknown-option
+.B --ignore-unknown-option
 .\"*********************************************************
 .TP
-.B \-\-setenv-safe name value
+.B --setenv-safe name value
 Set a custom environmental variable
 .B OPENVPN_name=3Dvalue
 to pass to script.
@@ -1920,13 +1920,13 @@ is a safety precaution to prevent a LD_PRELOAD styl=
e attack
 from a malicious or compromised server.
 .\"*********************************************************
 .TP
-.B \-\-ignore-unknown-option opt1 opt2 opt3 ... optN
+.B --ignore-unknown-option opt1 opt2 opt3 ... optN
 When one of options
 .B opt1 ... optN
 is encountered in the configuration file the configuration
 file parsing does not fail if this OpenVPN version does not
 support the option. Multiple
-.B \-\-ignore-unknown-option
+.B --ignore-unknown-option
 options can be given to support a larger number of options to ignore.
=20
 This option should be used with caution, as there are good security
@@ -1935,27 +1935,27 @@ config file. Having said that, there are valid reas=
ons for wanting
 new software features to gracefully degrade when encountered by
 older software versions.
=20
-.B \-\-ignore-unknown-option
+.B --ignore-unknown-option
 is available since OpenVPN 2.3.3.
 .\"*********************************************************
 .TP
-.B \-\-script-security level
+.B --script-security level
 This directive offers policy-level control over OpenVPN's usage of externa=
l programs
 and scripts.  Lower
 .B level
 values are more restrictive, higher values are more permissive.  Settings =
for
 .B level:
=20
-.B 0 \-\-
+.B 0 --
 Strictly no calling of external programs.
 .br
-.B 1 \-\-
+.B 1 --
 (Default) Only call built-in executables such as ifconfig, ip, route, or n=
etsh.
 .br
-.B 2 \-\-
+.B 2 --
 Allow calling of built-in executables and user-defined scripts.
 .br
-.B 3 \-\-
+.B 3 --
 Allow passwords to be passed to scripts via environmental variables (poten=
tially unsafe).
=20
 OpenVPN releases before v2.3 also supported a
@@ -1980,7 +1980,7 @@ example, if you have a Visual Basic script, you must =
use this syntax now:
 .nf
 .ft 3
 .in +4
-\-\-up 'C:\\\\Windows\\\\System32\\\\wscript.exe C:\\\\Program\\ Files\\\\=
OpenVPN\\\\config\\\\my-up-script.vbs'
+--up 'C:\\\\Windows\\\\System32\\\\wscript.exe C:\\\\Program\\ Files\\\\Op=
enVPN\\\\config\\\\my-up-script.vbs'
 .in -4
 .ft
 .fi
@@ -1994,19 +1994,19 @@ flag was removed is due to the security implication=
s with shell expansions
 when executing scripts via the system() call.
 .\"*********************************************************
 .TP
-.B \-\-disable-occ
+.B --disable-occ
 Don't output a warning message if option inconsistencies are detected betw=
een
 peers.  An example of an option inconsistency would be where one peer uses
-.B \-\-dev tun
+.B --dev tun
 while the other peer uses
-.B \-\-dev tap.
+.B --dev tap.
=20
 Use of this option is discouraged, but is provided as
 a temporary fix in situations where a recent version of OpenVPN must
 connect to an old version.
 .\"*********************************************************
 .TP
-.B \-\-user user
+.B --user user
 Change the user ID of the OpenVPN process to
 .B user
 after initialization, dropping privileges in the process.
@@ -2028,7 +2028,7 @@ you want to reset an OpenVPN daemon with a
 signal
 (for example in response
 to a DHCP reset), you should make use of one or more of the
-.B \-\-persist
+.B --persist
 options to ensure that OpenVPN doesn't need to execute any privileged
 operations in order to restart (such as re-reading key files
 or running
@@ -2036,16 +2036,16 @@ or running
 on the TUN device).
 .\"*********************************************************
 .TP
-.B \-\-group group
+.B --group group
 Similar to the
-.B \-\-user
+.B --user
 option,
 this option changes the group ID of the OpenVPN process to
 .B group
 after initialization.
 .\"*********************************************************
 .TP
-.B \-\-cd dir
+.B --cd dir
 Change directory to
 .B dir
 prior to reading any files such as
@@ -2057,16 +2057,16 @@ to the current directory such as "." or "..".
=20
 This option is useful when you are running
 OpenVPN in=20
-.B \-\-daemon
+.B --daemon
 mode, and you want to consolidate all of
 your OpenVPN control files in one location.
 .\"*********************************************************
 .TP
-.B \-\-chroot dir
+.B --chroot dir
 Chroot to
 .B dir
 after initialization.=20=20
-.B \-\-chroot
+.B --chroot
 essentially redefines
 .B dir
 as being the top
@@ -2086,7 +2086,7 @@ are executed after the chroot operation.
=20
 Note: if OpenVPN is built using the PolarSSL SSL
 library,
-.B \-\-chroot
+.B --chroot
 will only work if a /dev/urandom device node is available
 inside the chroot directory
 .B dir.
@@ -2095,22 +2095,22 @@ This is due to the way PolarSSL works (it wants to =
open
 at startup) and nothing OpenVPN can influence.
 .\"*********************************************************
 .TP
-.B \-\-setcon context
+.B --setcon context
 Apply SELinux
 .B context
 after initialization. This
 essentially provides the ability to restrict OpenVPN's
 rights to only network I/O operations, thanks to
 SELinux. This goes further than
-.B \-\-user
+.B --user
 and
-.B \-\-chroot
+.B --chroot
 in that those two, while being great security features,
 unfortunately do not protect against privilege escalation
 by exploitation of a vulnerable system call. You can of
 course combine all three, but please note that since
 setcon requires access to /proc you will have to provide
-it inside the chroot directory (e.g. with mount \-\-bind).
+it inside the chroot directory (e.g. with mount --bind).
=20
 Since the setcon operation is delayed until after
 initialization, OpenVPN can be restricted to just
@@ -2122,13 +2122,13 @@ allow many things required only during initializati=
on.
 Like with chroot, complications can result when scripts
 or restarts are executed after the setcon operation,
 which is why you should really consider using the
-.B \-\-persist-key
+.B --persist-key
 and
-.B \-\-persist-tun
+.B --persist-tun
 options.
 .\"*********************************************************
 .TP
-.B \-\-daemon [progname]
+.B --daemon [progname]
 Become a daemon after all initialization functions are completed.
 This option will cause all message and error output to
 be sent to the syslog file (such as /var/log/messages),
@@ -2137,10 +2137,10 @@ ifconfig commands,
 which will go to /dev/null unless otherwise redirected.
 The syslog redirection occurs immediately at the point
 that
-.B \-\-daemon
+.B --daemon
 is parsed on the command line even though
 the daemonization point occurs later.  If one of the
-.B \-\-log
+.B --log
 options is present, it will supercede syslog
 redirection.
=20
@@ -2156,7 +2156,7 @@ When unspecified,
 defaults to "openvpn".
=20
 When OpenVPN is run with the
-.B \-\-daemon
+.B --daemon
 option, it will try to delay daemonization until the majority of initializ=
ation
 functions which are capable of generating fatal errors are complete.  This=
 means
 that initialization scripts can test the return status of the
@@ -2166,25 +2166,25 @@ has correctly initialized and entered the packet fo=
rwarding event loop.
 In OpenVPN, the vast majority of errors which occur after initialization a=
re non-fatal.
 .\"*********************************************************
 .TP
-.B \-\-syslog [progname]
+.B --syslog [progname]
 Direct log output to system logger, but do not become a daemon.
 See
-.B \-\-daemon
+.B --daemon
 directive above for description of
 .B progname
 parameter.
 .TP
-.B \-\-errors-to-stderr
+.B --errors-to-stderr
 Output errors to stderr instead of stdout unless log output is redirected =
by one of the
-.B \-\-log
+.B --log
 options.
 .\"*********************************************************
 .TP
-.B \-\-passtos
+.B --passtos
 Set the TOS field of the tunnel packet to what the payload's TOS is.
 .\"*********************************************************
 .TP
-.B \-\-inetd [wait|nowait] [progname]
+.B --inetd [wait|nowait] [progname]
 Use this option when OpenVPN is being run from the inetd or
 .BR xinetd(8)
 server.
@@ -2195,7 +2195,7 @@ option must match what is specified in the inetd/xine=
td
 config file.  The
 .B nowait
 mode can only be used with
-.B \-\-proto tcp-server.
+.B --proto tcp-server.
 The default is
 .B wait.
 The
@@ -2207,16 +2207,16 @@ see the OpenVPN FAQ:
 .I http://openvpn.net/faq.html#oneport
=20
 This option precludes the use of
-.B \-\-daemon, \-\-local,
+.B --daemon, --local,
 or
-.B \-\-remote.
+.B --remote.
 Note that this option causes message and error output to be handled in the=
 same
 way as the
-.B \-\-daemon
+.B --daemon
 option.  The optional
 .B progname
 parameter is also handled exactly as in
-.B \-\-daemon.
+.B --daemon.
=20
 Also note that in
 .B wait
@@ -2226,7 +2226,7 @@ on using OpenVPN with xinetd:
 .I http://openvpn.net/1xhowto.html
 .\"*********************************************************
 .TP
-.B \-\-log file
+.B --log file
 Output logging messages to
 .B file,
 including output to stdout/stderr which
@@ -2237,44 +2237,44 @@ already exists it will be truncated.
 This option takes effect
 immediately when it is parsed in the command line
 and will supercede syslog output if
-.B \-\-daemon
+.B --daemon
 or
-.B \-\-inetd
+.B --inetd
 is also specified.
 This option is persistent over the entire course of
 an OpenVPN instantiation and will not be reset by SIGHUP,
 SIGUSR1, or
-.B \-\-ping-restart.
+.B --ping-restart.
=20
 Note that on Windows, when OpenVPN is started as a service,
 logging occurs by default without the need to specify
 this option.
 .\"*********************************************************
 .TP
-.B \-\-log-append file
+.B --log-append file
 Append logging messages to
 .B file.
 If
 .B file
 does not exist, it will be created.
 This option behaves exactly like
-.B \-\-log
+.B --log
 except that it appends to rather
 than truncating the log file.
 .\"*********************************************************
 .TP
-.B \-\-suppress-timestamps
+.B --suppress-timestamps
 Avoid writing timestamps to log messages, even when they
 otherwise would be prepended. In particular, this applies to
 log messages sent to stdout.
 .\"*********************************************************
 .TP
-.B \-\-writepid file
+.B --writepid file
 Write OpenVPN's main process ID to
 .B file.
 .\"*********************************************************
 .TP
-.B \-\-nice n
+.B --nice n
 Change process priority after initialization
 (
 .B n
@@ -2283,14 +2283,14 @@ greater than 0 is lower priority,
 less than zero is higher priority).
 .\"*********************************************************
 .\".TP
-.\".B \-\-nice-work n
+.\".B --nice-work n
 .\"Change priority of background TLS work thread.  The TLS thread
 .\"feature is enabled when OpenVPN is built
 .\"with pthread support, and you are running OpenVPN
 .\"in TLS mode (i.e. with
-.\".B \-\-tls-client
+.\".B --tls-client
 .\"or
-.\".B \-\-tls-server
+.\".B --tls-server
 .\"specified).
 .\"
 .\"Using a TLS thread offloads the CPU-intensive process of SSL/TLS-based
@@ -2300,12 +2300,12 @@ less than zero is higher priority).
 .\"The parameter
 .\".B n
 .\"is interpreted exactly as with the
-.\".B \-\-nice
+.\".B --nice
 .\"option above, but in relation to the work thread rather
 .\"than the main thread.
 .\"*********************************************************
 .TP
-.B \-\-fast-io
+.B --fast-io
 (Experimental) Optimize TUN/TAP/UDP I/O writes by avoiding
 a call to poll/epoll/select prior to the write operation.  The purpose
 of such a call would normally be to block until the device
@@ -2316,17 +2316,17 @@ by avoiding the poll/epoll/select call, improving C=
PU efficiency
 by 5% to 10%.
=20
 This option can only be used on non-Windows systems, when
-.B \-\-proto udp
+.B --proto udp
 is specified, and when
-.B \-\-shaper
+.B --shaper
 is NOT specified.
 .\"*********************************************************
 .TP
-.B \-\-multihome
+.B --multihome
 Configure a multi-homed UDP server.  This option needs to be used when
 a server has more than one IP address (e.g. multiple interfaces, or
 secondary IP addresses), and is not using
-.B \-\-local
+.B --local
 to force binding to one specific address only.  This option will
 add some extra lookups to the packet path to ensure that the UDP reply
 packets are always sent from the address that the client is
@@ -2342,7 +2342,7 @@ IPv4-mapped case (some distributions have ported this=
 to earlier kernel
 versions, though).
 .\"*********************************************************
 .TP
-.B \-\-echo [parms...]
+.B --echo [parms...]
 Echo
 .B parms
 to log output.
@@ -2351,7 +2351,7 @@ Designed to be used to send messages to a controlling=
 application
 which is receiving the OpenVPN log output.
 .\"*********************************************************
 .TP
-.B \-\-remap-usr1 signal
+.B --remap-usr1 signal
 Control whether internally or externally
 generated SIGUSR1 signals are remapped to
 SIGHUP (restart without persisting state) or
@@ -2362,20 +2362,20 @@ can be set to "SIGHUP" or "SIGTERM".  By default, n=
o remapping
 occurs.
 .\"*********************************************************
 .TP
-.B \-\-verb n
+.B --verb n
 Set output verbosity to
 .B n
 (default=3D1).  Each level shows all info from the previous levels.
 Level 3 is recommended if you want a good summary
 of what's happening without being swamped by output.
=20
-.B 0 \-\-
+.B 0 --
 No output except fatal errors.
 .br
-.B 1 to 4 \-\-
+.B 1 to 4 --
 Normal usage range.
 .br
-.B 5 \-\-
+.B 5 --
 Output
 .B R
 and
@@ -2383,12 +2383,12 @@ and
 characters to the console for each packet read and write, uppercase is
 used for TCP/UDP packets and lowercase is used for TUN/TAP packets.
 .br
-.B 6 to 11 \-\-
+.B 6 to 11 --
 Debug info range (see errlevel.h for additional
 information on debug levels).
 .\"*********************************************************
 .TP
-.B \-\-status file [n]
+.B --status file [n]
 Write operational status to
 .B file
 every
@@ -2400,21 +2400,21 @@ Status can also be written to the syslog by sending=
 a
 signal.
 .\"*********************************************************
 .TP
-.B \-\-status-version [n]
+.B --status-version [n]
 Choose the status file format version number.  Currently
 .B n
 can be 1, 2, or 3 and defaults to 1.
 .\"*********************************************************
 .TP
-.B \-\-mute n
+.B --mute n
 Log at most
 .B n
 consecutive messages in the same category.  This is useful to
 limit repetitive logging of similar message types.
 .\"*********************************************************
 .TP
-.B \-\-comp-lzo [mode]
-Use fast LZO compression \-\- may add up to 1 byte per
+.B --comp-lzo [mode]
+Use fast LZO compression -- may add up to 1 byte per
 packet for incompressible data.
 .B mode
 may be "yes", "no", or "adaptive" (default).
@@ -2424,16 +2424,16 @@ compression on or off for individual clients.
=20
 First, make sure the client-side config file enables selective
 compression by having at least one
-.B \-\-comp-lzo
+.B --comp-lzo
 directive, such as
-.B \-\-comp-lzo no.
+.B --comp-lzo no.
 This will turn off compression by default,
 but allow a future directive push from the server to
 dynamically change the
 on/off/adaptive setting.
=20
 Next in a
-.B \-\-client-config-dir
+.B --client-config-dir
 file, specify the compression setting for the client,
 for example:
=20
@@ -2452,12 +2452,12 @@ setting for the server
 side of the link, the second sets the client side.
 .\"*********************************************************
 .TP
-.B \-\-comp-noadapt
+.B --comp-noadapt
 When used in conjunction with
-.B \-\-comp-lzo,
+.B --comp-lzo,
 this option will disable OpenVPN's adaptive compression algorithm.
 Normally, adaptive compression is enabled with
-.B \-\-comp-lzo.
+.B --comp-lzo.
=20
 Adaptive compression tries to optimize the case where you have
 compression enabled, but you are sending predominantly incompressible
@@ -2469,7 +2469,7 @@ the compression efficiency will be very low, triggeri=
ng openvpn to disable
 compression for a period of time until the next re-sample test.
 .\"*********************************************************
 .TP
-.B \-\-management IP port [pw-file]
+.B --management IP port [pw-file]
 Enable a TCP server on
 .B IP:port
 to handle daemon management functions.
@@ -2488,9 +2488,9 @@ and set
 .B port
 to 'unix'.  While the default behavior is to create a unix domain socket
 that may be connected to by any process, the
-.B \-\-management-client-user
+.B --management-client-user
 and
-.B \-\-management-client-group
+.B --management-client-group
 directives can be used to restrict access.
=20
 The management interface provides a special mode where the TCP
@@ -2518,52 +2518,52 @@ be set to 127.0.0.1
 (localhost) to restrict accessibility of the management
 server to local clients.=20
 .TP
-.B \-\-management-client
+.B --management-client
 Management interface will connect as a TCP/unix domain client to
 .B IP:port
 specified by
-.B \-\-management
+.B --management
 rather than listen as a TCP server or on a unix domain socket.
=20
 If the client connection fails to connect or is disconnected,
 a SIGTERM signal will be generated causing OpenVPN to quit.
 .\"*********************************************************
 .TP
-.B \-\-management-query-passwords
+.B --management-query-passwords
 Query management channel for private key password and
-.B \-\-auth-user-pass
+.B --auth-user-pass
 username/password.  Only query the management channel
 for inputs which ordinarily would have been queried from the
 console.
 .\"*********************************************************
 .TP
-.B \-\-management-query-proxy
+.B --management-query-proxy
 Query management channel for proxy server information for a specific
-.B \-\-remote
+.B --remote
 (client-only).
 .\"*********************************************************
 .TP
-.B \-\-management-query-remote
+.B --management-query-remote
 Allow management interface to override
-.B \-\-remote
+.B --remote
 directives (client-only).
 .\"*********************************************************
-.B \-\-management-external-key
+.B --management-external-key
 Allows usage for external private key file instead of
-.B \-\-key
+.B --key
 option (client-only).
 .\"*********************************************************
 .TP
-.B \-\-management-forget-disconnect
+.B --management-forget-disconnect
 Make OpenVPN forget passwords when management session
 disconnects.
=20
 This directive does not affect the
-.B \-\-http-proxy
+.B --http-proxy
 username/password.  It is always cached.
 .\"*********************************************************
 .TP
-.B \-\-management-hold
+.B --management-hold
 Start OpenVPN in a hibernating state, until a client
 of the management interface explicitly starts it
 with the
@@ -2571,51 +2571,51 @@ with the
 command.
 .\"*********************************************************
 .TP
-.B \-\-management-signal
+.B --management-signal
 Send SIGUSR1 signal to OpenVPN if management session disconnects.
 This is useful when you wish to disconnect an OpenVPN session on
 user logoff. For --management-client this option is not needed since
 a disconnect will always generate a SIGTERM.
 .\"*********************************************************
 .TP
-.B \-\-management-log-cache n
+.B --management-log-cache n
 Cache the most recent
 .B n
 lines of log file history for usage
 by the management channel.
 .\"*********************************************************
 .TP
-.B \-\-management-up-down
+.B --management-up-down
 Report tunnel up/down events to management interface.
 .B=20
 .\"*********************************************************
 .TP
-.B \-\-management-client-auth
+.B --management-client-auth
 Gives management interface client the responsibility
 to authenticate clients after their client certificate
 has been verified.  See management-notes.txt in OpenVPN
 distribution for detailed notes.
 .\"*********************************************************
 .TP
-.B \-\-management-client-pf
+.B --management-client-pf
 Management interface clients must specify a packet
 filter file for each connecting client.  See management-notes.txt
 in OpenVPN distribution for detailed notes.
 .\"*********************************************************
 .TP
-.B \-\-management-client-user u
+.B --management-client-user u
 When the management interface is listening on a unix domain socket,
 only allow connections from user
 .B u.
 .\"*********************************************************
 .TP
-.B \-\-management-client-group g
+.B --management-client-group g
 When the management interface is listening on a unix domain socket,
 only allow connections from group
 .B g.
 .\"*********************************************************
 .TP
-.B \-\-plugin module-pathname [init-string]
+.B --plugin module-pathname [init-string]
 Load plug-in module from the file
 .B module-pathname,
 passing
@@ -2651,7 +2651,7 @@ the connection to be authenticated.
 .SS Server Mode
 Starting with OpenVPN 2.0, a multi-client TCP/UDP server mode
 is supported, and can be enabled with the
-.B \-\-mode server
+.B --mode server
 option.  In server mode, OpenVPN will listen on a single
 port for incoming client connections.  All client
 connections will be routed through a single tun or tap
@@ -2661,7 +2661,7 @@ on sufficiently fast hardware.  SSL/TLS authenticatio=
n must
 be used in this mode.
 .\"*********************************************************
 .TP
-.B \-\-server network netmask ['nopool']
+.B --server network netmask ['nopool']
 A helper directive designed to simplify the configuration
 of OpenVPN's server mode.  This directive will set up an
 OpenVPN server which will allocate addresses to clients
@@ -2671,7 +2671,7 @@ for use as the server-side endpoint of the local
 TUN/TAP interface.
=20
 For example,
-.B \-\-server 10.8.0.0 255.255.255.0
+.B --server 10.8.0.0 255.255.255.0
 expands as follows:
=20
 .nf
@@ -2704,23 +2704,23 @@ expands as follows:
 .fi
=20
 Don't use
-.B \-\-server
+.B --server
 if you are ethernet bridging.  Use
-.B \-\-server-bridge
+.B --server-bridge
 instead.
 .\"*********************************************************
 .TP
-.B \-\-server-bridge gateway netmask pool-start-IP pool-end-IP
+.B --server-bridge gateway netmask pool-start-IP pool-end-IP
 .TP
-.B \-\-server-bridge ['nogw']
+.B --server-bridge ['nogw']
=20
 A helper directive similar to
-.B \-\-server
+.B --server
 which is designed to simplify the configuration
 of OpenVPN's server mode in ethernet bridging configurations.
=20
 If
-.B \-\-server-bridge
+.B --server-bridge
 is used without any parameters, it will enable a DHCP-proxy
 mode, where connecting OpenVPN clients will receive an IP
 address for their TAP adapter from the DHCP server running
@@ -2748,7 +2748,7 @@ IP/netmask on the bridge interface.  The
 and
 .B netmask
 parameters to
-.B \-\-server-bridge
+.B --server-bridge
 can be set to either the IP/netmask of the
 bridge interface, or the IP/netmask of the
 default gateway/router on the bridged
@@ -2780,7 +2780,7 @@ push "route-gateway 10.8.0.4"
 .fi
=20
 In another example,
-.B \-\-server-bridge
+.B --server-bridge
 (without parameters) expands as follows:
=20
 .nf
@@ -2795,7 +2795,7 @@ push "route-gateway dhcp"
 .fi
=20
 Or
-.B \-\-server-bridge nogw
+.B --server-bridge nogw
 expands as follows:
=20
 .nf
@@ -2808,13 +2808,13 @@ tls-server
 .fi
 .\"*********************************************************
 .TP
-.B \-\-push "option"
+.B --push "option"
 Push a config file option back to the client for remote
 execution.  Note that
 .B
 option
 must be enclosed in double quotes ("").  The client must specify
-.B \-\-pull
+.B --pull
 in its config file.  The set of options which can be
 pushed is limited by both feasibility and security.
 Some options such as those which would execute scripts
@@ -2825,26 +2825,26 @@ cannot be pushed because the client needs to know
 them before the connection to the server can be initiated.
=20
 This is a partial list of options which can currently be pushed:
-.B \-\-route, \-\-route-gateway, \-\-route-delay, \-\-redirect-gateway,
-.B \-\-ip-win32, \-\-dhcp-option,
-.B \-\-inactive, \-\-ping, \-\-ping-exit, \-\-ping-restart,
-.B \-\-setenv,
-.B \-\-persist-key, \-\-persist-tun, \-\-echo,
-.B \-\-comp-lzo,
-.B \-\-socket-flags,
-.B \-\-sndbuf, \-\-rcvbuf
+.B --route, --route-gateway, --route-delay, --redirect-gateway,
+.B --ip-win32, --dhcp-option,
+.B --inactive, --ping, --ping-exit, --ping-restart,
+.B --setenv,
+.B --persist-key, --persist-tun, --echo,
+.B --comp-lzo,
+.B --socket-flags,
+.B --sndbuf, --rcvbuf
 .\"*********************************************************
 .TP
-.B \-\-push-reset
+.B --push-reset
 Don't inherit the global push list for a specific client instance.
 Specify this option in a client-specific context such
 as with a
-.B \-\-client-config-dir
+.B --client-config-dir
 configuration file.  This option will ignore
-.B \-\-push
+.B --push
 options at the global config file level.
 .TP
-.B \-\-push-peer-info
+.B --push-peer-info
 Push additional information about the client to server.  The additional in=
formation
 consists of the following data:
=20
@@ -2859,24 +2859,24 @@ IV_LZO_STUB=3D1 -- if client was built with LZO stu=
b capability
 UV_<name>=3D<value> -- client environment variables whose names start with=
 "UV_"
 .\"*********************************************************
 .TP
-.B \-\-disable
+.B --disable
 Disable a particular client (based on the common name)
 from connecting.  Don't use this option to disable a client
 due to key or password compromise.  Use a CRL (certificate
 revocation list) instead (see the
-.B \-\-crl-verify
+.B --crl-verify
 option).
=20
 This option must be associated with a specific client instance,
 which means that it must be specified either in a client
 instance config file using
-.B \-\-client-config-dir
+.B --client-config-dir
 or dynamically generated using a
-.B \-\-client-connect
+.B --client-connect
 script.
 .\"*********************************************************
 .TP
-.B \-\-ifconfig-pool start-IP end-IP [netmask]
+.B --ifconfig-pool start-IP end-IP [netmask]
 Set aside a pool of subnets to be
 dynamically allocated to connecting clients, similar
 to a DHCP server.  For tun-style
@@ -2889,7 +2889,7 @@ parameter will also be pushed to clients.
=20
 .\"*********************************************************
 .TP
-.B \-\-ifconfig-pool-persist file [seconds]
+.B --ifconfig-pool-persist file [seconds]
 Persist/unpersist ifconfig-pool
 data to
 .B file,
@@ -2904,7 +2904,7 @@ IP address assigned to them from the ifconfig-pool.
 Maintaining a long-term
 association is good for clients because it allows them
 to effectively use the
-.B \-\-persist-tun
+.B --persist-tun
 option.
=20
 .B file
@@ -2925,32 +2925,32 @@ suggestions only, based on past associations between
 a common name and IP address.  They do not guarantee that the given common
 name will always receive the given IP address.  If you want guaranteed
 assignment, use
-.B \-\-ifconfig-push
+.B --ifconfig-push
 .\"*********************************************************
 .TP
-.B \-\-ifconfig-pool-linear
+.B --ifconfig-pool-linear
 Modifies the
-.B \-\-ifconfig-pool
+.B --ifconfig-pool
 directive to
 allocate individual TUN interface addresses for
 clients rather than /30 subnets.  NOTE:  This option
 is incompatible with Windows clients.
=20
 This option is deprecated, and should be replaced with
-.B \-\-topology p2p
+.B --topology p2p
 which is functionally equivalent.
 .\"*********************************************************
 .TP
-.B \-\-ifconfig-push local remote-netmask [alias]
+.B --ifconfig-push local remote-netmask [alias]
 Push virtual IP endpoints for client tunnel,
-overriding the \-\-ifconfig-pool dynamic allocation.
+overriding the --ifconfig-pool dynamic allocation.
=20
 The parameters
 .B local
 and
 .B remote-netmask
 are set according to the
-.B \-\-ifconfig
+.B --ifconfig
 directive which you want to execute on the client machine to
 configure the remote end of the tunnel.  Note that the parameters
 .B local
@@ -2972,13 +2972,13 @@ will refer to the client view.
 This option must be associated with a specific client instance,
 which means that it must be specified either in a client
 instance config file using
-.B \-\-client-config-dir
+.B --client-config-dir
 or dynamically generated using a
-.B \-\-client-connect
+.B --client-connect
 script.
=20
 Remember also to include a
-.B \-\-route
+.B --route
 directive in the main OpenVPN config file which encloses
 .B local,
 so that the kernel will know to route it
@@ -2988,23 +2988,23 @@ OpenVPN's internal client IP address selection algo=
rithm works as
 follows:
=20
 .B 1
-\-\- Use
-.B \-\-client-connect script
+-- Use
+.B --client-connect script
 generated file for static IP (first choice).
 .br
 .B 2
-\-\- Use
-.B \-\-client-config-dir
+-- Use
+.B --client-config-dir
 file for static IP (next choice).
 .br
 .B 3
-\-\- Use
-.B \-\-ifconfig-pool
+-- Use
+.B --ifconfig-pool
 allocation for dynamic IP (last choice).
 .br
 .\"*********************************************************
 .TP
-.B \-\-iroute network [netmask]
+.B --iroute network [netmask]
 Generate an internal route to a specific
 client. The
 .B netmask
@@ -3015,36 +3015,36 @@ the server to a particular client, regardless
 of where the client is connecting from.  Remember
 that you must also add the route to the system
 routing table as well (such as by using the
-.B \-\-route
+.B --route
 directive).  The reason why two routes are needed
 is that the
-.B \-\-route
+.B --route
 directive routes the packet from the kernel
 to OpenVPN.  Once in OpenVPN, the
-.B \-\-iroute
+.B --iroute
 directive routes to the specific client.
=20
 This option must be specified either in a client
 instance config file using
-.B \-\-client-config-dir
+.B --client-config-dir
 or dynamically generated using a
-.B \-\-client-connect
+.B --client-connect
 script.
=20
 The
-.B \-\-iroute
+.B --iroute
 directive also has an important interaction with
-.B \-\-push
+.B --push
 "route ...".
-.B \-\-iroute
+.B --iroute
 essentially defines a subnet which is owned by a
 particular client (we will call this client A).
 If you would like other clients to be able to reach A's
 subnet, you can use
-.B \-\-push
+.B --push
 "route ..."
 together with
-.B \-\-client-to-client
+.B --client-to-client
 to effect this.  In order for all clients to see
 A's subnet, OpenVPN must push this route to all clients
 EXCEPT for A, since the subnet is already owned by A.
@@ -3053,11 +3053,11 @@ not pushing a route to a client
 if it matches one of the client's iroutes.
 .\"*********************************************************
 .TP
-.B \-\-client-to-client
+.B --client-to-client
 Because the OpenVPN server mode handles multiple clients
 through a single tun or tap interface, it is effectively
 a router.  The
-.B \-\-client-to-client
+.B --client-to-client
 flag tells OpenVPN to internally route client-to-client
 traffic rather than pushing all client-originating traffic
 to the TUN/TAP interface.
@@ -3069,13 +3069,13 @@ if you want to firewall tunnel traffic using
 custom, per-client rules.
 .\"*********************************************************
 .TP
-.B \-\-duplicate-cn
+.B --duplicate-cn
 Allow multiple clients with the same common name to concurrently connect.
 In the absence of this option, OpenVPN will disconnect a client instance
 upon connection of a new client having the same common name.
 .\"*********************************************************
 .TP
-.B \-\-client-connect cmd
+.B --client-connect cmd
 Run
 .B command cmd
 on client connection.
@@ -3100,7 +3100,7 @@ to be applied on the server when the client connects,
 it should write it to the file named by the last argument.
=20
 See the
-.B \-\-client-config-dir
+.B --client-config-dir
 option below for options which
 can be legally used in a dynamically generated config file.
=20
@@ -3112,18 +3112,18 @@ returns a non-zero error status, it will cause the =
client
 to be disconnected.
 .\"*********************************************************
 .TP
-.B \-\-client-disconnect cmd
+.B --client-disconnect cmd
 Like
-.B \-\-client-connect
+.B --client-connect
 but called on client instance shutdown.  Will not be called
 unless the
-.B \-\-client-connect
+.B --client-connect
 script and plugins (if defined)
 were previously called on this instance with
 successful (0) status returns.
=20
 The exception to this rule is if the
-.B \-\-client-disconnect
+.B --client-disconnect
 command or plugins are cascaded, and at least one client-connect
 function succeeded, then ALL of the client-disconnect functions for
 scripts and plugins will be called on client instance object deletion,
@@ -3131,16 +3131,16 @@ even in cases where some of the related client-conn=
ect functions returned
 an error status.
=20
 The
-.B \-\-client-disconnect
+.B --client-disconnect
 command is passed the same pathname as the corresponding
-.B \-\-client-connect
+.B --client-connect
 command as its last argument. (after any arguments specified in
 .B cmd
 ).
 .B=20
 .\"*********************************************************
 .TP
-.B \-\-client-config-dir dir
+.B --client-config-dir dir
 Specify a directory
 .B dir
 for custom client config files.  After
@@ -3156,9 +3156,9 @@ after it has dropped it's root privileges.
=20
 This file can specify a fixed IP address for a given
 client using
-.B \-\-ifconfig-push,
+.B --ifconfig-push,
 as well as fixed subnets owned by the client using
-.B \-\-iroute.
+.B --iroute.
=20
 One of the useful properties of this option is that it
 allows client configuration files to be conveniently
@@ -3167,19 +3167,19 @@ without needing to restart the server.
=20
 The following
 options are legal in a client-specific context:
-.B \-\-push, \-\-push-reset, \-\-iroute, \-\-ifconfig-push,
+.B --push, --push-reset, --iroute, --ifconfig-push,
 and
-.B \-\-config.
+.B --config.
 .\"*********************************************************
 .TP
-.B \-\-ccd-exclusive
+.B --ccd-exclusive
 Require, as a
 condition of authentication, that a connecting client has a
-.B \-\-client-config-dir
+.B --client-config-dir
 file.
 .\"*********************************************************
 .TP
-.B \-\-tmp-dir dir
+.B --tmp-dir dir
 Specify a directory
 .B dir
 for temporary files.  This directory will be used by
@@ -3191,7 +3191,7 @@ after it has dropped it's root privileges.
 This directory will be used by in the following cases:
=20
 *
-.B \-\-client-connect
+.B --client-connect
 scripts to dynamically generate client-specific
 configuration files.
=20
@@ -3205,7 +3205,7 @@ when using deferred auth method
 plugin hook to pass filtering rules via pf_file
 .\"*********************************************************
 .TP
-.B \-\-hash-size r v
+.B --hash-size r v
 Set the size of the real address hash table to
 .B r
 and the virtual address table to
@@ -3213,13 +3213,13 @@ and the virtual address table to
 By default, both tables are sized at 256 buckets.
 .\"*********************************************************
 .TP
-.B \-\-bcast-buffers n
+.B --bcast-buffers n
 Allocate
 .B n
 buffers for broadcast datagrams (default=3D256).
 .\"*********************************************************
 .TP
-.B \-\-tcp-queue-limit n
+.B --tcp-queue-limit n
 Maximum number of output packets queued before TCP (default=3D64).
=20
 When OpenVPN is tunneling data from a TUN/TAP device to a
@@ -3231,7 +3231,7 @@ OpenVPN will start to drop outgoing packets directed
 at this client.
 .\"*********************************************************
 .TP
-.B \-\-tcp-nodelay
+.B --tcp-nodelay
 This macro sets the TCP_NODELAY socket flag on the server
 as well as pushes it to connecting clients.  The TCP_NODELAY
 flag disables the Nagle algorithm on TCP sockets causing
@@ -3254,13 +3254,13 @@ The macro expands as follows:
 .fi
 .\"*********************************************************
 .TP
-.B \-\-max-clients n
+.B --max-clients n
 Limit server to a maximum of
 .B n
 concurrent clients.
 .\"*********************************************************
 .TP
-.B \-\-max-routes-per-client n
+.B --max-routes-per-client n
 Allow a maximum of
 .B n
 internal routes per client (default=3D256).
@@ -3270,9 +3270,9 @@ server with packets appearing to come from many uniqu=
e MAC addresses,
 forcing the server to deplete
 virtual memory as its internal routing table expands.
 This directive can be used in a
-.B \-\-client-config-dir
+.B --client-config-dir
 file or auto-generated by a
-.B \-\-client-connect
+.B --client-connect
 script to override the global value for a particular client.
=20
 Note that this
@@ -3280,7 +3280,7 @@ directive affects OpenVPN's internal routing table, n=
ot the
 kernel routing table.
 .\"*********************************************************
 .TP
-.B \-\-stale-routes-check n [t]
+.B --stale-routes-check n [t]
 Remove routes haven't had activity for
 .B n
 seconds (i.e. the ageing time).
@@ -3296,10 +3296,10 @@ is not present it defaults to
=20
 This option helps to keep the dynamic routing table small.
 See also
-.B \-\-max-routes-per-client
+.B --max-routes-per-client
 .\"*********************************************************
 .TP
-.B \-\-connect-freq n sec
+.B --connect-freq n sec
 Allow a maximum of
 .B n
 new connections per
@@ -3313,12 +3313,12 @@ DoS scenario, legitimate connections might also be =
refused.
=20
 For the best protection against DoS attacks in server mode,
 use
-.B \-\-proto udp
+.B --proto udp
 and
-.B \-\-tls-auth.
+.B --tls-auth.
 .\"*********************************************************
 .TP
-.B \-\-learn-address cmd
+.B --learn-address cmd
 Run command
 .B cmd
 to validate client virtual addresses or routes.
@@ -3332,19 +3332,19 @@ Three arguments will be appended to any arguments in
 .B cmd
 as follows:
=20
-.B [1] operation \-\-
+.B [1] operation --
 "add", "update", or "delete" based on whether or not
 the address is being added to, modified, or deleted from
 OpenVPN's internal routing table.
 .br
-.B [2] address \-\-
+.B [2] address --
 The address being learned or unlearned.  This can be
 an IPv4 address such as "198.162.10.14", an IPv4 subnet
 such as "198.162.10.0/24", or an ethernet MAC address (when
-.B \-\-dev tap
+.B --dev tap
 is being used) such as "00:FF:01:02:03:04".
 .br
-.B [3] common name \-\-
+.B [3] common name --
 The common name on the certificate associated with the
 client linked to this address.  Only present for "add"
 or "update" operations, not "delete".
@@ -3364,7 +3364,7 @@ policies with regard to the client's high-level commo=
n name,
 rather than the low level client virtual addresses.
 .\"*********************************************************
 .TP
-.B \-\-auth-user-pass-verify cmd method
+.B --auth-user-pass-verify cmd method
 Require the client to provide a username/password (possibly
 in addition to a client certificate) for authentication.
=20
@@ -3400,10 +3400,10 @@ will be passed as an argument to
 and the file will be automatically deleted by OpenVPN after
 the script returns.  The location of the temporary file is
 controlled by the
-.B \-\-tmp-dir
+.B --tmp-dir
 option, and will default to the current directory if unspecified.
 For security, consider setting=20
-.B \-\-tmp-dir
+.B --tmp-dir
 to a volatile storage medium such as
 .B /dev/shm
 (if available) to prevent the username/password file from touching the har=
d drive.
@@ -3435,7 +3435,7 @@ For a sample script that performs PAM authentication,=
 see
 in the OpenVPN source distribution.
 .\"*********************************************************
 .TP
-.B \-\-opt-verify
+.B --opt-verify
 Clients that connect with options that are incompatible
 with those of the server will be disconnected.
=20
@@ -3445,16 +3445,16 @@ comp-lzo, fragment, keydir, cipher, auth, keysize, =
secret,
 no-replay, no-iv, tls-auth, key-method, tls-server, and tls-client.
=20
 This option requires that
-.B \-\-disable-occ
+.B --disable-occ
 NOT be used.
 .\"*********************************************************
 .TP
-.B \-\-auth-user-pass-optional
+.B --auth-user-pass-optional
 Allow connections by clients that do not specify a username/password.
 Normally, when
-.B \-\-auth-user-pass-verify
+.B --auth-user-pass-verify
 or
-.B \-\-management-client-auth
+.B --management-client-auth
 is specified (or an authentication plugin module), the
 OpenVPN server daemon will require connecting clients to specify a
 username and password.  This option makes the submission of a username/pas=
sword
@@ -3467,35 +3467,35 @@ to empty strings ("").  The authentication module/s=
cript MUST have logic
 to detect this condition and respond accordingly.
 .\"*********************************************************
 .TP
-.B \-\-client-cert-not-required
+.B --client-cert-not-required
 Don't require client certificate, client will authenticate
 using username/password only.  Be aware that using this directive
 is less secure than requiring certificates from all clients.
=20
 If you use this directive, the
 entire responsibility of authentication will rest on your
-.B \-\-auth-user-pass-verify
+.B --auth-user-pass-verify
 script, so keep in mind that bugs in your script
 could potentially compromise the security of your VPN.
=20
 If you don't use this directive, but you also specify an
-.B \-\-auth-user-pass-verify
+.B --auth-user-pass-verify
 script, then OpenVPN will perform double authentication.  The
 client certificate verification AND the
-.B \-\-auth-user-pass-verify
+.B --auth-user-pass-verify
 script will need to succeed in order for a client to be
 authenticated and accepted onto the VPN.
 .\"*********************************************************
 .TP
-.B \-\-username-as-common-name
+.B --username-as-common-name
 For
-.B \-\-auth-user-pass-verify
+.B --auth-user-pass-verify
 authentication, use
 the authenticated username as the common name,
 rather than the common name from the client cert.
 .\"*********************************************************
 .TP
-.B \-\-compat\-names [no\-remapping] (DEPRECATED)
+.B --compat-names [no-remapping] (DEPRECATED)
 Until OpenVPN v2.3 the format of the X.509 Subject fields was formatted
 like this:
 .IP
@@ -3509,7 +3509,7 @@ underscore ('_').  The X.509 Subject string as return=
ed by the
 environmental variable, could additionally contain colon (':') or equal ('=
=3D').
 .IP
 When using the
-.B \-\-compat\-names
+.B --compat-names
 option, this old formatting and remapping will be re-enabled again.  This =
is
 purely implemented for compatibility reasons when using older plug-ins or
 scripts which does not handle the new formatting or UTF-8 characters.
@@ -3521,17 +3521,17 @@ standardised format.  It now looks like:
 C=3DUS, L=3DSomewhere, CN=3DJohn Doe, emailAddress=3Djohn@...1113...
 .IP
 The new default format in OpenVPN v2.3 also does not do the character rema=
pping
-which happened earlier.  This new format enables proper support for UTF\-8
+which happened earlier.  This new format enables proper support for UTF-8
 characters in the usernames, X.509 Subject fields and Common Name variable=
s and
-it complies to the RFC 2253, UTF\-8 String Representation of Distinguished
+it complies to the RFC 2253, UTF-8 String Representation of Distinguished
 Names.
=20
 The
-.B no\-remapping
+.B no-remapping
 mode flag can be used with the
 .B
-\-\-compat\-names
-option to be compatible with the now deprecated \-\-no\-name\-remapping op=
tion.
+--compat-names
+option to be compatible with the now deprecated --no-name-remapping option.
 It is only available at the server. When this mode flag is used, the Commo=
n Name,
 Subject, and username strings are allowed to include any printable charact=
er
 including space, but excluding control characters such as tab, newline, and
@@ -3541,30 +3541,30 @@ carriage-return. no-remapping is only available on =
the server side.
 This option is immediately deprecated.  It is only implemented
 to make the transition to the new formatting less intrusive.  It will be
 removed either in OpenVPN v2.4 or v2.5.  So please make sure you use the
-.B \-\-verify-x509-name
+.B --verify-x509-name
 option instead of
-.B \-\-tls-remote
+.B --tls-remote
 as soon as possible and update your scripts where necessary.
 .\"*********************************************************
 .TP
-.B \-\-no\-name\-remapping (DEPRECATED)
+.B --no-name-remapping (DEPRECATED)
 The
-.B \-\-no\-name\-remapping
+.B --no-name-remapping
 option is an alias for
-.B \-\-compat\-names\ no\-remapping.
+.B --compat-names\ no-remapping.
 It ensures compatibility with server configurations using the
-.B \-\-no\-name\-remapping
+.B --no-name-remapping
 option.
=20
 .B Please note:
 This option is now deprecated.  It will be removed either in OpenVPN v2.4
 or v2.5.  So please make sure you support the new X.509 name formatting
 described with the
-.B \-\-compat\-names
+.B --compat-names
 option as soon as possible.
 .\"*********************************************************
 .TP
-.B \-\-port-share host port [dir]
+.B --port-share host port [dir]
 When run in TCP server mode, share the OpenVPN port with
 another application, such as an HTTPS server.  If OpenVPN
 senses a connection to its port which is using a non-OpenVPN
@@ -3589,13 +3589,13 @@ Not implemented on Windows.
 .SS Client Mode
 Use client mode when connecting to an OpenVPN server
 which has
-.B \-\-server, \-\-server-bridge,
+.B --server, --server-bridge,
 or
-.B \-\-mode server
+.B --mode server
 in it's configuration.
 .\"*********************************************************
 .TP
-.B \-\-client
+.B --client
 A helper directive designed to simplify the configuration
 of OpenVPN's client mode.  This directive is equivalent to:
=20
@@ -3609,33 +3609,33 @@ of OpenVPN's client mode.  This directive is equiva=
lent to:
 .fi
 .\"*********************************************************
 .TP
-.B \-\-pull
+.B --pull
 This option must be used on a client which is connecting
 to a multi-client server.  It indicates to OpenVPN that it
 should accept options pushed by the server, provided they
 are part of the legal set of pushable options (note that the
-.B \-\-pull
+.B --pull
 option is implied by
-.B \-\-client
+.B --client
 ).
=20
 In particular,
-.B \-\-pull
+.B --pull
 allows the server to push routes to the client, so you should
 not use
-.B \-\-pull
+.B --pull
 or
-.B \-\-client
+.B --client
 in situations where you don't trust the server to have control
 over the client's routing table.
 .\"*********************************************************
 .TP
-.B \-\-auth-user-pass [up]
+.B --auth-user-pass [up]
 Authenticate with server using username/password.
 .B up
 is a file containing username/password on 2 lines (Note: OpenVPN
 will only read passwords from a file if it has been built
-with the \-\-enable-password-save configure option, or on Windows
+with the --enable-password-save configure option, or on Windows
 by defining ENABLE_PASSWORD_SAVE in win/settings.in).
=20
 If
@@ -3644,12 +3644,12 @@ is omitted, username/password will be prompted from=
 the
 console.
=20
 The server configuration must specify an
-.B \-\-auth-user-pass-verify
+.B --auth-user-pass-verify
 script to verify the username/password provided by
 the client.
 .\"*********************************************************
 .TP
-.B \-\-auth-retry type
+.B --auth-retry type
 Controls how OpenVPN responds to username/password verification
 errors such as the client-side response to an AUTH_FAILED message from the=
 server
 or verification failure of the private key password.
@@ -3660,33 +3660,33 @@ of error.
=20
 An AUTH_FAILED message is generated by the server if the client
 fails
-.B \-\-auth-user-pass
+.B --auth-user-pass
 authentication, or if the server-side
-.B \-\-client-connect
+.B --client-connect
 script returns an error status when the client
 tries to connect.
=20
 .B type
 can be one of:
=20
-.B none \-\-
+.B none --
 Client will exit with a fatal error (this is the default).
 .br
-.B nointeract \-\-
+.B nointeract --
 Client will retry the connection without requerying for an
-.B \-\-auth-user-pass
+.B --auth-user-pass
 username/password.  Use this option for unattended clients.
 .br
-.B interact \-\-
+.B interact --
 Client will requery for an
-.B \-\-auth-user-pass
+.B --auth-user-pass
 username/password and/or private key password before attempting a reconnec=
tion.
=20
 Note that while this option cannot be pushed, it can be controlled
 from the management interface.
 .\"*********************************************************
 .TP
-.B \-\-static\-challenge t e
+.B --static-challenge t e
 Enable static challenge/response protocol using challenge text
 .B t,
 with
@@ -3697,18 +3697,18 @@ echo flag given by
 The echo flag indicates whether or not the user's response
 to the challenge should be echoed.
=20
-See management\-notes.txt in the OpenVPN distribution for a
+See management-notes.txt in the OpenVPN distribution for a
 description of the OpenVPN challenge/response protocol.
 .\"*********************************************************
 .TP
-.B \-\-server-poll-timeout n
+.B --server-poll-timeout n
 when polling possible remote servers to connect to
 in a round-robin fashion, spend no more than
 .B n
 seconds waiting for a response before trying the next server.
 .\"*********************************************************
 .TP
-.B \-\-explicit-exit-notify [n]
+.B --explicit-exit-notify [n]
 In UDP client mode or point-to-point mode, send server/peer an exit notifi=
cation
 if tunnel is restarted or OpenVPN process is exited.  In client mode, on
 exit/restart, this
@@ -3724,12 +3724,12 @@ These options are meaningful for both Static & TLS-=
negotiated key modes
 (must be compatible between peers).
 .\"*********************************************************
 .TP
-.B \-\-secret file [direction]
+.B --secret file [direction]
 Enable Static Key encryption mode (non-TLS).
 Use pre-shared secret
 .B file
 which was generated with
-.B \-\-genkey.
+.B --genkey.
=20
 The optional
 .B direction
@@ -3760,7 +3760,7 @@ supports the
 .B direction
 parameter, will also support 2048 bit key file generation
 using the
-.B \-\-genkey
+.B --genkey
 option.
=20
 Static key encryption mode has certain advantages,
@@ -3790,15 +3790,15 @@ would see nothing
 but random-looking data.
 .\"*********************************************************
 .TP
-.B \-\-key-direction
+.B --key-direction
 Alternative way of specifying the optional direction parameter for the
-.B \-\-tls-auth
+.B --tls-auth
 and
-.B \-\-secret
+.B --secret
 options. Useful when using inline files (See section on inline files).
 .\"*********************************************************
 .TP
-.B \-\-auth alg
+.B --auth alg
 Authenticate packets with HMAC using message
 digest algorithm
 .B alg.
@@ -3813,7 +3813,7 @@ OpenVPN's usage of HMAC is to first encrypt a packet,=
 then HMAC the resulting ci
=20
 In static-key encryption mode, the HMAC key
 is included in the key file generated by
-.B \-\-genkey.
+.B --genkey.
 In TLS mode, the HMAC key is dynamically generated and shared
 between peers via the TLS control channel.  If OpenVPN receives a packet w=
ith
 a bad HMAC it will drop the packet.
@@ -3826,7 +3826,7 @@ For more information on HMAC see
 .I http://www.cs.ucsd.edu/users/mihir/papers/hmac.html
 .\"*********************************************************
 .TP
-.B \-\-cipher alg
+.B --cipher alg
 Encrypt packets with cipher algorithm
 .B alg.
 The default is
@@ -3841,7 +3841,7 @@ For more information on blowfish, see
=20
 To see other ciphers that are available with
 OpenVPN, use the
-.B \-\-show-ciphers
+.B --show-ciphers
 option.
=20
 OpenVPN supports the CBC, CFB, and OFB cipher modes,
@@ -3853,10 +3853,10 @@ Set
 to disable encryption.
 .\"*********************************************************
 .TP
-.B \-\-keysize n
+.B --keysize n
 Size of cipher key in bits (optional).
 If unspecified, defaults to cipher-specific default.  The
-.B \-\-show-ciphers
+.B --show-ciphers
 option (see below) shows all available OpenSSL ciphers,
 their default key sizes, and whether the key size can
 be changed.  Use care in changing a cipher's default
@@ -3866,7 +3866,7 @@ larger key may offer no real guarantee of greater
 security, or may even reduce security.
 .\"*********************************************************
 .TP
-.B \-\-prng alg [nsl]
+.B --prng alg [nsl]
 (Advanced) For PRNG (Pseudo-random number generator),
 use digest algorithm
 .B alg
@@ -3881,19 +3881,19 @@ to disable the PRNG and use the OpenSSL RAND_bytes =
function
 instead for all of OpenVPN's pseudo-random number needs.
 .\"*********************************************************
 .TP
-.B \-\-engine [engine-name]
+.B --engine [engine-name]
 Enable OpenSSL hardware-based crypto engine functionality.
=20
 If
 .B engine-name
 is specified,
 use a specific crypto engine.  Use the
-.B \-\-show-engines
+.B --show-engines
 standalone option to list the crypto engines which are
 supported by OpenSSL.
 .\"*********************************************************
 .TP
-.B \-\-no-replay
+.B --no-replay
 (Advanced) Disable OpenVPN's protection against replay attacks.
 Don't use this option unless you are prepared to make
 a tradeoff of greater efficiency in exchange for less
@@ -3937,7 +3937,7 @@ algorithm used
 by IPSec.
 .\"*********************************************************
 .TP
-.B \-\-replay-window n [t]
+.B --replay-window n [t]
 Use a replay protection sliding-window of size
 .B n
 and a time window of
@@ -3952,9 +3952,9 @@ is 15 seconds.
=20
 This option is only relevant in UDP mode, i.e.
 when either
-.B \-\-proto udp
+.B --proto udp
 is specifed, or no
-.B \-\-proto
+.B --proto
 option is specified.
=20
 When OpenVPN tunnels IP packets over UDP, there is the possibility that
@@ -3966,7 +3966,7 @@ the TCP/IP protocol stack, provided they satisfy seve=
ral constraints.
=20
 .B (a)
 The packet cannot be a replay (unless
-.B \-\-no-replay
+.B --no-replay
 is specified, which disables replay protection altogether).
=20
 .B (b)
@@ -3988,7 +3988,7 @@ a larger value for
 Satellite links in particular often require this.
=20
 If you run OpenVPN at
-.B \-\-verb 4,
+.B --verb 4,
 you will see the message "Replay-window backtrack occurred [x]"
 every time the maximum sequence number backtrack seen thus far
 increases.  This can be used to calibrate
@@ -4024,7 +4024,7 @@ parameters of what is to be expected from the physica=
l IP layer.  The problem
 is easily fixed by simply using TCP as the VPN transport layer.
 .\"*********************************************************
 .TP
-.B \-\-mute-replay-warnings
+.B --mute-replay-warnings
 Silence the output of replay warnings, which are a common
 false alarm on WiFi networks.  This option preserves
 the security of the replay protection code without
@@ -4032,7 +4032,7 @@ the verbosity associated with warnings about duplicate
 packets.
 .\"*********************************************************
 .TP
-.B \-\-replay-persist file
+.B --replay-persist file
 Persist replay-protection state across sessions using
 .B file
 to save and reload the state.
@@ -4040,7 +4040,7 @@ to save and reload the state.
 This option will strengthen protection against replay attacks,
 especially when you are using OpenVPN in a dynamic context (such
 as with
-.B \-\-inetd)
+.B --inetd)
 when OpenVPN sessions are frequently started and stopped.=20
=20
 This option will keep a disk copy of the current replay protection
@@ -4051,12 +4051,12 @@ which were already received by the prior session.
=20
 This option only makes sense when replay protection is enabled
 (the default) and you are using either
-.B \-\-secret
+.B --secret
 (shared-secret key mode) or TLS mode with
-.B \-\-tls-auth.
+.B --tls-auth.
 .\"*********************************************************
 .TP
-.B \-\-no-iv
+.B --no-iv
 (Advanced) Disable OpenVPN's use of IV (cipher initialization vector).
 Don't use this option unless you are prepared to make
 a tradeoff of greater efficiency in exchange for less
@@ -4077,7 +4077,7 @@ space-saving optimization that uses the unique identi=
fier for
 datagram replay protection as the IV.
 .\"*********************************************************
 .TP
-.B \-\-use-prediction-resistance
+.B --use-prediction-resistance
 Enable prediction resistance on PolarSSL's RNG.
=20
 Enabling prediction resistance causes the RNG to reseed in each
@@ -4091,24 +4091,24 @@ Note that this option only works with PolarSSL vers=
ions greater
 than 1.1.
 .\"*********************************************************
 .TP
-.B \-\-test-crypto
+.B --test-crypto
 Do a self-test of OpenVPN's crypto options by encrypting and
 decrypting test packets using the data channel encryption options
 specified above.  This option does not require a peer to function,
 and therefore can be specified without
-.B \-\-dev
+.B --dev
 or
-.B \-\-remote.
+.B --remote.
=20
 The typical usage of
-.B \-\-test-crypto
+.B --test-crypto
 would be something like this:
=20
-.B openvpn \-\-test-crypto \-\-secret key
+.B openvpn --test-crypto --secret key
=20
 or
=20
-.B openvpn \-\-test-crypto \-\-secret key \-\-verb 9
+.B openvpn --test-crypto --secret key --verb 9
=20
 This option is very useful to test OpenVPN after it has been ported to
 a new platform, or to isolate problems in the compiler, OpenSSL
@@ -4132,17 +4132,17 @@ including certificate-based authentication and Diff=
ie Hellman forward secrecy.
=20
 To use TLS mode, each peer that runs OpenVPN should have its own local
 certificate/key pair (
-.B \-\-cert
+.B --cert
 and
-.B \-\-key
+.B --key
 ), signed by the root certificate which is specified
 in
-.B \-\-ca.
+.B --ca.
=20
 When two OpenVPN peers connect, each presents its local certificate to the
 other.  Each peer will then check that its partner peer presented a
 certificate which was signed by the master root certificate as specified in
-.B \-\-ca.
+.B --ca.
=20
 If that check on both peers succeeds, then the TLS negotiation
 will succeed, both OpenVPN
@@ -4159,18 +4159,18 @@ The easy-rsa package is also rendered in web form h=
ere:
 .I http://openvpn.net/easyrsa.html
 .\"*********************************************************
 .TP
-.B \-\-tls-server
+.B --tls-server
 Enable TLS and assume server role during TLS handshake.  Note that
 OpenVPN is designed as a peer-to-peer application.  The designation
 of client or server is only for the purpose of negotiating the TLS
 control channel.
 .\"*********************************************************
 .TP
-.B \-\-tls-client
+.B --tls-client
 Enable TLS and assume client role during TLS handshake.
 .\"*********************************************************
 .TP
-.B \-\-ca file
+.B --ca file
 Certificate authority (CA) file in .pem format, also referred to as the
 .I root
 certificate.  This file can have multiple
@@ -4192,16 +4192,16 @@ production environment, since by virtue of the fact=
 that
 they are distributed with OpenVPN, they are totally insecure.
 .\"*********************************************************
 .TP
-.B \-\-capath dir
+.B --capath dir
 Directory containing trusted certificates (CAs and CRLs).
 Available with OpenSSL version >=3D 0.9.7 dev.
 Not available with PolarSSL.
 .\"*********************************************************
 .TP
-.B \-\-dh file
+.B --dh file
 File containing Diffie Hellman parameters
 in .pem format (required for
-.B \-\-tls-server
+.B --tls-server
 only). Use
=20
 .B openssl dhparam -out dh1024.pem 1024
@@ -4211,15 +4211,15 @@ included with the OpenVPN distribution.  Diffie Hel=
lman parameters
 may be considered public.
 .\"*********************************************************
 .TP
-.B \-\-cert file
-Local peer's signed certificate in .pem format \-\- must be signed
+.B --cert file
+Local peer's signed certificate in .pem format -- must be signed
 by a certificate authority whose certificate is in
-.B \-\-ca file.
+.B --ca file.
 Each peer in an OpenVPN link running in TLS mode should have its own
 certificate and private key file.  In addition, each certificate should
 have been signed by the key of a certificate
 authority whose public key resides in the
-.B \-\-ca
+.B --ca
 certificate authority file.
 You can easily make your own certificate authority (see above) or pay money
 to use a commercial service such as thawte.com (in which case you will be
@@ -4244,7 +4244,7 @@ Note that the
 command reads the location of the certificate authority key from its
 configuration file such as
 .B /usr/share/ssl/openssl.cnf
-\-\- note also
+-- note also
 that for certificate authority functions, you must set up the files
 .B index.txt
 (may be empty) and
@@ -4255,7 +4255,7 @@ that for certificate authority functions, you must se=
t up the files
 ).
 .\"*********************************************************
 .TP
-.B \-\-extra-certs file
+.B --extra-certs file
 Specify a
 .B file
 containing one or more PEM certs (concatenated together)
@@ -4271,14 +4271,14 @@ certificate, as would be the case if the certs were=
 placed in the
 file.
 .\"*********************************************************
 .TP
-.B \-\-key file
+.B --key file
 Local peer's private key in .pem format.  Use the private key which was ge=
nerated
 when you built your peer's certificate (see
 .B -cert file
 above).
 .\"*********************************************************
 .TP
-.B \-\-tls-version-min version ['or-highest']
+.B --tls-version-min version ['or-highest']
 Enable TLS version negotiation, and set the minimum
 TLS version we will accept from the peer (default is "1.0").
 Examples for version
@@ -4293,22 +4293,22 @@ out that TLS version negotiation can lead to handsh=
ake problems due
 to new signature algorithms in TLS 1.2.
 .\"*********************************************************
 .TP
-.B \-\-tls-version-max version
+.B --tls-version-max version
 Set the maximum TLS version we will use (default is the highest version
 supported).  Examples for version include "1.0", "1.1", or "1.2".
 .\"*********************************************************
 .TP
-.B \-\-pkcs12 file
+.B --pkcs12 file
 Specify a PKCS #12 file containing local private key,
 local certificate, and root CA certificate.
 This option can be used instead of
-.B \-\-ca, \-\-cert,
+.B --ca, --cert,
 and
-.B \-\-key.
+.B --key.
 Not available with PolarSSL.
 .\"*********************************************************
 .TP
-.B \-\-verify-hash hash
+.B --verify-hash hash
 Specify SHA1 fingerprint for level-1 cert.  The level-1 cert is the
 CA (or intermediate cert) that signs the leaf certificate, and is
 one removed from the leaf certificate in the direction of the root.
@@ -4319,84 +4319,84 @@ or certificate verification will fail.  Hash is spe=
cified
 as XX:XX:...  For example: AD:B0:95:D8:09:C8:36:45:12:A9:89:C8:90:09:CB:13=
:72:A6:AD:16
 .\"*********************************************************
 .TP
-.B \-\-pkcs11-cert-private [0|1]...
+.B --pkcs11-cert-private [0|1]...
 Set if access to certificate object should be performed after login.
 Every provider has its own setting.
 .\"*********************************************************
 .TP
-.B \-\-pkcs11-id name
+.B --pkcs11-id name
 Specify the serialized certificate id to be used. The id can be gotten
 by the standalone
-.B \-\-show-pkcs11-ids
+.B --show-pkcs11-ids
 option.
 .\"*********************************************************
 .TP
-.B \-\-pkcs11-id-management
+.B --pkcs11-id-management
 Acquire PKCS#11 id from management interface. In this case a NEED-STR 'pkc=
s11-id-request'
 real-time message will be triggered, application may use pkcs11-id-count c=
ommand to
 retrieve available number of certificates, and pkcs11-id-get command to re=
trieve certificate
 id and certificate body.
 .\"*********************************************************
 .TP
-.B \-\-pkcs11-pin-cache seconds
+.B --pkcs11-pin-cache seconds
 Specify how many seconds the PIN can be cached, the default is until the t=
oken is removed.
 .\"*********************************************************
 .TP
-.B \-\-pkcs11-protected-authentication [0|1]...
+.B --pkcs11-protected-authentication [0|1]...
 Use PKCS#11 protected authentication path, useful for biometric and extern=
al
 keypad devices.
 Every provider has its own setting.
 .\"*********************************************************
 .TP
-.B \-\-pkcs11-providers provider...
+.B --pkcs11-providers provider...
 Specify a RSA Security Inc. PKCS #11 Cryptographic Token Interface (Crypto=
ki) providers
 to load.
 This option can be used instead of
-.B \-\-cert, \-\-key,
+.B --cert, --key,
 and
-.B \-\-pkcs12.
+.B --pkcs12.
=20
 If p11-kit is present on the system, its
 .B p11-kit-proxy.so
 module will be loaded by default if either the
-.B \-\-pkcs11\-id
+.B --pkcs11-id
 or
-.B \-\-pkcs11\-id\-management
+.B --pkcs11-id-management
 options are specified without
-.B \-\-pkcs11\-provider
+.B --pkcs11-provider
 being given.
 .\"*********************************************************
 .TP
-.B \-\-pkcs11-private-mode mode...
+.B --pkcs11-private-mode mode...
 Specify which method to use in order to perform private key operations.
 A different mode can be specified for each provider.
 Mode is encoded as hex number, and can be a mask one of the following:
=20
 .B 0
-(default) \-\- Try to determine automatically.
+(default) -- Try to determine automatically.
 .br
 .B 1
-\-\- Use sign.
+-- Use sign.
 .br
 .B 2
-\-\- Use sign recover.
+-- Use sign recover.
 .br
 .B 4
-\-\- Use decrypt.
+-- Use decrypt.
 .br
 .B 8
-\-\- Use unwrap.
+-- Use unwrap.
 .br
 .\"*********************************************************
 .TP
-.B \-\-cryptoapicert select-string
+.B --cryptoapicert select-string
 Load the certificate and private key from the
 Windows Certificate System Store (Windows/OpenSSL Only).
=20
 Use this option instead of
-.B \-\-cert
+.B --cert
 and
-.B \-\-key.
+.B --key.
=20
 This makes
 it possible to use any smart card, supported by Windows, but also any
@@ -4422,7 +4422,7 @@ Certificate Store GUI.
=20
 .\"*********************************************************
 .TP
-.B \-\-key-method m
+.B --key-method m
 Use data channel key negotiation method
 .B m.
 The key method must match on both sides of the connection.
@@ -4450,16 +4450,16 @@ of keying occur:
 of the connection producing certificates and verifying the certificate
 (or other authentication info provided) of
 the other side.  The
-.B \-\-key-method
+.B --key-method
 parameter has no effect on this process.
=20
 (2) After the TLS connection is established, the tunnel session keys are
 separately negotiated over the existing secure TLS channel.  Here,
-.B \-\-key-method
+.B --key-method
 determines the derivation of the tunnel session keys.
 .\"*********************************************************
 .TP
-.B \-\-tls-cipher l
+.B --tls-cipher l
 A list
 .B l
 of allowable TLS ciphers delimited by a colon (":").
@@ -4469,11 +4469,11 @@ version rollback attack where a man-in-the-middle a=
ttacker tries
 to force two peers to negotiate to the lowest level
 of security they both support.
 Use
-.B \-\-show-tls
+.B --show-tls
 to see a list of supported TLS ciphers.
 .\"*********************************************************
 .TP
-.B \-\-tls-timeout n
+.B --tls-timeout n
 Packet retransmit timeout on TLS control channel
 if no acknowledgment from remote within
 .B n
@@ -4490,7 +4490,7 @@ the higher level network protocols running on top of =
the tunnel
 such as TCP expect this role to be left to them.
 .\"*********************************************************
 .TP
-.B \-\-reneg-bytes n
+.B --reneg-bytes n
 Renegotiate data channel key after
 .B n
 bytes sent or received (disabled by default).
@@ -4500,13 +4500,13 @@ a number of seconds.  A key renegotiation will be f=
orced
 if any of these three criteria are met by either peer.
 .\"*********************************************************
 .TP
-.B \-\-reneg-pkts n
+.B --reneg-pkts n
 Renegotiate data channel key after
 .B n
 packets sent and received (disabled by default).
 .\"*********************************************************
 .TP
-.B \-\-reneg-sec n
+.B --reneg-sec n
 Renegotiate data channel key after
 .B n
 seconds (default=3D3600).
@@ -4517,16 +4517,16 @@ cause the end user to be challenged to reauthorize =
once per hour.
 Also, keep in mind that this option can be used on both the client and ser=
ver,
 and whichever uses the lower value will be the one to trigger the renegoti=
ation.
 A common mistake is to set
-.B \-\-reneg-sec
+.B --reneg-sec
 to a higher value on either the client or server, while the other side of =
the connection
 is still using the default value of 3600 seconds, meaning that the renegot=
iation will
-still occur once per 3600 seconds.  The solution is to increase \-\-reneg-=
sec on both the
+still occur once per 3600 seconds.  The solution is to increase --reneg-se=
c on both the
 client and server, or set it to 0 on one side of the connection (to disabl=
e), and to
 your chosen value on the other side.
 .\"*********************************************************
 .TP
-.B \-\-hand-window n
-Handshake Window \-\- the TLS-based key exchange must finalize within
+.B --hand-window n
+Handshake Window -- the TLS-based key exchange must finalize within
 .B n
 seconds
 of handshake initiation by any peer (default =3D 60 seconds).
@@ -4534,47 +4534,47 @@ If the handshake fails
 we will attempt to reset our connection with our peer and try again.
 Even in the event of handshake failure we will still use
 our expiring key for up to
-.B \-\-tran-window
+.B --tran-window
 seconds to maintain continuity of transmission of tunnel
 data.
 .\"*********************************************************
 .TP
-.B \-\-tran-window n
-Transition window \-\- our old key can live this many seconds
+.B --tran-window n
+Transition window -- our old key can live this many seconds
 after a new a key renegotiation begins (default =3D 3600 seconds).
 This feature allows for a graceful transition from old to new
 key, and removes the key renegotiation sequence from the critical
 path of tunnel data forwarding.
 .\"*********************************************************
 .TP
-.B \-\-single-session
+.B --single-session
 After initially connecting to a remote peer, disallow any new connections.
 Using this
 option means that a remote peer cannot connect, disconnect, and then
 reconnect.
=20
 If the daemon is reset by a signal or
-.B \-\-ping-restart,
+.B --ping-restart,
 it will allow one new connection.
=20
-.B \-\-single-session
+.B --single-session
 can be used with
-.B \-\-ping-exit
+.B --ping-exit
 or
-.B \-\-inactive
+.B --inactive
 to create a single dynamic session that will exit when finished.
 .\"*********************************************************
 .TP
-.B \-\-tls-exit
+.B --tls-exit
 Exit on TLS negotiation failure.
 .\"*********************************************************
 .TP
-.B \-\-tls-auth file [direction]
+.B --tls-auth file [direction]
 Add an additional layer of HMAC authentication on top of the TLS
 control channel to protect against DoS attacks.
=20
 In a nutshell,
-.B \-\-tls-auth
+.B --tls-auth
 enables a kind of "HMAC firewall" on OpenVPN's TCP/UDP port,
 where TLS control channel packets
 bearing an incorrect HMAC signature can be dropped immediately without
@@ -4585,7 +4585,7 @@ response.
=20
 .B (1)
 An OpenVPN static key file generated by
-.B \-\-genkey
+.B --genkey
 (required if
 .B direction
 parameter is used).
@@ -4604,19 +4604,19 @@ OpenVPN will first try format (1), and if the file =
fails to parse as
 a static key file, format (2) will be used.
=20
 See the
-.B \-\-secret
+.B --secret
 option for more information on the optional
 .B direction
 parameter.
=20
-.B \-\-tls-auth
+.B --tls-auth
 is recommended when you are running OpenVPN in a mode where
 it is listening for packets from any IP address, such as when
-.B \-\-remote
+.B --remote
 is not specified, or
-.B \-\-remote
+.B --remote
 is specified with
-.B \-\-float.
+.B --float.
=20
 The rationale for
 this feature is as follows.  TLS requires a multi-packet exchange
@@ -4643,7 +4643,7 @@ An important rule of thumb in reducing vulnerability =
to DoS attacks is to
 minimize the amount of resources a potential, but as yet unauthenticated,
 client is able to consume.
=20
-.B \-\-tls-auth
+.B --tls-auth
 does this by signing every TLS control channel packet with an HMAC signatu=
re,
 including packets which are sent before the TLS level has had a chance
 to authenticate the peer.
@@ -4651,20 +4651,20 @@ The result is that packets without
 the correct signature can be dropped immediately upon reception,
 before they have a chance to consume additional system resources
 such as by initiating a TLS handshake.
-.B \-\-tls-auth
+.B --tls-auth
 can be strengthened by adding the
-.B \-\-replay-persist
+.B --replay-persist
 option which will keep OpenVPN's replay protection state
 in a file so that it is not lost across restarts.
=20
 It should be emphasized that this feature is optional and that the
 passphrase/key file used with
-.B \-\-tls-auth
+.B --tls-auth
 gives a peer nothing more than the power to initiate a TLS
 handshake.  It is not used to encrypt or authenticate any tunnel data.
 .\"*********************************************************
 .TP
-.B \-\-askpass [file]
+.B --askpass [file]
 Get certificate password from console or
 .B file
 before we daemonize.
@@ -4673,7 +4673,7 @@ For the extremely
 security conscious, it is possible to protect your private key with
 a password.  Of course this means that every time the OpenVPN
 daemon is started you must be there to type the password.  The
-.B \-\-askpass
+.B --askpass
 option allows you to start OpenVPN from the command line.  It will
 query you for a password before it daemonizes.  To protect a private
 key with a password you should omit the
@@ -4690,15 +4690,15 @@ Keep in mind that storing your password in a file
 to a certain extent invalidates the extra security provided by
 using an encrypted key (Note: OpenVPN
 will only read passwords from a file if it has been built
-with the \-\-enable-password-save configure option, or on Windows
+with the --enable-password-save configure option, or on Windows
 by defining ENABLE_PASSWORD_SAVE in win/settings.in).
 .\"*********************************************************
 .TP
-.B \-\-auth-nocache
+.B --auth-nocache
 Don't cache
-.B \-\-askpass
+.B --askpass
 or
-.B \-\-auth-user-pass
+.B --auth-user-pass
 username/passwords in virtual memory.
=20
 If specified, this directive will cause OpenVPN to immediately
@@ -4708,19 +4708,19 @@ from stdin, which may be multiple times during the =
duration of an
 OpenVPN session.
=20
 This directive does not affect the
-.B \-\-http-proxy
+.B --http-proxy
 username/password.  It is always cached.
 .\"*********************************************************
 .TP
-.B \-\-tls-verify cmd
+.B --tls-verify cmd
 Run command
 .B cmd
 to verify the X509 name of a
 pending TLS connection that has otherwise passed all other
 tests of certification (except for revocation via
-.B \-\-crl-verify
+.B --crl-verify
 directive; the revocation test occurs after the
-.B \-\-tls-verify
+.B --tls-verify
 test).
=20
 .B cmd
@@ -4757,24 +4757,24 @@ See the "Environmental Variables" section below for
 additional parameters passed as environmental variables.
 .\"*********************************************************
 .TP
-.B \-\-tls-export-cert directory
+.B --tls-export-cert directory
 Store the certificates the clients uses upon connection to this
-directory. This will be done before \-\-tls-verify is called.  The
+directory. This will be done before --tls-verify is called.  The
 certificates will use a temporary name and will be deleted when
 the tls-verify script returns.  The file name used for the certificate
 is available via the peer_cert environment variable.
 .\"*********************************************************
 .TP
-.B \-\-x509-username-field [ext:\]fieldname
+.B --x509-username-field [ext:\]fieldname
 Field in the X.509 certificate subject to be used as the username (default=
=3DCN).
 Typically, this option is specified with
 .B fieldname
 as either of the following:
=20
-.B \-\-x509-username-field
+.B --x509-username-field
 emailAddress
 .br
-.B \-\-x509-username-field ext:\fRsubjectAltName
+.B --x509-username-field ext:\fRsubjectAltName
=20
 The first example uses the value of the "emailAddress" attribute in the
 certificate's Subject field as the username.  The second example uses
@@ -4789,7 +4789,7 @@ in
 the last occurrence is chosen.
=20
 When this option is used, the
-.B \-\-verify-x509-name
+.B --verify-x509-name
 option will match against the chosen
 .B fieldname
 instead of the Common Name.
@@ -4805,7 +4805,7 @@ prefix will be left as-is.  This automatic upcasing f=
eature
 is deprecated and will be removed in a future release.
 .\"*********************************************************
 .TP
-.B \-\-tls-remote name (DEPRECATED)
+.B --tls-remote name (DEPRECATED)
 Accept connections only from a host with X509 name
 or common name equal to
 .B name.
@@ -4822,33 +4822,33 @@ a third party, such as a commercial web CA.
 Name can also be a common name prefix, for example if you
 want a client to only accept connections to "Server-1",
 "Server-2", etc., you can simply use
-.B \-\-tls-remote Server
+.B --tls-remote Server
=20
 Using a common name prefix is a useful alternative to managing
 a CRL (Certificate Revocation List) on the client, since it allows the cli=
ent
 to refuse all certificates except for those associated
 with designated servers.
=20
-.B \-\-tls-remote
+.B --tls-remote
 is a useful replacement for the
-.B \-\-tls-verify
+.B --tls-verify
 option to verify the remote host, because
-.B \-\-tls-remote
+.B --tls-remote
 works in a
-.B \-\-chroot
+.B --chroot
 environment too.
=20
 .B Please also note:
 This option is now deprecated.  It will be removed either in OpenVPN v2.4
 or v2.5.  So please make sure you support the new X.509 name formatting
 described with the
-.B \-\-compat-names
+.B --compat-names
 option as soon as possible by updating your configurations to use
-.B \-\-verify-x509-name
+.B --verify-x509-name
 instead.
 .\"*********************************************************
 .TP
-.B \-\-verify-x509-name name type
+.B --verify-x509-name name type
 Accept connections only if a host's X.509 name is equal to
 .B name.
 The remote host must also pass all other tests of verification.
@@ -4860,24 +4860,24 @@ depends on the setting of type.
 can be "subject" to match the complete subject DN (default),
 "name" to match a subject RDN or "name-prefix" to match a subject RDN pref=
ix.
 Which RDN is verified as name depends on the
-.B \-\-x509-username-field
+.B --x509-username-field
 option. But it defaults to the common name (CN), e.g. a certificate with a
 subject DN "C=3DKG, ST=3DNA, L=3DBishkek, CN=3DServer-1" would be matched =
by:
=20
-.B \-\-verify-x509-name 'C=3DKG, ST=3DNA, L=3DBishkek, CN=3DServer-1'
+.B --verify-x509-name 'C=3DKG, ST=3DNA, L=3DBishkek, CN=3DServer-1'
 and
-.B \-\-verify-x509-name Server-1 name
+.B --verify-x509-name Server-1 name
 or you could use
-.B \-\-verify-x509-name Server- name-prefix
+.B --verify-x509-name Server- name-prefix
 if you want a client to only accept connections to "Server-1", "Server-2",=
 etc.
=20
-.B \-\-verify-x509-name
+.B --verify-x509-name
 is a useful replacement for the
-.B \-\-tls-verify
+.B --tls-verify
 option to verify the remote host, because
-.B \-\-verify-x509-name
+.B --verify-x509-name
 works in a
-.B \-\-chroot
+.B --chroot
 environment without any dependencies.
=20
 Using a name prefix is a useful alternative to managing
@@ -4892,7 +4892,7 @@ Never use this option with type "name-prefix" when yo=
ur client certificates
 are signed by a third party, such as a commercial web CA.
 .\"*********************************************************
 .TP
-.B \-\-x509-track attribute
+.B --x509-track attribute
 Save peer X509
 .B attribute
 value in environment for use by plugins and management interface.
@@ -4900,12 +4900,12 @@ Prepend a '+' to
 .B attribute
 to save values from full cert chain.  Values will be encoded
 as X509_<depth>_<attribute>=3D<value>.  Multiple
-.B \-\-x509-track
+.B --x509-track
 options can be defined to track multiple attributes.
 Not available with PolarSSL.
 .\"*********************************************************
 .TP
-.B \-\-ns-cert-type client|server
+.B --ns-cert-type client|server
 Require that peer certificate was signed with an explicit
 .B nsCertType
 designation of "client" or "server".
@@ -4920,19 +4920,19 @@ field set to "server".
=20
 If the server certificate's nsCertType field is set
 to "server", then the clients can verify this with
-.B \-\-ns-cert-type server.
+.B --ns-cert-type server.
=20
 This is an important security precaution to protect against
 a man-in-the-middle attack where an authorized client
 attempts to connect to another client by impersonating the server.
 The attack is easily prevented by having clients verify
 the server certificate using any one of
-.B \-\-ns-cert-type, \-\-verify-x509-name,
+.B --ns-cert-type, --verify-x509-name,
 or
-.B \-\-tls-verify.
+.B --tls-verify.
 .\"*********************************************************
 .TP
-.B \-\-remote-cert-ku v...
+.B --remote-cert-ku v...
 Require that peer certificate was signed with an explicit
 .B key usage.
=20
@@ -4943,7 +4943,7 @@ The key usage should be encoded in hex, more than one=
 key
 usage can be specified.
 .\"*********************************************************
 .TP
-.B \-\-remote-cert-eku oid
+.B --remote-cert-eku oid
 Require that peer certificate was signed with an explicit
 .B extended key usage.
=20
@@ -4954,7 +4954,7 @@ The extended key usage should be encoded in oid notat=
ion, or
 OpenSSL symbolic representation.
 .\"*********************************************************
 .TP
-.B \-\-remote-cert-tls client|server
+.B --remote-cert-tls client|server
 Require that peer certificate was signed with an explicit
 .B key usage
 and
@@ -4965,18 +4965,18 @@ This is a useful security option for clients, to en=
sure that
 the host they connect to is a designated server.
=20
 The
-.B \-\-remote-cert-tls client
+.B --remote-cert-tls client
 option is equivalent to
 .B
-\-\-remote-cert-ku 80 08 88 \-\-remote-cert-eku "TLS Web Client Authentica=
tion"
+--remote-cert-ku 80 08 88 --remote-cert-eku "TLS Web Client Authentication"
=20
 The key usage is digitalSignature and/or keyAgreement.
=20
 The
-.B \-\-remote-cert-tls server
+.B --remote-cert-tls server
 option is equivalent to
 .B
-\-\-remote-cert-ku a0 88 \-\-remote-cert-eku "TLS Web Server Authenticatio=
n"
+--remote-cert-ku a0 88 --remote-cert-eku "TLS Web Server Authentication"
=20
 The key usage is digitalSignature and ( keyEncipherment or keyAgreement ).
=20
@@ -4985,12 +4985,12 @@ a man-in-the-middle attack where an authorized clie=
nt
 attempts to connect to another client by impersonating the server.
 The attack is easily prevented by having clients verify
 the server certificate using any one of
-.B \-\-remote-cert-tls, \-\-verify-x509-name,
+.B --remote-cert-tls, --verify-x509-name,
 or
-.B \-\-tls-verify.
+.B --tls-verify.
 .\"*********************************************************
 .TP
-.B \-\-crl-verify crl ['dir']
+.B --crl-verify crl ['dir']
 Check peer certificate against the file
 .B crl
 in PEM format.
@@ -5020,28 +5020,28 @@ it will be rejected.
 .SS SSL Library information:
 .\"*********************************************************
 .TP
-.B \-\-show-ciphers
+.B --show-ciphers
 (Standalone)
 Show all cipher algorithms to use with the
-.B \-\-cipher
+.B --cipher
 option.
 .\"*********************************************************
 .TP
-.B \-\-show-digests
+.B --show-digests
 (Standalone)
 Show all message digest algorithms to use with the
-.B \-\-auth
+.B --auth
 option.
 .\"*********************************************************
 .TP
-.B \-\-show-tls
+.B --show-tls
 (Standalone)
 Show all TLS ciphers (TLS used only as a control channel).  The TLS
 ciphers will be sorted from highest preference (most secure) to
 lowest.
 .\"*********************************************************
 .TP
-.B \-\-show-engines
+.B --show-engines
 (Standalone)
 Show currently available hardware-based crypto acceleration
 engines supported by the OpenSSL library.
@@ -5050,18 +5050,18 @@ engines supported by the OpenSSL library.
 Used only for non-TLS static key encryption mode.
 .\"*********************************************************
 .TP
-.B \-\-genkey
+.B --genkey
 (Standalone)
 Generate a random key to be used as a shared secret,
 for use with the
-.B \-\-secret
+.B --secret
 option.  This file must be shared with the
 peer over a pre-existing secure channel such as
 .BR scp (1)
 .
 .\"*********************************************************
 .TP
-.B \-\-secret file
+.B --secret file
 Write key to
 .B file.
 .\"*********************************************************
@@ -5070,7 +5070,7 @@ Available with linux 2.4.7+.  These options comprise =
a standalone mode
 of OpenVPN which can be used to create and delete persistent tunnels.
 .\"*********************************************************
 .TP
-.B \-\-mktun
+.B --mktun
 (Standalone)
 Create a persistent tunnel on platforms which support them such
 as Linux.  Normally TUN/TAP tunnels exist only for
@@ -5081,9 +5081,9 @@ only when they are deleted or the machine is rebooted.
=20
 One of the advantages of persistent tunnels is that they eliminate the
 need for separate
-.B \-\-up
+.B --up
 and
-.B \-\-down
+.B --down
 scripts to run the appropriate
 .BR ifconfig (8)
 and
@@ -5095,40 +5095,40 @@ Another advantage is that open connections through =
the TUN/TAP-based tunnel
 will not be reset if the OpenVPN peer restarts.  This can be useful to
 provide uninterrupted connectivity through the tunnel in the event of a DH=
CP
 reset of the peer's public IP address (see the
-.B \-\-ipchange
+.B --ipchange
 option above).
=20
 One disadvantage of persistent tunnels is that it is harder to automatical=
ly
 configure their MTU value (see
-.B \-\-link-mtu
+.B --link-mtu
 and
-.B \-\-tun-mtu
+.B --tun-mtu
 above).
=20
 On some platforms such as Windows, TAP-Win32 tunnels are persistent by
 default.
 .\"*********************************************************
 .TP
-.B \-\-rmtun
+.B --rmtun
 (Standalone)
 Remove a persistent tunnel.
 .\"*********************************************************
 .TP
-.B \-\-dev tunX | tapX
+.B --dev tunX | tapX
 TUN/TAP device
 .\"*********************************************************
 .TP
-.B \-\-user user
+.B --user user
 Optional user to be owner of this tunnel.
 .\"*********************************************************
 .TP
-.B \-\-group group
+.B --group group
 Optional group to be owner of this tunnel.
 .\"*********************************************************
 .SS Windows-Specific Options:
 .\"*********************************************************
 .TP
-.B \-\-win-sys path
+.B --win-sys path
 Set the Windows system directory pathname to use when looking for system
 executables such as
 .B route.exe
@@ -5147,23 +5147,23 @@ keyword any more, and it will just be ignored. A wa=
rning is logged when this
 is found in the configuration file.
 .\"*********************************************************
 .TP
-.B \-\-ip-win32 method
+.B --ip-win32 method
 When using
-.B \-\-ifconfig
+.B --ifconfig
 on Windows, set the TAP-Win32 adapter
 IP address and netmask using
 .B method.
 Don't use this option unless you are also using
-.B \-\-ifconfig.
+.B --ifconfig.
=20
-.B manual \-\-
+.B manual --
 Don't set the IP address or netmask automatically.
 Instead output a message
 to the console telling the user to configure the
 adapter manually and indicating the IP/netmask which
 OpenVPN expects the adapter to be set to.
=20
-.B dynamic [offset] [lease-time] \-\-
+.B dynamic [offset] [lease-time] --
 Automatically set the IP address and netmask by replying to
 DHCP query messages generated by the kernel.  This mode is
 probably the "cleanest" solution
@@ -5173,13 +5173,13 @@ this mode: (1) The TCP/IP properties for the TAP-Wi=
n32
 adapter must be set to "Obtain an IP address automatically," and
 (2) OpenVPN needs to claim an IP address in the subnet for use
 as the virtual DHCP server address.  By default in
-.B \-\-dev tap
+.B --dev tap
 mode, OpenVPN will
 take the normally unused first address in the subnet.  For example,
 if your subnet is 192.168.4.0 netmask 255.255.255.0, then
 OpenVPN will take the IP address 192.168.4.0 to use as the
 virtual DHCP server address.  In
-.B \-\-dev tun
+.B --dev tun
 mode, OpenVPN will cause the DHCP server to masquerade as if it were
 coming from the remote endpoint.  The optional offset parameter is
 an integer which is > -256 and < 256 and which defaults to 0.
@@ -5201,13 +5201,13 @@ because it prevents routes involving the TAP-Win32 =
adapter from
 being lost when the system goes to sleep.  The default
 lease time is one year.
=20
-.B netsh \-\-
+.B netsh --
 Automatically set the IP address and netmask using
 the Windows command-line "netsh"
 command.  This method appears to work correctly on
 Windows XP but not Windows 2000.
=20
-.B ipapi \-\-
+.B ipapi --
 Automatically set the IP address and netmask using the
 Windows IP Helper API.  This approach
 does not have ideal semantics, though testing has indicated
@@ -5216,7 +5216,7 @@ it is best to leave the TCP/IP properties for the TAP=
-Win32
 adapter in their default state, i.e. "Obtain an IP address
 automatically."
=20
-.B adaptive \-\-
+.B adaptive --
 (Default) Try
 .B dynamic
 method initially and fail over to
@@ -5246,55 +5246,55 @@ mode to restore the TAP-Win32 adapter TCP/IP proper=
ties
 to a DHCP configuration.
 .\"*********************************************************
 .TP
-.B \-\-route-method m
+.B --route-method m
 Which method
 .B m
 to use for adding routes on Windows?
=20
 .B adaptive
-(default) \-\- Try IP helper API first.  If that fails, fall
+(default) -- Try IP helper API first.  If that fails, fall
 back to the route.exe shell command.
 .br
 .B ipapi
-\-\- Use IP helper API.
+-- Use IP helper API.
 .br
 .B exe
-\-\- Call the route.exe shell command.
+-- Call the route.exe shell command.
 .\"*********************************************************
 .TP
-.B \-\-dhcp-option type [parm]
+.B --dhcp-option type [parm]
 Set extended TAP-Win32 TCP/IP properties, must
 be used with
-.B \-\-ip-win32 dynamic
+.B --ip-win32 dynamic
 or
-.B \-\-ip-win32 adaptive.
+.B --ip-win32 adaptive.
 This option can be used to set additional TCP/IP properties
 on the TAP-Win32 adapter, and is particularly useful for
 configuring an OpenVPN client to access a Samba server
 across the VPN.
=20
-.B DOMAIN name \-\-
+.B DOMAIN name --
 Set Connection-specific DNS Suffix.
=20
-.B DNS addr \-\-
+.B DNS addr --
 Set primary domain name server address.  Repeat
 this option to set secondary DNS server addresses.
=20
-.B WINS addr \-\-
+.B WINS addr --
 Set primary WINS server address (NetBIOS over TCP/IP Name Server).
 Repeat this option to set secondary WINS server addresses.
=20
-.B NBDD addr \-\-
+.B NBDD addr --
 Set primary NBDD server address (NetBIOS over TCP/IP Datagram Distribution=
 Server)
 Repeat this option
 to set secondary NBDD server addresses.
=20
-.B NTP addr \-\-
+.B NTP addr --
 Set primary NTP server address (Network Time Protocol).
 Repeat this option
 to set secondary NTP server addresses.
=20
-.B NBT type \-\-
+.B NBT type --
 Set NetBIOS over TCP/IP Node type.  Possible options:
 .B 1
 =3D b-node (broadcasts),
@@ -5307,7 +5307,7 @@ then query name server), and
 .B 8
 =3D h-node (query name server, then broadcast).
=20
-.B NBS scope-id \-\-
+.B NBS scope-id --
 Set NetBIOS over TCP/IP Scope. A NetBIOS Scope ID provides an extended
 naming service for the NetBIOS over TCP/IP (Known as NBT) module. The
 primary purpose of a NetBIOS scope ID is to isolate NetBIOS traffic on
@@ -5319,19 +5319,19 @@ computers to use the same computer name, as they ha=
ve different
 scope IDs. The Scope ID becomes a part of the NetBIOS name, making the nam=
e unique.
 (This description of NetBIOS scopes courtesy of NeonSurge@...1311...)
=20
-.B DISABLE-NBT \-\-
+.B DISABLE-NBT --
 Disable Netbios-over-TCP/IP.
=20
 Note that if
-.B \-\-dhcp-option
+.B --dhcp-option
 is pushed via
-.B \-\-push
+.B --push
 to a non-windows client, the option will be saved in the client's
 environment before the up script is called, under
 the name "foreign_option_{n}".
 .\"*********************************************************
 .TP
-.B \-\-tap-sleep n
+.B --tap-sleep n
 Cause OpenVPN to sleep for
 .B n
 seconds immediately after the TAP-Win32 adapter state
@@ -5339,21 +5339,21 @@ is set to "connected".
=20
 This option is intended to be used to troubleshoot problems
 with the
-.B \-\-ifconfig
+.B --ifconfig
 and
-.B \-\-ip-win32
+.B --ip-win32
 options, and is used to give
 the TAP-Win32 adapter time to come up before
 Windows IP Helper API operations are applied to it.
 .\"*********************************************************
 .TP
-.B \-\-show-net-up
+.B --show-net-up
 Output OpenVPN's view of the system routing table and network
 adapter list to the syslog or log file after the TUN/TAP adapter
 has been brought up and any routes have been added.
 .\"*********************************************************
 .TP
-.B \-\-dhcp-renew
+.B --dhcp-renew
 Ask Windows to renew the TAP adapter lease on startup.
 This option is normally unnecessary, as Windows automatically
 triggers a DHCP renegotiation on the TAP adapter when it
@@ -5362,28 +5362,28 @@ Media Status property to "Always Connected", you ma=
y need this
 flag.
 .\"*********************************************************
 .TP
-.B \-\-dhcp-release
+.B --dhcp-release
 Ask Windows to release the TAP adapter lease on shutdown.
 This option has the same caveats as
-.B \-\-dhcp-renew
+.B --dhcp-renew
 above.
 .\"*********************************************************
 .TP
-.B \-\-register-dns
+.B --register-dns
 Run net stop dnscache, net start dnscache, ipconfig /flushdns
 and ipconfig /registerdns on connection initiation.
 This is known to kick Windows into
 recognizing pushed DNS servers.
 .\"*********************************************************
 .TP
-.B \-\-pause-exit
+.B --pause-exit
 Put up a "press any key to continue" message on the console prior
 to OpenVPN program exit.  This option is automatically used by the
 Windows explorer when OpenVPN is run on a configuration
 file using the right-click explorer menu.
 .\"*********************************************************
 .TP
-.B \-\-service exit-event [0|1]
+.B --service exit-event [0|1]
 Should be used when OpenVPN is being automatically executed by another
 program in such
 a context that no interaction with the user via display or keyboard
@@ -5406,26 +5406,26 @@ parameter.  In any case, the controlling process ca=
n signal
 causing all such OpenVPN processes to exit.
=20
 When executing an OpenVPN process using the
-.B \-\-service
+.B --service
 directive, OpenVPN will probably not have a console
 window to output status/error
 messages, therefore it is useful to use
-.B \-\-log
+.B --log
 or
-.B \-\-log-append
+.B --log-append
 to write these messages to a file.
 .\"*********************************************************
 .TP
-.B \-\-show-adapters
+.B --show-adapters
 (Standalone)
 Show available TAP-Win32 adapters which can be selected using the
-.B \-\-dev-node
+.B --dev-node
 option.  On non-Windows systems, the
 .BR ifconfig (8)
 command provides similar functionality.
 .\"*********************************************************
 .TP
-.B \-\-allow-nonadmin [TAP-adapter]
+.B --allow-nonadmin [TAP-adapter]
 (Standalone)
 Set
 .B TAP-adapter
@@ -5440,10 +5440,10 @@ and reloaded.
 This directive can only be used by an administrator.
 .\"*********************************************************
 .TP
-.B \-\-show-valid-subnets
+.B --show-valid-subnets
 (Standalone)
 Show valid subnets for
-.B \-\-dev tun
+.B --dev tun
 emulation.  Since the TAP-Win32 driver
 exports an ethernet interface to Windows, and since TUN devices are
 point-to-point in nature, it is necessary for the TAP-Win32 driver
@@ -5453,7 +5453,7 @@ Namely, the point-to-point endpoints used in TUN devi=
ce emulation
 must be the middle two addresses of a /30 subnet (netmask 255.255.255.252).
 .\"*********************************************************
 .TP
-.B \-\-show-net
+.B --show-net
 (Standalone)
 Show OpenVPN's view of the system routing table and network
 adapter list.
@@ -5461,7 +5461,7 @@ adapter list.
 .SS PKCS#11 Standalone Options:
 .\"*********************************************************
 .TP
-.B \-\-show-pkcs11-ids [provider] [cert_private]
+.B --show-pkcs11-ids [provider] [cert_private]
 (Standalone)
 Show PKCS#11 token object list. Specify cert_private as 1
 if certificates are stored as private objects.
@@ -5472,7 +5472,7 @@ argument is optional; if omitted the default
 .B p11-kit-proxy.so
 module will be queried.
=20
-.B \-\-verb
+.B --verb
 option can be used BEFORE this option to produce debugging information.
 .\"*********************************************************
 .SS IPv6 Related Options
@@ -5481,7 +5481,7 @@ The following options exist to support IPv6 tunneling=
 in peer-to-peer
 and client-server mode.  All options are modeled after their IPv4
 counterparts, so more detailed explanations given there apply here
 as well (except for
-.B \-\-topology
+.B --topology
 , which has no effect on IPv6).
 .TP
 .B --ifconfig-ipv6 ipv6addr/bits ipv6remote
@@ -5536,56 +5536,56 @@ of environmental variables for use by user-defined =
scripts.
 .SS Script Order of Execution
 .\"*********************************************************
 .TP
-.B \-\-up
+.B --up
 Executed after TCP/UDP socket bind and TUN/TAP open.
 .\"*********************************************************
 .TP
-.B \-\-tls-verify
+.B --tls-verify
 Executed when we have a still untrusted remote peer.
 .\"*********************************************************
 .TP
-.B \-\-ipchange
+.B --ipchange
 Executed after connection authentication, or remote IP address change.
 .\"*********************************************************
 .TP
-.B \-\-client-connect
+.B --client-connect
 Executed in
-.B \-\-mode server
+.B --mode server
 mode immediately after client authentication.
 .\"*********************************************************
 .TP
-.B \-\-route-up
+.B --route-up
 Executed after connection authentication, either
 immediately after, or some number of seconds after
 as defined by the
-.B \-\-route-delay
+.B --route-delay
 option.
 .\"*********************************************************
 .TP
-.B \-\-route-pre-down
+.B --route-pre-down
 Executed right before the routes are removed.
 .\"*********************************************************
 .TP
-.B \-\-client-disconnect
+.B --client-disconnect
 Executed in
-.B \-\-mode server
+.B --mode server
 mode on client instance shutdown.
 .\"*********************************************************
 .TP
-.B \-\-down
+.B --down
 Executed after TCP/UDP and TUN/TAP close.
 .\"*********************************************************
 .TP
-.B \-\-learn-address
+.B --learn-address
 Executed in
-.B \-\-mode server
+.B --mode server
 mode whenever an IPv4 address/route or MAC address is added to OpenVPN's
 internal routing table.
 .\"*********************************************************
 .TP
-.B \-\-auth-user-pass-verify
+.B --auth-user-pass-verify
 Executed in
-.B \-\-mode server
+.B --mode server
 mode on new client connections, when the client is
 still untrusted.
 .\"*********************************************************
@@ -5609,7 +5609,7 @@ Can string remapping be disabled?
=20
 .B A:
 Yes, by using the
-.B \-\-no-name-remapping
+.B --no-name-remapping
 option, however this should be considered an advanced option.
=20
 Here is a brief rundown of OpenVPN's current string types and the=20
@@ -5625,17 +5625,17 @@ true.
 Alphanumeric, underbar ('_'), dash ('-'), dot ('.'), and at=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20
 ('@').
=20
-.B \-\-auth-user-pass username:
+.B --auth-user-pass username:
 Same as Common Name, with one exception: starting with OpenVPN 2.0.1,
 the username is passed to the OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY plugin =
in its raw form,
 without string remapping.
=20
-.B \-\-auth-user-pass password:
+.B --auth-user-pass password:
 Any "printable" character except CR or LF.=20=20
 Printable is defined to be a character which will cause the C library=20
 isprint() function to return true.
=20
-.B \-\-client-config-dir filename as derived from common name or username:
+.B --client-config-dir filename as derived from common name or username:
 Alphanumeric, underbar ('_'), dash ('-'), and dot ('.') except for "." or=
=20
 ".." as standalone strings.  As of 2.0.1-rc6, the at ('@') character has
 been added as well for compatibility with the common name character class.
@@ -5665,45 +5665,45 @@ which refer to different client instances.
 .B bytes_received
 Total number of bytes received from client during VPN session.
 Set prior to execution of the
-.B \-\-client-disconnect
+.B --client-disconnect
 script.
 .\"*********************************************************
 .TP
 .B bytes_sent
 Total number of bytes sent to client during VPN session.
 Set prior to execution of the
-.B \-\-client-disconnect
+.B --client-disconnect
 script.
 .\"*********************************************************
 .TP
 .B common_name
 The X509 common name of an authenticated client.
 Set prior to execution of
-.B \-\-client-connect, \-\-client-disconnect,
+.B --client-connect, --client-disconnect,
 and
-.B \-\-auth-user-pass-verify
+.B --auth-user-pass-verify
 scripts.
 .\"*********************************************************
 .TP
 .B config
 Name of first
-.B \-\-config
+.B --config
 file.
 Set on program initiation and reset on SIGHUP.
 .\"*********************************************************
 .TP
 .B daemon
 Set to "1" if the
-.B \-\-daemon
+.B --daemon
 directive is specified, or "0" otherwise.
 Set on program initiation and reset on SIGHUP.
 .\"*********************************************************
 .TP
 .B daemon_log_redirect
 Set to "1" if the
-.B \-\-log
+.B --log
 or
-.B \-\-log-append
+.B --log-append
 directives are specified, or "0" otherwise.
 Set on program initiation and reset on SIGHUP.
 .\"*********************************************************
@@ -5712,30 +5712,30 @@ Set on program initiation and reset on SIGHUP.
 The actual name of the TUN/TAP device, including
 a unit number if it exists.
 Set prior to
-.B \-\-up
+.B --up
 or
-.B \-\-down
+.B --down
 script execution.
 .\"*********************************************************
 .TP
 .B foreign_option_{n}
 An option pushed via
-.B \-\-push
+.B --push
 to a client which does not natively support it,
 such as
-.B \-\-dhcp-option
+.B --dhcp-option
 on a non-Windows system, will be recorded to this
 environmental variable sequence prior to
-.B \-\-up
+.B --up
 script execution.
 .\"*********************************************************
 .TP
 .B ifconfig_broadcast
 The broadcast address for the virtual
 ethernet segment which is derived from the
-.B \-\-ifconfig
+.B --ifconfig
 option when
-.B \-\-dev tap
+.B --dev tap
 is used.
 Set prior to OpenVPN calling the
 .I ifconfig
@@ -5743,13 +5743,13 @@ or
 .I netsh
 (windows version of ifconfig) commands which
 normally occurs prior to
-.B \-\-up
+.B --up
 script execution.
 .\"*********************************************************
 .TP
 .B ifconfig_ipv6_local
 The local VPN endpoint IPv6 address specified in the
-.B \-\-ifconfig-ipv6
+.B --ifconfig-ipv6
 option (first parameter).
 Set prior to OpenVPN calling the
 .I ifconfig
@@ -5757,14 +5757,14 @@ or
 .I netsh
 (windows version of ifconfig) commands which
 normally occurs prior to
-.B \-\-up
+.B --up
 script execution.
 .\"*********************************************************
 .TP
 .B ifconfig_ipv6_netbits
 The prefix length of the IPv6 network on the VPN interface.  Derived from
 the /nnn parameter of the IPv6 address in the
-.B \-\-ifconfig-ipv6
+.B --ifconfig-ipv6
 option (first parameter).
 Set prior to OpenVPN calling the
 .I ifconfig
@@ -5772,13 +5772,13 @@ or
 .I netsh
 (windows version of ifconfig) commands which
 normally occurs prior to
-.B \-\-up
+.B --up
 script execution.
 .\"*********************************************************
 .TP
 .B ifconfig_ipv6_remote
 The remote VPN endpoint IPv6 address specified in the
-.B \-\-ifconfig-ipv6
+.B --ifconfig-ipv6
 option (second parameter).
 Set prior to OpenVPN calling the
 .I ifconfig
@@ -5786,13 +5786,13 @@ or
 .I netsh
 (windows version of ifconfig) commands which
 normally occurs prior to
-.B \-\-up
+.B --up
 script execution.
 .\"*********************************************************
 .TP
 .B ifconfig_local
 The local VPN endpoint IP address specified in the
-.B \-\-ifconfig
+.B --ifconfig
 option (first parameter).
 Set prior to OpenVPN calling the
 .I ifconfig
@@ -5800,15 +5800,15 @@ or
 .I netsh
 (windows version of ifconfig) commands which
 normally occurs prior to
-.B \-\-up
+.B --up
 script execution.
 .\"*********************************************************
 .TP
 .B ifconfig_remote
 The remote VPN endpoint IP address specified in the
-.B \-\-ifconfig
+.B --ifconfig
 option (second parameter) when
-.B \-\-dev tun
+.B --dev tun
 is used.
 Set prior to OpenVPN calling the
 .I ifconfig
@@ -5816,16 +5816,16 @@ or
 .I netsh
 (windows version of ifconfig) commands which
 normally occurs prior to
-.B \-\-up
+.B --up
 script execution.
 .\"*********************************************************
 .TP
 .B ifconfig_netmask
 The subnet mask of the virtual ethernet segment
 that is specified as the second parameter to
-.B \-\-ifconfig
+.B --ifconfig
 when
-.B \-\-dev tap
+.B --dev tap
 is being used.
 Set prior to OpenVPN calling the
 .I ifconfig
@@ -5833,61 +5833,61 @@ or
 .I netsh
 (windows version of ifconfig) commands which
 normally occurs prior to
-.B \-\-up
+.B --up
 script execution.
 .\"*********************************************************
 .TP
 .B ifconfig_pool_local_ip
 The local
 virtual IP address for the TUN/TAP tunnel taken from an
-.B \-\-ifconfig-push
+.B --ifconfig-push
 directive if specified, or otherwise from
 the ifconfig pool (controlled by the
-.B \-\-ifconfig-pool
+.B --ifconfig-pool
 config file directive).
 Only set for
-.B \-\-dev tun
+.B --dev tun
 tunnels.
 This option is set on the server prior to execution
 of the
-.B \-\-client-connect
+.B --client-connect
 and
-.B \-\-client-disconnect
+.B --client-disconnect
 scripts.
 .\"*********************************************************
 .TP
 .B ifconfig_pool_netmask
 The
 virtual IP netmask for the TUN/TAP tunnel taken from an
-.B \-\-ifconfig-push
+.B --ifconfig-push
 directive if specified, or otherwise from
 the ifconfig pool (controlled by the
-.B \-\-ifconfig-pool
+.B --ifconfig-pool
 config file directive).
 Only set for
-.B \-\-dev tap
+.B --dev tap
 tunnels.
 This option is set on the server prior to execution
 of the
-.B \-\-client-connect
+.B --client-connect
 and
-.B \-\-client-disconnect
+.B --client-disconnect
 scripts.
 .\"*********************************************************
 .TP
 .B ifconfig_pool_remote_ip
 The remote
 virtual IP address for the TUN/TAP tunnel taken from an
-.B \-\-ifconfig-push
+.B --ifconfig-push
 directive if specified, or otherwise from
 the ifconfig pool (controlled by the
-.B \-\-ifconfig-pool
+.B --ifconfig-pool
 config file directive).
 This option is set on the server prior to execution
 of the
-.B \-\-client-connect
+.B --client-connect
 and
-.B \-\-client-disconnect
+.B --client-disconnect
 scripts.
 .\"*********************************************************
 .TP
@@ -5895,31 +5895,31 @@ scripts.
 The maximum packet size (not including the IP header)
 of tunnel data in UDP tunnel transport mode.
 Set prior to
-.B \-\-up
+.B --up
 or
-.B \-\-down
+.B --down
 script execution.
 .\"*********************************************************
 .TP
 .B local
 The
-.B \-\-local
+.B --local
 parameter.
 Set on program initiation and reset on SIGHUP.
 .\"*********************************************************
 .TP
 .B local_port
 The local port number, specified by
-.B \-\-port
+.B --port
 or
-.B \-\-lport.
+.B --lport.
 Set on program initiation and reset on SIGHUP.
 .\"*********************************************************
 .TP
 .B password
 The password provided by a connecting client.
 Set prior to
-.B \-\-auth-user-pass-verify
+.B --auth-user-pass-verify
 script execution only when the
 .B via-env
 modifier is specified, and deleted from the environment
@@ -5928,23 +5928,23 @@ after the script returns.
 .TP
 .B proto
 The
-.B \-\-proto
+.B --proto
 parameter.
 Set on program initiation and reset on SIGHUP.
 .\"*********************************************************
 .TP
 .B remote_{n}
 The
-.B \-\-remote
+.B --remote
 parameter.
 Set on program initiation and reset on SIGHUP.
 .\"*********************************************************
 .TP
 .B remote_port_{n}
 The remote port number, specified by
-.B \-\-port
+.B --port
 or
-.B \-\-rport.
+.B --rport.
 Set on program initiation and reset on SIGHUP.
 .\"*********************************************************
 .TP
@@ -5952,29 +5952,29 @@ Set on program initiation and reset on SIGHUP.
 The pre-existing default IP gateway in the system routing
 table.
 Set prior to
-.B \-\-up
+.B --up
 script execution.
 .\"*********************************************************
 .TP
 .B route_vpn_gateway
 The default gateway used by
-.B \-\-route
+.B --route
 options, as specified in either the
-.B \-\-route-gateway
+.B --route-gateway
 option or the second parameter to
-.B \-\-ifconfig
+.B --ifconfig
 when
-.B \-\-dev tun
+.B --dev tun
 is specified.
 Set prior to
-.B \-\-up
+.B --up
 script execution.
 .\"*********************************************************
 .TP
 .B route_{parm}_{n}
 A set of variables which define each route to be added, and
 are set prior to
-.B \-\-up
+.B --up
 script execution.
=20
 .B parm
@@ -5992,7 +5992,7 @@ or configuration file.
 .B route_ipv6_{parm}_{n}
 A set of variables which define each IPv6 route to be added, and
 are set prior to
-.B \-\-up
+.B --up
 script execution.
=20
 .B parm
@@ -6018,7 +6018,7 @@ connection.  Useful in conjunction with --tls-verify
 Set to "init" or "restart" prior to up/down script execution.
 For more information, see
 documentation for
-.B \-\-up.
+.B --up.
 .\"*********************************************************
 .TP
 .B script_type
@@ -6035,15 +6035,15 @@ Set prior to execution of any script.
 The reason for exit or restart.  Can be one of
 .B sigusr1, sighup, sigterm, sigint, inactive
 (controlled by
-.B \-\-inactive
+.B --inactive
 option),
 .B ping-exit
 (controlled by
-.B \-\-ping-exit
+.B --ping-exit
 option),
 .B ping-restart
 (controlled by
-.B \-\-ping-restart
+.B --ping-restart
 option),
 .B connection-reset
 (triggered on TCP connection reset),
@@ -6057,7 +6057,7 @@ or
 Client connection timestamp, formatted as a human-readable
 time string.
 Set prior to execution of the
-.B \-\-client-connect
+.B --client-connect
 script.
 .\"*********************************************************
 .TP
@@ -6065,7 +6065,7 @@ script.
 The duration (in seconds) of the client session which is now
 disconnecting.
 Set prior to execution of the
-.B \-\-client-disconnect
+.B --client-disconnect
 script.
 .\"*********************************************************
 .TP
@@ -6073,7 +6073,7 @@ script.
 Client connection timestamp, formatted as a unix integer
 date/time value.
 Set prior to execution of the
-.B \-\-client-connect
+.B --client-connect
 script.
 .\"*********************************************************
 .TP
@@ -6083,7 +6083,7 @@ where
 .B n
 is the verification level.  Only set for TLS connections.  Set prior
 to execution of
-.B \-\-tls-verify
+.B --tls-verify
 script.
 .\"*********************************************************
 .TP
@@ -6093,7 +6093,7 @@ where
 .B n
 is the verification level.  Only set for TLS connections.  Set prior
 to execution of
-.B \-\-tls-verify
+.B --tls-verify
 script.
 .\"*********************************************************
 .TP
@@ -6103,7 +6103,7 @@ where
 .B n
 is the verification level.  Only set for TLS connections.  Set prior
 to execution of
-.B \-\-tls-verify
+.B --tls-verify
 script. This is in the form of a decimal string like "933971680", which is
 suitable for doing serial-based OCSP queries (with OpenSSL, do not
 prepend "0x" to the string) If something goes wrong while reading
@@ -6121,18 +6121,18 @@ but in hex form (e.g. "12:34:56:78:9A").
 .B tun_mtu
 The MTU of the TUN/TAP device.
 Set prior to
-.B \-\-up
+.B --up
 or
-.B \-\-down
+.B --down
 script execution.
 .\"*********************************************************
 .TP
 .B trusted_ip (or trusted_ip6)
 Actual IP address of connecting client or peer which has been authenticate=
d.
 Set prior to execution of
-.B \-\-ipchange, \-\-client-connect,
+.B --ipchange, --client-connect,
 and
-.B \-\-client-disconnect
+.B --client-disconnect
 scripts.
 If using ipv6 endpoints (udp6, tcp6),
 .B trusted_ip6
@@ -6142,9 +6142,9 @@ will be set instead.
 .B trusted_port
 Actual port number of connecting client or peer which has been authenticat=
ed.
 Set prior to execution of
-.B \-\-ipchange, \-\-client-connect,
+.B --ipchange, --client-connect,
 and
-.B \-\-client-disconnect
+.B --client-disconnect
 scripts.
 .\"*********************************************************
 .TP
@@ -6153,12 +6153,12 @@ Actual IP address of connecting client or peer whic=
h has not been authenticated
 yet.  Sometimes used to
 .B nmap
 the connecting host in a
-.B \-\-tls-verify
+.B --tls-verify
 script to ensure it is firewalled properly.
 Set prior to execution of
-.B \-\-tls-verify
+.B --tls-verify
 and
-.B \-\-auth-user-pass-verify
+.B --auth-user-pass-verify
 scripts.
 If using ipv6 endpoints (udp6, tcp6),
 .B untrusted_ip6
@@ -6169,16 +6169,16 @@ will be set instead.
 Actual port number of connecting client or peer which has not been authent=
icated
 yet.
 Set prior to execution of
-.B \-\-tls-verify
+.B --tls-verify
 and
-.B \-\-auth-user-pass-verify
+.B --auth-user-pass-verify
 scripts.
 .\"*********************************************************
 .TP
 .B username
 The username provided by a connecting client.
 Set prior to
-.B \-\-auth-user-pass-verify
+.B --auth-user-pass-verify
 script execution only when the
 .B via-env
 modifier is specified.
@@ -6190,7 +6190,7 @@ where
 .B n
 is the verification level.  Only set for TLS connections.  Set prior
 to execution of
-.B \-\-tls-verify
+.B --tls-verify
 script.  This variable is similar to
 .B tls_id_{n}
 except the component X509 subject fields are broken out, and
@@ -6221,9 +6221,9 @@ X509_1_C=3DKG
 .\"*********************************************************
 .SH INLINE FILE SUPPORT
 OpenVPN allows including files in the main configuration for the
-.B \-\-ca, \-\-cert, \-\-dh, \-\-extra-certs, \-\-key, \-\-pkcs12, \-\-sec=
ret
+.B --ca, --cert, --dh, --extra-certs, --key, --pkcs12, --secret
 and
-.B \-\-tls-auth
+.B --tls-auth
 options.
=20
 Each inline file started by the line
@@ -6246,7 +6246,7 @@ Here is an example of an inline file usage
 .fi
=20
 When using the inline file feature with
-.B \-\-pkcs12
+.B --pkcs12
 the inline file has to be base64 encoded. Encoding of a .p12 file into bas=
e64 can be done for example with OpenSSL by running
 .B openssl base64 -in input.p12
=20
@@ -6265,30 +6265,30 @@ Like
 except don't re-read configuration file, and possibly don't close and reop=
en TUN/TAP
 device, re-read key files, preserve local IP address/port, or preserve mos=
t recently authenticated
 remote IP address/port based on
-.B \-\-persist-tun, \-\-persist-key, \-\-persist-local-ip,
+.B --persist-tun, --persist-key, --persist-local-ip,
 and
-.B \-\-persist-remote-ip
+.B --persist-remote-ip
 options respectively (see above).
=20
 This signal may also be internally generated by a timeout condition, gover=
ned
 by the
-.B \-\-ping-restart
+.B --ping-restart
 option.
=20
 This signal, when combined with
-.B \-\-persist-remote-ip,
+.B --persist-remote-ip,
 may be
 sent when the underlying parameters of the host's network interface change
 such as when the host is a DHCP client and is assigned a new IP address.
 See
-.B \-\-ipchange
+.B --ipchange
 above for more information.
 .\"*********************************************************
 .TP
 .B SIGUSR2
 Causes OpenVPN to display its current statistics (to the syslog
 file if
-.B \-\-daemon
+.B --daemon
 is used, or stdout otherwise).
 .\"*********************************************************
 .TP
@@ -6335,7 +6335,7 @@ If firewalls exist between
 the two machines, they should be set to forward UDP port 1194
 in both directions.  If you do not have control over the firewalls
 between the two machines, you may still be able to use OpenVPN by adding
-.B \-\-ping 15
+.B --ping 15
 to each of the
 .B openvpn
 commands used below in the examples (this will cause each peer to send out
@@ -6404,11 +6404,11 @@ you will get a weird feedback loop.
 .LP
 On may:
 .IP
-.B openvpn \-\-remote june.kg \-\-dev tun1 \-\-ifconfig 10.4.0.1 10.4.0.2 =
\-\-verb 9
+.B openvpn --remote june.kg --dev tun1 --ifconfig 10.4.0.1 10.4.0.2 --verb=
 9
 .LP
 On june:
 .IP
-.B openvpn \-\-remote may.kg \-\-dev tun1 \-\-ifconfig 10.4.0.2 10.4.0.1 \=
-\-verb 9
+.B openvpn --remote may.kg --dev tun1 --ifconfig 10.4.0.2 10.4.0.1 --verb 9
 .LP
 Now verify the tunnel is working by pinging across the tunnel.
 .LP
@@ -6421,17 +6421,17 @@ On june:
 .B ping 10.4.0.1
 .LP
 The
-.B \-\-verb 9
+.B --verb 9
 option will produce verbose output, similar to the
 .BR tcpdump (8)
 program.  Omit the
-.B \-\-verb 9
+.B --verb 9
 option to have OpenVPN run quietly.
 .\"*********************************************************
 .SS Example 2: A tunnel with static-key security (i.e. using a pre-shared =
secret)
 First build a static key on may.
 .IP
-.B openvpn \-\-genkey \-\-secret key
+.B openvpn --genkey --secret key
 .LP
 This command will build a random key file called
 .B key
@@ -6445,11 +6445,11 @@ program.
 .LP
 On may:
 .IP
-.B openvpn \-\-remote june.kg \-\-dev tun1 \-\-ifconfig 10.4.0.1 10.4.0.2 =
\-\-verb 5 \-\-secret key
+.B openvpn --remote june.kg --dev tun1 --ifconfig 10.4.0.1 10.4.0.2 --verb=
 5 --secret key
 .LP
 On june:
 .IP
-.B openvpn \-\-remote may.kg \-\-dev tun1 \-\-ifconfig 10.4.0.2 10.4.0.1 \=
-\-verb 5 \-\-secret key
+.B openvpn --remote may.kg --dev tun1 --ifconfig 10.4.0.2 10.4.0.1 --verb =
5 --secret key
 .LP
 Now verify the tunnel is working by pinging across the tunnel.
 .LP
@@ -6471,10 +6471,10 @@ as the TLS server.
=20
 First, build a separate certificate/key pair
 for both may and june (see above where
-.B \-\-cert
+.B --cert
 is discussed for more info).  Then construct
 Diffie Hellman parameters (see above where
-.B \-\-dh
+.B --dh
 is discussed for more info).  You can also use the
 included test files client.crt, client.key,
 server.crt, server.key and ca.crt.
@@ -6487,11 +6487,11 @@ parameters you can use the included file dh1024.pem.
 .LP
 On may:
 .IP
-.B openvpn \-\-remote june.kg \-\-dev tun1 \-\-ifconfig 10.4.0.1 10.4.0.2 =
\-\-tls-client \-\-ca ca.crt \-\-cert client.crt \-\-key client.key \-\-ren=
eg-sec 60 \-\-verb 5
+.B openvpn --remote june.kg --dev tun1 --ifconfig 10.4.0.1 10.4.0.2 --tls-=
client --ca ca.crt --cert client.crt --key client.key --reneg-sec 60 --verb=
 5
 .LP
 On june:
 .IP
-.B openvpn \-\-remote may.kg \-\-dev tun1 \-\-ifconfig 10.4.0.2 10.4.0.1 \=
-\-tls-server \-\-dh dh1024.pem \-\-ca ca.crt \-\-cert server.crt \-\-key s=
erver.key \-\-reneg-sec 60 \-\-verb 5
+.B openvpn --remote may.kg --dev tun1 --ifconfig 10.4.0.2 10.4.0.1 --tls-s=
erver --dh dh1024.pem --ca ca.crt --cert server.crt --key server.key --rene=
g-sec 60 --verb 5
 .LP
 Now verify the tunnel is working by pinging across the tunnel.
 .LP
@@ -6504,16 +6504,16 @@ On june:
 .B ping 10.4.0.1
 .LP
 Notice the
-.B \-\-reneg-sec 60
+.B --reneg-sec 60
 option we used above.  That tells OpenVPN to renegotiate
 the data channel keys every minute.
 Since we used
-.B \-\-verb 5
+.B --verb 5
 above, you will see status information on each new key negotiation.
=20
 For production operations, a key renegotiation interval of 60 seconds
 is probably too frequent.  Omit the
-.B \-\-reneg-sec 60
+.B --reneg-sec 60
 option to use OpenVPN's default key renegotiation interval of one hour.
 .\"*********************************************************
 .SS Routing:
@@ -6549,7 +6549,7 @@ over the secure tunnel (or vice versa).
=20
 In a production environment, you could put the route command(s)
 in a script and execute with the
-.B \-\-up
+.B --up
 option.
 .\"*********************************************************
 .SH FIREWALLS
@@ -6557,7 +6557,7 @@ OpenVPN's usage of a single UDP port makes it fairly =
firewall-friendly.
 You should add an entry to your firewall rules to allow incoming OpenVPN
 packets.  On Linux 2.4+:
 .IP
-.B iptables -A INPUT -p udp -s 1.2.3.4 \-\-dport 1194 -j ACCEPT
+.B iptables -A INPUT -p udp -s 1.2.3.4 --dport 1194 -j ACCEPT
 .LP
 This will allow incoming packets on UDP port 1194 (OpenVPN's default UDP p=
ort)
 from an OpenVPN peer at 1.2.3.4.
@@ -6568,7 +6568,7 @@ address can be considered optional, since HMAC packet=
 authentication
 is a much more secure method of verifying the authenticity of
 a packet source.  In that case:
 .IP
-.B iptables -A INPUT -p udp \-\-dport 1194 -j ACCEPT
+.B iptables -A INPUT -p udp --dport 1194 -j ACCEPT
 .LP
 would be adequate and would not render the host inflexible with
 respect to its peer having a dynamic IP address.
@@ -6577,7 +6577,7 @@ OpenVPN also works well on stateful firewalls.  In so=
me cases, you may
 not need to add any static rules to the firewall list if you are
 using a stateful firewall that knows how to track UDP connections.
 If you specify
-.B \-\-ping n,
+.B --ping n,
 OpenVPN will be guaranteed
 to send a packet to its peer at least once every
 .B n
--=20
1.9.1


