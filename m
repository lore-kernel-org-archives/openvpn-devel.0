From: samuli@...515...
Date: Mon, 11 May 2015 13:19:14 +0300
Message-Id: <1431339554-20553-1-git-send-email-samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Properly escape dashes on the man-page
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

On UTF-8 systems groff interprets unescaped dashes as hyphens and escaped d=
ashes
as minus signs. Unescaped dashes can cause problems when searching for or
copying and pasting options. This patch ensures that dashes in command-line
options are escaped and that everything else is left unescaped. This patch =
is
for the Git "master" branch.

Trac: 512
Signed-off-by: Samuli Sepp=C3=A4nen <samuli@...515...>
---
 doc/openvpn.8 | 1200 ++++++++++++++++++++++++++++-------------------------=
----
 1 file changed, 600 insertions(+), 600 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index d2f47b3..23cc789 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -234,7 +234,7 @@ Note that since UDP is connectionless, connection failu=
re
 is defined by the
 .B \-\-ping
 and
-.B \-\-ping-restart
+.B \-\-ping\-restart
 options.
=20
 Note the following corner case:  If you use multiple
@@ -273,7 +273,7 @@ chosen, providing a sort of basic load-balancing and
 failover capability.
 .\"*********************************************************
 .TP
-.B \-\-remote-random-hostname
+.B \-\-remote\-random\-hostname
 Prepend a random string (6 bytes, 12 hex characters) to hostname to prevent
 DNS caching.  For example, "foo.bar.gov" would be modified to
 "<random-chars>.foo.bar.gov".
@@ -292,7 +292,7 @@ and
 An OpenVPN client will try each connection profile sequentially
 until it achieves a successful connection.=20=20
=20
-.B \-\-remote-random
+.B \-\-remote\-random
 can be used to initially "scramble" the connection
 list.
=20
@@ -314,20 +314,20 @@ remote 198.19.34.56 443 tcp
=20
 <connection>
 remote 198.19.34.56 443 tcp
-http-proxy 192.168.0.8 8080
-http-proxy-retry
+http\-proxy 192.168.0.8 8080
+http\-proxy\-retry
 </connection>
=20
 <connection>
 remote 198.19.36.99 443 tcp
-http-proxy 192.168.0.8 8080
-http-proxy-retry
+http\-proxy 192.168.0.8 8080
+http\-proxy\-retry
 </connection>
=20
-persist-key
-persist-tun
+persist\-key
+persist\-tun
 pkcs12 client.p12
-ns-cert-type server
+ns\-cert\-type server
 verb 3
 .in -4
 .ft
@@ -346,30 +346,30 @@ a
 block:
=20
 .B bind,
-.B connect-retry,
-.B connect-retry-max,
-.B connect-timeout,
-.B explicit-exit-notify,
+.B connect\-retry,
+.B connect\-retry\-max,
+.B connect\-timeout,
+.B explicit\-exit\-notify,
 .B float,
 .B fragment,
-.B http-proxy,
-.B http-proxy-option,
-.B http-proxy-retry,
-.B http-proxy-timeout,
-.B link-mtu,
+.B http\-proxy,
+.B http\-proxy\-option,
+.B http\-proxy\-retry,
+.B http\-proxy\-timeout,
+.B link\-mtu,
 .B local,
 .B lport,
 .B mssfix,
-.B mtu-disc,
+.B mtu\-disc,
 .B nobind,
 .B port,
 .B proto,
 .B remote,
 .B rport,
-.B socks-proxy,
-.B socks-proxy-retry,
-.B tun-mtu and
-.B tun-mtu-extra.
+.B socks\-proxy,
+.B socks\-proxy\-retry,
+.B tun\-mtu and
+.B tun\-mtu\-extra.
=20
 A defaulting mechanism exists for specifying options to apply to
 all
@@ -396,14 +396,14 @@ were declared in all
 blocks below it.
 .\"*********************************************************
 .TP
-.B \-\-proto-force p
+.B \-\-proto\-force p
 When iterating through connection profiles,
 only consider profiles using protocol
 .B p
 ('tcp'|'udp').=20
 .\"*********************************************************
 .TP
-.B \-\-remote-random
+.B \-\-remote\-random
 When multiple
 .B \-\-remote
 address/ports are specified, or if connection profiles are being
@@ -418,9 +418,9 @@ for communicating with remote host.
 .B p
 can be
 .B udp,
-.B tcp-client,
+.B tcp\-client,
 or
-.B tcp-server.
+.B tcp\-server.
=20
 The default protocol is
 .B udp
@@ -433,19 +433,19 @@ For UDP operation,
 should be specified on both peers.
=20
 For TCP operation, one peer must use
-.B \-\-proto tcp-server
+.B \-\-proto tcp\-server
 and the other must use
-.B \-\-proto tcp-client.
+.B \-\-proto tcp\-client.
 A peer started with
-.B tcp-server
+.B tcp\-server
 will wait indefinitely for an incoming connection.  A peer
 started with
-.B tcp-client
+.B tcp\-client
 will attempt to connect, and if that fails, will sleep for 5
 seconds (adjustable via the
-.B \-\-connect-retry
+.B \-\-connect\-retry
 option) and try again infinite or up to N retries (adjustable via the
-.B \-\-connect-retry-max
+.B \-\-connect\-retry\-max
 option).  Both TCP client and server will simulate
 a SIGUSR1 restart signal if either side resets the connection.
=20
@@ -465,21 +465,21 @@ application-level UDP protocols, or tunneling protoco=
ls which don't
 possess a built-in reliability layer.
 .\"*********************************************************
 .TP
-.B \-\-connect-retry n
+.B \-\-connect\-retry n
 Wait
 .B n
 seconds  between connection attempts (default=3D5).
 .\"*********************************************************
 .TP
-.B \-\-connect-timeout n
+.B \-\-connect\-timeout n
 For
-.B \-\-proto tcp-client,
+.B \-\-proto tcp\-client,
 set connection timeout to
 .B n
 seconds (default=3D10).
 .\"*********************************************************
 .TP
-.B \-\-connect-retry-max n
+.B \-\-connect\-retry\-max n
 .B n
 specifies the number of times all
 .B \-\-remote
@@ -491,12 +491,12 @@ as one would try each entry exactly once. A sucessful=
 connection
 resets the counter. (default=3Dumlimited).
 .\"*********************************************************
 .TP
-.B \-\-show-proxy-settings
+.B \-\-show\-proxy\-settings
 Show sensed HTTP or SOCKS proxy settings. Currently, only Windows clients
 support this option.
 .\"*********************************************************
 .TP
-.B \-\-http-proxy server port [authfile|'auto'|'auto-nct'] [auth-method]
+.B \-\-http\-proxy server port [authfile|'auto'|'auto\-nct'] [auth-method]
 Connect to remote host through an HTTP proxy at address
 .B server
 and port
@@ -506,56 +506,56 @@ If HTTP Proxy-Authenticate is required,
 is a file containing a username and password on 2 lines, or
 "stdin" to prompt from console.
=20
-.B auth-method
+.B auth\-method
 should be one of "none", "basic", or "ntlm".
=20
 HTTP Digest authentication is supported as well, but only via
 the
 .B auto
 or
-.B auto-nct
+.B auto\-nct
 flags (below).
=20
 The
 .B auto
 flag causes OpenVPN to automatically determine the
-.B auth-method
+.B auth\-method
 and query stdin or the management interface for
 username/password credentials, if required.  This flag
 exists on OpenVPN 2.1 or higher.
=20
 The
-.B auto-nct
+.B auto\-nct
 flag (no clear-text auth) instructs OpenVPN to automatically
 determine the authentication method, but to reject weak
 authentication protocols such as HTTP Basic Authentication.
 .\"*********************************************************
 .TP
-.B \-\-http-proxy-retry
+.B \-\-http\-proxy\-retry
 Retry indefinitely on HTTP proxy errors.  If an HTTP proxy error
 occurs, simulate a SIGUSR1 reset.
 .\"*********************************************************
 .TP
-.B \-\-http-proxy-timeout n
+.B \-\-http\-proxy\-timeout n
 Set proxy timeout to
 .B n
 seconds, default=3D5.
 .\"*********************************************************
 .TP
-.B \-\-http-proxy-option type [parm]
+.B \-\-http\-proxy\-option type [parm]
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
=20
-.B CUSTOM\-HEADER name content \-\-
+.B CUSTOM\-HEADER name content --
 Adds the custom Header with
 .B name
 as name and
@@ -563,7 +563,7 @@ as name and
 as the content of the custom HTTP header.
 .\"*********************************************************
 .TP
-.B \-\-socks-proxy server [port] [authfile]
+.B \-\-socks\-proxy server [port] [authfile]
 Connect to remote host through a Socks5 proxy at address
 .B server
 and port
@@ -574,12 +574,12 @@ and port
 "stdin" to prompt from console.
 .\"*********************************************************
 .TP
-.B \-\-socks-proxy-retry
+.B \-\-socks\-proxy\-retry
 Retry indefinitely on Socks proxy errors.  If a Socks proxy error
 occurs, simulate a SIGUSR1 reset.
 .\"*********************************************************
 .TP
-.B \-\-resolv-retry n
+.B \-\-resolv\-retry n
 If hostname resolve fails for
 .B \-\-remote,
 retry resolve for
@@ -591,7 +591,7 @@ Set
 to "infinite" to retry indefinitely.
=20
 By default,
-.B \-\-resolv-retry infinite
+.B \-\-resolv\-retry infinite
 is enabled.  You can disable by setting n=3D0.
 .\"*********************************************************
 .TP
@@ -642,7 +642,7 @@ Don't use
 in
 .B \-\-mode server
 mode.  Use a
-.B \-\-client-connect
+.B \-\-client\-connect
 script instead.
=20
 See the "Environmental Variables" section below for
@@ -686,11 +686,11 @@ TCP/UDP port number or name for remote.
 .TP
 .B \-\-bind [ipv6only]
 Bind to local address and port. This is the default unless any of=20
-.B \-\-proto tcp-client
+.B \-\-proto tcp\-client
 ,
-.B \-\-http-proxy
+.B \-\-http\-proxy
 or
-.B \-\-socks-proxy
+.B \-\-socks\-proxy
 are used.
=20
 If the
@@ -727,7 +727,7 @@ devices encapsulate IPv4 or IPv6 (OSI Layer 3) while
 devices encapsulate Ethernet 802.3 (OSI Layer 2).
 .\"*********************************************************
 .TP
-.B \-\-dev-type device-type
+.B \-\-dev\-type device-type
 Which device type are we using?
 .B device-type
 should be
@@ -756,7 +756,7 @@ topology.
 If you set this directive on the server, the
 .B \-\-server
 and
-.B \-\-server-bridge
+.B \-\-server\-bridge
 directives will automatically push your chosen topology setting to clients
 as well.  This directive can also be manually pushed to clients.  Like the
 .B \-\-dev
@@ -778,7 +778,7 @@ This mode allocates a single IP address per connecting =
client.
 Only use
 when none of the connecting clients are Windows systems.  This mode
 is functionally equivalent to the
-.B \-\-ifconfig-pool-linear
+.B \-\-ifconfig\-pool\-linear
 directive which is available in OpenVPN 2.0 and is now deprecated.
=20
 .B subnet \-\-
@@ -806,7 +806,7 @@ changes the interpretation of the arguments of
 to mean "address netmask", no longer "local remote".
 .\"*********************************************************
 .TP
-.B \-\-tun-ipv6
+.B \-\-tun\-ipv6
 Build a tun link capable of forwarding IPv6 traffic.
 Should be used in conjunction with
 .B \-\-dev tun
@@ -818,16 +818,16 @@ if no specific IPv6 TUN support for your OS has been =
compiled into OpenVPN.
 See below for further IPv6-related configuration options.
 .\"*********************************************************
 .TP
-.B \-\-dev-node node
+.B \-\-dev\-node node
 Explicitly set the device node rather than using
 /dev/net/tun, /dev/tun, /dev/tap, etc.  If OpenVPN
 cannot figure out whether
 .B node
 is a TUN or TAP device based on the name, you should
 also specify
-.B \-\-dev-type tun
+.B \-\-dev\-type tun
 or
-.B \-\-dev-type tap.
+.B \-\-dev\-type tap.
=20
 Under Mac OS X this option can be used to specify the default tun
 implementation. Using
@@ -846,7 +846,7 @@ is named
 in the Network Connections Control Panel or the
 raw GUID of the adapter enclosed by braces.
 The
-.B \-\-show-adapters
+.B \-\-show\-adapters
 option under Windows can also be used
 to enumerate all available TAP-Win32
 adapters and will show both the network
@@ -932,14 +932,14 @@ getting an IP address lease from a DHCP
 server.
 .\"*********************************************************
 .TP
-.B \-\-ifconfig-noexec
+.B \-\-ifconfig\-noexec
 Don't actually execute ifconfig/netsh commands, instead
 pass
 .B \-\-ifconfig
 parameters to scripts using environmental variables.
 .\"*********************************************************
 .TP
-.B \-\-ifconfig-nowarn
+.B \-\-ifconfig\-nowarn
 Don't output an options consistency check warning
 if the
 .B \-\-ifconfig
@@ -947,7 +947,7 @@ option on this side of the
 connection doesn't match the remote side.  This is useful
 when you want to retain the overall benefits of the
 options consistency check (also see
-.B \-\-disable-occ
+.B \-\-disable\-occ
 option) while only disabling the ifconfig component of
 the check.
=20
@@ -955,7 +955,7 @@ For example,
 if you have a configuration where the local host uses
 .B \-\-ifconfig
 but the remote host does not, use
-.B \-\-ifconfig-nowarn
+.B \-\-ifconfig\-nowarn
 on the local host.
=20
 This option will also silence warnings about potential
@@ -977,11 +977,11 @@ while at the same time providing portable semantics
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
+.B \-\-route\-gateway
 or the second parameter to
 .B \-\-ifconfig
 when
@@ -989,8 +989,8 @@ when
 is specified.
=20
 .B metric
-default \-\- taken from
-.B \-\-route-metric
+default -- taken from
+.B \-\-route\-metric
 otherwise 0.
=20
 The default can be specified by leaving an option blank or setting
@@ -1005,9 +1005,9 @@ also be specified as a DNS or /etc/hosts
 file resolvable name, or as one of three special keywords:
=20
 .B vpn_gateway
-\-\- The remote VPN endpoint address
+-- The remote VPN endpoint address
 (derived either from
-.B \-\-route-gateway
+.B \-\-route\-gateway
 or the second parameter to
 .B \-\-ifconfig
 when
@@ -1015,16 +1015,16 @@ when
 is specified).
=20
 .B net_gateway
-\-\- The pre-existing IP default gateway, read from the routing
+-- The pre-existing IP default gateway, read from the routing
 table (not supported on all OSes).
=20
 .B remote_host
-\-\- The
+-- The
 .B \-\-remote
 address if OpenVPN is being run in client mode, and is undefined in server=
 mode.
 .\"*********************************************************
 .TP
-.B \-\-route-gateway gw|'dhcp'
+.B \-\-route\-gateway gw|'dhcp'
 Specify a default gateway
 .B gw
 for use with
@@ -1037,14 +1037,14 @@ the gateway address will be extracted from a DHCP
 negotiation with the OpenVPN server-side LAN.
 .\"*********************************************************
 .TP
-.B \-\-route-metric m
+.B \-\-route\-metric m
 Specify a default metric
 .B m
 for use with
 .B \-\-route.
 .\"*********************************************************
 .TP
-.B \-\-route-delay [n] [w]
+.B \-\-route\-delay [n] [w]
 Delay
 .B n
 seconds (default=3D0) after connection
@@ -1052,7 +1052,7 @@ establishment, before adding routes. If
 .B n
 is 0, routes will be added immediately upon connection
 establishment.  If
-.B \-\-route-delay
+.B \-\-route\-delay
 is omitted, routes will be added immediately after TUN/TAP device
 open and
 .B \-\-up
@@ -1070,18 +1070,18 @@ tap adapter addresses.  The delay will give the DHC=
P handshake
 time to complete before routes are added.
=20
 On Windows,
-.B \-\-route-delay
+.B \-\-route\-delay
 tries to be more intelligent by waiting
 .B w
 seconds (w=3D30 by default)
 for the TAP-Win32 adapter to come up before adding routes.
 .\"*********************************************************
 .TP
-.B \-\-route-up cmd
+.B \-\-route\-up cmd
 Run command
 .B cmd
 after routes are added, subject to
-.B \-\-route-delay.
+.B \-\-route\-delay.
=20
 .B cmd
 consists of a path to script (or executable program), optionally
@@ -1092,7 +1092,7 @@ See the "Environmental Variables" section below for
 additional parameters passed as environmental variables.
 .\"*********************************************************
 .TP
-.B \-\-route-pre-down cmd
+.B \-\-route\-pre\-down cmd
 Run command
 .B cmd
 before routes are removed upon disconnection.
@@ -1106,13 +1106,13 @@ See the "Environmental Variables" section below for
 additional parameters passed as environmental variables.
 .\"*********************************************************
 .TP
-.B \-\-route-noexec
+.B \-\-route\-noexec
 Don't add or remove routes automatically.  Instead pass routes to
-.B \-\-route-up
+.B \-\-route\-up
 script using environmental variables.
 .\"*********************************************************
 .TP
-.B \-\-route-nopull
+.B \-\-route\-nopull
 When used with
 .B \-\-client
 or
@@ -1126,16 +1126,16 @@ however note that this option still allows the serv=
er
 to set the TCP/IP properties of the client's TUN/TAP interface.
 .\"*********************************************************
 .TP
-.B \-\-allow-pull-fqdn
+.B \-\-allow\-pull\-fqdn
 Allow client to pull DNS names from server (rather than being limited
 to IP address) for
 .B \-\-ifconfig,
 .B \-\-route,
 and
-.B \-\-route-gateway.
+.B \-\-route\-gateway.
 .\"*********************************************************
 .TP
-.B \-\-client-nat snat|dnat network netmask alias
+.B \-\-client\-nat snat|dnat network netmask alias
 This pushable client option sets up a stateless one-to-one NAT
 rule on packet addresses (not ports), and is useful in cases
 where routes or ifconfig settings pushed to the client would
@@ -1160,7 +1160,7 @@ for debugging info showing the transformation of src/=
dest
 addresses in packets.
 .\"*********************************************************
 .TP
-.B \-\-redirect-gateway flags...
+.B \-\-redirect\-gateway flags...
 Automatically execute routing commands to cause all outgoing IP traffic
 to be redirected over the VPN.  This is a client-side option.
=20
@@ -1179,7 +1179,7 @@ Delete the default gateway route.
=20
 .B (3)
 Set the new default gateway to be the VPN endpoint address (derived either=
 from
-.B \-\-route-gateway
+.B \-\-route\-gateway
 or the second parameter to
 .B \-\-ifconfig
 when
@@ -1206,43 +1206,43 @@ Try to automatically determine whether to enable
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
+.B \-\-link\-mtu n
 Sets an upper bound on the size of UDP packets which are sent
 between OpenVPN peers.  It's best not to set this parameter unless
 you know what you're doing.
 .\"*********************************************************
 .\"*********************************************************
 .TP
-.B \-\-redirect-private [flags]
-Like \-\-redirect-gateway, but omit actually changing the default
+.B \-\-redirect\-private [flags]
+Like \-\-redirect\-gateway, but omit actually changing the default
 gateway.  Useful when pushing private subnets.
 .\"*********************************************************
 .TP
-.B \-\-tun-mtu n
+.B \-\-tun\-mtu n
 Take the TUN device MTU to be
 .B n
 and derive the link MTU
@@ -1264,11 +1264,11 @@ and/or
 options to deal with MTU sizing issues.
 .\"*********************************************************
 .TP
-.B \-\-tun-mtu-extra n
+.B \-\-tun\-mtu\-extra n
 Assume that the TUN/TAP device might return as many as
 .B n
 bytes more than the
-.B \-\-tun-mtu
+.B \-\-tun\-mtu
 size on read.  This parameter defaults to 0, which is sufficient for
 most TUN devices.  TAP devices may introduce additional overhead in excess
 of the MTU size, and a setting of 32 is the default when TAP devices are u=
sed.
@@ -1276,30 +1276,30 @@ This parameter only controls internal OpenVPN buffe=
r sizing,
 so there is no transmission overhead associated with using a larger value.
 .\"*********************************************************
 .TP
-.B \-\-mtu-disc type
+.B \-\-mtu\-disc type
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
+.B \-\-mtu\-test
 To empirically measure MTU on connection startup,
 add the
-.B \-\-mtu-test
+.B \-\-mtu\-test
 option to your configuration.
 OpenVPN will send ping packets of various sizes
 to the remote peer and measure the largest packets
 which were successfully received.  The
-.B \-\-mtu-test
+.B \-\-mtu\-test
 process normally takes about 3 minutes to complete.
 .\"*********************************************************
 .TP
@@ -1313,7 +1313,7 @@ bytes.
 The
 .B max
 parameter is interpreted in the same way as the
-.B \-\-link-mtu
+.B \-\-link\-mtu
 parameter, i.e. the UDP packet size after encapsulation
 overhead has been added in, but not including
 the UDP header itself.
@@ -1355,7 +1355,7 @@ bytes. The default value is
 The
 .B max
 parameter is interpreted in the same way as the
-.B \-\-link-mtu
+.B \-\-link\-mtu
 parameter, i.e. the UDP packet size after encapsulation
 overhead has been added in, but not including
 the UDP header itself.
@@ -1405,7 +1405,7 @@ Therefore, one could lower the maximum UDP packet size
 to 1300 (a good first try for solving MTU-related
 connection problems) with the following options:
=20
-.B \-\-tun-mtu 1500 \-\-fragment 1300 \-\-mssfix
+.B \-\-tun\-mtu 1500 \-\-fragment 1300 \-\-mssfix
 .\"*********************************************************
 .TP
 .B \-\-sndbuf size
@@ -1424,7 +1424,7 @@ matched in policy routing and packetfilter rules. Thi=
s option is
 only supported in Linux and does nothing on other operating systems.
 .\"*********************************************************
 .TP
-.B \-\-socket-flags flags...
+.B \-\-socket\-flags flags...
 Apply the given flags to the OpenVPN transport socket.
 Currently, only
 .B TCP_NODELAY
@@ -1516,9 +1516,9 @@ seconds (specify
 on both peers to cause ping packets to be sent in both directions since
 OpenVPN ping packets are not echoed like IP ping packets).
 When used in one of OpenVPN's secure modes (where
-.B \-\-secret, \-\-tls-server,
+.B \-\-secret, \-\-tls\-server,
 or
-.B \-\-tls-client
+.B \-\-tls\-client
 is specified), the ping packet
 will be cryptographically secure.
=20
@@ -1531,11 +1531,11 @@ pass will not time out.
=20
 (2) To provide a basis for the remote to test the existence
 of its peer using the
-.B \-\-ping-exit
+.B \-\-ping\-exit
 option.
 .\"*********************************************************
 .TP
-.B \-\-ping-exit n
+.B \-\-ping\-exit n
 Causes OpenVPN to exit after
 .B n
 seconds pass without reception of a ping
@@ -1543,21 +1543,21 @@ or other packet from remote.
 This option can be combined with
 .B \-\-inactive, \-\-ping,
 and
-.B \-\-ping-exit
+.B \-\-ping\-exit
 to create a two-tiered inactivity disconnect.
=20
 For example,
=20
-.B openvpn [options...] \-\-inactive 3600 \-\-ping 10 \-\-ping-exit 60
+.B openvpn [options...] \-\-inactive 3600 \-\-ping 10 \-\-ping\-exit 60
=20
 when used on both peers will cause OpenVPN to exit within 60
 seconds if its peer disconnects, but will exit after one
 hour if no actual tunnel data is exchanged.
 .\"*********************************************************
 .TP
-.B \-\-ping-restart n
+.B \-\-ping\-restart n
 Similar to
-.B \-\-ping-exit,
+.B \-\-ping\-exit,
 but trigger a
 .B SIGUSR1
 restart after
@@ -1578,11 +1578,11 @@ If the peer cannot be reached, a restart will be tr=
iggered, causing
 the hostname used with
 .B \-\-remote
 to be re-resolved (if
-.B \-\-resolv-retry
+.B \-\-resolv\-retry
 is also specified).
=20
 In server mode,
-.B \-\-ping-restart, \-\-inactive,
+.B \-\-ping\-restart, \-\-inactive,
 or any other type of internally generated signal will always be
 applied to
 individual client instance objects, never to whole server itself.
@@ -1591,14 +1591,14 @@ which would normally cause a restart, will cause th=
e deletion
 of the client instance object instead.
=20
 In client mode, the
-.B \-\-ping-restart
+.B \-\-ping\-restart
 parameter is set to 120 seconds by default.  This default will
 hold until the client pulls a replacement value from the server, based on
 the
 .B \-\-keepalive
 setting in the server configuration.
 To disable the 120 second default, set
-.B \-\-ping-restart 0
+.B \-\-ping\-restart 0
 on the client.
=20
 See the signals section below for more information
@@ -1608,15 +1608,15 @@ on
 Note that the behavior of
 .B SIGUSR1
 can be modified by the
-.B \-\-persist-tun, \-\-persist-key, \-\-persist-local-ip,
+.B \-\-persist\-tun, \-\-persist\-key, \-\-persist\-local\-ip,
 and
-.B \-\-persist-remote-ip
+.B \-\-persist\-remote\-ip
 options.
=20
 Also note that
-.B \-\-ping-exit
+.B \-\-ping\-exit
 and
-.B \-\-ping-restart
+.B \-\-ping\-restart
 are mutually exclusive and cannot be used together.
 .\"*********************************************************
 .TP
@@ -1624,7 +1624,7 @@ are mutually exclusive and cannot be used together.
 A helper directive designed to simplify the expression of
 .B \-\-ping
 and
-.B \-\-ping-restart
+.B \-\-ping\-restart
 in server mode configurations.
=20
 The server timeout is set twice the value of the second argument.
@@ -1640,22 +1640,22 @@ expands as follows:
 .in +4
  if mode server:
    ping 10
-   ping-restart 120
+   ping\-restart 120
    push "ping 10"
-   push "ping-restart 60"
+   push "ping\-restart 60"
  else
    ping 10
-   ping-restart 60
+   ping\-restart 60
 .in -4
 .ft
 .fi
 .\"*********************************************************
 .TP
-.B \-\-ping-timer-rem
+.B \-\-ping\-timer\-rem
 Run the
-.B \-\-ping-exit
+.B \-\-ping\-exit
 /
-.B \-\-ping-restart
+.B \-\-ping\-restart
 timer only if we have a remote address.  Use this option if you are
 starting the daemon in listen mode (i.e. without an explicit
 .B \-\-remote
@@ -1663,12 +1663,12 @@ peer), and you don't want to start clocking timeout=
s until a remote
 peer connects.
 .\"*********************************************************
 .TP
-.B \-\-persist-tun
+.B \-\-persist\-tun
 Don't close and reopen TUN/TAP device or run up/down scripts
 across
 .B SIGUSR1
 or
-.B \-\-ping-restart
+.B \-\-ping\-restart
 restarts.
=20
 .B SIGUSR1
@@ -1678,11 +1678,11 @@ but which offers finer-grained control over
 reset options.
 .\"*********************************************************
 .TP
-.B \-\-persist-key
+.B \-\-persist\-key
 Don't re-read key files across
 .B SIGUSR1
 or
-.B \-\-ping-restart.
+.B \-\-ping\-restart.
=20
 This option can be combined with
 .B \-\-user nobody
@@ -1698,21 +1698,21 @@ This option solves the problem by persisting keys a=
cross
 resets, so they don't need to be re-read.
 .\"*********************************************************
 .TP
-.B \-\-persist-local-ip
+.B \-\-persist\-local\-ip
 Preserve initially resolved local IP address and port number
 across
 .B SIGUSR1
 or
-.B \-\-ping-restart
+.B \-\-ping\-restart
 restarts.
 .\"*********************************************************
 .TP
-.B \-\-persist-remote-ip
+.B \-\-persist\-remote\-ip
 Preserve most recently authenticated remote IP address and port number
 across
 .B SIGUSR1
 or
-.B \-\-ping-restart
+.B \-\-ping\-restart
 restarts.
 .\"*********************************************************
 .TP
@@ -1790,19 +1790,19 @@ In this context, the last command line parameter pa=
ssed to the script
 will be
 .I init.
 If the
-.B \-\-up-restart
+.B \-\-up\-restart
 option is also used, the up script will be called for restarts as
 well.  A restart is considered to be a partial reinitialization
 of OpenVPN where the TUN/TAP instance is preserved (the
-.B \-\-persist-tun
+.B \-\-persist\-tun
 option will enable such preservation).  A restart
 can be generated by a SIGUSR1 signal, a
-.B \-\-ping-restart
+.B \-\-ping\-restart
 timeout, or a connection reset when the TCP protocol is enabled
 with the
 .B \-\-proto
 option.  If a restart occurs, and
-.B \-\-up-restart
+.B \-\-up\-restart
 has been specified, the up script will be called with
 .I restart
 as the last parameter.
@@ -1814,7 +1814,7 @@ script can be called in both an initialization and re=
start context.
 9999 is blocked by your firewall.  Also, the example will run indefinitely,
 so you should abort with control-c).
=20
-.B openvpn \-\-dev tun \-\-port 9999 \-\-verb 4 \-\-ping-restart 10 \-\-up=
 'echo up' \-\-down 'echo down' \-\-persist-tun \-\-up-restart
+.B openvpn \-\-dev tun \-\-port 9999 \-\-verb 4 \-\-ping\-restart 10 \-\-u=
p 'echo up' \-\-down 'echo down' \-\-persist\-tun \-\-up\-restart
=20
 Note that OpenVPN also provides the
 .B \-\-ifconfig
@@ -1833,10 +1833,10 @@ and remote endpoints on the command line to the
 .B \-\-up
 script so that they can be used to configure routes such as:
=20
-.B route add -net 10.0.0.0 netmask 255.255.255.0 gw $5
+.B route add \-net 10.0.0.0 netmask 255.255.255.0 gw $5
 .\"*********************************************************
 .TP
-.B \-\-up-delay
+.B \-\-up\-delay
 Delay TUN/TAP open and possible
 .B \-\-up
 script execution
@@ -1882,13 +1882,13 @@ your
 script will also run at reduced privilege.
 .\"*********************************************************
 .TP
-.B \-\-down-pre
+.B \-\-down\-pre
 Call
 .B \-\-down
 cmd/script before, rather than after, TUN/TAP close.
 .\"*********************************************************
 .TP
-.B \-\-up-restart
+.B \-\-up\-restart
 Enable the
 .B \-\-up
 and
@@ -1927,10 +1927,10 @@ Versions prior to OpenVPN 2.3.3 will always ignore =
options set with the
 directive.
=20
 See also
-.B \-\-ignore-unknown-option
+.B \-\-ignore\-unknown\-option
 .\"*********************************************************
 .TP
-.B \-\-setenv-safe name value
+.B \-\-setenv\-safe name value
 Set a custom environmental variable
 .B OPENVPN_name=3Dvalue
 to pass to script.
@@ -1941,13 +1941,13 @@ is a safety precaution to prevent a LD_PRELOAD styl=
e attack
 from a malicious or compromised server.
 .\"*********************************************************
 .TP
-.B \-\-ignore-unknown-option opt1 opt2 opt3 ... optN
+.B \-\-ignore\-unknown\-option opt1 opt2 opt3 ... optN
 When one of options
 .B opt1 ... optN
 is encountered in the configuration file the configuration
 file parsing does not fail if this OpenVPN version does not
 support the option. Multiple
-.B \-\-ignore-unknown-option
+.B \-\-ignore\-unknown\-option
 options can be given to support a larger number of options to ignore.
=20
 This option should be used with caution, as there are good security
@@ -1956,11 +1956,11 @@ config file. Having said that, there are valid reas=
ons for wanting
 new software features to gracefully degrade when encountered by
 older software versions.
=20
-.B \-\-ignore-unknown-option
+.B \-\-ignore\-unknown\-option
 is available since OpenVPN 2.3.3.
 .\"*********************************************************
 .TP
-.B \-\-script-security level
+.B \-\-script\-security level
 This directive offers policy-level control over OpenVPN's usage of externa=
l programs
 and scripts.  Lower
 .B level
@@ -2015,7 +2015,7 @@ flag was removed is due to the security implications =
with shell expansions
 when executing scripts via the system() call.
 .\"*********************************************************
 .TP
-.B \-\-disable-occ
+.B \-\-disable\-occ
 Don't output a warning message if option inconsistencies are detected betw=
een
 peers.  An example of an option inconsistency would be where one peer uses
 .B \-\-dev tun
@@ -2143,9 +2143,9 @@ allow many things required only during initialization.
 Like with chroot, complications can result when scripts
 or restarts are executed after the setcon operation,
 which is why you should really consider using the
-.B \-\-persist-key
+.B \-\-persist\-key
 and
-.B \-\-persist-tun
+.B \-\-persist\-tun
 options.
 .\"*********************************************************
 .TP
@@ -2195,7 +2195,7 @@ directive above for description of
 .B progname
 parameter.
 .TP
-.B \-\-errors-to-stderr
+.B \-\-errors\-to\-stderr
 Output errors to stderr instead of stdout unless log output is redirected =
by one of the
 .B \-\-log
 options.
@@ -2216,7 +2216,7 @@ option must match what is specified in the inetd/xine=
td
 config file.  The
 .B nowait
 mode can only be used with
-.B \-\-proto tcp-server.
+.B \-\-proto tcp\-server.
 The default is
 .B wait.
 The
@@ -2265,14 +2265,14 @@ is also specified.
 This option is persistent over the entire course of
 an OpenVPN instantiation and will not be reset by SIGHUP,
 SIGUSR1, or
-.B \-\-ping-restart.
+.B \-\-ping\-restart.
=20
 Note that on Windows, when OpenVPN is started as a service,
 logging occurs by default without the need to specify
 this option.
 .\"*********************************************************
 .TP
-.B \-\-log-append file
+.B \-\-log\-append file
 Append logging messages to
 .B file.
 If
@@ -2284,13 +2284,13 @@ except that it appends to rather
 than truncating the log file.
 .\"*********************************************************
 .TP
-.B \-\-suppress-timestamps
+.B \-\-suppress\-timestamps
 Avoid writing timestamps to log messages, even when they
 otherwise would be prepended. In particular, this applies to
 log messages sent to stdout.
 .\"*********************************************************
 .TP
-.B \-\-machine-readable-output
+.B \-\-machine\-readable\-output
 Always write timestamps and message flags to log messages, even when they
 otherwise would not be prefixed. In particular, this applies to
 log messages sent to stdout.
@@ -2310,14 +2310,14 @@ greater than 0 is lower priority,
 less than zero is higher priority).
 .\"*********************************************************
 .\".TP
-.\".B \-\-nice-work n
+.\".B \-\-nice\-work n
 .\"Change priority of background TLS work thread.  The TLS thread
 .\"feature is enabled when OpenVPN is built
 .\"with pthread support, and you are running OpenVPN
 .\"in TLS mode (i.e. with
-.\".B \-\-tls-client
+.\".B \-\-tls\-client
 .\"or
-.\".B \-\-tls-server
+.\".B \-\-tls\-server
 .\"specified).
 .\"
 .\"Using a TLS thread offloads the CPU-intensive process of SSL/TLS-based
@@ -2332,7 +2332,7 @@ less than zero is higher priority).
 .\"than the main thread.
 .\"*********************************************************
 .TP
-.B \-\-fast-io
+.B \-\-fast\-io
 (Experimental) Optimize TUN/TAP/UDP I/O writes by avoiding
 a call to poll/epoll/select prior to the write operation.  The purpose
 of such a call would normally be to block until the device
@@ -2378,7 +2378,7 @@ Designed to be used to send messages to a controlling=
 application
 which is receiving the OpenVPN log output.
 .\"*********************************************************
 .TP
-.B \-\-remap-usr1 signal
+.B \-\-remap\-usr1 signal
 Control whether internally or externally
 generated SIGUSR1 signals are remapped to
 SIGHUP (restart without persisting state) or
@@ -2427,7 +2427,7 @@ Status can also be written to the syslog by sending a
 signal.
 .\"*********************************************************
 .TP
-.B \-\-status-version [n]
+.B \-\-status\-version [n]
 Choose the status file format version number.  Currently
 .B n
 can be 1, 2, or 3 and defaults to 1.
@@ -2449,7 +2449,7 @@ parameter may be "snappy", "lzo", "lz4", or empty.  S=
nappy, LZO and LZ4
 are different compression algorithms, with Snappy generally
 offering the best performance while LZ4 is faster with less CPU usage.
 For backwards compatibility with OpenVPN versions before 2.4, use "lzo"
-(which is identical to the older option "\-\-comp-lzo yes").
+(which is identical to the older option "\-\-comp\-lzo yes").
=20
 If the
 .B algorithm
@@ -2458,8 +2458,8 @@ framing for compression will still be enabled, allowi=
ng a different
 setting to be pushed later.
 .\"*********************************************************
 .TP
-.B \-\-comp-lzo [mode]
-Use LZO compression \-\- may add up to 1 byte per
+.B \-\-comp\-lzo [mode]
+Use LZO compression -- may add up to 1 byte per
 packet for incompressible data.
 .B mode
 may be "yes", "no", or "adaptive" (default).
@@ -2473,40 +2473,40 @@ compression on or off for individual clients.
=20
 First, make sure the client-side config file enables selective
 compression by having at least one
-.B \-\-comp-lzo
+.B \-\-comp\-lzo
 directive, such as
-.B \-\-comp-lzo no.
+.B \-\-comp\-lzo no.
 This will turn off compression by default,
 but allow a future directive push from the server to
 dynamically change the
 on/off/adaptive setting.
=20
 Next in a
-.B \-\-client-config-dir
+.B \-\-client\-config\-dir
 file, specify the compression setting for the client,
 for example:
=20
 .nf
 .ft 3
 .in +4
-comp-lzo yes
-push "comp-lzo yes"
+comp\-lzo yes
+push "comp\-lzo yes"
 .in -4
 .ft
 .fi
=20
 The first line sets the
-.B comp-lzo
+.B comp\-lzo
 setting for the server
 side of the link, the second sets the client side.
 .\"*********************************************************
 .TP
-.B \-\-comp-noadapt
+.B \-\-comp\-noadapt
 When used in conjunction with
-.B \-\-comp-lzo,
+.B \-\-comp\-lzo,
 this option will disable OpenVPN's adaptive compression algorithm.
 Normally, adaptive compression is enabled with
-.B \-\-comp-lzo.
+.B \-\-comp\-lzo.
=20
 Adaptive compression tries to optimize the case where you have
 compression enabled, but you are sending predominantly incompressible
@@ -2537,9 +2537,9 @@ and set
 .B port
 to 'unix'.  While the default behavior is to create a unix domain socket
 that may be connected to by any process, the
-.B \-\-management-client-user
+.B \-\-management\-client\-user
 and
-.B \-\-management-client-group
+.B \-\-management\-client\-group
 directives can be used to restrict access.
=20
 The management interface provides a special mode where the TCP
@@ -2556,7 +2556,7 @@ to the port, using a telnet client in "raw" mode.  On=
ce connected,
 type "help" for a list of commands.
=20
 For detailed documentation on the management interface, see
-the management-notes.txt file in the
+the management\-notes.txt file in the
 .B management
 folder of
 the OpenVPN source distribution.
@@ -2567,7 +2567,7 @@ be set to 127.0.0.1
 (localhost) to restrict accessibility of the management
 server to local clients.=20
 .TP
-.B \-\-management-client
+.B \-\-management\-client
 Management interface will connect as a TCP/unix domain client to
 .B IP:port
 specified by
@@ -2578,33 +2578,33 @@ If the client connection fails to connect or is dis=
connected,
 a SIGTERM signal will be generated causing OpenVPN to quit.
 .\"*********************************************************
 .TP
-.B \-\-management-query-passwords
+.B \-\-management\-query\-passwords
 Query management channel for private key password and
-.B \-\-auth-user-pass
+.B \-\-auth\-user\-pass
 username/password.  Only query the management channel
 for inputs which ordinarily would have been queried from the
 console.
 .\"*********************************************************
 .TP
-.B \-\-management-query-proxy
+.B \-\-management\-query\-proxy
 Query management channel for proxy server information for a specific
 .B \-\-remote
 (client-only).
 .\"*********************************************************
 .TP
-.B \-\-management-query-remote
+.B \-\-management\-query\-remote
 Allow management interface to override
 .B \-\-remote
 directives (client-only).
 .\"*********************************************************
 .TP
-.B \-\-management-external-key
+.B \-\-management\-external\-key
 Allows usage for external private key file instead of
 .B \-\-key
 option (client-only).
 .\"*********************************************************
 .TP
-.B \-\-management-external-cert certificate-hint
+.B \-\-management\-external\-cert certificate-hint
 Allows usage for external certificate instead of
 .B \-\-cert
 option (client-only).
@@ -2613,16 +2613,16 @@ is an arbitrary string which is passed to a managem=
ent
 interface client as an argument of NEED-CERTIFICATE notification.
 .\"*********************************************************
 .TP
-.B \-\-management-forget-disconnect
+.B \-\-management\-forget\-disconnect
 Make OpenVPN forget passwords when management session
 disconnects.
=20
 This directive does not affect the
-.B \-\-http-proxy
+.B \-\-http\-proxy
 username/password.  It is always cached.
 .\"*********************************************************
 .TP
-.B \-\-management-hold
+.B \-\-management\-hold
 Start OpenVPN in a hibernating state, until a client
 of the management interface explicitly starts it
 with the
@@ -2630,45 +2630,45 @@ with the
 command.
 .\"*********************************************************
 .TP
-.B \-\-management-signal
+.B \-\-management\-signal
 Send SIGUSR1 signal to OpenVPN if management session disconnects.
 This is useful when you wish to disconnect an OpenVPN session on
-user logoff. For --management-client this option is not needed since
+user logoff. For \-\-management\-client this option is not needed since
 a disconnect will always generate a SIGTERM.
 .\"*********************************************************
 .TP
-.B \-\-management-log-cache n
+.B \-\-management\-log\-cache n
 Cache the most recent
 .B n
 lines of log file history for usage
 by the management channel.
 .\"*********************************************************
 .TP
-.B \-\-management-up-down
+.B \-\-management\-up\-down
 Report tunnel up/down events to management interface.
 .B=20
 .\"*********************************************************
 .TP
-.B \-\-management-client-auth
+.B \-\-management\-client\-auth
 Gives management interface client the responsibility
 to authenticate clients after their client certificate
 has been verified.  See management-notes.txt in OpenVPN
 distribution for detailed notes.
 .\"*********************************************************
 .TP
-.B \-\-management-client-pf
+.B \-\-management\-client\-pf
 Management interface clients must specify a packet
-filter file for each connecting client.  See management-notes.txt
+filter file for each connecting client.  See management\-notes.txt
 in OpenVPN distribution for detailed notes.
 .\"*********************************************************
 .TP
-.B \-\-management-client-user u
+.B \-\-management\-client\-user u
 When the management interface is listening on a unix domain socket,
 only allow connections from user
 .B u.
 .\"*********************************************************
 .TP
-.B \-\-management-client-group g
+.B \-\-management\-client\-group g
 When the management interface is listening on a unix domain socket,
 only allow connections from group
 .B g.
@@ -2702,8 +2702,8 @@ OpenVPN in the order that they are declared in the co=
nfig
 file.  If both a plugin and script are configured for the same
 callback, the script will be called last.  If the
 return code of the module/script controls an authentication
-function (such as tls-verify, auth-user-pass-verify, or
-client-connect), then
+function (such as tls\-verify, auth\-user\-pass\-verify, or
+client\-connect), then
 every module and script must return success (0) in order for
 the connection to be authenticated.
 .\"*********************************************************
@@ -2737,15 +2737,15 @@ expands as follows:
 .ft 3
 .in +4
  mode server
- tls-server
+ tls\-server
  push "topology [topology]"
=20
  if dev tun AND (topology =3D=3D net30 OR topology =3D=3D p2p):
    ifconfig 10.8.0.1 10.8.0.2
    if !nopool:
-     ifconfig-pool 10.8.0.4 10.8.0.251
+     ifconfig\-pool 10.8.0.4 10.8.0.251
    route 10.8.0.0 255.255.255.0
-   if client-to-client:
+   if client\-to\-client:
      push "route 10.8.0.0 255.255.255.0"
    else if topology =3D=3D net30:
      push "route 10.8.0.1"
@@ -2753,10 +2753,10 @@ expands as follows:
  if dev tap OR (dev tun AND topology =3D=3D subnet):
    ifconfig 10.8.0.1 255.255.255.0
    if !nopool:
-     ifconfig-pool 10.8.0.2 10.8.0.254 255.255.255.0
-   push "route-gateway 10.8.0.1"
-   if route-gateway unset:
-     route-gateway 10.8.0.2
+     ifconfig\-pool 10.8.0.2 10.8.0.254 255.255.255.0
+   push "route\-gateway 10.8.0.1"
+   if route\-gateway unset:
+     route\-gateway 10.8.0.2
=20
 .in -4
 .ft
@@ -2765,13 +2765,13 @@ expands as follows:
 Don't use
 .B \-\-server
 if you are ethernet bridging.  Use
-.B \-\-server-bridge
+.B \-\-server\-bridge
 instead.
 .\"*********************************************************
 .TP
-.B \-\-server-bridge gateway netmask pool-start-IP pool-end-IP
+.B \-\-server\-bridge gateway netmask pool-start-IP pool-end-IP
 .TP
-.B \-\-server-bridge ['nogw']
+.B \-\-server\-bridge ['nogw']
=20
 A helper directive similar to
 .B \-\-server
@@ -2779,7 +2779,7 @@ which is designed to simplify the configuration
 of OpenVPN's server mode in ethernet bridging configurations.
=20
 If
-.B \-\-server-bridge
+.B \-\-server\-bridge
 is used without any parameters, it will enable a DHCP-proxy
 mode, where connecting OpenVPN clients will receive an IP
 address for their TAP adapter from the DHCP server running
@@ -2807,7 +2807,7 @@ IP/netmask on the bridge interface.  The
 and
 .B netmask
 parameters to
-.B \-\-server-bridge
+.B \-\-server\-bridge
 can be set to either the IP/netmask of the
 bridge interface, or the IP/netmask of the
 default gateway/router on the bridged
@@ -2823,45 +2823,45 @@ for OpenVPN to allocate to connecting
 clients.
=20
 For example,
-.B server-bridge 10.8.0.4 255.255.255.0 10.8.0.128 10.8.0.254
+.B server\-bridge 10.8.0.4 255.255.255.0 10.8.0.128 10.8.0.254
 expands as follows:
=20
 .nf
 .ft 3
 .in +4
 mode server
-tls-server
+tls\-server
=20
-ifconfig-pool 10.8.0.128 10.8.0.254 255.255.255.0
-push "route-gateway 10.8.0.4"
+ifconfig\-pool 10.8.0.128 10.8.0.254 255.255.255.0
+push "route\-gateway 10.8.0.4"
 .in -4
 .ft
 .fi
=20
 In another example,
-.B \-\-server-bridge
+.B \-\-server\-bridge
 (without parameters) expands as follows:
=20
 .nf
 .ft 3
 .in +4
 mode server
-tls-server
+tls\-server
=20
-push "route-gateway dhcp"
+push "route\-gateway dhcp"
 .in -4
 .ft
 .fi
=20
 Or
-.B \-\-server-bridge nogw
+.B \-\-server\-bridge nogw
 expands as follows:
=20
 .nf
 .ft 3
 .in +4
 mode server
-tls-server
+tls\-server
 .in -4
 .ft
 .fi
@@ -2884,26 +2884,26 @@ cannot be pushed because the client needs to know
 them before the connection to the server can be initiated.
=20
 This is a partial list of options which can currently be pushed:
-.B \-\-route, \-\-route-gateway, \-\-route-delay, \-\-redirect-gateway,
-.B \-\-ip-win32, \-\-dhcp-option,
-.B \-\-inactive, \-\-ping, \-\-ping-exit, \-\-ping-restart,
+.B \-\-route, \-\-route\-gateway, \-\-route\-delay, \-\-redirect\-gateway,
+.B \-\-ip\-win32, \-\-dhcp\-option,
+.B \-\-inactive, \-\-ping, \-\-ping\-exit, \-\-ping\-restart,
 .B \-\-setenv,
-.B \-\-persist-key, \-\-persist-tun, \-\-echo,
-.B \-\-comp-lzo,
-.B \-\-socket-flags,
+.B \-\-persist\-key, \-\-persist\-tun, \-\-echo,
+.B \-\-comp\-lzo,
+.B \-\-socket\-flags,
 .B \-\-sndbuf, \-\-rcvbuf
 .\"*********************************************************
 .TP
-.B \-\-push-reset
+.B \-\-push\-reset
 Don't inherit the global push list for a specific client instance.
 Specify this option in a client-specific context such
 as with a
-.B \-\-client-config-dir
+.B \-\-client\-config\-dir
 configuration file.  This option will ignore
 .B \-\-push
 options at the global config file level.
 .TP
-.B \-\-push-peer-info
+.B \-\-push\-peer\-info
 Push additional information about the client to server.  The additional in=
formation
 consists of the following data:
=20
@@ -2923,19 +2923,19 @@ Disable a particular client (based on the common na=
me)
 from connecting.  Don't use this option to disable a client
 due to key or password compromise.  Use a CRL (certificate
 revocation list) instead (see the
-.B \-\-crl-verify
+.B \-\-crl\-verify
 option).
=20
 This option must be associated with a specific client instance,
 which means that it must be specified either in a client
 instance config file using
-.B \-\-client-config-dir
+.B \-\-client\-config\-dir
 or dynamically generated using a
-.B \-\-client-connect
+.B \-\-client\-connect
 script.
 .\"*********************************************************
 .TP
-.B \-\-ifconfig-pool start-IP end-IP [netmask]
+.B \-\-ifconfig\-pool start-IP end-IP [netmask]
 Set aside a pool of subnets to be
 dynamically allocated to connecting clients, similar
 to a DHCP server.  For tun-style
@@ -2948,8 +2948,8 @@ parameter will also be pushed to clients.
=20
 .\"*********************************************************
 .TP
-.B \-\-ifconfig-pool-persist file [seconds]
-Persist/unpersist ifconfig-pool
+.B \-\-ifconfig\-pool\-persist file [seconds]
+Persist/unpersist ifconfig\-pool
 data to
 .B file,
 at
@@ -2963,7 +2963,7 @@ IP address assigned to them from the ifconfig-pool.
 Maintaining a long-term
 association is good for clients because it allows them
 to effectively use the
-.B \-\-persist-tun
+.B \-\-persist\-tun
 option.
=20
 .B file
@@ -2984,12 +2984,12 @@ suggestions only, based on past associations between
 a common name and IP address.  They do not guarantee that the given common
 name will always receive the given IP address.  If you want guaranteed
 assignment, use
-.B \-\-ifconfig-push
+.B \-\-ifconfig\-push
 .\"*********************************************************
 .TP
-.B \-\-ifconfig-pool-linear
+.B \-\-ifconfig\-pool\-linear
 Modifies the
-.B \-\-ifconfig-pool
+.B \-\-ifconfig\-pool
 directive to
 allocate individual TUN interface addresses for
 clients rather than /30 subnets.  NOTE:  This option
@@ -3000,21 +3000,21 @@ This option is deprecated, and should be replaced w=
ith
 which is functionally equivalent.
 .\"*********************************************************
 .TP
-.B \-\-ifconfig-push local remote-netmask [alias]
+.B \-\-ifconfig\-push local remote\-netmask [alias]
 Push virtual IP endpoints for client tunnel,
-overriding the \-\-ifconfig-pool dynamic allocation.
+overriding the \-\-ifconfig\-pool dynamic allocation.
=20
 The parameters
 .B local
 and
-.B remote-netmask
+.B remote\-netmask
 are set according to the
 .B \-\-ifconfig
 directive which you want to execute on the client machine to
 configure the remote end of the tunnel.  Note that the parameters
 .B local
 and
-.B remote-netmask
+.B remote\-netmask
 are from the perspective of the client, not the server.  They may be
 DNS names rather than IP addresses, in which case they will be resolved
 on the server at the time of client connection.
@@ -3023,17 +3023,17 @@ The optional
 .B alias
 parameter may be used in cases where NAT causes the client view
 of its local endpoint to differ from the server view.  In this case
-.B local/remote-netmask
+.B local/remote\-netmask
 will refer to the server view while
-.B alias/remote-netmask
+.B alias/remote\-netmask
 will refer to the client view.
=20
 This option must be associated with a specific client instance,
 which means that it must be specified either in a client
 instance config file using
-.B \-\-client-config-dir
+.B \-\-client\-config\-dir
 or dynamically generated using a
-.B \-\-client-connect
+.B \-\-client\-connect
 script.
=20
 Remember also to include a
@@ -3047,18 +3047,18 @@ OpenVPN's internal client IP address selection algo=
rithm works as
 follows:
=20
 .B 1
-\-\- Use
-.B \-\-client-connect script
+-- Use
+.B \-\-client\-connect script
 generated file for static IP (first choice).
 .br
 .B 2
-\-\- Use
-.B \-\-client-config-dir
+-- Use
+.B \-\-client\-config\-dir
 file for static IP (next choice).
 .br
 .B 3
-\-\- Use
-.B \-\-ifconfig-pool
+-- Use
+.B \-\-ifconfig\-pool
 allocation for dynamic IP (last choice).
 .br
 .\"*********************************************************
@@ -3085,9 +3085,9 @@ directive routes to the specific client.
=20
 This option must be specified either in a client
 instance config file using
-.B \-\-client-config-dir
+.B \-\-client\-config\-dir
 or dynamically generated using a
-.B \-\-client-connect
+.B \-\-client\-connect
 script.
=20
 The
@@ -3103,7 +3103,7 @@ subnet, you can use
 .B \-\-push
 "route ..."
 together with
-.B \-\-client-to-client
+.B \-\-client\-to\-client
 to effect this.  In order for all clients to see
 A's subnet, OpenVPN must push this route to all clients
 EXCEPT for A, since the subnet is already owned by A.
@@ -3112,11 +3112,11 @@ not pushing a route to a client
 if it matches one of the client's iroutes.
 .\"*********************************************************
 .TP
-.B \-\-client-to-client
+.B \-\-client\-to\-client
 Because the OpenVPN server mode handles multiple clients
 through a single tun or tap interface, it is effectively
 a router.  The
-.B \-\-client-to-client
+.B \-\-client\-to\-client
 flag tells OpenVPN to internally route client-to-client
 traffic rather than pushing all client-originating traffic
 to the TUN/TAP interface.
@@ -3128,13 +3128,13 @@ if you want to firewall tunnel traffic using
 custom, per-client rules.
 .\"*********************************************************
 .TP
-.B \-\-duplicate-cn
+.B \-\-duplicate\-cn
 Allow multiple clients with the same common name to concurrently connect.
 In the absence of this option, OpenVPN will disconnect a client instance
 upon connection of a new client having the same common name.
 .\"*********************************************************
 .TP
-.B \-\-client-connect cmd
+.B \-\-client\-connect cmd
 Run
 .B command cmd
 on client connection.
@@ -3159,7 +3159,7 @@ to be applied on the server when the client connects,
 it should write it to the file named by the last argument.
=20
 See the
-.B \-\-client-config-dir
+.B \-\-client\-config\-dir
 option below for options which
 can be legally used in a dynamically generated config file.
=20
@@ -3171,18 +3171,18 @@ returns a non-zero error status, it will cause the =
client
 to be disconnected.
 .\"*********************************************************
 .TP
-.B \-\-client-disconnect cmd
+.B \-\-client\-disconnect cmd
 Like
-.B \-\-client-connect
+.B \-\-client\-connect
 but called on client instance shutdown.  Will not be called
 unless the
-.B \-\-client-connect
+.B \-\-client\-connect
 script and plugins (if defined)
 were previously called on this instance with
 successful (0) status returns.
=20
 The exception to this rule is if the
-.B \-\-client-disconnect
+.B \-\-client\-disconnect
 command or plugins are cascaded, and at least one client-connect
 function succeeded, then ALL of the client-disconnect functions for
 scripts and plugins will be called on client instance object deletion,
@@ -3190,16 +3190,16 @@ even in cases where some of the related client-conn=
ect functions returned
 an error status.
=20
 The
-.B \-\-client-disconnect
+.B \-\-client\-disconnect
 command is passed the same pathname as the corresponding
-.B \-\-client-connect
+.B \-\-client\-connect
 command as its last argument. (after any arguments specified in
 .B cmd
 ).
 .B=20
 .\"*********************************************************
 .TP
-.B \-\-client-config-dir dir
+.B \-\-client\-config\-dir dir
 Specify a directory
 .B dir
 for custom client config files.  After
@@ -3215,7 +3215,7 @@ after it has dropped it's root privileges.
=20
 This file can specify a fixed IP address for a given
 client using
-.B \-\-ifconfig-push,
+.B \-\-ifconfig\-push,
 as well as fixed subnets owned by the client using
 .B \-\-iroute.
=20
@@ -3226,19 +3226,19 @@ without needing to restart the server.
=20
 The following
 options are legal in a client-specific context:
-.B \-\-push, \-\-push-reset, \-\-iroute, \-\-ifconfig-push,
+.B \-\-push, \-\-push\-reset, \-\-iroute, \-\-ifconfig\-push,
 and
 .B \-\-config.
 .\"*********************************************************
 .TP
-.B \-\-ccd-exclusive
+.B \-\-ccd\-exclusive
 Require, as a
 condition of authentication, that a connecting client has a
-.B \-\-client-config-dir
+.B \-\-client\-config\-dir
 file.
 .\"*********************************************************
 .TP
-.B \-\-tmp-dir dir
+.B \-\-tmp\-dir dir
 Specify a directory
 .B dir
 for temporary files.  This directory will be used by
@@ -3250,7 +3250,7 @@ after it has dropped it's root privileges.
 This directory will be used by in the following cases:
=20
 *
-.B \-\-client-connect
+.B \-\-client\-connect
 scripts to dynamically generate client-specific
 configuration files.
=20
@@ -3264,7 +3264,7 @@ when using deferred auth method
 plugin hook to pass filtering rules via pf_file
 .\"*********************************************************
 .TP
-.B \-\-hash-size r v
+.B \-\-hash\-size r v
 Set the size of the real address hash table to
 .B r
 and the virtual address table to
@@ -3272,13 +3272,13 @@ and the virtual address table to
 By default, both tables are sized at 256 buckets.
 .\"*********************************************************
 .TP
-.B \-\-bcast-buffers n
+.B \-\-bcast\-buffers n
 Allocate
 .B n
 buffers for broadcast datagrams (default=3D256).
 .\"*********************************************************
 .TP
-.B \-\-tcp-queue-limit n
+.B \-\-tcp\-queue\-limit n
 Maximum number of output packets queued before TCP (default=3D64).
=20
 When OpenVPN is tunneling data from a TUN/TAP device to a
@@ -3290,7 +3290,7 @@ OpenVPN will start to drop outgoing packets directed
 at this client.
 .\"*********************************************************
 .TP
-.B \-\-tcp-nodelay
+.B \-\-tcp\-nodelay
 This macro sets the TCP_NODELAY socket flag on the server
 as well as pushes it to connecting clients.  The TCP_NODELAY
 flag disables the Nagle algorithm on TCP sockets causing
@@ -3306,20 +3306,20 @@ The macro expands as follows:
 .ft 3
 .in +4
  if mode server:
-   socket-flags TCP_NODELAY
-   push "socket-flags TCP_NODELAY"
+   socket\-flags TCP_NODELAY
+   push "socket\-flags TCP_NODELAY"
 .in -4
 .ft
 .fi
 .\"*********************************************************
 .TP
-.B \-\-max-clients n
+.B \-\-max\-clients n
 Limit server to a maximum of
 .B n
 concurrent clients.
 .\"*********************************************************
 .TP
-.B \-\-max-routes-per-client n
+.B \-\-max\-routes\-per\-client n
 Allow a maximum of
 .B n
 internal routes per client (default=3D256).
@@ -3329,9 +3329,9 @@ server with packets appearing to come from many uniqu=
e MAC addresses,
 forcing the server to deplete
 virtual memory as its internal routing table expands.
 This directive can be used in a
-.B \-\-client-config-dir
+.B \-\-client\-config\-dir
 file or auto-generated by a
-.B \-\-client-connect
+.B \-\-client\-connect
 script to override the global value for a particular client.
=20
 Note that this
@@ -3339,7 +3339,7 @@ directive affects OpenVPN's internal routing table, n=
ot the
 kernel routing table.
 .\"*********************************************************
 .TP
-.B \-\-stale-routes-check n [t]
+.B \-\-stale\-routes\-check n [t]
 Remove routes haven't had activity for
 .B n
 seconds (i.e. the ageing time).
@@ -3355,10 +3355,10 @@ is not present it defaults to
=20
 This option helps to keep the dynamic routing table small.
 See also
-.B \-\-max-routes-per-client
+.B \-\-max\-routes\-per\-client
 .\"*********************************************************
 .TP
-.B \-\-connect-freq n sec
+.B \-\-connect\-freq n sec
 Allow a maximum of
 .B n
 new connections per
@@ -3374,10 +3374,10 @@ For the best protection against DoS attacks in serv=
er mode,
 use
 .B \-\-proto udp
 and
-.B \-\-tls-auth.
+.B \-\-tls\-auth.
 .\"*********************************************************
 .TP
-.B \-\-learn-address cmd
+.B \-\-learn\-address cmd
 Run command
 .B cmd
 to validate client virtual addresses or routes.
@@ -3423,7 +3423,7 @@ policies with regard to the client's high-level commo=
n name,
 rather than the low level client virtual addresses.
 .\"*********************************************************
 .TP
-.B \-\-auth-user-pass-verify cmd method
+.B \-\-auth\-user\-pass\-verify cmd method
 Require the client to provide a username/password (possibly
 in addition to a client certificate) for authentication.
=20
@@ -3439,7 +3439,7 @@ and/or escaped using a backslash, and should be separ=
ated by one or more spaces.
=20
 If
 .B method
-is set to "via-env", OpenVPN will call
+is set to "via\-env", OpenVPN will call
 .B script
 with the environmental variables
 .B username
@@ -3452,17 +3452,17 @@ unprivileged processes.
=20
 If
 .B method
-is set to "via-file", OpenVPN will write the username and
+is set to "via\-file", OpenVPN will write the username and
 password to the first two lines of a temporary file.  The filename
 will be passed as an argument to
 .B script,
 and the file will be automatically deleted by OpenVPN after
 the script returns.  The location of the temporary file is
 controlled by the
-.B \-\-tmp-dir
+.B \-\-tmp\-dir
 option, and will default to the current directory if unspecified.
 For security, consider setting=20
-.B \-\-tmp-dir
+.B \-\-tmp\-dir
 to a volatile storage medium such as
 .B /dev/shm
 (if available) to prevent the username/password file from touching the har=
d drive.
@@ -3490,30 +3490,30 @@ strings are handled.  Never use these strings in su=
ch a way
 that they might be escaped or evaluated by a shell interpreter.
=20
 For a sample script that performs PAM authentication, see
-.B sample-scripts/auth-pam.pl
+.B sample\-scripts/auth\-pam.pl
 in the OpenVPN source distribution.
 .\"*********************************************************
 .TP
-.B \-\-opt-verify
+.B \-\-opt\-verify
 Clients that connect with options that are incompatible
 with those of the server will be disconnected.
=20
 Options that will be compared for compatibility include
-dev-type, link-mtu, tun-mtu, proto, tun-ipv6, ifconfig,
-comp-lzo, fragment, keydir, cipher, auth, keysize, secret,
-no-replay, no-iv, tls-auth, key-method, tls-server, and tls-client.
+dev\-type, link\-mtu, tun\-mtu, proto, tun\-ipv6, ifconfig,
+comp\-lzo, fragment, keydir, cipher, auth, keysize, secret,
+no\-replay, no\-iv, tls\-auth, key\-method, tls\-server, and tls\-client.
=20
 This option requires that
-.B \-\-disable-occ
+.B \-\-disable\-occ
 NOT be used.
 .\"*********************************************************
 .TP
-.B \-\-auth-user-pass-optional
+.B \-\-auth\-user\-pass\-optional
 Allow connections by clients that do not specify a username/password.
 Normally, when
-.B \-\-auth-user-pass-verify
+.B \-\-auth\-user\-pass\-verify
 or
-.B \-\-management-client-auth
+.B \-\-management\-client\-auth
 is specified (or an authentication plugin module), the
 OpenVPN server daemon will require connecting clients to specify a
 username and password.  This option makes the submission of a username/pas=
sword
@@ -3526,29 +3526,29 @@ to empty strings ("").  The authentication module/s=
cript MUST have logic
 to detect this condition and respond accordingly.
 .\"*********************************************************
 .TP
-.B \-\-client-cert-not-required
+.B \-\-client\-cert\-not\-required
 Don't require client certificate, client will authenticate
 using username/password only.  Be aware that using this directive
 is less secure than requiring certificates from all clients.
=20
 If you use this directive, the
 entire responsibility of authentication will rest on your
-.B \-\-auth-user-pass-verify
+.B \-\-auth\-user\-pass\-verify
 script, so keep in mind that bugs in your script
 could potentially compromise the security of your VPN.
=20
 If you don't use this directive, but you also specify an
-.B \-\-auth-user-pass-verify
+.B \-\-auth\-user\-pass\-verify
 script, then OpenVPN will perform double authentication.  The
 client certificate verification AND the
-.B \-\-auth-user-pass-verify
+.B \-\-auth\-user\-pass\-verify
 script will need to succeed in order for a client to be
 authenticated and accepted onto the VPN.
 .\"*********************************************************
 .TP
-.B \-\-username-as-common-name
+.B \-\-username\-as\-common\-name
 For
-.B \-\-auth-user-pass-verify
+.B \-\-auth\-user\-pass\-verify
 authentication, use
 the authenticated username as the common name,
 rather than the common name from the client cert.
@@ -3600,9 +3600,9 @@ carriage-return. no-remapping is only available on th=
e server side.
 This option is immediately deprecated.  It is only implemented
 to make the transition to the new formatting less intrusive.  It will be
 removed either in OpenVPN v2.4 or v2.5.  So please make sure you use the
-.B \-\-verify-x509-name
+.B \-\-verify\-x509\-name
 option instead of
-.B \-\-tls-remote
+.B \-\-tls\-remote
 as soon as possible and update your scripts where necessary.
 .\"*********************************************************
 .TP
@@ -3623,7 +3623,7 @@ described with the
 option as soon as possible.
 .\"*********************************************************
 .TP
-.B \-\-port-share host port [dir]
+.B \-\-port\-share host port [dir]
 When run in TCP server mode, share the OpenVPN port with
 another application, such as an HTTPS server.  If OpenVPN
 senses a connection to its port which is using a non-OpenVPN
@@ -3648,7 +3648,7 @@ Not implemented on Windows.
 .SS Client Mode
 Use client mode when connecting to an OpenVPN server
 which has
-.B \-\-server, \-\-server-bridge,
+.B \-\-server, \-\-server\-bridge,
 or
 .B \-\-mode server
 in it's configuration.
@@ -3662,7 +3662,7 @@ of OpenVPN's client mode.  This directive is equivale=
nt to:
 .ft 3
 .in +4
  pull
- tls-client
+ tls\-client
 .in -4
 .ft
 .fi
@@ -3689,12 +3689,12 @@ in situations where you don't trust the server to h=
ave control
 over the client's routing table.
 .\"*********************************************************
 .TP
-.B \-\-auth-user-pass [up]
+.B \-\-auth\-user\-pass [up]
 Authenticate with server using username/password.
 .B up
 is a file containing username/password on 2 lines (Note: OpenVPN
 will only read passwords from a file if it has been built
-with the \-\-enable-password-save configure option, or on Windows
+with the \-\-enable\-password\-save configure option, or on Windows
 by defining ENABLE_PASSWORD_SAVE in win/settings.in).
=20
 If
@@ -3703,12 +3703,12 @@ is omitted, username/password will be prompted from=
 the
 console.
=20
 The server configuration must specify an
-.B \-\-auth-user-pass-verify
+.B \-\-auth\-user\-pass\-verify
 script to verify the username/password provided by
 the client.
 .\"*********************************************************
 .TP
-.B \-\-auth-retry type
+.B \-\-auth\-retry type
 Controls how OpenVPN responds to username/password verification
 errors such as the client-side response to an AUTH_FAILED message from the=
 server
 or verification failure of the private key password.
@@ -3719,9 +3719,9 @@ of error.
=20
 An AUTH_FAILED message is generated by the server if the client
 fails
-.B \-\-auth-user-pass
+.B \-\-auth\-user\-pass
 authentication, or if the server-side
-.B \-\-client-connect
+.B \-\-client\-connect
 script returns an error status when the client
 tries to connect.
=20
@@ -3733,12 +3733,12 @@ Client will exit with a fatal error (this is the de=
fault).
 .br
 .B nointeract \-\-
 Client will retry the connection without requerying for an
-.B \-\-auth-user-pass
+.B \-\-auth\-user\-pass
 username/password.  Use this option for unattended clients.
 .br
 .B interact \-\-
 Client will requery for an
-.B \-\-auth-user-pass
+.B \-\-auth\-user\-pass
 username/password and/or private key password before attempting a reconnec=
tion.
=20
 Note that while this option cannot be pushed, it can be controlled
@@ -3760,14 +3760,14 @@ See management\-notes.txt in the OpenVPN distributi=
on for a
 description of the OpenVPN challenge/response protocol.
 .\"*********************************************************
 .TP
-.B \-\-server-poll-timeout n
+.B \-\-server\-poll\-timeout n
 when polling possible remote servers to connect to
 in a round-robin fashion, spend no more than
 .B n
 seconds waiting for a response before trying the next server.
 .\"*********************************************************
 .TP
-.B \-\-explicit-exit-notify [n]
+.B \-\-explicit\-exit\-notify [n]
 In UDP client mode or point-to-point mode, send server/peer an exit notifi=
cation
 if tunnel is restarted or OpenVPN process is exited.  In client mode, on
 exit/restart, this
@@ -3849,9 +3849,9 @@ would see nothing
 but random-looking data.
 .\"*********************************************************
 .TP
-.B \-\-key-direction
+.B \-\-key\-direction
 Alternative way of specifying the optional direction parameter for the
-.B \-\-tls-auth
+.B \-\-tls\-auth
 and
 .B \-\-secret
 options. Useful when using inline files (See section on inline files).
@@ -3900,7 +3900,7 @@ For more information on blowfish, see
=20
 To see other ciphers that are available with
 OpenVPN, use the
-.B \-\-show-ciphers
+.B \-\-show\-ciphers
 option.
=20
 OpenVPN supports the CBC, CFB, and OFB cipher modes,
@@ -3915,7 +3915,7 @@ to disable encryption.
 .B \-\-keysize n
 Size of cipher key in bits (optional).
 If unspecified, defaults to cipher-specific default.  The
-.B \-\-show-ciphers
+.B \-\-show\-ciphers
 option (see below) shows all available OpenSSL ciphers,
 their default key sizes, and whether the key size can
 be changed.  Use care in changing a cipher's default
@@ -3947,12 +3947,12 @@ If
 .B engine-name
 is specified,
 use a specific crypto engine.  Use the
-.B \-\-show-engines
+.B \-\-show\-engines
 standalone option to list the crypto engines which are
 supported by OpenSSL.
 .\"*********************************************************
 .TP
-.B \-\-no-replay
+.B \-\-no\-replay
 (Advanced) Disable OpenVPN's protection against replay attacks.
 Don't use this option unless you are prepared to make
 a tradeoff of greater efficiency in exchange for less
@@ -3996,7 +3996,7 @@ algorithm used
 by IPSec.
 .\"*********************************************************
 .TP
-.B \-\-replay-window n [t]
+.B \-\-replay\-window n [t]
 Use a replay protection sliding-window of size
 .B n
 and a time window of
@@ -4025,7 +4025,7 @@ the TCP/IP protocol stack, provided they satisfy seve=
ral constraints.
=20
 .B (a)
 The packet cannot be a replay (unless
-.B \-\-no-replay
+.B \-\-no\-replay
 is specified, which disables replay protection altogether).
=20
 .B (b)
@@ -4083,7 +4083,7 @@ parameters of what is to be expected from the physica=
l IP layer.  The problem
 is easily fixed by simply using TCP as the VPN transport layer.
 .\"*********************************************************
 .TP
-.B \-\-mute-replay-warnings
+.B \-\-mute\-replay\-warnings
 Silence the output of replay warnings, which are a common
 false alarm on WiFi networks.  This option preserves
 the security of the replay protection code without
@@ -4091,7 +4091,7 @@ the verbosity associated with warnings about duplicate
 packets.
 .\"*********************************************************
 .TP
-.B \-\-replay-persist file
+.B \-\-replay\-persist file
 Persist replay-protection state across sessions using
 .B file
 to save and reload the state.
@@ -4112,10 +4112,10 @@ This option only makes sense when replay protection=
 is enabled
 (the default) and you are using either
 .B \-\-secret
 (shared-secret key mode) or TLS mode with
-.B \-\-tls-auth.
+.B \-\-tls\-auth.
 .\"*********************************************************
 .TP
-.B \-\-no-iv
+.B \-\-no\-iv
 (Advanced) Disable OpenVPN's use of IV (cipher initialization vector).
 Don't use this option unless you are prepared to make
 a tradeoff of greater efficiency in exchange for less
@@ -4136,7 +4136,7 @@ space-saving optimization that uses the unique identi=
fier for
 datagram replay protection as the IV.
 .\"*********************************************************
 .TP
-.B \-\-use-prediction-resistance
+.B \-\-use\-prediction\-resistance
 Enable prediction resistance on PolarSSL's RNG.
=20
 Enabling prediction resistance causes the RNG to reseed in each
@@ -4150,7 +4150,7 @@ Note that this option only works with PolarSSL versio=
ns greater
 than 1.1.
 .\"*********************************************************
 .TP
-.B \-\-test-crypto
+.B \-\-test\-crypto
 Do a self-test of OpenVPN's crypto options by encrypting and
 decrypting test packets using the data channel encryption options
 specified above.  This option does not require a peer to function,
@@ -4160,14 +4160,14 @@ or
 .B \-\-remote.
=20
 The typical usage of
-.B \-\-test-crypto
+.B \-\-test\-crypto
 would be something like this:
=20
-.B openvpn \-\-test-crypto \-\-secret key
+.B openvpn \-\-test\-crypto \-\-secret key
=20
 or
=20
-.B openvpn \-\-test-crypto \-\-secret key \-\-verb 9
+.B openvpn \-\-test\-crypto \-\-secret key \-\-verb 9
=20
 This option is very useful to test OpenVPN after it has been ported to
 a new platform, or to isolate problems in the compiler, OpenSSL
@@ -4218,14 +4218,14 @@ The easy-rsa package is also rendered in web form h=
ere:
 .I http://openvpn.net/easyrsa.html
 .\"*********************************************************
 .TP
-.B \-\-tls-server
+.B \-\-tls\-server
 Enable TLS and assume server role during TLS handshake.  Note that
 OpenVPN is designed as a peer-to-peer application.  The designation
 of client or server is only for the purpose of negotiating the TLS
 control channel.
 .\"*********************************************************
 .TP
-.B \-\-tls-client
+.B \-\-tls\-client
 Enable TLS and assume client role during TLS handshake.
 .\"*********************************************************
 .TP
@@ -4236,7 +4236,7 @@ certificate.  This file can have multiple
 certificates in .pem format, concatenated together.  You can construct you=
r own
 certificate authority certificate and private key by using a command such =
as:
=20
-.B openssl req -nodes -new -x509 -keyout ca.key -out ca.crt
+.B openssl req \-nodes \-new \-x509 \-keyout ca.key \-out ca.crt
=20
 Then edit your openssl.cnf file and edit the
 .B certificate
@@ -4260,7 +4260,7 @@ Not available with PolarSSL.
 .B \-\-dh file
 File containing Diffie Hellman parameters
 in .pem format (required for
-.B \-\-tls-server
+.B \-\-tls\-server
 only).
=20
 Set
@@ -4270,20 +4270,20 @@ requires peers to be using an SSL library that supp=
orts ECDH TLS cipher suites
 (e.g. OpenSSL 1.0.1+, or PolarSSL 1.3+).
=20
 Use
-.B openssl dhparam -out dh2048.pem 2048
+.B openssl dhparam \-out dh2048.pem 2048
 to generate 2048-bit DH parameters. Diffie Hellman parameters may be consi=
dered
 public.
 .\"*********************************************************
 .TP
-.B \-\-ecdh-curve name
+.B \-\-ecdh\-curve name
 Specify the curve to use for elliptic curve Diffie Hellman. Available
 curves can be listed with
-.B \-\-show-curves
+.B \-\-show\-curves
 . The specified curve will only be used for ECDH TLS-ciphers.
 .\"*********************************************************
 .TP
 .B \-\-cert file
-Local peer's signed certificate in .pem format \-\- must be signed
+Local peer's signed certificate in .pem format -- must be signed
 by a certificate authority whose certificate is in
 .B \-\-ca file.
 Each peer in an OpenVPN link running in TLS mode should have its own
@@ -4298,14 +4298,14 @@ helping to finance the world's second space tourist=
 :).
 To generate a certificate,
 you can use a command such as:
=20
-.B openssl req -nodes -new -keyout mycert.key -out mycert.csr
+.B openssl req \-nodes \-new \-keyout mycert.key \-out mycert.csr
=20
 If your certificate authority private key lives on another machine, copy
 the certificate signing request (mycert.csr) to this other machine (this c=
an
 be done over an insecure channel such as email).  Now sign the certificate
 with a command such as:
=20
-.B openssl ca -out mycert.crt -in mycert.csr
+.B openssl ca \-out mycert.crt \-in mycert.csr
=20
 Now copy the certificate (mycert.crt)
 back to the peer which initially generated the .csr file (this
@@ -4315,7 +4315,7 @@ Note that the
 command reads the location of the certificate authority key from its
 configuration file such as
 .B /usr/share/ssl/openssl.cnf
-\-\- note also
+-- note also
 that for certificate authority functions, you must set up the files
 .B index.txt
 (may be empty) and
@@ -4326,7 +4326,7 @@ that for certificate authority functions, you must se=
t up the files
 ).
 .\"*********************************************************
 .TP
-.B \-\-extra-certs file
+.B \-\-extra\-certs file
 Specify a
 .B file
 containing one or more PEM certs (concatenated together)
@@ -4345,11 +4345,11 @@ file.
 .B \-\-key file
 Local peer's private key in .pem format.  Use the private key which was ge=
nerated
 when you built your peer's certificate (see
-.B -cert file
+.B \-\-cert file
 above).
 .\"*********************************************************
 .TP
-.B \-\-tls-version-min version ['or-highest']
+.B \-\-tls\-version\-min version ['or\-highest']
 Sets the minimum
 TLS version we will accept from the peer (default is "1.0").
 Examples for version
@@ -4358,7 +4358,7 @@ and version is not recognized, we will only accept th=
e highest TLS
 version supported by the local SSL implementation.
 .\"*********************************************************
 .TP
-.B \-\-tls-version-max version
+.B \-\-tls\-version\-max version
 Set the maximum TLS version we will use (default is the highest version
 supported).  Examples for version include "1.0", "1.1", or "1.2".
 .\"*********************************************************
@@ -4373,7 +4373,7 @@ and
 Not available with PolarSSL.
 .\"*********************************************************
 .TP
-.B \-\-verify-hash hash
+.B \-\-verify\-hash hash
 Specify SHA1 fingerprint for level-1 cert.  The level-1 cert is the
 CA (or intermediate cert) that signs the leaf certificate, and is
 one removed from the leaf certificate in the direction of the root.
@@ -4384,36 +4384,36 @@ or certificate verification will fail.  Hash is spe=
cified
 as XX:XX:...  For example: AD:B0:95:D8:09:C8:36:45:12:A9:89:C8:90:09:CB:13=
:72:A6:AD:16
 .\"*********************************************************
 .TP
-.B \-\-pkcs11-cert-private [0|1]...
+.B \-\-pkcs11\-cert\-private [0|1]...
 Set if access to certificate object should be performed after login.
 Every provider has its own setting.
 .\"*********************************************************
 .TP
-.B \-\-pkcs11-id name
+.B \-\-pkcs11\-id name
 Specify the serialized certificate id to be used. The id can be gotten
 by the standalone
-.B \-\-show-pkcs11-ids
+.B \-\-show\-pkcs11\-ids
 option.
 .\"*********************************************************
 .TP
-.B \-\-pkcs11-id-management
+.B \-\-pkcs11\-id\-management
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
+.B \-\-pkcs11\-pin\-cache seconds
 Specify how many seconds the PIN can be cached, the default is until the t=
oken is removed.
 .\"*********************************************************
 .TP
-.B \-\-pkcs11-protected-authentication [0|1]...
+.B \-\-pkcs11\-protected\-authentication [0|1]...
 Use PKCS#11 protected authentication path, useful for biometric and extern=
al
 keypad devices.
 Every provider has its own setting.
 .\"*********************************************************
 .TP
-.B \-\-pkcs11-providers provider...
+.B \-\-pkcs11\-providers provider...
 Specify a RSA Security Inc. PKCS #11 Cryptographic Token Interface (Crypto=
ki) providers
 to load.
 This option can be used instead of
@@ -4422,7 +4422,7 @@ and
 .B \-\-pkcs12.
=20
 If p11-kit is present on the system, its
-.B p11-kit-proxy.so
+.B p11\-kit\-proxy.so
 module will be loaded by default if either the
 .B \-\-pkcs11\-id
 or
@@ -4432,25 +4432,25 @@ options are specified without
 being given.
 .\"*********************************************************
 .TP
-.B \-\-pkcs11-private-mode mode...
+.B \-\-pkcs11\-private\-mode mode...
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
@@ -4487,7 +4487,7 @@ Certificate Store GUI.
=20
 .\"*********************************************************
 .TP
-.B \-\-key-method m
+.B \-\-key\-method m
 Use data channel key negotiation method
 .B m.
 The key method must match on both sides of the connection.
@@ -4515,12 +4515,12 @@ of keying occur:
 of the connection producing certificates and verifying the certificate
 (or other authentication info provided) of
 the other side.  The
-.B \-\-key-method
+.B \-\-key\-method
 parameter has no effect on this process.
=20
 (2) After the TLS connection is established, the tunnel session keys are
 separately negotiated over the existing secure TLS channel.  Here,
-.B \-\-key-method
+.B \-\-key\-method
 determines the derivation of the tunnel session keys.
 .\"*********************************************************
 .TP
@@ -4548,11 +4548,11 @@ is an expert feature, which - if used correcly - ca=
n improve the security of
 your VPN connection.  But it is also easy to unwittingly use it to careful=
ly
 align a gun with your foot, or just break your connection.  Use with care!
=20
-The default for --tls-cipher is to use PolarSSL's default cipher list
+The default for \-\-tls\-cipher is to use PolarSSL's default cipher list
 when using PolarSSL or "DEFAULT:!EXP:!PSK:!SRP:!kRSA" when using OpenSSL.
 .\"*********************************************************
 .TP
-.B \-\-tls-timeout n
+.B \-\-tls\-timeout n
 Packet retransmit timeout on TLS control channel
 if no acknowledgment from remote within
 .B n
@@ -4569,7 +4569,7 @@ the higher level network protocols running on top of =
the tunnel
 such as TCP expect this role to be left to them.
 .\"*********************************************************
 .TP
-.B \-\-reneg-bytes n
+.B \-\-reneg\-bytes n
 Renegotiate data channel key after
 .B n
 bytes sent or received (disabled by default).
@@ -4579,13 +4579,13 @@ a number of seconds.  A key renegotiation will be f=
orced
 if any of these three criteria are met by either peer.
 .\"*********************************************************
 .TP
-.B \-\-reneg-pkts n
+.B \-\-reneg\-pkts n
 Renegotiate data channel key after
 .B n
 packets sent and received (disabled by default).
 .\"*********************************************************
 .TP
-.B \-\-reneg-sec n
+.B \-\-reneg\-sec n
 Renegotiate data channel key after
 .B n
 seconds (default=3D3600).
@@ -4596,16 +4596,16 @@ cause the end user to be challenged to reauthorize =
once per hour.
 Also, keep in mind that this option can be used on both the client and ser=
ver,
 and whichever uses the lower value will be the one to trigger the renegoti=
ation.
 A common mistake is to set
-.B \-\-reneg-sec
+.B \-\-reneg\-sec
 to a higher value on either the client or server, while the other side of =
the connection
 is still using the default value of 3600 seconds, meaning that the renegot=
iation will
-still occur once per 3600 seconds.  The solution is to increase \-\-reneg-=
sec on both the
+still occur once per 3600 seconds.  The solution is to increase \-\-reneg\=
-sec on both the
 client and server, or set it to 0 on one side of the connection (to disabl=
e), and to
 your chosen value on the other side.
 .\"*********************************************************
 .TP
-.B \-\-hand-window n
-Handshake Window \-\- the TLS-based key exchange must finalize within
+.B \-\-hand\-window n
+Handshake Window -- the TLS-based key exchange must finalize within
 .B n
 seconds
 of handshake initiation by any peer (default =3D 60 seconds).
@@ -4613,47 +4613,47 @@ If the handshake fails
 we will attempt to reset our connection with our peer and try again.
 Even in the event of handshake failure we will still use
 our expiring key for up to
-.B \-\-tran-window
+.B \-\-tran\-window
 seconds to maintain continuity of transmission of tunnel
 data.
 .\"*********************************************************
 .TP
-.B \-\-tran-window n
-Transition window \-\- our old key can live this many seconds
+.B \-\-tran\-window n
+Transition window -- our old key can live this many seconds
 after a new a key renegotiation begins (default =3D 3600 seconds).
 This feature allows for a graceful transition from old to new
 key, and removes the key renegotiation sequence from the critical
 path of tunnel data forwarding.
 .\"*********************************************************
 .TP
-.B \-\-single-session
+.B \-\-single\-session
 After initially connecting to a remote peer, disallow any new connections.
 Using this
 option means that a remote peer cannot connect, disconnect, and then
 reconnect.
=20
 If the daemon is reset by a signal or
-.B \-\-ping-restart,
+.B \-\-ping\-restart,
 it will allow one new connection.
=20
-.B \-\-single-session
+.B \-\-single\-session
 can be used with
-.B \-\-ping-exit
+.B \-\-ping\-exit
 or
 .B \-\-inactive
 to create a single dynamic session that will exit when finished.
 .\"*********************************************************
 .TP
-.B \-\-tls-exit
+.B \-\-tls\-exit
 Exit on TLS negotiation failure.
 .\"*********************************************************
 .TP
-.B \-\-tls-auth file [direction]
+.B \-\-tls\-auth file [direction]
 Add an additional layer of HMAC authentication on top of the TLS
 control channel to protect against DoS attacks.
=20
 In a nutshell,
-.B \-\-tls-auth
+.B \-\-tls\-auth
 enables a kind of "HMAC firewall" on OpenVPN's TCP/UDP port,
 where TLS control channel packets
 bearing an incorrect HMAC signature can be dropped immediately without
@@ -4672,7 +4672,7 @@ option for more information on the optional
 .B direction
 parameter.
=20
-.B \-\-tls-auth
+.B \-\-tls\-auth
 is recommended when you are running OpenVPN in a mode where
 it is listening for packets from any IP address, such as when
 .B \-\-remote
@@ -4706,7 +4706,7 @@ An important rule of thumb in reducing vulnerability =
to DoS attacks is to
 minimize the amount of resources a potential, but as yet unauthenticated,
 client is able to consume.
=20
-.B \-\-tls-auth
+.B \-\-tls\-auth
 does this by signing every TLS control channel packet with an HMAC signatu=
re,
 including packets which are sent before the TLS level has had a chance
 to authenticate the peer.
@@ -4714,15 +4714,15 @@ The result is that packets without
 the correct signature can be dropped immediately upon reception,
 before they have a chance to consume additional system resources
 such as by initiating a TLS handshake.
-.B \-\-tls-auth
+.B \-\-tls\-auth
 can be strengthened by adding the
-.B \-\-replay-persist
+.B \-\-replay\-persist
 option which will keep OpenVPN's replay protection state
 in a file so that it is not lost across restarts.
=20
 It should be emphasized that this feature is optional and that the
 passphrase/key file used with
-.B \-\-tls-auth
+.B \-\-tls\-auth
 gives a peer nothing more than the power to initiate a TLS
 handshake.  It is not used to encrypt or authenticate any tunnel data.
 .\"*********************************************************
@@ -4740,7 +4740,7 @@ daemon is started you must be there to type the passw=
ord.  The
 option allows you to start OpenVPN from the command line.  It will
 query you for a password before it daemonizes.  To protect a private
 key with a password you should omit the
-.B -nodes
+.B \-nodes
 option when you use the
 .B openssl
 command line tool to manage certificates and private keys.
@@ -4753,15 +4753,15 @@ Keep in mind that storing your password in a file
 to a certain extent invalidates the extra security provided by
 using an encrypted key (Note: OpenVPN
 will only read passwords from a file if it has been built
-with the \-\-enable-password-save configure option, or on Windows
+with the \-\-enable\-password\-save configure option, or on Windows
 by defining ENABLE_PASSWORD_SAVE in win/settings.in).
 .\"*********************************************************
 .TP
-.B \-\-auth-nocache
+.B \-\-auth\-nocache
 Don't cache
 .B \-\-askpass
 or
-.B \-\-auth-user-pass
+.B \-\-auth\-user\-pass
 username/passwords in virtual memory.
=20
 If specified, this directive will cause OpenVPN to immediately
@@ -4771,19 +4771,19 @@ from stdin, which may be multiple times during the =
duration of an
 OpenVPN session.
=20
 This directive does not affect the
-.B \-\-http-proxy
+.B \-\-http\-proxy
 username/password.  It is always cached.
 .\"*********************************************************
 .TP
-.B \-\-tls-verify cmd
+.B \-\-tls\-verify cmd
 Run command
 .B cmd
 to verify the X509 name of a
 pending TLS connection that has otherwise passed all other
 tests of certification (except for revocation via
-.B \-\-crl-verify
+.B \-\-crl\-verify
 directive; the revocation test occurs after the
-.B \-\-tls-verify
+.B \-\-tls\-verify
 test).
=20
 .B cmd
@@ -4813,31 +4813,31 @@ peer certificate you will accept.  This feature all=
ows you to write a script
 which will test the X509 name on a certificate and decide whether or
 not it should be accepted.  For a simple perl script which will test
 the common name field on the certificate, see the file
-.B verify-cn
+.B verify\-cn
 in the OpenVPN distribution.
=20
 See the "Environmental Variables" section below for
 additional parameters passed as environmental variables.
 .\"*********************************************************
 .TP
-.B \-\-tls-export-cert directory
+.B \-\-tls\-export\-cert directory
 Store the certificates the clients uses upon connection to this
-directory. This will be done before \-\-tls-verify is called.  The
+directory. This will be done before \-\-tls\-verify is called.  The
 certificates will use a temporary name and will be deleted when
-the tls-verify script returns.  The file name used for the certificate
+the tls\-verify script returns.  The file name used for the certificate
 is available via the peer_cert environment variable.
 .\"*********************************************************
 .TP
-.B \-\-x509-username-field [ext:\]fieldname
+.B \-\-x509\-username\-field [ext:\]fieldname
 Field in the X.509 certificate subject to be used as the username (default=
=3DCN).
 Typically, this option is specified with
 .B fieldname
 as either of the following:
=20
-.B \-\-x509-username-field
+.B \-\-x509\-username\-field
 emailAddress
 .br
-.B \-\-x509-username-field ext:\fRsubjectAltName
+.B \-\-x509\-username\-field ext:\fRsubjectAltName
=20
 The first example uses the value of the "emailAddress" attribute in the
 certificate's Subject field as the username.  The second example uses
@@ -4852,7 +4852,7 @@ in
 the last occurrence is chosen.
=20
 When this option is used, the
-.B \-\-verify-x509-name
+.B \-\-verify\-x509\-name
 option will match against the chosen
 .B fieldname
 instead of the Common Name.
@@ -4868,7 +4868,7 @@ prefix will be left as-is.  This automatic upcasing f=
eature
 is deprecated and will be removed in a future release.
 .\"*********************************************************
 .TP
-.B \-\-tls-remote name (DEPRECATED)
+.B \-\-tls\-remote name (DEPRECATED)
 Accept connections only from a host with X509 name
 or common name equal to
 .B name.
@@ -4876,7 +4876,7 @@ The remote host must also pass all other tests
 of verification.
=20
 .B NOTE:
-Because tls-remote may test against a common name prefix,
+Because tls\-remote may test against a common name prefix,
 only use this option when you are using OpenVPN with a custom CA
 certificate that is under your control.
 Never use this option when your client certificates are signed by
@@ -4885,18 +4885,18 @@ a third party, such as a commercial web CA.
 Name can also be a common name prefix, for example if you
 want a client to only accept connections to "Server-1",
 "Server-2", etc., you can simply use
-.B \-\-tls-remote Server
+.B \-\-tls\-remote Server
=20
 Using a common name prefix is a useful alternative to managing
 a CRL (Certificate Revocation List) on the client, since it allows the cli=
ent
 to refuse all certificates except for those associated
 with designated servers.
=20
-.B \-\-tls-remote
+.B \-\-tls\-remote
 is a useful replacement for the
-.B \-\-tls-verify
+.B \-\-tls\-verify
 option to verify the remote host, because
-.B \-\-tls-remote
+.B \-\-tls\-remote
 works in a
 .B \-\-chroot
 environment too.
@@ -4905,13 +4905,13 @@ environment too.
 This option is now deprecated.  It will be removed either in OpenVPN v2.4
 or v2.5.  So please make sure you support the new X.509 name formatting
 described with the
-.B \-\-compat-names
+.B \-\-compat\-names
 option as soon as possible by updating your configurations to use
-.B \-\-verify-x509-name
+.B \-\-verify\-x509\-name
 instead.
 .\"*********************************************************
 .TP
-.B \-\-verify-x509-name name type
+.B \-\-verify\-x509\-name name type
 Accept connections only if a host's X.509 name is equal to
 .B name.
 The remote host must also pass all other tests of verification.
@@ -4923,22 +4923,22 @@ depends on the setting of type.
 can be "subject" to match the complete subject DN (default),
 "name" to match a subject RDN or "name-prefix" to match a subject RDN pref=
ix.
 Which RDN is verified as name depends on the
-.B \-\-x509-username-field
+.B \-\-x509\-username\-field
 option. But it defaults to the common name (CN), e.g. a certificate with a
 subject DN "C=3DKG, ST=3DNA, L=3DBishkek, CN=3DServer-1" would be matched =
by:
=20
-.B \-\-verify-x509-name 'C=3DKG, ST=3DNA, L=3DBishkek, CN=3DServer-1'
+.B \-\-verify\-x509\-name 'C=3DKG, ST=3DNA, L=3DBishkek, CN=3DServer\-1'
 and
-.B \-\-verify-x509-name Server-1 name
+.B \-\-verify\-x509\-name Server\-1 name
 or you could use
-.B \-\-verify-x509-name Server- name-prefix
+.B \-\-verify\-x509\-name Server -name-prefix
 if you want a client to only accept connections to "Server-1", "Server-2",=
 etc.
=20
-.B \-\-verify-x509-name
+.B \-\-verify\-x509\-name
 is a useful replacement for the
-.B \-\-tls-verify
+.B \-\-tls\-verify
 option to verify the remote host, because
-.B \-\-verify-x509-name
+.B \-\-verify\-x509\-name
 works in a
 .B \-\-chroot
 environment without any dependencies.
@@ -4955,7 +4955,7 @@ Never use this option with type "name-prefix" when yo=
ur client certificates
 are signed by a third party, such as a commercial web CA.
 .\"*********************************************************
 .TP
-.B \-\-x509-track attribute
+.B \-\-x509\-track attribute
 Save peer X509
 .B attribute
 value in environment for use by plugins and management interface.
@@ -4963,12 +4963,12 @@ Prepend a '+' to
 .B attribute
 to save values from full cert chain.  Values will be encoded
 as X509_<depth>_<attribute>=3D<value>.  Multiple
-.B \-\-x509-track
+.B \-\-x509\-track
 options can be defined to track multiple attributes.
 Not available with PolarSSL.
 .\"*********************************************************
 .TP
-.B \-\-ns-cert-type client|server
+.B \-\-ns\-cert\-type client|server
 Require that peer certificate was signed with an explicit
 .B nsCertType
 designation of "client" or "server".
@@ -4976,26 +4976,26 @@ designation of "client" or "server".
 This is a useful security option for clients, to ensure that
 the host they connect with is a designated server.
=20
-See the easy-rsa/build-key-server script for an example
+See the easy\-rsa/build\-key\-server script for an example
 of how to generate a certificate with the
 .B nsCertType
 field set to "server".
=20
 If the server certificate's nsCertType field is set
 to "server", then the clients can verify this with
-.B \-\-ns-cert-type server.
+.B \-\-ns\-cert\-type server.
=20
 This is an important security precaution to protect against
 a man-in-the-middle attack where an authorized client
 attempts to connect to another client by impersonating the server.
 The attack is easily prevented by having clients verify
 the server certificate using any one of
-.B \-\-ns-cert-type, \-\-verify-x509-name,
+.B \-\-ns\-cert\-type, \-\-verify\-x509\-name,
 or
-.B \-\-tls-verify.
+.B \-\-tls\-verify.
 .\"*********************************************************
 .TP
-.B \-\-remote-cert-ku v...
+.B \-\-remote\-cert\-ku v...
 Require that peer certificate was signed with an explicit
 .B key usage.
=20
@@ -5006,7 +5006,7 @@ The key usage should be encoded in hex, more than one=
 key
 usage can be specified.
 .\"*********************************************************
 .TP
-.B \-\-remote-cert-eku oid
+.B \-\-remote\-cert\-eku oid
 Require that peer certificate was signed with an explicit
 .B extended key usage.
=20
@@ -5017,7 +5017,7 @@ The extended key usage should be encoded in oid notat=
ion, or
 OpenSSL symbolic representation.
 .\"*********************************************************
 .TP
-.B \-\-remote-cert-tls client|server
+.B \-\-remote\-cert\-tls client|server
 Require that peer certificate was signed with an explicit
 .B key usage
 and
@@ -5028,18 +5028,18 @@ This is a useful security option for clients, to en=
sure that
 the host they connect to is a designated server.
=20
 The
-.B \-\-remote-cert-tls client
+.B \-\-remote\-cert\-tls client
 option is equivalent to
 .B
-\-\-remote-cert-ku 80 08 88 \-\-remote-cert-eku "TLS Web Client Authentica=
tion"
+\-\-remote\-cert\-ku 80 08 88 \-\-remote\-cert\-eku "TLS Web Client Authen=
tication"
=20
 The key usage is digitalSignature and/or keyAgreement.
=20
 The
-.B \-\-remote-cert-tls server
+.B \-\-remote\-cert\-tls server
 option is equivalent to
 .B
-\-\-remote-cert-ku a0 88 \-\-remote-cert-eku "TLS Web Server Authenticatio=
n"
+\-\-remote\-cert\-ku a0 88 \-\-remote\-cert\-eku "TLS Web Server Authentic=
ation"
=20
 The key usage is digitalSignature and ( keyEncipherment or keyAgreement ).
=20
@@ -5048,12 +5048,12 @@ a man-in-the-middle attack where an authorized clie=
nt
 attempts to connect to another client by impersonating the server.
 The attack is easily prevented by having clients verify
 the server certificate using any one of
-.B \-\-remote-cert-tls, \-\-verify-x509-name,
+.B \-\-remote\-cert\-tls, \-\-verify\-x509\-name,
 or
-.B \-\-tls-verify.
+.B \-\-tls\-verify.
 .\"*********************************************************
 .TP
-.B \-\-crl-verify crl ['dir']
+.B \-\-crl\-verify crl ['dir']
 Check peer certificate against the file
 .B crl
 in PEM format.
@@ -5082,20 +5082,20 @@ it will be rejected.
=20
 Note: As the crl file (or directory) is read every time a peer connects,
 if you are dropping root privileges with
-.B --user,
+.B \-\-user,
 make sure that this user has sufficient privileges to read the file.
 .\"*********************************************************
 .SS SSL Library information:
 .\"*********************************************************
 .TP
-.B \-\-show-ciphers
+.B \-\-show\-ciphers
 (Standalone)
 Show all cipher algorithms to use with the
 .B \-\-cipher
 option.
 .\"*********************************************************
 .TP
-.B \-\-show-digests
+.B \-\-show\-digests
 (Standalone)
 Show all message digest algorithms to use with the
 .B \-\-auth
@@ -5114,16 +5114,16 @@ the specific setup of both peers (e.g. both peers m=
ust support the cipher, and
 an ECDSA cipher suite will not work if you are using an RSA certificate, e=
tc.).
 .\"*********************************************************
 .TP
-.B \-\-show-engines
+.B \-\-show\-engines
 (Standalone)
 Show currently available hardware-based crypto acceleration
 engines supported by the OpenSSL library.
 .\"*********************************************************
 .TP
-.B \-\-show-curves
+.B \-\-show\-curves
 (Standalone)
 Show all available elliptic curves to use with the
-.B \-\-ecdh-curve
+.B \-\-ecdh\-curve
 option.
 .\"*********************************************************
 .SS Generate a random key:
@@ -5180,9 +5180,9 @@ option above).
=20
 One disadvantage of persistent tunnels is that it is harder to automatical=
ly
 configure their MTU value (see
-.B \-\-link-mtu
+.B \-\-link\-mtu
 and
-.B \-\-tun-mtu
+.B \-\-tun\-mtu
 above).
=20
 On some platforms such as Windows, TAP-Win32 tunnels are persistent by
@@ -5208,7 +5208,7 @@ Optional group to be owner of this tunnel.
 .SS Windows-Specific Options:
 .\"*********************************************************
 .TP
-.B \-\-win-sys path
+.B \-\-win\-sys path
 Set the Windows system directory pathname to use when looking for system
 executables such as
 .B route.exe
@@ -5219,7 +5219,7 @@ not specified, OpenVPN will use the SystemRoot enviro=
nment variable.
=20
 This option have changed behaviour in OpenVPN 2.3.  Earlier you had to
 define
-.B --win-sys env
+.B \-\-win\-sys env
 to use the SystemRoot environment variable, otherwise it defaulted to C:\\=
WINDOWS.
 It is not needed to use the
 .B env
@@ -5227,7 +5227,7 @@ keyword any more, and it will just be ignored. A warn=
ing is logged when this
 is found in the configuration file.
 .\"*********************************************************
 .TP
-.B \-\-ip-win32 method
+.B \-\-ip\-win32 method
 When using
 .B \-\-ifconfig
 on Windows, set the TAP-Win32 adapter
@@ -5243,7 +5243,7 @@ to the console telling the user to configure the
 adapter manually and indicating the IP/netmask which
 OpenVPN expects the adapter to be set to.
=20
-.B dynamic [offset] [lease-time] \-\-
+.B dynamic [offset] [lease-time] --
 Automatically set the IP address and netmask by replying to
 DHCP query messages generated by the kernel.  This mode is
 probably the "cleanest" solution
@@ -5326,28 +5326,28 @@ mode to restore the TAP-Win32 adapter TCP/IP proper=
ties
 to a DHCP configuration.
 .\"*********************************************************
 .TP
-.B \-\-route-method m
+.B \-\-route\-method m
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
+.B \-\-dhcp\-option type [parm]
 Set extended TAP-Win32 TCP/IP properties, must
 be used with
-.B \-\-ip-win32 dynamic
+.B \-\-ip\-win32 dynamic
 or
-.B \-\-ip-win32 adaptive.
+.B \-\-ip\-win32 adaptive.
 This option can be used to set additional TCP/IP properties
 on the TAP-Win32 adapter, and is particularly useful for
 configuring an OpenVPN client to access a Samba server
@@ -5387,7 +5387,7 @@ then query name server), and
 .B 8
 =3D h-node (query name server, then broadcast).
=20
-.B NBS scope-id \-\-
+.B NBS scope-id --
 Set NetBIOS over TCP/IP Scope. A NetBIOS Scope ID provides an extended
 naming service for the NetBIOS over TCP/IP (Known as NBT) module. The
 primary purpose of a NetBIOS scope ID is to isolate NetBIOS traffic on
@@ -5399,11 +5399,11 @@ computers to use the same computer name, as they ha=
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
+.B \-\-dhcp\-option
 is pushed via
 .B \-\-push
 to a non-windows client, the option will be saved in the client's
@@ -5411,7 +5411,7 @@ environment before the up script is called, under
 the name "foreign_option_{n}".
 .\"*********************************************************
 .TP
-.B \-\-tap-sleep n
+.B \-\-tap\-sleep n
 Cause OpenVPN to sleep for
 .B n
 seconds immediately after the TAP-Win32 adapter state
@@ -5421,19 +5421,19 @@ This option is intended to be used to troubleshoot =
problems
 with the
 .B \-\-ifconfig
 and
-.B \-\-ip-win32
+.B \-\-ip\-win32
 options, and is used to give
 the TAP-Win32 adapter time to come up before
 Windows IP Helper API operations are applied to it.
 .\"*********************************************************
 .TP
-.B \-\-show-net-up
+.B \-\-show\-net\-up
 Output OpenVPN's view of the system routing table and network
 adapter list to the syslog or log file after the TUN/TAP adapter
 has been brought up and any routes have been added.
 .\"*********************************************************
 .TP
-.B \-\-dhcp-renew
+.B \-\-dhcp\-renew
 Ask Windows to renew the TAP adapter lease on startup.
 This option is normally unnecessary, as Windows automatically
 triggers a DHCP renegotiation on the TAP adapter when it
@@ -5442,21 +5442,21 @@ Media Status property to "Always Connected", you ma=
y need this
 flag.
 .\"*********************************************************
 .TP
-.B \-\-dhcp-release
+.B \-\-dhcp\-release
 Ask Windows to release the TAP adapter lease on shutdown.
 This option has the same caveats as
-.B \-\-dhcp-renew
+.B \-\-dhcp\-renew
 above.
 .\"*********************************************************
 .TP
-.B \-\-register-dns
+.B \-\-register\-dns
 Run net stop dnscache, net start dnscache, ipconfig /flushdns
 and ipconfig /registerdns on connection initiation.
 This is known to kick Windows into
 recognizing pushed DNS servers.
 .\"*********************************************************
 .TP
-.B \-\-pause-exit
+.B \-\-pause\-exit
 Put up a "press any key to continue" message on the console prior
 to OpenVPN program exit.  This option is automatically used by the
 Windows explorer when OpenVPN is run on a configuration
@@ -5492,20 +5492,20 @@ window to output status/error
 messages, therefore it is useful to use
 .B \-\-log
 or
-.B \-\-log-append
+.B \-\-log\-append
 to write these messages to a file.
 .\"*********************************************************
 .TP
-.B \-\-show-adapters
+.B \-\-show\-adapters
 (Standalone)
 Show available TAP-Win32 adapters which can be selected using the
-.B \-\-dev-node
+.B \-\-dev\-node
 option.  On non-Windows systems, the
 .BR ifconfig (8)
 command provides similar functionality.
 .\"*********************************************************
 .TP
-.B \-\-allow-nonadmin [TAP-adapter]
+.B \-\-allow\-nonadmin [TAP\-adapter]
 (Standalone)
 Set
 .B TAP-adapter
@@ -5520,7 +5520,7 @@ and reloaded.
 This directive can only be used by an administrator.
 .\"*********************************************************
 .TP
-.B \-\-show-valid-subnets
+.B \-\-show\-valid\-subnets
 (Standalone)
 Show valid subnets for
 .B \-\-dev tun
@@ -5533,7 +5533,7 @@ Namely, the point-to-point endpoints used in TUN devi=
ce emulation
 must be the middle two addresses of a /30 subnet (netmask 255.255.255.252).
 .\"*********************************************************
 .TP
-.B \-\-show-net
+.B \-\-show\-net
 (Standalone)
 Show OpenVPN's view of the system routing table and network
 adapter list.
@@ -5541,7 +5541,7 @@ adapter list.
 .SS PKCS#11 Standalone Options:
 .\"*********************************************************
 .TP
-.B \-\-show-pkcs11-ids [provider] [cert_private]
+.B \-\-show\-pkcs11\-ids [provider] [cert_private]
 (Standalone)
 Show PKCS#11 token object list. Specify cert_private as 1
 if certificates are stored as private objects.
@@ -5549,7 +5549,7 @@ if certificates are stored as private objects.
 If p11-kit is present on the system, the
 .B provider
 argument is optional; if omitted the default
-.B p11-kit-proxy.so
+.B p11\-kit\-proxy.so
 module will be queried.
=20
 .B \-\-verb
@@ -5564,30 +5564,30 @@ as well (except for
 .B \-\-topology
 , which has no effect on IPv6).
 .TP
-.B --ifconfig-ipv6 ipv6addr/bits ipv6remote
+.B \-\-ifconfig\-ipv6 ipv6addr/bits ipv6remote
 configure IPv6 address
 .B ipv6addr/bits
 on the ``tun'' device.  The second parameter is used as route target for
-.B --route-ipv6
+.B \-\-route\-ipv6
 if no gateway is specified.
 .TP
-.B --route-ipv6 ipv6addr/bits [gateway] [metric]
+.B \-\-route\-ipv6 ipv6addr/bits [gateway] [metric]
 setup IPv6 routing in the system to send the specified IPv6 network
 into OpenVPN's ``tun''.  The gateway parameter is only used for
 IPv6 routes across ``tap'' devices, and if missing, the ``ipv6remote''
 field from
-.B --ifconfig-ipv6
+.B \-\-ifconfig\-ipv6
 is used.
 .TP
-.B --server-ipv6 ipv6addr/bits
+.B \-\-server\-ipv6 ipv6addr/bits
 convenience-function to enable a number of IPv6 related options at
 once, namely
-.B --ifconfig-ipv6, --ifconfig-ipv6-pool, --tun-ipv6
+.B \-\-ifconfig\-ipv6, \-\-ifconfig\-ipv6\-pool, \-\-tun\-ipv6
 and
-.B --push tun-ipv6
-Is only accepted if ``--mode server'' or ``--server'' is set.
+.B \-\-push tun\-ipv6
+Is only accepted if ``\-\-mode server'' or ``\-\-server'' is set.
 .TP
-.B --ifconfig-ipv6-pool ipv6addr/bits
+.B \-\-ifconfig\-ipv6\-pool ipv6addr/bits
 Specify an IPv6 address pool for dynamic assignment to clients.  The
 pool starts at
 .B ipv6addr
@@ -5596,20 +5596,20 @@ and increments by +1 for every new client (linear m=
ode).  The
 setting controls the size of the pool.  Due to implementation details,
 the pool size must be between /64 and /112.
 .TP
-.B --ifconfig-ipv6-push ipv6addr/bits ipv6remote
+.B \-\-ifconfig\-ipv6\-push ipv6addr/bits ipv6remote
 for ccd/ per-client static IPv6 interface configuration, see
-.B --client-config-dir
+.B \-\-client\-config\-dir
 and
-.B --ifconfig-push
+.B \-\-ifconfig\-push
 for more details.
 .TP
-.B --iroute-ipv6 ipv6addr/bits
+.B \-\-iroute\-ipv6 ipv6addr/bits
 for ccd/ per-client static IPv6 route configuration, see
-.B --iroute
+.B \-\-iroute
 for more details how to setup and use this, and how
-.B --iroute
+.B \-\-iroute
 and
-.B --route
+.B \-\-route
 interact.
=20
 .\"*********************************************************
@@ -5624,7 +5624,7 @@ of environmental variables for use by user-defined sc=
ripts.
 Executed after TCP/UDP socket bind and TUN/TAP open.
 .\"*********************************************************
 .TP
-.B \-\-tls-verify
+.B \-\-tls\-verify
 Executed when we have a still untrusted remote peer.
 .\"*********************************************************
 .TP
@@ -5632,25 +5632,25 @@ Executed when we have a still untrusted remote peer.
 Executed after connection authentication, or remote IP address change.
 .\"*********************************************************
 .TP
-.B \-\-client-connect
+.B \-\-client\-connect
 Executed in
 .B \-\-mode server
 mode immediately after client authentication.
 .\"*********************************************************
 .TP
-.B \-\-route-up
+.B \-\-route\-up
 Executed after connection authentication, either
 immediately after, or some number of seconds after
 as defined by the
-.B \-\-route-delay
+.B \-\-route\-delay
 option.
 .\"*********************************************************
 .TP
-.B \-\-route-pre-down
+.B \-\-route\-pre\-down
 Executed right before the routes are removed.
 .\"*********************************************************
 .TP
-.B \-\-client-disconnect
+.B \-\-client\-disconnect
 Executed in
 .B \-\-mode server
 mode on client instance shutdown.
@@ -5660,14 +5660,14 @@ mode on client instance shutdown.
 Executed after TCP/UDP and TUN/TAP close.
 .\"*********************************************************
 .TP
-.B \-\-learn-address
+.B \-\-learn\-address
 Executed in
 .B \-\-mode server
 mode whenever an IPv4 address/route or MAC address is added to OpenVPN's
 internal routing table.
 .\"*********************************************************
 .TP
-.B \-\-auth-user-pass-verify
+.B \-\-auth\-user\-pass\-verify
 Executed in
 .B \-\-mode server
 mode on new client connections, when the client is
@@ -5693,7 +5693,7 @@ Can string remapping be disabled?
=20
 .B A:
 Yes, by using the
-.B \-\-no-name-remapping
+.B \-\-no\-name\-remapping
 option, however this should be considered an advanced option.
=20
 Here is a brief rundown of OpenVPN's current string types and the=20
@@ -5709,17 +5709,17 @@ true.
 Alphanumeric, underbar ('_'), dash ('-'), dot ('.'), and at=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20
 ('@').
=20
-.B \-\-auth-user-pass username:
+.B \-\-auth\-user\-pass username:
 Same as Common Name, with one exception: starting with OpenVPN 2.0.1,
 the username is passed to the OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY plugin =
in its raw form,
 without string remapping.
=20
-.B \-\-auth-user-pass password:
+.B \-\-auth\-user\-pass password:
 Any "printable" character except CR or LF.=20=20
 Printable is defined to be a character which will cause the C library=20
 isprint() function to return true.
=20
-.B \-\-client-config-dir filename as derived from common name or username:
+.B \-\-client\-config\-dir filename as derived from common name or usernam=
e:
 Alphanumeric, underbar ('_'), dash ('-'), and dot ('.') except for "." or=
=20
 ".." as standalone strings.  As of 2.0.1-rc6, the at ('@') character has
 been added as well for compatibility with the common name character class.
@@ -5749,23 +5749,23 @@ which refer to different client instances.
 .B bytes_received
 Total number of bytes received from client during VPN session.
 Set prior to execution of the
-.B \-\-client-disconnect
+.B \-\-client\-disconnect
 script.
 .\"*********************************************************
 .TP
 .B bytes_sent
 Total number of bytes sent to client during VPN session.
 Set prior to execution of the
-.B \-\-client-disconnect
+.B \-\-client\-disconnect
 script.
 .\"*********************************************************
 .TP
 .B common_name
 The X509 common name of an authenticated client.
 Set prior to execution of
-.B \-\-client-connect, \-\-client-disconnect,
+.B \-\-client\-connect, \-\-client\-disconnect,
 and
-.B \-\-auth-user-pass-verify
+.B \-\-auth\-user\-pass\-verify
 scripts.
 .\"*********************************************************
 .TP
@@ -5787,7 +5787,7 @@ Set on program initiation and reset on SIGHUP.
 Set to "1" if the
 .B \-\-log
 or
-.B \-\-log-append
+.B \-\-log\-append
 directives are specified, or "0" otherwise.
 Set on program initiation and reset on SIGHUP.
 .\"*********************************************************
@@ -5807,7 +5807,7 @@ An option pushed via
 .B \-\-push
 to a client which does not natively support it,
 such as
-.B \-\-dhcp-option
+.B \-\-dhcp\-option
 on a non-Windows system, will be recorded to this
 environmental variable sequence prior to
 .B \-\-up
@@ -5833,7 +5833,7 @@ script execution.
 .TP
 .B ifconfig_ipv6_local
 The local VPN endpoint IPv6 address specified in the
-.B \-\-ifconfig-ipv6
+.B \-\-ifconfig\-ipv6
 option (first parameter).
 Set prior to OpenVPN calling the
 .I ifconfig
@@ -5848,7 +5848,7 @@ script execution.
 .B ifconfig_ipv6_netbits
 The prefix length of the IPv6 network on the VPN interface.  Derived from
 the /nnn parameter of the IPv6 address in the
-.B \-\-ifconfig-ipv6
+.B \-\-ifconfig\-ipv6
 option (first parameter).
 Set prior to OpenVPN calling the
 .I ifconfig
@@ -5862,7 +5862,7 @@ script execution.
 .TP
 .B ifconfig_ipv6_remote
 The remote VPN endpoint IPv6 address specified in the
-.B \-\-ifconfig-ipv6
+.B \-\-ifconfig\-ipv6
 option (second parameter).
 Set prior to OpenVPN calling the
 .I ifconfig
@@ -5924,54 +5924,54 @@ script execution.
 .B ifconfig_pool_local_ip
 The local
 virtual IP address for the TUN/TAP tunnel taken from an
-.B \-\-ifconfig-push
+.B \-\-ifconfig\-push
 directive if specified, or otherwise from
 the ifconfig pool (controlled by the
-.B \-\-ifconfig-pool
+.B \-\-ifconfig\-pool
 config file directive).
 Only set for
 .B \-\-dev tun
 tunnels.
 This option is set on the server prior to execution
 of the
-.B \-\-client-connect
+.B \-\-client\-connect
 and
-.B \-\-client-disconnect
+.B \-\-client\-disconnect
 scripts.
 .\"*********************************************************
 .TP
 .B ifconfig_pool_netmask
 The
 virtual IP netmask for the TUN/TAP tunnel taken from an
-.B \-\-ifconfig-push
+.B \-\-ifconfig\-push
 directive if specified, or otherwise from
 the ifconfig pool (controlled by the
-.B \-\-ifconfig-pool
+.B \-\-ifconfig\-pool
 config file directive).
 Only set for
 .B \-\-dev tap
 tunnels.
 This option is set on the server prior to execution
 of the
-.B \-\-client-connect
+.B \-\-client\-connect
 and
-.B \-\-client-disconnect
+.B \-\-client\-disconnect
 scripts.
 .\"*********************************************************
 .TP
 .B ifconfig_pool_remote_ip
 The remote
 virtual IP address for the TUN/TAP tunnel taken from an
-.B \-\-ifconfig-push
+.B \-\-ifconfig\-push
 directive if specified, or otherwise from
 the ifconfig pool (controlled by the
-.B \-\-ifconfig-pool
+.B \-\-ifconfig\-pool
 config file directive).
 This option is set on the server prior to execution
 of the
-.B \-\-client-connect
+.B \-\-client\-connect
 and
-.B \-\-client-disconnect
+.B \-\-client\-disconnect
 scripts.
 .\"*********************************************************
 .TP
@@ -6003,9 +6003,9 @@ Set on program initiation and reset on SIGHUP.
 .B password
 The password provided by a connecting client.
 Set prior to
-.B \-\-auth-user-pass-verify
+.B \-\-auth\-user\-pass\-verify
 script execution only when the
-.B via-env
+.B via\-env
 modifier is specified, and deleted from the environment
 after the script returns.
 .\"*********************************************************
@@ -6044,7 +6044,7 @@ script execution.
 The default gateway used by
 .B \-\-route
 options, as specified in either the
-.B \-\-route-gateway
+.B \-\-route\-gateway
 option or the second parameter to
 .B \-\-ifconfig
 when
@@ -6095,7 +6095,7 @@ or configuration file.
 .TP
 .B peer_cert
 Temporary file name containing the client certificate upon
-connection.  Useful in conjunction with --tls-verify
+connection.  Useful in conjunction with \-\-tls\-verify
 .\"*********************************************************
 .TP
 .B script_context
@@ -6108,10 +6108,10 @@ documentation for
 .B script_type
 Prior to execution of any script, this variable is set to the type of
 script being run.  It can be one of the following:
-.B up, down, ipchange, route-up, tls-verify, auth-user-pass-verify,
-.B client-connect, client-disconnect,=20
+.B up, down, ipchange, route\-up, tls\-verify, auth\-user\-pass\-verify,
+.B client\-connect, client\-disconnect,
 or
-.B learn-address.
+.B learn\-address.
 Set prior to execution of any script.
 .\"*********************************************************
 .TP
@@ -6121,15 +6121,15 @@ The reason for exit or restart.  Can be one of
 (controlled by
 .B \-\-inactive
 option),
-.B ping-exit
+.B ping\-exit
 (controlled by
-.B \-\-ping-exit
+.B \-\-ping\-exit
 option),
-.B ping-restart
+.B ping\-restart
 (controlled by
-.B \-\-ping-restart
+.B \-\-ping\-restart
 option),
-.B connection-reset
+.B connection\-reset
 (triggered on TCP connection reset),
 .B error,
 or
@@ -6141,7 +6141,7 @@ or
 Client connection timestamp, formatted as a human-readable
 time string.
 Set prior to execution of the
-.B \-\-client-connect
+.B \-\-client\-connect
 script.
 .\"*********************************************************
 .TP
@@ -6149,7 +6149,7 @@ script.
 The duration (in seconds) of the client session which is now
 disconnecting.
 Set prior to execution of the
-.B \-\-client-disconnect
+.B \-\-client\-disconnect
 script.
 .\"*********************************************************
 .TP
@@ -6157,7 +6157,7 @@ script.
 Client connection timestamp, formatted as a unix integer
 date/time value.
 Set prior to execution of the
-.B \-\-client-connect
+.B \-\-client\-connect
 script.
 .\"*********************************************************
 .TP
@@ -6167,7 +6167,7 @@ where
 .B n
 is the verification level.  Only set for TLS connections.  Set prior
 to execution of
-.B \-\-tls-verify
+.B \-\-tls\-verify
 script.
 .\"*********************************************************
 .TP
@@ -6177,7 +6177,7 @@ where
 .B n
 is the verification level.  Only set for TLS connections.  Set prior
 to execution of
-.B \-\-tls-verify
+.B \-\-tls\-verify
 script.
 .\"*********************************************************
 .TP
@@ -6187,7 +6187,7 @@ where
 .B n
 is the verification level.  Only set for TLS connections.  Set prior
 to execution of
-.B \-\-tls-verify
+.B \-\-tls\-verify
 script. This is in the form of a decimal string like "933971680", which is
 suitable for doing serial-based OCSP queries (with OpenSSL, do not
 prepend "0x" to the string) If something goes wrong while reading
@@ -6214,9 +6214,9 @@ script execution.
 .B trusted_ip (or trusted_ip6)
 Actual IP address of connecting client or peer which has been authenticate=
d.
 Set prior to execution of
-.B \-\-ipchange, \-\-client-connect,
+.B \-\-ipchange, \-\-client\-connect,
 and
-.B \-\-client-disconnect
+.B \-\-client\-disconnect
 scripts.
 If using ipv6 endpoints (udp6, tcp6),
 .B trusted_ip6
@@ -6226,9 +6226,9 @@ will be set instead.
 .B trusted_port
 Actual port number of connecting client or peer which has been authenticat=
ed.
 Set prior to execution of
-.B \-\-ipchange, \-\-client-connect,
+.B \-\-ipchange, \-\-client\-connect,
 and
-.B \-\-client-disconnect
+.B \-\-client\-disconnect
 scripts.
 .\"*********************************************************
 .TP
@@ -6237,12 +6237,12 @@ Actual IP address of connecting client or peer whic=
h has not been authenticated
 yet.  Sometimes used to
 .B nmap
 the connecting host in a
-.B \-\-tls-verify
+.B \-\-tls\-verify
 script to ensure it is firewalled properly.
 Set prior to execution of
-.B \-\-tls-verify
+.B \-\-tls\-verify
 and
-.B \-\-auth-user-pass-verify
+.B \-\-auth\-user\-pass\-verify
 scripts.
 If using ipv6 endpoints (udp6, tcp6),
 .B untrusted_ip6
@@ -6253,18 +6253,18 @@ will be set instead.
 Actual port number of connecting client or peer which has not been authent=
icated
 yet.
 Set prior to execution of
-.B \-\-tls-verify
+.B \-\-tls\-verify
 and
-.B \-\-auth-user-pass-verify
+.B \-\-auth\-user\-pass\-verify
 scripts.
 .\"*********************************************************
 .TP
 .B username
 The username provided by a connecting client.
 Set prior to
-.B \-\-auth-user-pass-verify
+.B \-\-auth\-user\-pass\-verify
 script execution only when the
-.B via-env
+.B via\-env
 modifier is specified.
 .\"*********************************************************
 .TP
@@ -6274,7 +6274,7 @@ where
 .B n
 is the verification level.  Only set for TLS connections.  Set prior
 to execution of
-.B \-\-tls-verify
+.B \-\-tls\-verify
 script.  This variable is similar to
 .B tls_id_{n}
 except the component X509 subject fields are broken out, and
@@ -6282,7 +6282,7 @@ no string remapping occurs on these field values (exc=
ept for remapping
 of control characters to "_").
 For example, the following variables would be set on the
 OpenVPN server using the sample client certificate
-in sample-keys (client.crt).
+in sample\-keys (client.crt).
 Note that the verification level is 0 for the client certificate
 and 1 for the CA certificate.
=20
@@ -6305,9 +6305,9 @@ X509_1_C=3DKG
 .\"*********************************************************
 .SH INLINE FILE SUPPORT
 OpenVPN allows including files in the main configuration for the
-.B \-\-ca, \-\-cert, \-\-dh, \-\-extra-certs, \-\-key, \-\-pkcs12, \-\-sec=
ret
+.B \-\-ca, \-\-cert, \-\-dh, \-\-extra\-certs, \-\-key, \-\-pkcs12, \-\-se=
cret
 and
-.B \-\-tls-auth
+.B \-\-tls\-auth
 options.
=20
 Each inline file started by the line
@@ -6332,7 +6332,7 @@ Here is an example of an inline file usage
 When using the inline file feature with
 .B \-\-pkcs12
 the inline file has to be base64 encoded. Encoding of a .p12 file into bas=
e64 can be done for example with OpenSSL by running
-.B openssl base64 -in input.p12
+.B openssl base64 \-in input.p12
=20
 .SH SIGNALS
 .TP
@@ -6349,18 +6349,18 @@ Like
 except don't re-read configuration file, and possibly don't close and reop=
en TUN/TAP
 device, re-read key files, preserve local IP address/port, or preserve mos=
t recently authenticated
 remote IP address/port based on
-.B \-\-persist-tun, \-\-persist-key, \-\-persist-local-ip,
+.B \-\-persist\-tun, \-\-persist\-key, \-\-persist\-local\-ip,
 and
-.B \-\-persist-remote-ip
+.B \-\-persist\-remote\-ip
 options respectively (see above).
=20
 This signal may also be internally generated by a timeout condition, gover=
ned
 by the
-.B \-\-ping-restart
+.B \-\-ping\-restart
 option.
=20
 This signal, when combined with
-.B \-\-persist-remote-ip,
+.B \-\-persist\-remote\-ip,
 may be
 sent when the underlying parameters of the host's network interface change
 such as when the host is a DHCP client and is assigned a new IP address.
@@ -6430,7 +6430,7 @@ without an explicit firewall rule).
 If you are using a Linux iptables-based firewall, you may need to enter
 the following command to allow incoming packets on the TUN device:
 .IP
-.B iptables -A INPUT -i tun+ -j ACCEPT
+.B iptables \-A INPUT \-i tun+ \-j ACCEPT
 .LP
 See the firewalls section below for more information on configuring firewa=
lls
 for use with OpenVPN.
@@ -6571,11 +6571,11 @@ parameters you can use the included file dh1024.pem.
 .LP
 On may:
 .IP
-.B openvpn \-\-remote june.kg \-\-dev tun1 \-\-ifconfig 10.4.0.1 10.4.0.2 =
\-\-tls-client \-\-ca ca.crt \-\-cert client.crt \-\-key client.key \-\-ren=
eg-sec 60 \-\-verb 5
+.B openvpn \-\-remote june.kg \-\-dev tun1 \-\-ifconfig 10.4.0.1 10.4.0.2 =
\-\-tls\-client \-\-ca ca.crt \-\-cert client.crt \-\-key client.key \-\-re=
neg\-sec 60 \-\-verb 5
 .LP
 On june:
 .IP
-.B openvpn \-\-remote may.kg \-\-dev tun1 \-\-ifconfig 10.4.0.2 10.4.0.1 \=
-\-tls-server \-\-dh dh1024.pem \-\-ca ca.crt \-\-cert server.crt \-\-key s=
erver.key \-\-reneg-sec 60 \-\-verb 5
+.B openvpn \-\-remote may.kg \-\-dev tun1 \-\-ifconfig 10.4.0.2 10.4.0.1 \=
-\-tls\-server \-\-dh dh1024.pem \-\-ca ca.crt \-\-cert server.crt \-\-key =
server.key \-\-reneg\-sec 60 \-\-verb 5
 .LP
 Now verify the tunnel is working by pinging across the tunnel.
 .LP
@@ -6588,7 +6588,7 @@ On june:
 .B ping 10.4.0.1
 .LP
 Notice the
-.B \-\-reneg-sec 60
+.B \-\-reneg\-sec 60
 option we used above.  That tells OpenVPN to renegotiate
 the data channel keys every minute.
 Since we used
@@ -6597,7 +6597,7 @@ above, you will see status information on each new ke=
y negotiation.
=20
 For production operations, a key renegotiation interval of 60 seconds
 is probably too frequent.  Omit the
-.B \-\-reneg-sec 60
+.B \-\-reneg\-sec 60
 option to use OpenVPN's default key renegotiation interval of one hour.
 .\"*********************************************************
 .SS Routing:
@@ -6617,15 +6617,15 @@ On Linux, enable routing:
 .LP
 and enable TUN packet forwarding through the firewall:
 .IP
-.B iptables -A FORWARD -i tun+ -j ACCEPT
+.B iptables \-A FORWARD \-i tun+ \-j ACCEPT
 .LP
 On may:
 .IP
-.B route add -net 10.0.1.0 netmask 255.255.255.0 gw 10.4.0.2
+.B route add \-net 10.0.1.0 netmask 255.255.255.0 gw 10.4.0.2
 .LP
 On june:
 .IP
-.B route add -net 10.0.0.0 netmask 255.255.255.0 gw 10.4.0.1
+.B route add \-net 10.0.0.0 netmask 255.255.255.0 gw 10.4.0.1
 .LP
 Now any machine on the 10.0.0.0/24 subnet can
 access any machine on the 10.0.1.0/24 subnet
@@ -6641,7 +6641,7 @@ OpenVPN's usage of a single UDP port makes it fairly =
firewall-friendly.
 You should add an entry to your firewall rules to allow incoming OpenVPN
 packets.  On Linux 2.4+:
 .IP
-.B iptables -A INPUT -p udp -s 1.2.3.4 \-\-dport 1194 -j ACCEPT
+.B iptables \-A INPUT \-p udp \-s 1.2.3.4 \-\-dport 1194 \-j ACCEPT
 .LP
 This will allow incoming packets on UDP port 1194 (OpenVPN's default UDP p=
ort)
 from an OpenVPN peer at 1.2.3.4.
@@ -6652,7 +6652,7 @@ address can be considered optional, since HMAC packet=
 authentication
 is a much more secure method of verifying the authenticity of
 a packet source.  In that case:
 .IP
-.B iptables -A INPUT -p udp \-\-dport 1194 -j ACCEPT
+.B iptables \-A INPUT \-p udp \-\-dport 1194 \-j ACCEPT
 .LP
 would be adequate and would not render the host inflexible with
 respect to its peer having a dynamic IP address.
@@ -6674,20 +6674,20 @@ firewall rules.
 You should also add firewall rules to allow incoming IP traffic on
 TUN or TAP devices such as:
 .IP
-.B iptables -A INPUT -i tun+ -j ACCEPT
+.B iptables \-A INPUT \-i tun+ \-j ACCEPT
 .LP
 to allow input packets from tun devices,
 .IP
-.B iptables -A FORWARD -i tun+ -j ACCEPT
+.B iptables \-A FORWARD \-i tun+ \-j ACCEPT
 .LP
 to allow input packets from tun devices to be forwarded to
 other hosts on the local network,
 .IP
-.B iptables -A INPUT -i tap+ -j ACCEPT
+.B iptables \-A INPUT \-i tap+ \-j ACCEPT
 .LP
 to allow input packets from tap devices, and
 .IP
-.B iptables -A FORWARD -i tap+ -j ACCEPT
+.B iptables \-A FORWARD \-i tap+ \-j ACCEPT
 .LP
 to allow input packets from tap devices to be forwarded to
 other hosts on the local network.
--=20
2.1.4


