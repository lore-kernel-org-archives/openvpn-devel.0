From: fragmentux@...277...
Date: Sat, 19 Aug 2017 21:37:35 +0100
Message-Id: <20170819203735.8681-1-fragmentux@...277...>
Subject: [Openvpn-devel]  [PATCH] Corrections to doc/openvpn.8
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

From: Richard Bonhomme <fragmentux@...277...>

Correct usage example: --verify-x509-name name-stub- name-prefix

  This was to correct "--verfiy-x509-name Server -name-prexif"
                   to "--verify-x509-name Server- name-prefix"

Escape all dashes (with some exceptions)

  Due to the nature of this patch mistakes are easily over looked, 
  therefore, I have included the bash script I used to make these changes.

  My thanks go to members of irc.freenode.##sed for helping me get sed
  and their award to me for the "Useless use of cat" ;-)

  Please excuse my amateurish bashitisms.

Regards


=====

#!/bin/bash
#
# To use this script include a copy of doc/openvpn.8 in the current directory
#

Base="openvpn"
Source="$Base.8"
Hidden="$Base.8.hdn"
Destin="$Base.8.new"

#Highlight
BRed='\033[41m'
BGrn='\033[42m'
BBlu='\033[44m'
BNoC='\033[0m'
SRed='\o033[1;41m'
SGrn='\o033[42m'
SBlu='\o033[44m'
SNoC='\o033[0m'

# Formatting line: "^.in -*\n"
Find_fmtdash='^\.in[[:space:]]\-.$'
Hide_fmtdash='~FFFFF'
Rest_fmtdash='.in\ -4'

# Escape dash "\-"
Find_escdash='\\\-'
Hide_escdash='~E'
Rest_escdash='\\-'

# Look for "-"
Find_onedash='-'
Repl_onedash='\\-'


echo

echo -e "$BBlu ########## Why use ~ to hide other strings ? $BNoC"
# Because there are zero "~" in openvpn.8
grep -E "~" $Source
echo

echo -e "$BRed ########## Sed tricks to split initial fluff from file $BNoC"
# Strip first 36 lines to do the main work on .end
sed 36q $Source > $Source.top
sed 1,36d $Source > $Source.end
echo


echo -e "$BBlu ########## Verify all $Find_fmtdash are [ .in -4 ] $BNoC"
# Check the entire original file to be sure
grep -nE $Find_fmtdash $Source | sed -e 's/.*/  &/g'
echo


echo -e "$BRed ########## Hide $Find_fmtdash with $Hide_fmtdash $BNoC"
# Only use the END part of Source to do work
cat $Source.end | sed -e 's/'$Find_fmtdash'/'$Hide_fmtdash'/g' > $Hidden.1
echo


echo -e "$BRed ########## Hide $Find_escdash with $Hide_escdash $BNoC"
cat $Hidden.1 | sed -e 's/'$Find_escdash'/'$Hide_escdash'/g' > $Hidden.2
echo


echo -e "$BRed ########## Replace $Find_onedash with $Repl_onedash $BNoC"
cat $Hidden.2 | sed -e 's/'$Find_onedash'/'$Repl_onedash'/g' > $Destin.2
echo


echo -e "$BRed ########## Restore $Hide_escdash to $Rest_escdash $BNoC"
cat $Destin.2 | sed -e 's/'$Hide_escdash'/'$Rest_escdash'/g' > $Destin.1
echo


echo -e "$BRed ########## Restore $Hide_fmtdash to [ $Rest_fmtdash ] $BNoC"
cat $Destin.1 | sed -e 's/'$Hide_fmtdash'/'"$Rest_fmtdash"'/g' > $Destin
echo


echo -e "$BRed ########## Restore the first comments to top of Destination $BNoC"
cat $Source.top $Destin > $Destin.Final
echo


echo -e "$BBlu ########## VERIFY: Highlight ALL dashes $BNoC"
if [ "$1" == "-v1" ]; then
   sed -e 's/'$Find_onedash'/'$SRed'&'$SNoC'/g' $Destin.Final
else
   echo -e "  $BGrn To see the result use: ./dodash -v1 $BNoC"
fi
echo


echo -e $BBlu "########## VERIFY: Highlight un-escaped dashes" $BNoC
if [ "$1" == "-v2" ]; then
   sed -e 's/\([^\\]-\)/'$SRed'&'$SNoC'/g' $Destin.Final
else
   echo -e "  $BGrn To see the result use: ./dodash -v2 $BNoC"
fi
echo


echo -e $BRed "########## Delete temp files" $BNoC
rm $Source.top
rm $Source.end
rm $Hidden.1
rm $Hidden.2
rm $Destin.2
rm $Destin.1
rm $Destin
echo

echo -e $BBlu '########## Done' $BNoC
echo

exit 0
#EOF

=====


---
 doc/openvpn.8 | 778 +++++++++++++++++++++++++++++-----------------------------
 1 file changed, 389 insertions(+), 389 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 04ff9cb5..31ee657d 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -77,14 +77,14 @@ of its crypto capabilities from it.
 
 OpenVPN supports
 conventional encryption
-using a pre-shared secret key
+using a pre\-shared secret key
 .B (Static Key mode)
 or
 public key security
 .B (SSL/TLS mode)
 using client & server certificates.
 OpenVPN also
-supports non-encrypted TCP/UDP tunnels.  
+supports non\-encrypted TCP/UDP tunnels.  
 
 OpenVPN is designed to work with the
 .B TUN/TAP
@@ -96,7 +96,7 @@ with a relatively lightweight footprint.
 .SH OPTIONS
 OpenVPN allows any option to be placed either on the command line
 or in a configuration file.  Though all command line options are preceded
-by a double-leading-dash ("\-\-"), this prefix can be removed when
+by a double\-leading\-dash ("\-\-"), this prefix can be removed when
 an option is placed in a configuration file.
 .\"*********************************************************
 .TP
@@ -126,7 +126,7 @@ can be used to enclose single parameters containing whitespace,
 and "#" or ";" characters in the first column
 can be used to denote comments.
 
-Note that OpenVPN 2.0 and higher performs backslash-based shell
+Note that OpenVPN 2.0 and higher performs backslash\-based shell
 escaping for characters not in single quotations,
 so the following mappings should be observed:
 
@@ -164,7 +164,7 @@ Here is an example configuration file:
 .in +4
 #
 # Sample OpenVPN configuration file for
-# using a pre-shared static key.
+# using a pre\-shared static key.
 #
 # '#' or ';' may be used to delimit comments.
 
@@ -178,7 +178,7 @@ remote mypeer.mydomain
 # 10.1.0.2 is our remote VPN endpoint
 ifconfig 10.1.0.1 10.1.0.2
 
-# Our pre-shared static key
+# Our pre\-shared static key
 secret static.key
 .in -4
 .ft
@@ -188,8 +188,8 @@ secret static.key
 .TP
 .B \-\-mode m
 Set OpenVPN major mode.  By default, OpenVPN runs in
-point-to-point mode ("p2p").  OpenVPN 2.0 introduces
-a new mode ("server") which implements a multi-client
+point\-to\-point mode ("p2p").  OpenVPN 2.0 introduces
+a new mode ("server") which implements a multi\-client
 server capability.
 .\"*********************************************************
 .TP
@@ -206,7 +206,7 @@ options may be specified for redundancy, each referring
 to a different OpenVPN server.  Specifying multiple
 .B \-\-remote
 options for this purpose is a special case of the more
-general connection-profile feature.  See the
+general connection\-profile feature.  See the
 .B <connection>
 documentation below.
 
@@ -243,7 +243,7 @@ the client with
 .B \-\-user
 and/or
 .B \-\-group,
-AND the client is running a non-Windows OS, if the client needs
+AND the client is running a non\-Windows OS, if the client needs
 to switch to a different server, and that server pushes
 back different TUN/TAP or route settings, the client may lack
 the necessary privileges to close and reopen the TUN/TAP interface.
@@ -277,7 +277,7 @@ and IPv6 addresses, in the order getaddrinfo() returns them.
 .B \-\-remote\-random\-hostname
 Prepend a random string (6 bytes, 12 hex characters) to hostname to prevent
 DNS caching.  For example, "foo.bar.gov" would be modified to
-"<random-chars>.foo.bar.gov".
+"<random\-chars>.foo.bar.gov".
 .\"*********************************************************
 .TP
 .B <connection>
@@ -404,7 +404,7 @@ When multiple
 .B \-\-remote
 address/ports are specified, or if connection profiles are being
 used, initially randomize the order of the list
-as a kind of basic load-balancing measure.
+as a kind of basic load\-balancing measure.
 .\"*********************************************************
 .TP
 .B \-\-proto p
@@ -453,12 +453,12 @@ networks.
 
 This article outlines some of problems with tunneling IP over TCP:
 
-.I http://sites.inka.de/sites/bigred/devel/tcp-tcp.html
+.I http://sites.inka.de/sites/bigred/devel/tcp\-tcp.html
 
 There are certain cases, however, where using TCP may be advantageous from
-a security and robustness perspective, such as tunneling non-IP or
-application-level UDP protocols, or tunneling protocols which don't
-possess a built-in reliability layer.
+a security and robustness perspective, such as tunneling non\-IP or
+application\-level UDP protocols, or tunneling protocols which don't
+possess a built\-in reliability layer.
 .\"*********************************************************
 .TP
 .B \-\-connect\-retry n [max]
@@ -489,12 +489,12 @@ Show sensed HTTP or SOCKS proxy settings. Currently, only Windows clients
 support this option.
 .\"*********************************************************
 .TP
-.B \-\-http\-proxy server port [authfile|'auto'|'auto\-nct'] [auth-method]
+.B \-\-http\-proxy server port [authfile|'auto'|'auto\-nct'] [auth\-method]
 Connect to remote host through an HTTP proxy at address
 .B server
 and port
 .B port.
-If HTTP Proxy-Authenticate is required,
+If HTTP Proxy\-Authenticate is required,
 .B authfile
 is a file containing a username and password on 2 lines, or
 "stdin" to prompt from console. Its content can also be specified
@@ -522,7 +522,7 @@ exists on OpenVPN 2.1 or higher.
 
 The
 .B auto\-nct
-flag (no clear-text auth) instructs OpenVPN to automatically
+flag (no clear\-text auth) instructs OpenVPN to automatically
 determine the authentication method, but to reject weak
 authentication protocols such as HTTP Basic Authentication.
 .\"*********************************************************
@@ -531,16 +531,16 @@ authentication protocols such as HTTP Basic Authentication.
 Set extended HTTP proxy options.
 Repeat to set multiple options.
 
-.B VERSION version --
+.B VERSION version \-\-
 Set HTTP version number to
 .B version
 (default=1.0).
 
-.B AGENT user-agent --
-Set HTTP "User-Agent" string to
-.B user-agent.
+.B AGENT user\-agent \-\-
+Set HTTP "User\-Agent" string to
+.B user\-agent.
 
-.B CUSTOM\-HEADER name content --
+.B CUSTOM\-HEADER name content \-\-
 Adds the custom Header with
 .B name
 as name and
@@ -588,7 +588,7 @@ at a known address, however if packets arrive from a new
 address and pass all authentication tests, the new address
 will take control of the session.  This is useful when
 you are connecting to a peer which holds a dynamic address
-such as a dial-in user or DHCP client.
+such as a dial\-in user or DHCP client.
 
 Essentially,
 .B \-\-float
@@ -601,12 +601,12 @@ option.
 .B \-\-ipchange cmd
 Run command
 .B cmd
-when our remote ip-address is initially authenticated or
+when our remote ip\-address is initially authenticated or
 changes.
 
 .B cmd
 consists of a path to script (or executable program), optionally
-followed by arguments. The path and arguments may be single- or double-quoted
+followed by arguments. The path and arguments may be single\- or double\-quoted
 and/or escaped using a backslash, and should be separated by one or more spaces.
 
 When
@@ -656,7 +656,7 @@ and
 .B \-\-rport
 options to given port).  The current
 default of 1194 represents the official IANA port number
-assignment for OpenVPN and has been used since version 2.0-beta17.
+assignment for OpenVPN and has been used since version 2.0\-beta17.
 Previous versions used port 5000 as the default.
 .\"*********************************************************
 .TP
@@ -717,9 +717,9 @@ devices encapsulate IPv4 or IPv6 (OSI Layer 3) while
 devices encapsulate Ethernet 802.3 (OSI Layer 2).
 .\"*********************************************************
 .TP
-.B \-\-dev\-type device-type
+.B \-\-dev\-type device\-type
 Which device type are we using?
-.B device-type
+.B device\-type
 should be
 .B tun
 (OSI Layer 3)
@@ -756,13 +756,13 @@ directive, this directive must always be compatible between client and server.
 can be one of:
 
 .B net30 \-\-
-Use a point-to-point topology, by allocating one /30 subnet per client.
-This is designed to allow point-to-point semantics when some
+Use a point\-to\-point topology, by allocating one /30 subnet per client.
+This is designed to allow point\-to\-point semantics when some
 or all of the connecting clients might be Windows systems.  This is the
 default on OpenVPN 2.0.
 
 .B p2p \-\-
-Use a point-to-point topology where the remote endpoint of the client's
+Use a point\-to\-point topology where the remote endpoint of the client's
 tun interface always points to the local endpoint of the server's tun interface.
 This mode allocates a single IP address per connecting client.
 Only use
@@ -773,7 +773,7 @@ directive which is available in OpenVPN 2.0, is deprecated and will be
 removed in OpenVPN 2.5
 
 .B subnet \-\-
-Use a subnet rather than a point-to-point topology by
+Use a subnet rather than a point\-to\-point topology by
 configuring the tun interface with a local IP address and subnet mask,
 similar to the topology used in
 .B \-\-dev tap
@@ -783,7 +783,7 @@ Windows as well.  Only available when server and clients are OpenVPN 2.1 or
 higher, or OpenVPN 2.0.x which has been manually patched with the
 .B \-\-topology
 directive code.  When used on Windows, requires version 8.2 or higher
-of the TAP-Win32 driver.  When used on *nix, requires that the tun
+of the TAP\-Win32 driver.  When used on *nix, requires that the tun
 driver supports an
 .BR ifconfig (8)
 command which sets a subnet instead of a remote endpoint IP address.
@@ -819,7 +819,7 @@ When not specifying a
 .B \-\-dev\-node
 option openvpn will first try to open utun, and fall back to tun.kext.
 
-On Windows systems, select the TAP-Win32 adapter which
+On Windows systems, select the TAP\-Win32 adapter which
 is named
 .B node
 in the Network Connections Control Panel or the
@@ -827,10 +827,10 @@ raw GUID of the adapter enclosed by braces.
 The
 .B \-\-show\-adapters
 option under Windows can also be used
-to enumerate all available TAP-Win32
+to enumerate all available TAP\-Win32
 adapters and will show both the network
 connections control panel name and the GUID for
-each TAP-Win32 adapter.
+each TAP\-Win32 adapter.
 .TP
 .B \-\-lladdr address
 Specify the link layer address, more commonly known as the MAC address.
@@ -846,7 +846,7 @@ May be used in order to execute OpenVPN in unprivileged environment.
 Set TUN/TAP adapter parameters. 
 .B l
 is the IP address of the local VPN endpoint.
-For TUN devices in point-to-point mode,
+For TUN devices in point\-to\-point mode,
 .B rn
 is the IP address of the remote VPN endpoint.
 For TAP devices, or TUN devices used with
@@ -856,7 +856,7 @@ is the subnet mask of the virtual network segment
 which is being created or connected to.
 
 For TUN devices, which facilitate virtual
-point-to-point IP connections (when used in
+point\-to\-point IP connections (when used in
 .B \-\-topology net30
 or
 .B p2p
@@ -876,7 +876,7 @@ you will be pinging across the VPN.
 For TAP devices, which provide
 the ability to create virtual
 ethernet segments, or TUN devices in
-.B --topology subnet
+.B \-\-topology subnet
 mode (which create virtual "multipoint networks"),
 .B \-\-ifconfig
 is used to set an IP address and
@@ -956,10 +956,10 @@ while at the same time providing portable semantics
 across OpenVPN's platform space.
 
 .B netmask
-default -- 255.255.255.255
+default \-\- 255.255.255.255
 
 .B gateway
-default -- taken from
+default \-\- taken from
 .B \-\-route\-gateway
 or the second parameter to
 .B \-\-ifconfig
@@ -968,7 +968,7 @@ when
 is specified.
 
 .B metric
-default -- taken from
+default \-\- taken from
 .B \-\-route\-metric
 otherwise 0.
 
@@ -984,7 +984,7 @@ also be specified as a DNS or /etc/hosts
 file resolvable name, or as one of three special keywords:
 
 .B vpn_gateway
--- The remote VPN endpoint address
+\-\- The remote VPN endpoint address
 (derived either from
 .B \-\-route\-gateway
 or the second parameter to
@@ -994,11 +994,11 @@ when
 is specified).
 
 .B net_gateway
--- The pre-existing IP default gateway, read from the routing
+\-\- The pre\-existing IP default gateway, read from the routing
 table (not supported on all OSes).
 
 .B remote_host
--- The
+\-\- The
 .B \-\-remote
 address if OpenVPN is being run in client mode, and is undefined in server mode.
 .\"*********************************************************
@@ -1013,7 +1013,7 @@ If
 .B dhcp
 is specified as the parameter,
 the gateway address will be extracted from a DHCP
-negotiation with the OpenVPN server-side LAN.
+negotiation with the OpenVPN server\-side LAN.
 .\"*********************************************************
 .TP
 .B \-\-route\-metric m
@@ -1053,7 +1053,7 @@ On Windows,
 tries to be more intelligent by waiting
 .B w
 seconds (w=30 by default)
-for the TAP-Win32 adapter to come up before adding routes.
+for the TAP\-Win32 adapter to come up before adding routes.
 .\"*********************************************************
 .TP
 .B \-\-route\-up cmd
@@ -1064,7 +1064,7 @@ after routes are added, subject to
 
 .B cmd
 consists of a path to script (or executable program), optionally
-followed by arguments. The path and arguments may be single- or double-quoted
+followed by arguments. The path and arguments may be single\- or double\-quoted
 and/or escaped using a backslash, and should be separated by one or more spaces.
 
 See the "Environmental Variables" section below for
@@ -1078,7 +1078,7 @@ before routes are removed upon disconnection.
 
 .B cmd
 consists of a path to script (or executable program), optionally
-followed by arguments. The path and arguments may be single- or double-quoted
+followed by arguments. The path and arguments may be single\- or double\-quoted
 and/or escaped using a backslash, and should be separated by one or more spaces.
 
 See the "Environmental Variables" section below for
@@ -1096,7 +1096,7 @@ When used with
 .B \-\-client
 or
 .B \-\-pull,
-accept options pushed by server EXCEPT for routes, block-outside-dns and dhcp
+accept options pushed by server EXCEPT for routes, block\-outside\-dns and dhcp
 options like DNS servers.
 
 When used on the client, this option effectively bars the
@@ -1115,7 +1115,7 @@ and
 .\"*********************************************************
 .TP
 .B \-\-client\-nat snat|dnat network netmask alias
-This pushable client option sets up a stateless one-to-one NAT
+This pushable client option sets up a stateless one\-to\-one NAT
 rule on packet addresses (not ports), and is useful in cases
 where routes or ifconfig settings pushed to the client would
 create an IP numbering conflict.
@@ -1141,14 +1141,14 @@ addresses in packets.
 .TP
 .B \-\-redirect\-gateway flags...
 Automatically execute routing commands to cause all outgoing IP traffic
-to be redirected over the VPN.  This is a client-side option.
+to be redirected over the VPN.  This is a client\-side option.
 
 This option performs three steps:
 
 .B (1)
 Create a static route for the
 .B \-\-remote
-address which forwards to the pre-existing default gateway.
+address which forwards to the pre\-existing default gateway.
 This is done so that
 .B (3)
 will not create a routing loop.
@@ -1185,39 +1185,39 @@ Try to automatically determine whether to enable
 .B local
 flag above.
 
-.B def1 --
+.B def1 \-\-
 Use this flag to override
 the default gateway by using 0.0.0.0/1 and 128.0.0.0/1
 rather than 0.0.0.0/0.  This has the benefit of overriding
 but not wiping out the original default gateway. 
 
-.B bypass-dhcp --
-Add a direct route to the DHCP server (if it is non-local) which
+.B bypass\-dhcp \-\-
+Add a direct route to the DHCP server (if it is non\-local) which
 bypasses the tunnel
 (Available on Windows clients, may not be available
-on non-Windows clients).
+on non\-Windows clients).
 
-.B bypass-dns --
-Add a direct route to the DNS server(s) (if they are non-local) which
+.B bypass\-dns \-\-
+Add a direct route to the DNS server(s) (if they are non\-local) which
 bypasses the tunnel
 (Available on Windows clients, may not be available
-on non-Windows clients).
+on non\-Windows clients).
 
-.B block-local --
+.B block\-local \-\-
 Block access to local LAN when the tunnel is active, except for
 the LAN gateway itself.  This is accomplished by routing the local
 LAN (except for the LAN gateway address) into the tunnel.
 
-.B ipv6 --
+.B ipv6 \-\-
 Redirect IPv6 routing into the tunnel.  This works similar to the
 .B def1
 flag, that is, more specific IPv6 routes are added (2000::/4, 3000::/4),
 covering the whole IPv6 unicast space.
 
-.B !ipv4 --
-Do not redirect IPv4 traffic - typically used in the flag pair
+.B !ipv4 \-\-
+Do not redirect IPv4 traffic \- typically used in the flag pair
 .B "ipv6 !ipv4"
-to redirect IPv6-only.
+to redirect IPv6\-only.
 .\"*********************************************************
 .TP
 .B \-\-link\-mtu n
@@ -1271,13 +1271,13 @@ Should we do Path MTU discovery on TCP/UDP channel?  Only supported on OSes such
 as Linux that supports the necessary system call to set.
 
 .B 'no'
--- Never send DF (Don't Fragment) frames
+\-\- Never send DF (Don't Fragment) frames
 .br
 .B 'maybe'
--- Use per-route hints
+\-\- Use per\-route hints
 .br
 .B 'yes'
--- Always DF (Don't Fragment)
+\-\- Always DF (Don't Fragment)
 .br
 .\"*********************************************************
 .TP
@@ -1357,7 +1357,7 @@ without IP level fragmentation.
 The
 .B \-\-mssfix
 option only makes sense when you are using the UDP protocol
-for OpenVPN peer-to-peer communication, i.e.
+for OpenVPN peer\-to\-peer communication, i.e.
 .B \-\-proto udp.
 
 .B \-\-mssfix
@@ -1396,7 +1396,7 @@ parameter from the
 option.
 
 Therefore, one could lower the maximum UDP packet size
-to 1300 (a good first try for solving MTU-related
+to 1300 (a good first try for solving MTU\-related
 connection problems) with the following options:
 
 .B \-\-tun\-mtu 1500 \-\-fragment 1300 \-\-mssfix
@@ -1459,11 +1459,11 @@ seconds before queuing the next write.
 
 It should be noted that OpenVPN supports multiple
 tunnels between the same two peers, allowing you
-to construct full-speed and reduced bandwidth tunnels
+to construct full\-speed and reduced bandwidth tunnels
 at the same time,
-routing low-priority data such as off-site backups
+routing low\-priority data such as off\-site backups
 over the reduced bandwidth tunnel, and other data
-over the full-speed tunnel.
+over the full\-speed tunnel.
 
 Also note that for low bandwidth tunnels
 (under 1000 bytes per second), you should probably
@@ -1538,7 +1538,7 @@ This option can be combined with
 .B \-\-inactive, \-\-ping,
 and
 .B \-\-ping\-exit
-to create a two-tiered inactivity disconnect.
+to create a two\-tiered inactivity disconnect.
 
 For example,
 
@@ -1561,7 +1561,7 @@ or other packet from remote.
 
 This option is useful in cases
 where the remote peer has a dynamic IP address and
-a low-TTL DNS name is used to track the IP address using
+a low\-TTL DNS name is used to track the IP address using
 a service such as
 .I http://dyndns.org/
 + a dynamic DNS client such
@@ -1571,7 +1571,7 @@ as
 If the peer cannot be reached, a restart will be triggered, causing
 the hostname used with
 .B \-\-remote
-to be re-resolved (if
+to be re\-resolved (if
 .B \-\-resolv\-retry
 is also specified).
 
@@ -1677,12 +1677,12 @@ restarts.
 .B SIGUSR1
 is a restart signal similar to
 .B SIGHUP,
-but which offers finer-grained control over
+but which offers finer\-grained control over
 reset options.
 .\"*********************************************************
 .TP
 .B \-\-persist\-key
-Don't re-read key files across
+Don't re\-read key files across
 .B SIGUSR1
 or
 .B \-\-ping\-restart.
@@ -1693,12 +1693,12 @@ to allow restarts triggered by the
 .B SIGUSR1
 signal.
 Normally if you drop root privileges in OpenVPN,
-the daemon cannot be restarted since it will now be unable to re-read protected
+the daemon cannot be restarted since it will now be unable to re\-read protected
 key files.
 
 This option solves the problem by persisting keys across
 .B SIGUSR1
-resets, so they don't need to be re-read.
+resets, so they don't need to be re\-read.
 .\"*********************************************************
 .TP
 .B \-\-persist\-local\-ip
@@ -1755,7 +1755,7 @@ UID change).
 
 .B cmd
 consists of a path to script (or executable program), optionally
-followed by arguments. The path and arguments may be single- or double-quoted
+followed by arguments. The path and arguments may be single\- or double\-quoted
 and/or escaped using a backslash, and should be separated by one or more spaces.
 
 The up command is useful for specifying route
@@ -1780,7 +1780,7 @@ additional parameters passed as environmental variables.
 
 Note that if
 .B cmd
-includes arguments, all OpenVPN-generated arguments will be appended
+includes arguments, all OpenVPN\-generated arguments will be appended
 to them to build an argument list with which the executable will be
 called.
 
@@ -1812,7 +1812,7 @@ as the last parameter.
 
 NOTE: on restart, OpenVPN will not pass the full set of environment
 variables to the script.  Namely, everything related to routing and
-gateways will not be passed, as nothing needs to be done anyway - all
+gateways will not be passed, as nothing needs to be done anyway \- all
 the routing setup is already in place.  Additionally, the up\-restart
 script will run with the downgraded UID/GID settings (if configured).
 
@@ -1821,7 +1821,7 @@ The following standalone example shows how the
 script can be called in both an initialization and restart context.
 (NOTE: for security reasons, don't run the following example unless UDP port
 9999 is blocked by your firewall.  Also, the example will run indefinitely,
-so you should abort with control-c).
+so you should abort with control\-c).
 
 .B openvpn \-\-dev tun \-\-port 9999 \-\-verb 4 \-\-ping\-restart 10 \-\-up 'echo up' \-\-down 'echo down' \-\-persist\-tun \-\-up\-restart
 
@@ -1858,7 +1858,7 @@ mode, this option normally requires the use of
 to allow connection initiation to be sensed in the absence
 of tunnel data, since UDP is a "connectionless" protocol.
 
-On Windows, this option will delay the TAP-Win32 media state
+On Windows, this option will delay the TAP\-Win32 media state
 transitioning to "connected" until connection establishment,
 i.e. the receipt of the first authenticated packet from the peer.
 .\"*********************************************************
@@ -1874,7 +1874,7 @@ UID change and/or
 ).
 .B cmd
 consists of a path to script (or executable program), optionally
-followed by arguments. The path and arguments may be single- or double-quoted
+followed by arguments. The path and arguments may be single\- or double\-quoted
 and/or escaped using a backslash, and should be separated by one or more spaces.
 
 Called with the same parameters and environmental
@@ -1970,7 +1970,7 @@ is available since OpenVPN 2.3.3.
 .\"*********************************************************
 .TP
 .B \-\-script\-security level
-This directive offers policy-level control over OpenVPN's usage of external programs
+This directive offers policy\-level control over OpenVPN's usage of external programs
 and scripts.  Lower
 .B level
 values are more restrictive, higher values are more permissive.  Settings for
@@ -1980,10 +1980,10 @@ values are more restrictive, higher values are more permissive.  Settings for
 Strictly no calling of external programs.
 .br
 .B 1 \-\-
-(Default) Only call built-in executables such as ifconfig, ip, route, or netsh.
+(Default) Only call built\-in executables such as ifconfig, ip, route, or netsh.
 .br
 .B 2 \-\-
-Allow calling of built-in executables and user-defined scripts.
+Allow calling of built\-in executables and user\-defined scripts.
 .br
 .B 3 \-\-
 Allow passwords to be passed to scripts via environmental variables (potentially unsafe).
@@ -2008,14 +2008,14 @@ versions you needed to either add a full path to the script interpreter which ca
 script or use the
 .B system
 flag to run these scripts.  As of OpenVPN 2.3 it is now a strict requirement to have
-full path to the script interpreter when running non-executables files.
+full path to the script interpreter when running non\-executables files.
 This is not needed for executable files, such as .exe, .com, .bat or .cmd files.  For
 example, if you have a Visual Basic script, you must use this syntax now:
 
 .nf
 .ft 3
 .in +4
-\-\-up 'C:\\\\Windows\\\\System32\\\\wscript.exe C:\\\\Program\\ Files\\\\OpenVPN\\\\config\\\\my-up-script.vbs'
+\-\-up 'C:\\\\Windows\\\\System32\\\\wscript.exe C:\\\\Program\\ Files\\\\OpenVPN\\\\config\\\\my\-up\-script.vbs'
 .in -4
 .ft
 .fi
@@ -2065,7 +2065,7 @@ signal
 to a DHCP reset), you should make use of one or more of the
 .B \-\-persist
 options to ensure that OpenVPN doesn't need to execute any privileged
-operations in order to restart (such as re-reading key files
+operations in order to restart (such as re\-reading key files
 or running
 .BR ifconfig
 on the TUN device).
@@ -2111,7 +2111,7 @@ This can be desirable from a security standpoint.
 
 Since the chroot operation is delayed until after
 initialization, most OpenVPN options that reference
-files will operate in a pre-chroot context.
+files will operate in a pre\-chroot context.
 
 In many cases, the
 .B dir
@@ -2146,7 +2146,7 @@ it inside the chroot directory (e.g. with mount \-\-bind).
 
 Since the setcon operation is delayed until after
 initialization, OpenVPN can be restricted to just
-network-related system calls, whereas by applying the
+network\-related system calls, whereas by applying the
 context before startup (such as the OpenVPN one provided
 in the SELinux Reference Policies) you will have to
 allow many things required only during initialization.
@@ -2195,11 +2195,11 @@ that initialization scripts can test the return status of the
 openvpn command for a fairly reliable indication of whether the command
 has correctly initialized and entered the packet forwarding event loop.
 
-In OpenVPN, the vast majority of errors which occur after initialization are non-fatal.
+In OpenVPN, the vast majority of errors which occur after initialization are non\-fatal.
 
 Note: as soon as OpenVPN has daemonized, it can not ask for usernames,
 passwords, or key pass phrases anymore.  This has certain consequences,
-namely that using a password-protected private key will fail unless the
+namely that using a password\-protected private key will fail unless the
 .B \-\-askpass
 option is used to tell OpenVPN to ask for the pass phrase (this
 requirement is new in v2.3.7, and is a consequence of calling daemon()
@@ -2208,9 +2208,9 @@ before initializing the crypto layer).
 Further, using
 .B \-\-daemon
 together with
-.B \-\-auth-user-pass
+.B \-\-auth\-user\-pass
 (entered on console) and
-.B \-\-auth-nocache
+.B \-\-auth\-nocache
 will fail as soon as key renegotiation (and reauthentication) occurs.
 .\"*********************************************************
 .TP
@@ -2347,7 +2347,7 @@ less than zero is higher priority).
 .\".B \-\-tls\-server
 .\"specified).
 .\"
-.\"Using a TLS thread offloads the CPU-intensive process of SSL/TLS-based
+.\"Using a TLS thread offloads the CPU\-intensive process of SSL/TLS\-based
 .\"key exchange to a background thread so that it does not become
 .\"a latency bottleneck in the tunnel packet forwarding process.
 .\"
@@ -2369,7 +2369,7 @@ or TUN/TAP devices.  In such cases, one can optimize the event loop
 by avoiding the poll/epoll/select call, improving CPU efficiency
 by 5% to 10%.
 
-This option can only be used on non-Windows systems, when
+This option can only be used on non\-Windows systems, when
 .B \-\-proto udp
 is specified, and when
 .B \-\-shaper
@@ -2377,7 +2377,7 @@ is NOT specified.
 .\"*********************************************************
 .TP
 .B \-\-multihome
-Configure a multi-homed UDP server.  This option needs to be used when
+Configure a multi\-homed UDP server.  This option needs to be used when
 a server has more than one IP address (e.g. multiple interfaces, or
 secondary IP addresses), and is not using
 .B \-\-local
@@ -2389,10 +2389,10 @@ processing, so it's not enabled by default.
 
 Note: this option is only relevant for UDP servers.
 
-Note 2: if you do an IPv6+IPv4 dual-stack bind on a Linux machine with
+Note 2: if you do an IPv6+IPv4 dual\-stack bind on a Linux machine with
 multiple IPv4 address, connections to IPv4 addresses will not work
 right on kernels before 3.15, due to missing kernel support for the
-IPv4-mapped case (some distributions have ported this to earlier kernel
+IPv4\-mapped case (some distributions have ported this to earlier kernel
 versions, though).
 .\"*********************************************************
 .TP
@@ -2492,7 +2492,7 @@ newer
 .B \-\-compress
 instead.
 
-Use LZO compression -- may add up to 1 byte per
+Use LZO compression \-\- may add up to 1 byte per
 packet for incompressible data.
 .B mode
 may be "yes", "no", or "adaptive" (default).
@@ -2500,7 +2500,7 @@ may be "yes", "no", or "adaptive" (default).
 In a server mode setup, it is possible to selectively turn
 compression on or off for individual clients.
 
-First, make sure the client-side config file enables selective
+First, make sure the client\-side config file enables selective
 compression by having at least one
 .B \-\-comp\-lzo
 directive, such as
@@ -2539,19 +2539,19 @@ Normally, adaptive compression is enabled with
 
 Adaptive compression tries to optimize the case where you have
 compression enabled, but you are sending predominantly incompressible
-(or pre-compressed) packets over the tunnel, such as an FTP or rsync transfer
+(or pre\-compressed) packets over the tunnel, such as an FTP or rsync transfer
 of a large, compressed file.  With adaptive compression,
 OpenVPN will periodically sample the compression process to measure its
 efficiency.  If the data being sent over the tunnel is already compressed,
 the compression efficiency will be very low, triggering openvpn to disable
-compression for a period of time until the next re-sample test.
+compression for a period of time until the next re\-sample test.
 .\"*********************************************************
 .TP
-.B \-\-management IP port [pw-file]
+.B \-\-management IP port [pw\-file]
 Enable a TCP server on
 .B IP:port
 to handle daemon management functions.
-.B pw-file,
+.B pw\-file,
 if specified,
 is a password file (password on first line)
 or "stdin" to prompt from standard input.  The password
@@ -2618,28 +2618,28 @@ console.
 .B \-\-management\-query\-proxy
 Query management channel for proxy server information for a specific
 .B \-\-remote
-(client-only).
+(client\-only).
 .\"*********************************************************
 .TP
 .B \-\-management\-query\-remote
 Allow management interface to override
 .B \-\-remote
-directives (client-only).
+directives (client\-only).
 .\"*********************************************************
 .TP
 .B \-\-management\-external\-key
 Allows usage for external private key file instead of
 .B \-\-key
-option (client-only).
+option (client\-only).
 .\"*********************************************************
 .TP
-.B \-\-management\-external\-cert certificate-hint
+.B \-\-management\-external\-cert certificate\-hint
 Allows usage for external certificate instead of
 .B \-\-cert
-option (client-only).
-.B certificate-hint
+option (client\-only).
+.B certificate\-hint
 is an arbitrary string which is passed to a management
-interface client as an argument of NEED-CERTIFICATE notification.
+interface client as an argument of NEED\-CERTIFICATE notification.
 Requires \-\-management\-external\-key.
 .\"*********************************************************
 .TP
@@ -2682,7 +2682,7 @@ Report tunnel up/down events to management interface.
 .B \-\-management\-client\-auth
 Gives management interface client the responsibility
 to authenticate clients after their client certificate
-has been verified.  See management-notes.txt in OpenVPN
+has been verified.  See management\-notes.txt in OpenVPN
 distribution for detailed notes.
 .\"*********************************************************
 .TP
@@ -2704,21 +2704,21 @@ only allow connections from group
 .B g.
 .\"*********************************************************
 .TP
-.B \-\-plugin module-pathname [init-string]
-Load plug-in module from the file
-.B module-pathname,
+.B \-\-plugin module\-pathname [init\-string]
+Load plug\-in module from the file
+.B module\-pathname,
 passing
-.B init-string
+.B init\-string
 as an argument
 to the module initialization function.  Multiple
 plugin modules may be loaded into one OpenVPN
 process.
 
 The
-.B module-pathname
+.B module\-pathname
 argument can be just a filename or a filename with a relative
 or absolute path.  The format of the filename and path defines
-if the plug-in will be loaded from a default plug-in directory
+if the plug\-in will be loaded from a default plug\-in directory
 or outside this directory.
 
 .nf
@@ -2733,7 +2733,7 @@ or outside this directory.
 .in -4
 .fi
 
-DEFAULT_DIR is replaced by the default plug-in directory,
+DEFAULT_DIR is replaced by the default plug\-in directory,
 which is configured at the build time of OpenVPN.  CWD is the
 current directory where OpenVPN was started or the directory
 OpenVPN have swithed into via the
@@ -2743,7 +2743,7 @@ option before the
 option.
 
 For more information and examples on how to build OpenVPN
-plug-in modules, see the README file in the
+plug\-in modules, see the README file in the
 .B plugin
 folder of the OpenVPN source distribution.
 
@@ -2766,7 +2766,7 @@ every module and script must return success (0) in order for
 the connection to be authenticated.
 .\"*********************************************************
 .TP
-.B \-\-keying-material-exporter label len
+.B \-\-keying\-material\-exporter label len
 Save Exported Keying Material [RFC5705] of len bytes (must be
 between 16 and 4095 bytes) using label in environment
 (exported_keying_material) for use by plugins in
@@ -2777,7 +2777,7 @@ labels. In order to prevent this, labels MUST begin with "EXPORTER".
 
 .\"*********************************************************
 .SS Server Mode
-Starting with OpenVPN 2.0, a multi-client TCP/UDP server mode
+Starting with OpenVPN 2.0, a multi\-client TCP/UDP server mode
 is supported, and can be enabled with the
 .B \-\-mode server
 option.  In server mode, OpenVPN will listen on a single
@@ -2795,7 +2795,7 @@ of OpenVPN's server mode.  This directive will set up an
 OpenVPN server which will allocate addresses to clients
 out of the given network/netmask.  The server itself
 will take the ".1" address of the given network
-for use as the server-side endpoint of the local
+for use as the server\-side endpoint of the local
 TUN/TAP interface.
 
 For example,
@@ -2838,7 +2838,7 @@ if you are ethernet bridging.  Use
 instead.
 .\"*********************************************************
 .TP
-.B \-\-server\-bridge gateway netmask pool-start-IP pool-end-IP
+.B \-\-server\-bridge gateway netmask pool\-start\-IP pool\-end\-IP
 .TP
 .B \-\-server\-bridge ['nogw']
 
@@ -2849,10 +2849,10 @@ of OpenVPN's server mode in ethernet bridging configurations.
 
 If
 .B \-\-server\-bridge
-is used without any parameters, it will enable a DHCP-proxy
+is used without any parameters, it will enable a DHCP\-proxy
 mode, where connecting OpenVPN clients will receive an IP
 address for their TAP adapter from the DHCP server running
-on the OpenVPN server-side LAN.
+on the OpenVPN server\-side LAN.
 Note that only clients that support
 the binding of a DHCP client with the TAP adapter (such as
 Windows) can support this mode.  The optional 
@@ -2868,7 +2868,7 @@ with the
 .B brctl
 tool, and with Windows XP it is done in the Network
 Connections Panel by selecting the ethernet and
-TAP adapters and right-clicking on "Bridge Connections".
+TAP adapters and right\-clicking on "Bridge Connections".
 
 Next you you must manually set the
 IP/netmask on the bridge interface.  The
@@ -2885,9 +2885,9 @@ subnet.
 Finally, set aside a IP range in the bridged
 subnet,
 denoted by
-.B pool-start-IP
+.B pool\-start\-IP
 and
-.B pool-end-IP,
+.B pool\-end\-IP,
 for OpenVPN to allocate to connecting
 clients.
 
@@ -2966,7 +2966,7 @@ This is a partial list of options which can currently be pushed:
 .TP
 .B \-\-push\-reset
 Don't inherit the global push list for a specific client instance.
-Specify this option in a client-specific context such
+Specify this option in a client\-specific context such
 as with a
 .B \-\-client\-config\-dir
 configuration file.  This option will ignore
@@ -2978,22 +2978,22 @@ options at the global config file level.
 selectively remove all
 .B \-\-push
 options matching "opt" from the option list for a client.  "opt" is matched
-as a substring against the whole option string to-be-pushed to the client, so
+as a substring against the whole option string to\-be\-pushed to the client, so
 .B \-\-push\-remove route
 would remove all
 .B \-\-push route ...
 and
-.B \-\-push route-ipv6 ...
+.B \-\-push route\-ipv6 ...
 statements, while
-.B \-\-push\-remove 'route-ipv6 2001:'
+.B \-\-push\-remove 'route\-ipv6 2001:'
 would only remove IPv6 routes for 2001:... networks.
 
 .B \-\-push\-remove
-can only be used in a client-specific context, like in a
+can only be used in a client\-specific context, like in a
 .B \-\-client\-config\-dir
 file, or
 .B \-\-client\-connect
-script or plugin -- similar to
+script or plugin \-\- similar to
 .B \-\-push\-reset,
 just more selective.
 
@@ -3010,22 +3010,22 @@ option with the new value.
 Push additional information about the client to server.
 The following data is always pushed to the server:
 
-IV_VER=<version> -- the client OpenVPN version
+IV_VER=<version> \-\- the client OpenVPN version
 
-IV_PLAT=[linux|solaris|openbsd|mac|netbsd|freebsd|win] -- the client OS platform
+IV_PLAT=[linux|solaris|openbsd|mac|netbsd|freebsd|win] \-\- the client OS platform
 
-IV_LZO_STUB=1 -- if client was built with LZO stub capability
+IV_LZO_STUB=1 \-\- if client was built with LZO stub capability
 
-IV_LZ4=1 -- if the client supports LZ4 compressions.
+IV_LZ4=1 \-\- if the client supports LZ4 compressions.
 
-IV_PROTO=2 -- if the client supports peer-id floating mechansim
+IV_PROTO=2 \-\- if the client supports peer\-id floating mechansim
 
-IV_NCP=2 -- negotiable ciphers, client supports
+IV_NCP=2 \-\- negotiable ciphers, client supports
 .B \-\-cipher
 pushed by the server, a value of 2 or greater indicates client
-supports AES-GCM-128 and AES-GCM-256.
+supports AES\-GCM\-128 and AES\-GCM\-256.
 
-IV_UI_VER=<gui_id> <version> -- the UI version of a UI if one is
+IV_UI_VER=<gui_id> <version> \-\- the UI version of a UI if one is
 running, for example "de.blinkt.openvpn 0.5.47" for the
 Android app.
 
@@ -3033,13 +3033,13 @@ When
 .B \-\-push\-peer\-info
 is enabled the additional information consists of the following data:
 
-IV_HWADDR=<mac address> -- the MAC address of clients default gateway
+IV_HWADDR=<mac address> \-\- the MAC address of clients default gateway
 
-IV_SSL=<version string> -- the ssl version used by the client, e.g. "OpenSSL 1.0.2f 28 Jan 2016".
+IV_SSL=<version string> \-\- the ssl version used by the client, e.g. "OpenSSL 1.0.2f 28 Jan 2016".
 
-IV_PLAT_VER=x.y - the version of the operating system, e.g. 6.1 for Windows 7.
+IV_PLAT_VER=x.y \- the version of the operating system, e.g. 6.1 for Windows 7.
 
-UV_<name>=<value> -- client environment variables whose names start with "UV_"
+UV_<name>=<value> \-\- client environment variables whose names start with "UV_"
 .\"*********************************************************
 .TP
 .B \-\-disable
@@ -3059,12 +3059,12 @@ or dynamically generated using a
 script.
 .\"*********************************************************
 .TP
-.B \-\-ifconfig\-pool start-IP end-IP [netmask]
+.B \-\-ifconfig\-pool start\-IP end\-IP [netmask]
 Set aside a pool of subnets to be
 dynamically allocated to connecting clients, similar
-to a DHCP server.  For tun-style
+to a DHCP server.  For tun\-style
 tunnels, each client will be given a /30 subnet (for
-interoperability with Windows clients).  For tap-style
+interoperability with Windows clients).  For tap\-style
 tunnels, individual addresses will be allocated, and the
 optional
 .B netmask
@@ -3081,24 +3081,24 @@ at
 intervals (default=600), as well as on program startup and
 shutdown.
 
-The goal of this option is to provide a long-term association
+The goal of this option is to provide a long\-term association
 between clients (denoted by their common name) and the virtual
-IP address assigned to them from the ifconfig-pool.
-Maintaining a long-term
+IP address assigned to them from the ifconfig\-pool.
+Maintaining a long\-term
 association is good for clients because it allows them
 to effectively use the
 .B \-\-persist\-tun
 option.
 
 .B file
-is a comma-delimited ASCII file, formatted as
-<Common-Name>,<IP-address>.
+is a comma\-delimited ASCII file, formatted as
+<Common\-Name>,<IP\-address>.
 
 If
 .B seconds
 = 0,
 .B file
-will be treated as read-only.  This is useful if
+will be treated as read\-only.  This is useful if
 you would like to treat
 .B file
 as a configuration file.
@@ -3175,17 +3175,17 @@ OpenVPN's internal client IP address selection algorithm works as
 follows:
 
 .B 1
--- Use
+\-\- Use
 .B \-\-client\-connect script
 generated file for static IP (first choice).
 .br
 .B 2
--- Use
+\-\- Use
 .B \-\-client\-config\-dir
 file for static IP (next choice).
 .br
 .B 3
--- Use
+\-\- Use
 .B \-\-ifconfig\-pool
 allocation for dynamic IP (last choice).
 .br
@@ -3245,15 +3245,15 @@ Because the OpenVPN server mode handles multiple clients
 through a single tun or tap interface, it is effectively
 a router.  The
 .B \-\-client\-to\-client
-flag tells OpenVPN to internally route client-to-client
-traffic rather than pushing all client-originating traffic
+flag tells OpenVPN to internally route client\-to\-client
+traffic rather than pushing all client\-originating traffic
 to the TUN/TAP interface.
 
 When this option is used, each client will "see" the other
 clients which are currently connected.  Otherwise, each
 client will only see the server.  Don't use this option
 if you want to firewall tunnel traffic using
-custom, per-client rules.
+custom, per\-client rules.
 .\"*********************************************************
 .TP
 .B \-\-duplicate\-cn
@@ -3269,11 +3269,11 @@ on client connection.
 
 .B cmd
 consists of a path to script (or executable program), optionally
-followed by arguments. The path and arguments may be single- or double-quoted
+followed by arguments. The path and arguments may be single\- or double\-quoted
 and/or escaped using a backslash, and should be separated by one or more spaces.
 
 The command is passed the common name
-and IP address of the just-authenticated client
+and IP address of the just\-authenticated client
 as environmental variables (see environmental variable section
 below).  The command is also passed
 the pathname of a freshly created temporary file as the last argument
@@ -3295,7 +3295,7 @@ Note that the return value of
 .B script
 is significant.  If
 .B script
-returns a non-zero error status, it will cause the client
+returns a non\-zero error status, it will cause the client
 to be disconnected.
 .\"*********************************************************
 .TP
@@ -3311,10 +3311,10 @@ successful (0) status returns.
 
 The exception to this rule is if the
 .B \-\-client\-disconnect
-command or plugins are cascaded, and at least one client-connect
-function succeeded, then ALL of the client-disconnect functions for
+command or plugins are cascaded, and at least one client\-connect
+function succeeded, then ALL of the client\-disconnect functions for
 scripts and plugins will be called on client instance object deletion,
-even in cases where some of the related client-connect functions returned
+even in cases where some of the related client\-connect functions returned
 an error status.
 
 The
@@ -3334,7 +3334,7 @@ for custom client config files.  After
 a connecting client has been authenticated, OpenVPN will
 look in this directory for a file having the same name
 as the client's X509 common name.  If a matching file
-exists, it will be opened and parsed for client-specific
+exists, it will be opened and parsed for client\-specific
 configuration options.  If no matching file is found, OpenVPN
 will instead try to open and parse a default file called
 "DEFAULT", which may be provided but is not required. Note that
@@ -3353,7 +3353,7 @@ created, edited, or removed while the server is live,
 without needing to restart the server.
 
 The following
-options are legal in a client-specific context:
+options are legal in a client\-specific context:
 .B \-\-push, \-\-push\-reset, \-\-push\-remove, \-\-iroute, \-\-ifconfig\-push,
 and
 .B \-\-config.
@@ -3379,7 +3379,7 @@ This directory will be used by in the following cases:
 
 *
 .B \-\-client\-connect
-scripts to dynamically generate client-specific
+scripts to dynamically generate client\-specific
 configuration files.
 
 *
@@ -3458,7 +3458,7 @@ forcing the server to deplete
 virtual memory as its internal routing table expands.
 This directive can be used in a
 .B \-\-client\-config\-dir
-file or auto-generated by a
+file or auto\-generated by a
 .B \-\-client\-connect
 script to override the global value for a particular client.
 
@@ -3514,7 +3514,7 @@ to validate client virtual addresses or routes.
 
 .B cmd
 consists of a path to script (or executable program), optionally
-followed by arguments. The path and arguments may be single- or double-quoted
+followed by arguments. The path and arguments may be single\- or double\-quoted
 and/or escaped using a backslash, and should be separated by one or more spaces.
 
 Three arguments will be appended to any arguments in
@@ -3539,7 +3539,7 @@ client linked to this address.  Only present for "add"
 or "update" operations, not "delete".
 
 On "add" or "update" methods, if the script returns
-a failure code (non-zero), OpenVPN will reject the address
+a failure code (non\-zero), OpenVPN will reject the address
 and will not modify its internal routing table.
 
 Normally, the
@@ -3548,8 +3548,8 @@ script will use the information provided above to set
 appropriate firewall entries on the VPN TUN/TAP interface.
 Since OpenVPN provides the association between virtual IP
 or MAC address and the client's authenticated common name,
-it allows a user-defined script to configure firewall access
-policies with regard to the client's high-level common name,
+it allows a user\-defined script to configure firewall access
+policies with regard to the client's high\-level common name,
 rather than the low level client virtual addresses.
 .\"*********************************************************
 .TP
@@ -3564,7 +3564,7 @@ provided by the client.
 
 .B cmd
 consists of a path to script (or executable program), optionally
-followed by arguments. The path and arguments may be single- or double-quoted
+followed by arguments. The path and arguments may be single\- or double\-quoted
 and/or escaped using a backslash, and should be separated by one or more spaces.
 
 If
@@ -3603,18 +3603,18 @@ returning a success exit code (0) if the
 client's authentication request is to be accepted, or a failure
 code (1) to reject the client.
 
-This directive is designed to enable a plugin-style interface
+This directive is designed to enable a plugin\-style interface
 for extending OpenVPN's authentication capabilities.
 
 To protect against a client passing a maliciously formed
 username or password string, the username string must
 consist only of these characters: alphanumeric, underbar
-('_'), dash ('-'), dot ('.'), or at ('@').  The password
+('_'), dash ('\-'), dot ('.'), or at ('@').  The password
 string can consist of any printable characters except for
 CR or LF.  Any illegal characters in either the username
 or password string will be converted to underbar ('_').
 
-Care must be taken by any user-defined scripts to avoid
+Care must be taken by any user\-defined scripts to avoid
 creating a security vulnerability in the way that these
 strings are handled.  Never use these strings in such a way
 that they might be escaped or evaluated by a shell interpreter.
@@ -3643,7 +3643,7 @@ or it is set to 0, the token will never expire.
 This feature is useful for environments which is configured
 to use One Time Passwords (OTP) as part of the user/password
 authentications and that authentication mechanism does not
-implement any auth-token support.
+implement any auth\-token support.
 .\"*********************************************************
 .TP
 .B \-\-opt\-verify
@@ -3669,10 +3669,10 @@ or
 is specified (or an authentication plugin module), the
 OpenVPN server daemon will require connecting clients to specify a
 username and password.  This option makes the submission of a username/password
-by clients optional, passing the responsibility to the user-defined authentication
+by clients optional, passing the responsibility to the user\-defined authentication
 module/script to accept or deny the client based on other factors
 (such as the setting of X509 certificate fields).  When this option is used,
-and a connecting client does not submit a username/password, the user-defined
+and a connecting client does not submit a username/password, the user\-defined
 authentication module/script will see the username and password as being set
 to empty strings ("").  The authentication module/script MUST have logic
 to detect this condition and respond accordingly.
@@ -3763,16 +3763,16 @@ like this:
 /C=US/L=Somewhere/CN=John Doe/emailAddress=john@...1113...
 .IP
 In addition the old behaviour was to remap any character other than
-alphanumeric, underscore ('_'), dash ('-'), dot ('.'), and slash ('/') to
+alphanumeric, underscore ('_'), dash ('\-'), dot ('.'), and slash ('/') to
 underscore ('_').  The X.509 Subject string as returned by the
 .B tls_id
 environmental variable, could additionally contain colon (':') or equal ('=').
 .IP
 When using the
 .B \-\-compat\-names
-option, this old formatting and remapping will be re-enabled again.  This is
-purely implemented for compatibility reasons when using older plug-ins or
-scripts which does not handle the new formatting or UTF-8 characters.
+option, this old formatting and remapping will be re\-enabled again.  This is
+purely implemented for compatibility reasons when using older plug\-ins or
+scripts which does not handle the new formatting or UTF\-8 characters.
 .IP
 In OpenVPN 2.3 the formatting of these fields changed into a more
 standardised format.  It now looks like:
@@ -3795,12 +3795,12 @@ option to be compatible with the now deprecated \-\-no\-name\-remapping option.
 It is only available at the server. When this mode flag is used, the Common Name,
 Subject, and username strings are allowed to include any printable character
 including space, but excluding control characters such as tab, newline, and
-carriage-return. no-remapping is only available on the server side.
+carriage\-return. no\-remapping is only available on the server side.
 
 .B Please note:
 This option is immediately deprecated.  It is only implemented
 to make the transition to the new formatting less intrusive.  It will be
-removed in OpenVPN 2.5.  So please update your scripts/plug-ins where necessary.
+removed in OpenVPN 2.5.  So please update your scripts/plug\-ins where necessary.
 .\"*********************************************************
 .TP
 .B \-\-no\-name\-remapping
@@ -3826,7 +3826,7 @@ option as soon as possible.
 .B \-\-port\-share host port [dir]
 When run in TCP server mode, share the OpenVPN port with
 another application, such as an HTTPS server.  If OpenVPN
-senses a connection to its port which is using a non-OpenVPN
+senses a connection to its port which is using a non\-OpenVPN
 protocol, it will proxy the connection to the server at
 .B host:port.
 Currently only designed to work with HTTP/HTTPS,
@@ -3870,7 +3870,7 @@ of OpenVPN's client mode.  This directive is equivalent to:
 .TP
 .B \-\-pull
 This option must be used on a client which is connecting
-to a multi-client server.  It indicates to OpenVPN that it
+to a multi\-client server.  It indicates to OpenVPN that it
 should accept options pushed by the server, provided they
 are part of the legal set of pushable options (note that the
 .B \-\-pull
@@ -3959,7 +3959,7 @@ the client.
 .TP
 .B \-\-auth\-retry type
 Controls how OpenVPN responds to username/password verification
-errors such as the client-side response to an AUTH_FAILED message from the server
+errors such as the client\-side response to an AUTH_FAILED message from the server
 or verification failure of the private key password.
 
 Normally used to prevent auth errors from being fatal
@@ -3969,7 +3969,7 @@ of error.
 An AUTH_FAILED message is generated by the server if the client
 fails
 .B \-\-auth\-user\-pass
-authentication, or if the server-side
+authentication, or if the server\-side
 .B \-\-client\-connect
 script returns an error status when the client
 tries to connect.
@@ -4018,7 +4018,7 @@ connect timeouts.
 .\"*********************************************************
 .TP
 .B \-\-explicit\-exit\-notify [n]
-In UDP client mode or point-to-point mode, send server/peer an exit notification
+In UDP client mode or point\-to\-point mode, send server/peer an exit notification
 if tunnel is restarted or OpenVPN process is exited.  In client mode, on
 exit/restart, this
 option will tell the server to immediately close its client instance object
@@ -4044,13 +4044,13 @@ When this option is set, OpenVPN will not drop incoming tun packets
 with same destination as host.
 .\"*********************************************************
 .SS Data Channel Encryption Options:
-These options are meaningful for both Static & TLS-negotiated key modes
+These options are meaningful for both Static & TLS\-negotiated key modes
 (must be compatible between peers).
 .\"*********************************************************
 .TP
 .B \-\-secret file [direction]
-Enable Static Key encryption mode (non-TLS).
-Use pre-shared secret
+Enable Static Key encryption mode (non\-TLS).
+Use pre\-shared secret
 .B file
 which was generated with
 .B \-\-genkey.
@@ -4058,7 +4058,7 @@ which was generated with
 The optional
 .B direction
 parameter enables the use of 4 distinct keys
-(HMAC-send, cipher-encrypt, HMAC-receive, cipher-decrypt), so that
+(HMAC\-send, cipher\-encrypt, HMAC\-receive, cipher\-decrypt), so that
 each data flow direction has a different set of HMAC and cipher keys.
 This has a number of desirable security properties including
 eliminating certain kinds of DoS and message replay attacks.
@@ -4078,7 +4078,7 @@ The
 .B direction
 parameter requires that
 .B file
-contains a 2048 bit key.  While pre-1.5 versions of OpenVPN
+contains a 2048 bit key.  While pre\-1.5 versions of OpenVPN
 generate 1024 bit key files, any version of OpenVPN which
 supports the
 .B direction
@@ -4092,7 +4092,7 @@ the primary being ease of configuration.
 
 There are no certificates
 or certificate authorities or complicated negotiation handshakes and protocols.
-The only requirement is that you have a pre-existing secure channel with
+The only requirement is that you have a pre\-existing secure channel with
 your peer (such as
 .B ssh
 ) to initially copy the key.  This requirement, along with the
@@ -4105,13 +4105,13 @@ was able to steal your private key, he would gain no information to help
 him decrypt past sessions.
 
 Another advantageous aspect of Static Key encryption mode is that
-it is a handshake-free protocol 
+it is a handshake\-free protocol 
 without any distinguishing signature or feature
 (such as a header or protocol handshake sequence) 
 that would mark the ciphertext packets as being
 generated by OpenVPN.  Anyone eavesdropping on the wire
 would see nothing
-but random-looking data.
+but random\-looking data.
 .\"*********************************************************
 .TP
 .B \-\-key\-direction
@@ -4124,7 +4124,7 @@ options. Useful when using inline files (See section on inline files).
 .TP
 .B \-\-auth alg
 Authenticate data channel packets and (if enabled)
-.B tls-auth
+.B tls\-auth
 control channel packets with HMAC using message digest algorithm
 .B alg.
 (The default is
@@ -4134,7 +4134,7 @@ HMAC is a commonly used message authentication algorithm (MAC) that uses
 a data string, a secure hash algorithm, and a key, to produce
 a digital signature.
 
-The OpenVPN data channel protocol uses encrypt-then-mac (i.e. first encrypt a
+The OpenVPN data channel protocol uses encrypt\-then\-mac (i.e. first encrypt a
 packet, then HMAC the resulting ciphertext), which prevents padding oracle
 attacks.
 
@@ -4144,9 +4144,9 @@ algorithm is ignored for the data channel, and the authentication method of the
 AEAD cipher is used instead.  Note that
 .B alg
 still specifies the digest used for
-.B tls-auth\fR.
+.B tls\-auth\fR.
 
-In static-key encryption mode, the HMAC key
+In static\-key encryption mode, the HMAC key
 is included in the key file generated by
 .B \-\-genkey.
 In TLS mode, the HMAC key is dynamically generated and shared
@@ -4166,11 +4166,11 @@ Encrypt data channel packets with cipher algorithm
 .B alg.
 
 The default is
-.B BF-CBC,
+.B BF\-CBC,
 an abbreviation for Blowfish in Cipher Block Chaining mode.  When cipher
 negotiation (NCP) is allowed, OpenVPN 2.4 and newer on both client and server
 side will automatically upgrade to
-.B AES-256-GCM.
+.B AES\-256\-GCM.
 See
 .B \-\-ncp\-ciphers
 and
@@ -4178,12 +4178,12 @@ and
 for more details on NCP.
 
 Using
-.B BF-CBC
-is no longer recommended, because of its 64-bit block size.  This
+.B BF\-CBC
+is no longer recommended, because of its 64\-bit block size.  This
 small block size allows attacks based on collisions, as demonstrated by SWEET32.
 See https://community.openvpn.net/openvpn/wiki/SWEET32 for details.  Due to
 this, support for
-.B BF-CBC, DES, CAST5, IDEA
+.B BF\-CBC, DES, CAST5, IDEA
 and
 .B RC2
 ciphers will be removed in OpenVPN 2.6.
@@ -4202,20 +4202,20 @@ to disable encryption.
 Restrict the allowed ciphers to be negotiated to the ciphers in
 .B cipher_list\fR.
 .B cipher_list
-is a colon-separated list of ciphers, and defaults to
-"AES-256-GCM:AES-128-GCM".
+is a colon\-separated list of ciphers, and defaults to
+"AES\-256\-GCM:AES\-128\-GCM".
 
 For servers, the first cipher from
 .B cipher_list
 will be pushed to clients that support cipher negotiation.
 
-Cipher negotiation is enabled in client-server mode only.  I.e. if
+Cipher negotiation is enabled in client\-server mode only.  I.e. if
 .B \-\-mode
-is set to 'server' (server-side, implied by setting
+is set to 'server' (server\-side, implied by setting
 .B \-\-server
 ), or if
 .B \-\-pull
-is specified (client-side, implied by setting \-\-client).
+is specified (client\-side, implied by setting \-\-client).
 
 If both peers support and do not disable NCP, the negotiated cipher will
 override the cipher specified by
@@ -4226,10 +4226,10 @@ will inherit the cipher of the peer if that cipher is different from the local
 .B \-\-cipher
 setting, but the peer cipher is one of the ciphers specified in
 .B \-\-ncp\-ciphers\fR.
-E.g. a non-NCP client (<=v2.3, or with \-\-ncp\-disabled set) connecting to a
-NCP server (v2.4+) with "\-\-cipher BF-CBC" and "\-\-ncp-ciphers
-AES-256-GCM:AES-256-CBC" set can either specify "\-\-cipher BF-CBC" or
-"\-\-cipher AES-256-CBC" and both will work.
+E.g. a non\-NCP client (<=v2.3, or with \-\-ncp\-disabled set) connecting to a
+NCP server (v2.4+) with "\-\-cipher BF\-CBC" and "\-\-ncp\-ciphers
+AES\-256\-GCM:AES\-256\-CBC" set can either specify "\-\-cipher BF\-CBC" or
+"\-\-cipher AES\-256\-CBC" and both will work.
 
 .\"*********************************************************
 .TP
@@ -4243,19 +4243,19 @@ negotiation.
 This option will be removed in OpenVPN 2.6.
 
 Size of cipher key in bits (optional).
-If unspecified, defaults to cipher-specific default.  The
+If unspecified, defaults to cipher\-specific default.  The
 .B \-\-show\-ciphers
 option (see below) shows all available OpenSSL ciphers,
 their default key sizes, and whether the key size can
 be changed.  Use care in changing a cipher's default
 key size.  Many ciphers have not been extensively
-cryptanalyzed with non-standard key lengths, and a
+cryptanalyzed with non\-standard key lengths, and a
 larger key may offer no real guarantee of greater
 security, or may even reduce security.
 .\"*********************************************************
 .TP
 .B \-\-prng alg [nsl]
-(Advanced) For PRNG (Pseudo-random number generator),
+(Advanced) For PRNG (Pseudo\-random number generator),
 use digest algorithm
 .B alg
 (default=sha1), and set
@@ -4266,14 +4266,14 @@ to the size in bytes of the nonce secret length (between 16 and 64).
 Set
 .B alg=none
 to disable the PRNG and use the OpenSSL RAND_bytes function
-instead for all of OpenVPN's pseudo-random number needs.
+instead for all of OpenVPN's pseudo\-random number needs.
 .\"*********************************************************
 .TP
-.B \-\-engine [engine-name]
-Enable OpenSSL hardware-based crypto engine functionality.
+.B \-\-engine [engine\-name]
+Enable OpenSSL hardware\-based crypto engine functionality.
 
 If
-.B engine-name
+.B engine\-name
 is specified,
 use a specific crypto engine.  Use the
 .B \-\-show\-engines
@@ -4329,7 +4329,7 @@ by IPSec.
 .\"*********************************************************
 .TP
 .B \-\-replay\-window n [t]
-Use a replay protection sliding-window of size
+Use a replay protection sliding\-window of size
 .B n
 and a time window of
 .B t
@@ -4351,7 +4351,7 @@ option is specified.
 When OpenVPN tunnels IP packets over UDP, there is the possibility that
 packets might be dropped or delivered out of order.  Because OpenVPN, like IPSec,
 is emulating the physical network layer,
-it will accept an out-of-order packet sequence, and
+it will accept an out\-of\-order packet sequence, and
 will deliver such packets in the same order they were received to
 the TCP/IP protocol stack, provided they satisfy several constraints.
 
@@ -4380,7 +4380,7 @@ Satellite links in particular often require this.
 
 If you run OpenVPN at
 .B \-\-verb 4,
-you will see the message "Replay-window backtrack occurred [x]"
+you will see the message "Replay\-window backtrack occurred [x]"
 every time the maximum sequence number backtrack seen thus far
 increases.  This can be used to calibrate
 .B n.
@@ -4404,11 +4404,11 @@ reordering:  Don't allow it.  Since TCP guarantees reliability, any packet
 loss or reordering event can be assumed to be an attack.
 
 In this sense, it could be argued that TCP tunnel transport is preferred when
-tunneling non-IP or UDP application protocols which might be vulnerable to a
+tunneling non\-IP or UDP application protocols which might be vulnerable to a
 message deletion or reordering attack which falls within the normal
 operational parameters of IP networks.
 
-So I would make the statement that one should never tunnel a non-IP protocol
+So I would make the statement that one should never tunnel a non\-IP protocol
 or UDP application protocol over UDP, if the protocol might be vulnerable to a
 message deletion or reordering attack that falls within the normal operating
 parameters of what is to be expected from the physical IP layer.  The problem
@@ -4424,7 +4424,7 @@ packets.
 .\"*********************************************************
 .TP
 .B \-\-replay\-persist file
-Persist replay-protection state across sessions using
+Persist replay\-protection state across sessions using
 .B file
 to save and reload the state.
 
@@ -4443,7 +4443,7 @@ which were already received by the prior session.
 This option only makes sense when replay protection is enabled
 (the default) and you are using either
 .B \-\-secret
-(shared-secret key mode) or TLS mode with
+(shared\-secret key mode) or TLS mode with
 .B \-\-tls\-auth.
 .\"*********************************************************
 .TP
@@ -4463,11 +4463,11 @@ messages are being encrypted/decrypted with the same key.
 
 IV is implemented differently depending on the cipher mode used.
 
-In CBC mode, OpenVPN uses a pseudo-random IV for each packet.
+In CBC mode, OpenVPN uses a pseudo\-random IV for each packet.
 
 In CFB/OFB mode, OpenVPN uses a unique sequence number and time stamp
 as the IV.  In fact, in CFB/OFB mode, OpenVPN uses a datagram
-space-saving optimization that uses the unique identifier for
+space\-saving optimization that uses the unique identifier for
 datagram replay protection as the IV.
 .\"*********************************************************
 .TP
@@ -4486,7 +4486,7 @@ than 1.1.
 .\"*********************************************************
 .TP
 .B \-\-test\-crypto
-Do a self-test of OpenVPN's crypto options by encrypting and
+Do a self\-test of OpenVPN's crypto options by encrypting and
 decrypting test packets using the data channel encryption options
 specified above.  This option does not require a peer to function,
 and therefore can be specified without
@@ -4506,7 +4506,7 @@ or
 
 This option is very useful to test OpenVPN after it has been ported to
 a new platform, or to isolate problems in the compiler, OpenSSL
-crypto library, or OpenVPN's crypto code.  Since it is a self-test mode,
+crypto library, or OpenVPN's crypto code.  Since it is a self\-test mode,
 problems with encryption and authentication can be debugged independently
 of network and tunnel issues.
 .\"*********************************************************
@@ -4522,7 +4522,7 @@ any mediation.  The result is the best of both worlds: a fast data channel
 that forwards over UDP with only the overhead of encrypt,
 decrypt, and HMAC functions,
 and a control channel that provides all of the security features of TLS,
-including certificate-based authentication and Diffie Hellman forward secrecy.
+including certificate\-based authentication and Diffie Hellman forward secrecy.
 
 To use TLS mode, each peer that runs OpenVPN should have its own local
 certificate/key pair (
@@ -4545,12 +4545,12 @@ passing data.
 
 The OpenVPN project provides a set of scripts for
 managing RSA certificates & keys:
-.I https://github.com/OpenVPN/easy-rsa
+.I https://github.com/OpenVPN/easy\-rsa
 .\"*********************************************************
 .TP
 .B \-\-tls\-server
 Enable TLS and assume server role during TLS handshake.  Note that
-OpenVPN is designed as a peer-to-peer application.  The designation
+OpenVPN is designed as a peer\-to\-peer application.  The designation
 of client or server is only for the purpose of negotiating the TLS
 control channel.
 .\"*********************************************************
@@ -4590,11 +4590,11 @@ When using the
 option, you are required to supply valid CRLs for the CAs too.  CAs in the
 capath directory are expected to be named <hash>.<n>.  CRLs are expected to
 be named <hash>.r<n>.  See the
-.B -CApath
+.B \-CApath
 option of
 .B openssl verify
 , and the
-.B -hash
+.B \-hash
 option of
 .B openssl x509
 and
@@ -4616,7 +4616,7 @@ requires peers to be using an SSL library that supports ECDH TLS cipher suites
 
 Use
 .B openssl dhparam \-out dh2048.pem 2048
-to generate 2048-bit DH parameters. Diffie Hellman parameters may be considered
+to generate 2048\-bit DH parameters. Diffie Hellman parameters may be considered
 public.
 .\"*********************************************************
 .TP
@@ -4624,13 +4624,13 @@ public.
 Specify the curve to use for elliptic curve Diffie Hellman. Available
 curves can be listed with
 .BR \-\-show\-curves .
-The specified curve will only be used for ECDH TLS-ciphers.
+The specified curve will only be used for ECDH TLS\-ciphers.
 
 This option is not supported in mbed TLS builds of OpenVPN.
 .\"*********************************************************
 .TP
 .B \-\-cert file
-Local peer's signed certificate in .pem format -- must be signed
+Local peer's signed certificate in .pem format \-\- must be signed
 by a certificate authority whose certificate is in
 .B \-\-ca file.
 Each peer in an OpenVPN link running in TLS mode should have its own
@@ -4662,7 +4662,7 @@ Note that the
 command reads the location of the certificate authority key from its
 configuration file such as
 .B /usr/share/ssl/openssl.cnf
--- note also
+\-\- note also
 that for certificate authority functions, you must set up the files
 .B index.txt
 (may be empty) and
@@ -4683,7 +4683,7 @@ local certificate chain.
 This option is useful for "split" CAs, where the CA for server
 certs is different than the CA for client certs.  Putting certs
 in this file allows them to be used to complete the local
-certificate chain without trusting them to verify the peer-submitted
+certificate chain without trusting them to verify the peer\-submitted
 certificate, as would be the case if the certs were placed in the
 .B ca
 file.
@@ -4700,7 +4700,7 @@ above).
 Sets the minimum
 TLS version we will accept from the peer (default is "1.0").
 Examples for version
-include "1.0", "1.1", or "1.2".  If 'or-highest' is specified
+include "1.0", "1.1", or "1.2".  If 'or\-highest' is specified
 and version is not recognized, we will only accept the highest TLS
 version supported by the local SSL implementation.
 .\"*********************************************************
@@ -4721,10 +4721,10 @@ Not available with PolarSSL.
 .\"*********************************************************
 .TP
 .B \-\-verify\-hash hash [algo]
-Specify SHA1 or SHA256 fingerprint for level-1 cert.  The level-1 cert is the
+Specify SHA1 or SHA256 fingerprint for level\-1 cert.  The level\-1 cert is the
 CA (or intermediate cert) that signs the leaf certificate, and is
 one removed from the leaf certificate in the direction of the root.
-When accepting a connection from a peer, the level-1 cert
+When accepting a connection from a peer, the level\-1 cert
 fingerprint must match
 .B hash
 or certificate verification will fail.  Hash is specified
@@ -4756,9 +4756,9 @@ option.
 .\"*********************************************************
 .TP
 .B \-\-pkcs11\-id\-management
-Acquire PKCS#11 id from management interface. In this case a NEED-STR 'pkcs11-id-request'
-real-time message will be triggered, application may use pkcs11-id-count command to
-retrieve available number of certificates, and pkcs11-id-get command to retrieve certificate
+Acquire PKCS#11 id from management interface. In this case a NEED\-STR 'pkcs11\-id\-request'
+real\-time message will be triggered, application may use pkcs11\-id\-count command to
+retrieve available number of certificates, and pkcs11\-id\-get command to retrieve certificate
 id and certificate body.
 .\"*********************************************************
 .TP
@@ -4780,7 +4780,7 @@ This option can be used instead of
 and
 .B \-\-pkcs12.
 
-If p11-kit is present on the system, its
+If p11\-kit is present on the system, its
 .B p11\-kit\-proxy.so
 module will be loaded by default if either the
 .B \-\-pkcs11\-id
@@ -4797,23 +4797,23 @@ A different mode can be specified for each provider.
 Mode is encoded as hex number, and can be a mask one of the following:
 
 .B 0
-(default) -- Try to determine automatically.
+(default) \-\- Try to determine automatically.
 .br
 .B 1
--- Use sign.
+\-\- Use sign.
 .br
 .B 2
--- Use sign recover.
+\-\- Use sign recover.
 .br
 .B 4
--- Use decrypt.
+\-\- Use decrypt.
 .br
 .B 8
--- Use unwrap.
+\-\- Use unwrap.
 .br
 .\"*********************************************************
 .TP
-.B \-\-cryptoapicert select-string
+.B \-\-cryptoapicert select\-string
 Load the certificate and private key from the
 Windows Certificate System Store (Windows/OpenSSL Only).
 
@@ -4841,7 +4841,7 @@ To select a certificate, based on certificate's thumbprint:
 .B cryptoapicert
 "THUMB:f6 49 24 41 01 b4 ..."
 
-The thumbprint hex string can easily be copy-and-pasted from the Windows
+The thumbprint hex string can easily be copy\-and\-pasted from the Windows
 Certificate Store GUI.
 
 .\"*********************************************************
@@ -4859,7 +4859,7 @@ for protecting the tunnel data channel is generated and
 exchanged over the TLS session.
 
 In method 1 (the default for OpenVPN 1.x), both sides generate
-random encrypt and HMAC-send keys which are forwarded to
+random encrypt and HMAC\-send keys which are forwarded to
 the other host over the TLS channel. Method 1 is
 .B deprecated in OpenVPN 2.4
 , and
@@ -4909,7 +4909,7 @@ to see a list of TLS ciphers supported by your crypto library.
 
 Warning!
 .B \-\-tls\-cipher
-is an expert feature, which - if used correcly - can improve the security of
+is an expert feature, which \- if used correcly \- can improve the security of
 your VPN connection.  But it is also easy to unwittingly use it to carefully
 align a gun with your foot, or just break your connection.  Use with care!
 
@@ -4928,7 +4928,7 @@ packet to its peer, it will expect to receive an
 acknowledgement within
 .B n
 seconds or it will retransmit the packet, subject
-to a TCP-like exponential backoff algorithm.  This parameter
+to a TCP\-like exponential backoff algorithm.  This parameter
 only applies to control channel packets.  Data channel
 packets (which carry encrypted tunnel data) are never
 acknowledged, sequenced, or retransmitted by OpenVPN because
@@ -4945,7 +4945,7 @@ to be expressed as a number of bytes encrypted/decrypted, a number of packets,
 or a number of seconds.  A key renegotiation will be forced
 if any of these three criteria are met by either peer.
 
-If using ciphers with cipher block sizes less than 128-bits, \-\-reneg\-bytes is
+If using ciphers with cipher block sizes less than 128\-bits, \-\-reneg\-bytes is
 set to 64MB by default, unless it is explicitly disabled by setting the value to
 0, but this is
 .B HIGHLY DISCOURAGED
@@ -4964,7 +4964,7 @@ Renegotiate data channel key after
 .B n
 seconds (default=3600).
 
-When using dual-factor authentication, note that this default value may
+When using dual\-factor authentication, note that this default value may
 cause the end user to be challenged to reauthorize once per hour.
 
 Also, keep in mind that this option can be used on both the client and server,
@@ -4979,7 +4979,7 @@ your chosen value on the other side.
 .\"*********************************************************
 .TP
 .B \-\-hand\-window n
-Handshake Window -- the TLS-based key exchange must finalize within
+Handshake Window \-\- the TLS\-based key exchange must finalize within
 .B n
 seconds
 of handshake initiation by any peer (default = 60 seconds).
@@ -4993,7 +4993,7 @@ data.
 .\"*********************************************************
 .TP
 .B \-\-tran\-window n
-Transition window -- our old key can live this many seconds
+Transition window \-\- our old key can live this many seconds
 after a new a key renegotiation begins (default = 3600 seconds).
 This feature allows for a graceful transition from old to new
 key, and removes the key renegotiation sequence from the critical
@@ -5056,7 +5056,7 @@ is specified with
 .B \-\-float.
 
 The rationale for
-this feature is as follows.  TLS requires a multi-packet exchange
+this feature is as follows.  TLS requires a multi\-packet exchange
 before it is able to authenticate a peer.  During this time
 before authentication, OpenVPN is allocating resources (memory
 and CPU) to this potential peer.  The potential peer is also
@@ -5065,7 +5065,7 @@ it is sending.  Most successful network attacks today seek
 to either exploit bugs in programs (such as buffer overflow attacks) or
 force a program to consume so many resources that it becomes unusable.
 Of course the first line of defense is always to produce clean,
-well-audited code.  OpenVPN has been written with buffer overflow
+well\-audited code.  OpenVPN has been written with buffer overflow
 attack prevention as a top priority.
 But as history has shown, many of the most widely used
 network applications have, from time to time,
@@ -5121,8 +5121,8 @@ provides more privacy by hiding the certificate used for the TLS connection,
 .IP \[bu]
 makes it harder to identify OpenVPN traffic as such,
 .IP \[bu]
-provides "poor-man's" post-quantum security, against attackers who will never
-know the pre-shared key (i.e. no forward secrecy).
+provides "poor\-man's" post\-quantum security, against attackers who will never
+know the pre\-shared key (i.e. no forward secrecy).
 .RE
 
 .IP
@@ -5135,10 +5135,10 @@ does *not* require the user to set
 .B Security Considerations
 
 All peers use the same
-.B \-\-tls-crypt
-pre-shared group key to authenticate and encrypt control channel messages.  To
+.B \-\-tls\-crypt
+pre\-shared group key to authenticate and encrypt control channel messages.  To
 ensure that IV collisions remain unlikely, this key should not be used to
-encrypt more than 2^48 client-to-server or 2^48 server-to-client control
+encrypt more than 2^48 client\-to\-server or 2^48 server\-to\-client control
 channel messages.  A typical initial negotiation is about 10 packets in each
 direction.  Assuming both initial negotiation and renegotiations are at most
 2^16 (65536) packets (to be conservative), and (re)negotiations happen each
@@ -5152,8 +5152,8 @@ If IV collisions were to occur, this could result in the security of
 degrading to the same security as using
 .B \-\-tls\-auth\fR.
 That is, the control channel still benefits from the extra protection against
-active man-in-the-middle-attacks and DoS attacks, but may no longer offer
-extra privacy and post-quantum security on top of what TLS itself offers.
+active man\-in\-the\-middle\-attacks and DoS attacks, but may no longer offer
+extra privacy and post\-quantum security on top of what TLS itself offers.
 .\"*********************************************************
 .TP
 .B \-\-askpass [file]
@@ -5271,7 +5271,7 @@ should return 0 to allow the TLS handshake to proceed, or 1 to fail.
 
 .B cmd
 consists of a path to script (or executable program), optionally
-followed by arguments. The path and arguments may be single- or double-quoted
+followed by arguments. The path and arguments may be single\- or double\-quoted
 and/or escaped using a backslash, and should be separated by one or more spaces.
 
 When
@@ -5340,13 +5340,13 @@ instead of the Common Name.
 Only the subjectAltName and issuerAltName X.509 extensions are supported.
 
 .B Please note:
-This option has a feature which will convert an all-lowercase
+This option has a feature which will convert an all\-lowercase
 .B fieldname
-to uppercase characters, e.g., ou -> OU.  A mixed-case
+to uppercase characters, e.g., ou \-> OU.  A mixed\-case
 .B fieldname
 or one having the
 .B ext:
-prefix will be left as-is.  This automatic upcasing feature
+prefix will be left as\-is.  This automatic upcasing feature
 is deprecated and will be removed in a future release.
 .\"*********************************************************
 .TP
@@ -5360,18 +5360,18 @@ Which X.509 name is compared to
 depends on the setting of type.
 .B type
 can be "subject" to match the complete subject DN (default),
-"name" to match a subject RDN or "name-prefix" to match a subject RDN prefix.
+"name" to match a subject RDN or "name\-prefix" to match a subject RDN prefix.
 Which RDN is verified as name depends on the
 .B \-\-x509\-username\-field
 option. But it defaults to the common name (CN), e.g. a certificate with a
-subject DN "C=KG, ST=NA, L=Bishkek, CN=Server-1" would be matched by:
+subject DN "C=KG, ST=NA, L=Bishkek, CN=Server\-1" would be matched by:
 
 .B \-\-verify\-x509\-name 'C=KG, ST=NA, L=Bishkek, CN=Server\-1'
 and
 .B \-\-verify\-x509\-name Server\-1 name
 or you could use
-.B \-\-verify\-x509\-name Server -name-prefix
-if you want a client to only accept connections to "Server-1", "Server-2", etc.
+.B \-\-verify\-x509\-name Server\- name\-prefix
+if you want a client to only accept connections to "Server\-1", "Server\-2", etc.
 
 .B \-\-verify\-x509\-name
 is a useful replacement for the
@@ -5390,7 +5390,7 @@ with designated servers.
 .B NOTE:
 Test against a name prefix only when you are using OpenVPN with
 a custom CA certificate that is under your control.
-Never use this option with type "name-prefix" when your client certificates
+Never use this option with type "name\-prefix" when your client certificates
 are signed by a third party, such as a commercial web CA.
 .\"*********************************************************
 .TP
@@ -5429,7 +5429,7 @@ to "server", then the clients can verify this with
 .B \-\-ns\-cert\-type server.
 
 This is an important security precaution to protect against
-a man-in-the-middle attack where an authorized client
+a man\-in\-the\-middle attack where an authorized client
 attempts to connect to another client by impersonating the server.
 The attack is easily prevented by having clients verify
 the server certificate using any one of
@@ -5494,7 +5494,7 @@ option is equivalent to
 \-\-remote\-cert\-ku \-\-remote\-cert\-eku "TLS Web Server Authentication"
 
 This is an important security precaution to protect against
-a man-in-the-middle attack where an authorized client
+a man\-in\-the\-middle attack where an authorized client
 attempts to connect to another client by impersonating the server.
 The attack is easily prevented by having clients verify
 the server certificate using any one of
@@ -5566,7 +5566,7 @@ an ECDSA cipher suite will not work if you are using an RSA certificate, etc.).
 .TP
 .B \-\-show\-engines
 (Standalone)
-Show currently available hardware-based crypto acceleration
+Show currently available hardware\-based crypto acceleration
 engines supported by the OpenSSL library.
 .\"*********************************************************
 .TP
@@ -5577,7 +5577,7 @@ Show all available elliptic curves to use with the
 option.
 .\"*********************************************************
 .SS Generate a random key:
-Used only for non-TLS static key encryption mode.
+Used only for non\-TLS static key encryption mode.
 .\"*********************************************************
 .TP
 .B \-\-genkey
@@ -5586,7 +5586,7 @@ Generate a random key to be used as a shared secret,
 for use with the
 .B \-\-secret
 option.  This file must be shared with the
-peer over a pre-existing secure channel such as
+peer over a pre\-existing secure channel such as
 .BR scp (1)
 .
 .\"*********************************************************
@@ -5621,7 +5621,7 @@ and
 commands.  These commands can be placed in the the same shell script
 which starts or terminates an OpenVPN session.
 
-Another advantage is that open connections through the TUN/TAP-based tunnel
+Another advantage is that open connections through the TUN/TAP\-based tunnel
 will not be reset if the OpenVPN peer restarts.  This can be useful to
 provide uninterrupted connectivity through the tunnel in the event of a DHCP
 reset of the peer's public IP address (see the
@@ -5635,7 +5635,7 @@ and
 .B \-\-tun\-mtu
 above).
 
-On some platforms such as Windows, TAP-Win32 tunnels are persistent by
+On some platforms such as Windows, TAP\-Win32 tunnels are persistent by
 default.
 .\"*********************************************************
 .TP
@@ -5655,7 +5655,7 @@ Optional user to be owner of this tunnel.
 .B \-\-group group
 Optional group to be owner of this tunnel.
 .\"*********************************************************
-.SS Windows-Specific Options:
+.SS Windows\-Specific Options:
 .\"*********************************************************
 .TP
 .B \-\-win\-sys path
@@ -5680,7 +5680,7 @@ is found in the configuration file.
 .B \-\-ip\-win32 method
 When using
 .B \-\-ifconfig
-on Windows, set the TAP-Win32 adapter
+on Windows, set the TAP\-Win32 adapter
 IP address and netmask using
 .B method.
 Don't use this option unless you are also using
@@ -5693,13 +5693,13 @@ to the console telling the user to configure the
 adapter manually and indicating the IP/netmask which
 OpenVPN expects the adapter to be set to.
 
-.B dynamic [offset] [lease-time] --
+.B dynamic [offset] [lease\-time] \-\-
 Automatically set the IP address and netmask by replying to
 DHCP query messages generated by the kernel.  This mode is
 probably the "cleanest" solution
-for setting the TCP/IP properties since it uses the well-known
+for setting the TCP/IP properties since it uses the well\-known
 DHCP protocol.  There are, however, two prerequisites for using
-this mode: (1) The TCP/IP properties for the TAP-Win32
+this mode: (1) The TCP/IP properties for the TAP\-Win32
 adapter must be set to "Obtain an IP address automatically," and
 (2) OpenVPN needs to claim an IP address in the subnet for use
 as the virtual DHCP server address.  By default in
@@ -5712,7 +5712,7 @@ virtual DHCP server address.  In
 .B \-\-dev tun
 mode, OpenVPN will cause the DHCP server to masquerade as if it were
 coming from the remote endpoint.  The optional offset parameter is
-an integer which is > \-256 and < 256 and which defaults to -1.
+an integer which is > \-256 and < 256 and which defaults to \-1.
 If offset is positive, the DHCP server will masquerade as the IP
 address at network address + offset.
 If offset is negative, the DHCP server will masquerade as the IP
@@ -5723,17 +5723,17 @@ address is.  OpenVPN will "claim" this address, so make sure to
 use a free address.  Having said that, different OpenVPN instantiations,
 including different ends of the same connection, can share the same
 virtual DHCP server address.  The
-.B lease-time
+.B lease\-time
 parameter controls the lease time of the DHCP assignment given to
-the TAP-Win32 adapter, and is denoted in seconds.
+the TAP\-Win32 adapter, and is denoted in seconds.
 Normally a very long lease time is preferred
-because it prevents routes involving the TAP-Win32 adapter from
+because it prevents routes involving the TAP\-Win32 adapter from
 being lost when the system goes to sleep.  The default
 lease time is one year.
 
 .B netsh \-\-
 Automatically set the IP address and netmask using
-the Windows command-line "netsh"
+the Windows command\-line "netsh"
 command.  This method appears to work correctly on
 Windows XP but not Windows 2000.
 
@@ -5742,7 +5742,7 @@ Automatically set the IP address and netmask using the
 Windows IP Helper API.  This approach
 does not have ideal semantics, though testing has indicated
 that it works okay in practice.  If you use this option,
-it is best to leave the TCP/IP properties for the TAP-Win32
+it is best to leave the TCP/IP properties for the TAP\-Win32
 adapter in their default state, i.e. "Obtain an IP address
 automatically."
 
@@ -5751,14 +5751,14 @@ automatically."
 .B dynamic
 method initially and fail over to
 .B netsh
-if the DHCP negotiation with the TAP-Win32 adapter does
+if the DHCP negotiation with the TAP\-Win32 adapter does
 not succeed in 20 seconds.  Such failures have been known
-to occur when certain third-party firewall packages installed
+to occur when certain third\-party firewall packages installed
 on the client machine block the DHCP negotiation used by
-the TAP-Win32 adapter.
+the TAP\-Win32 adapter.
 Note that if the
 .B netsh
-failover occurs, the TAP-Win32 adapter
+failover occurs, the TAP\-Win32 adapter
 TCP/IP properties will be reset from DHCP to static, and this
 will cause future OpenVPN startups using the
 .B adaptive
@@ -5772,7 +5772,7 @@ mode from using
 .B netsh,
 run OpenVPN at least once using the
 .B dynamic
-mode to restore the TAP-Win32 adapter TCP/IP properties
+mode to restore the TAP\-Win32 adapter TCP/IP properties
 to a DHCP configuration.
 .\"*********************************************************
 .TP
@@ -5782,29 +5782,29 @@ Which method
 to use for adding routes on Windows?
 
 .B adaptive
-(default) -- Try IP helper API first.  If that fails, fall
+(default) \-\- Try IP helper API first.  If that fails, fall
 back to the route.exe shell command.
 .br
 .B ipapi
--- Use IP helper API.
+\-\- Use IP helper API.
 .br
 .B exe
--- Call the route.exe shell command.
+\-\- Call the route.exe shell command.
 .\"*********************************************************
 .TP
 .B \-\-dhcp\-option type [parm]
-Set extended TAP-Win32 TCP/IP properties, must
+Set extended TAP\-Win32 TCP/IP properties, must
 be used with
 .B \-\-ip\-win32 dynamic
 or
 .B \-\-ip\-win32 adaptive.
 This option can be used to set additional TCP/IP properties
-on the TAP-Win32 adapter, and is particularly useful for
+on the TAP\-Win32 adapter, and is particularly useful for
 configuring an OpenVPN client to access a Samba server
 across the VPN.
 
 .B DOMAIN name \-\-
-Set Connection-specific DNS Suffix.
+Set Connection\-specific DNS Suffix.
 
 .B DNS addr \-\-
 Set primary domain name server IPv4 address.  Repeat
@@ -5838,17 +5838,17 @@ to set secondary NTP server addresses.
 .B NBT type \-\-
 Set NetBIOS over TCP/IP Node type.  Possible options:
 .B 1
-= b-node (broadcasts),
+= b\-node (broadcasts),
 .B 2
-= p-node (point-to-point
+= p\-node (point\-to\-point
 name queries to a WINS server),
 .B 4
-= m-node (broadcast
+= m\-node (broadcast
 then query name server), and
 .B 8
-= h-node (query name server, then broadcast).
+= h\-node (query name server, then broadcast).
 
-.B NBS scope-id --
+.B NBS scope\-id \-\-
 Set NetBIOS over TCP/IP Scope. A NetBIOS Scope ID provides an extended
 naming service for the NetBIOS over TCP/IP (Known as NBT) module. The
 primary purpose of a NetBIOS scope ID is to isolate NetBIOS traffic on
@@ -5860,14 +5860,14 @@ computers to use the same computer name, as they have different
 scope IDs. The Scope ID becomes a part of the NetBIOS name, making the name unique.
 (This description of NetBIOS scopes courtesy of NeonSurge@...1311...)
 
-.B DISABLE-NBT --
-Disable Netbios-over-TCP/IP.
+.B DISABLE\-NBT \-\-
+Disable Netbios\-over\-TCP/IP.
 
 Note that if
 .B \-\-dhcp\-option
 is pushed via
 .B \-\-push
-to a non-windows client, the option will be saved in the client's
+to a non\-windows client, the option will be saved in the client's
 environment before the up script is called, under
 the name "foreign_option_{n}".
 .\"*********************************************************
@@ -5875,7 +5875,7 @@ the name "foreign_option_{n}".
 .B \-\-tap\-sleep n
 Cause OpenVPN to sleep for
 .B n
-seconds immediately after the TAP-Win32 adapter state
+seconds immediately after the TAP\-Win32 adapter state
 is set to "connected".
 
 This option is intended to be used to troubleshoot problems
@@ -5884,7 +5884,7 @@ with the
 and
 .B \-\-ip\-win32
 options, and is used to give
-the TAP-Win32 adapter time to come up before
+the TAP\-Win32 adapter time to come up before
 Windows IP Helper API operations are applied to it.
 .\"*********************************************************
 .TP
@@ -5901,7 +5901,7 @@ TCP or UDP port 53 except one inside the tunnel. It uses
 Windows Filtering Platform (WFP) and works on Windows Vista or
 later.
 
-This option is considered unknown on non-Windows platforms
+This option is considered unknown on non\-Windows platforms
 and unsupported on Windows XP, resulting in fatal error.
 You may want to use
 .B \-\-setenv opt
@@ -5916,7 +5916,7 @@ fatal errors.
 Ask Windows to renew the TAP adapter lease on startup.
 This option is normally unnecessary, as Windows automatically
 triggers a DHCP renegotiation on the TAP adapter when it
-comes up, however if you set the TAP-Win32 adapter
+comes up, however if you set the TAP\-Win32 adapter
 Media Status property to "Always Connected", you may need this
 flag.
 .\"*********************************************************
@@ -5936,29 +5936,29 @@ recognizing pushed DNS servers.
 Put up a "press any key to continue" message on the console prior
 to OpenVPN program exit.  This option is automatically used by the
 Windows explorer when OpenVPN is run on a configuration
-file using the right-click explorer menu.
+file using the right\-click explorer menu.
 .\"*********************************************************
 .TP
-.B \-\-service exit-event [0|1]
+.B \-\-service exit\-event [0|1]
 Should be used when OpenVPN is being automatically executed by another
 program in such
 a context that no interaction with the user via display or keyboard
-is possible.  In general, end-users should never need to explicitly
+is possible.  In general, end\-users should never need to explicitly
 use this option, as it is automatically added by the OpenVPN service wrapper
 when a given OpenVPN configuration is being run as a service.
 
-.B exit-event
+.B exit\-event
 is the name of a Windows global event object, and OpenVPN will continuously
 monitor the state of this event object and exit when it becomes signaled.
 
 The second parameter indicates the initial state of
-.B exit-event
+.B exit\-event
 and normally defaults to 0.
 
 Multiple OpenVPN processes can be simultaneously executed with the same
-.B exit-event
+.B exit\-event
 parameter.  In any case, the controlling process can signal
-.B exit-event,
+.B exit\-event,
 causing all such OpenVPN processes to exit.
 
 When executing an OpenVPN process using the
@@ -5974,9 +5974,9 @@ to write these messages to a file.
 .TP
 .B \-\-show\-adapters
 (Standalone)
-Show available TAP-Win32 adapters which can be selected using the
+Show available TAP\-Win32 adapters which can be selected using the
 .B \-\-dev\-node
-option.  On non-Windows systems, the
+option.  On non\-Windows systems, the
 .BR ifconfig (8)
 command provides similar functionality.
 .\"*********************************************************
@@ -5984,14 +5984,14 @@ command provides similar functionality.
 .B \-\-allow\-nonadmin [TAP\-adapter]
 (Standalone)
 Set
-.B TAP-adapter
-to allow access from non-administrative accounts.  If
-.B TAP-adapter
+.B TAP\-adapter
+to allow access from non\-administrative accounts.  If
+.B TAP\-adapter
 is omitted, all TAP adapters on the system will be configured to allow
-non-admin access.
-The non-admin access setting will only persist for the length of time that
-the TAP-Win32 device object and driver remain loaded, and will need
-to be re-enabled after a reboot, or if the driver is unloaded
+non\-admin access.
+The non\-admin access setting will only persist for the length of time that
+the TAP\-Win32 device object and driver remain loaded, and will need
+to be re\-enabled after a reboot, or if the driver is unloaded
 and reloaded.
 This directive can only be used by an administrator.
 .\"*********************************************************
@@ -6000,12 +6000,12 @@ This directive can only be used by an administrator.
 (Standalone)
 Show valid subnets for
 .B \-\-dev tun
-emulation.  Since the TAP-Win32 driver
+emulation.  Since the TAP\-Win32 driver
 exports an ethernet interface to Windows, and since TUN devices are
-point-to-point in nature, it is necessary for the TAP-Win32 driver
+point\-to\-point in nature, it is necessary for the TAP\-Win32 driver
 to impose certain constraints on TUN endpoint address selection.
 
-Namely, the point-to-point endpoints used in TUN device emulation
+Namely, the point\-to\-point endpoints used in TUN device emulation
 must be the middle two addresses of a /30 subnet (netmask 255.255.255.252).
 .\"*********************************************************
 .TP
@@ -6022,7 +6022,7 @@ adapter list.
 Show PKCS#11 token object list. Specify cert_private as 1
 if certificates are stored as private objects.
 
-If p11-kit is present on the system, the
+If p11\-kit is present on the system, the
 .B provider
 argument is optional; if omitted the default
 .B p11\-kit\-proxy.so
@@ -6042,8 +6042,8 @@ is passed as argument, the IPv6 route for this host is reported.
 .\"*********************************************************
 .SS IPv6 Related Options
 .\"*********************************************************
-The following options exist to support IPv6 tunneling in peer-to-peer
-and client-server mode.  All options are modeled after their IPv4
+The following options exist to support IPv6 tunneling in peer\-to\-peer
+and client\-server mode.  All options are modeled after their IPv4
 counterparts, so more detailed explanations given there apply here
 as well (except for
 .B \-\-topology
@@ -6065,7 +6065,7 @@ field from
 is used.
 .TP
 .B \-\-server\-ipv6 ipv6addr/bits
-convenience-function to enable a number of IPv6 related options at
+convenience\-function to enable a number of IPv6 related options at
 once, namely
 .B \-\-ifconfig\-ipv6, \-\-ifconfig\-ipv6\-pool
 and
@@ -6082,14 +6082,14 @@ pool starts at
 and matches the offset determined from the start of the IPv4 pool.
 .TP
 .B \-\-ifconfig\-ipv6\-push ipv6addr/bits ipv6remote
-for ccd/ per-client static IPv6 interface configuration, see
+for ccd/ per\-client static IPv6 interface configuration, see
 .B \-\-client\-config\-dir
 and
 .B \-\-ifconfig\-push
 for more details.
 .TP
 .B \-\-iroute\-ipv6 ipv6addr/bits
-for ccd/ per-client static IPv6 route configuration, see
+for ccd/ per\-client static IPv6 route configuration, see
 .B \-\-iroute
 for more details how to setup and use this, and how
 .B \-\-iroute
@@ -6100,7 +6100,7 @@ interact.
 .\"*********************************************************
 .SH SCRIPTING AND ENVIRONMENTAL VARIABLES
 OpenVPN exports a series
-of environmental variables for use by user-defined scripts.
+of environmental variables for use by user\-defined scripts.
 .\"*********************************************************
 .SS Script Order of Execution
 .\"*********************************************************
@@ -6185,13 +6185,13 @@ Here is a brief rundown of OpenVPN's current string types and the
 permitted character class for each string:
 
 .B X509 Names:
-Alphanumeric, underbar ('_'), dash ('-'), dot ('.'), at 
+Alphanumeric, underbar ('_'), dash ('\-'), dot ('.'), at 
 ('@'), colon (':'), slash ('/'), and equal ('=').  Alphanumeric is defined 
 as a character which will cause the C library isalnum() function to return 
 true.
 
 .B Common Names:
-Alphanumeric, underbar ('_'), dash ('-'), dot ('.'), and at                
+Alphanumeric, underbar ('_'), dash ('\-'), dot ('.'), and at                
 ('@').
 
 .B \-\-auth\-user\-pass username:
@@ -6205,8 +6205,8 @@ Printable is defined to be a character which will cause the C library
 isprint() function to return true.
 
 .B \-\-client\-config\-dir filename as derived from common name or username:
-Alphanumeric, underbar ('_'), dash ('-'), and dot ('.') except for "." or 
-".." as standalone strings.  As of v2.0.1-rc6, the at ('@') character has
+Alphanumeric, underbar ('_'), dash ('\-'), and dot ('.') except for "." or 
+".." as standalone strings.  As of v2.0.1\-rc6, the at ('@') character has
 been added as well for compatibility with the common name character class.
 
 .B Environmental variable names:
@@ -6222,7 +6222,7 @@ character class for that string type will be remapped to underbar ('_').
 Once set, a variable is persisted
 indefinitely until it is reset by a new value or a restart,
 
-As of OpenVPN 2.0-beta12, in server mode, environmental
+As of OpenVPN 2.0\-beta12, in server mode, environmental
 variables set by OpenVPN
 are scoped according to the client objects
 they are
@@ -6304,7 +6304,7 @@ An option pushed via
 to a client which does not natively support it,
 such as
 .B \-\-dhcp\-option
-on a non-Windows system, will be recorded to this
+on a non\-Windows system, will be recorded to this
 environmental variable sequence prior to
 .B \-\-up
 script execution.
@@ -6529,7 +6529,7 @@ Set on program initiation and reset on SIGHUP.
 .\"*********************************************************
 .TP
 .B route_net_gateway
-The pre-existing default IP gateway in the system routing
+The pre\-existing default IP gateway in the system routing
 table.
 Set prior to
 .B \-\-up
@@ -6634,7 +6634,7 @@ or
 .\"*********************************************************
 .TP
 .B time_ascii
-Client connection timestamp, formatted as a human-readable
+Client connection timestamp, formatted as a human\-readable
 time string.
 Set prior to execution of the
 .B \-\-client\-connect
@@ -6684,7 +6684,7 @@ is the verification level.  Only set for TLS connections.  Set prior
 to execution of
 .B \-\-tls\-verify
 script. This is in the form of a decimal string like "933971680", which is
-suitable for doing serial-based OCSP queries (with OpenSSL, do not
+suitable for doing serial\-based OCSP queries (with OpenSSL, do not
 prepend "0x" to the string) If something goes wrong while reading
 the value from the certificate it will be an empty string, so your
 code should check that.
@@ -6785,12 +6785,12 @@ and 1 for the CA certificate.
 .ft 3
 .in +4
 X509_0_emailAddress=me@...430...
-X509_0_CN=Test-Client
-X509_0_O=OpenVPN-TEST
+X509_0_CN=Test\-Client
+X509_0_O=OpenVPN\-TEST
 X509_0_ST=NA
 X509_0_C=KG
 X509_1_emailAddress=me@...430...
-X509_1_O=OpenVPN-TEST
+X509_1_O=OpenVPN\-TEST
 X509_1_L=BISHKEK
 X509_1_ST=NA
 X509_1_C=KG
@@ -6801,7 +6801,7 @@ X509_1_C=KG
 .SH INLINE FILE SUPPORT
 OpenVPN allows including files in the main configuration for the
 .B \-\-ca, \-\-cert, \-\-dh, \-\-extra\-certs, \-\-key, \-\-pkcs12, \-\-secret,
-.B \-\-crl\-verify, \-\-http\-proxy\-user\-pass, \-\-tls-auth
+.B \-\-crl\-verify, \-\-http\-proxy\-user\-pass, \-\-tls\-auth
 and
 .B \-\-tls\-crypt
 options.
@@ -6817,9 +6817,9 @@ Here is an example of an inline file usage
 .ft 3
 .in +4
 <cert>
------BEGIN CERTIFICATE-----
+\-\-\-\-\-BEGIN CERTIFICATE\-\-\-\-\-
 [...]
------END CERTIFICATE-----
+\-\-\-\-\-END CERTIFICATE\-\-\-\-\-
 </cert>
 .in -4
 .ft
@@ -6835,15 +6835,15 @@ the inline file has to be base64 encoded. Encoding of a .p12 file into base64 ca
 .B SIGHUP
 Cause OpenVPN to close all TUN/TAP and
 network connections,
-restart, re-read the configuration file (if any),
+restart, re\-read the configuration file (if any),
 and reopen TUN/TAP and network connections.
 .\"*********************************************************
 .TP
 .B SIGUSR1
 Like 
 .B SIGHUP,
-except don't re-read configuration file, and possibly don't close and reopen TUN/TAP
-device, re-read key files, preserve local IP address/port, or preserve most recently authenticated
+except don't re\-read configuration file, and possibly don't close and reopen TUN/TAP
+device, re\-read key files, preserve local IP address/port, or preserve most recently authenticated
 remote IP address/port based on
 .B \-\-persist\-tun, \-\-persist\-key, \-\-persist\-local\-ip,
 and
@@ -6923,7 +6923,7 @@ a UDP ping to its remote peer once every 15 seconds which will cause many
 stateful firewalls to forward packets in both directions
 without an explicit firewall rule).
 
-If you are using a Linux iptables-based firewall, you may need to enter
+If you are using a Linux iptables\-based firewall, you may need to enter
 the following command to allow incoming packets on the TUN device:
 .IP
 .B iptables \-A INPUT \-i tun+ \-j ACCEPT
@@ -6963,7 +6963,7 @@ via
 .B ssh
 without using the VPN (since
 .B ssh
-has its own built-in security) you would use the command
+has its own built\-in security) you would use the command
 .B ssh alice.example.com.
 However in the same scenario, you could also use the command
 .B telnet 10.4.0.2
@@ -7008,7 +7008,7 @@ program.  Omit the
 .B \-\-verb 9
 option to have OpenVPN run quietly.
 .\"*********************************************************
-.SS Example 2: A tunnel with static-key security (i.e. using a pre-shared secret)
+.SS Example 2: A tunnel with static\-key security (i.e. using a pre\-shared secret)
 First build a static key on bob.
 .IP
 .B openvpn \-\-genkey \-\-secret key
@@ -7041,13 +7041,13 @@ On alice:
 .IP
 .B ping 10.4.0.1
 .\"*********************************************************
-.SS Example 3: A tunnel with full TLS-based security
+.SS Example 3: A tunnel with full TLS\-based security
 For this test, we will designate
 .B bob
 as the TLS client and
 .B alice
 as the TLS server.
-.I Note that client or server designation only has meaning for the TLS subsystem.  It has no bearing on OpenVPN's peer-to-peer, UDP-based communication model.
+.I Note that client or server designation only has meaning for the TLS subsystem.  It has no bearing on OpenVPN's peer\-to\-peer, UDP\-based communication model.
 
 First, build a separate certificate/key pair
 for both bob and alice (see above where
@@ -7058,7 +7058,7 @@ Diffie Hellman parameters (see above where
 is discussed for more info).  You can also use the
 included test files client.crt, client.key,
 server.crt, server.key and ca.crt.
-The .crt files are certificates/public-keys, the .key
+The .crt files are certificates/public\-keys, the .key
 files are private keys, and ca.crt is a certification
 authority who has signed both
 client.crt and server.crt.  For Diffie Hellman
@@ -7133,7 +7133,7 @@ in a script and execute with the
 option.
 .\"*********************************************************
 .SH FIREWALLS
-OpenVPN's usage of a single UDP port makes it fairly firewall-friendly.
+OpenVPN's usage of a single UDP port makes it fairly firewall\-friendly.
 You should add an entry to your firewall rules to allow incoming OpenVPN
 packets.  On Linux 2.4+:
 .IP
@@ -7142,7 +7142,7 @@ packets.  On Linux 2.4+:
 This will allow incoming packets on UDP port 1194 (OpenVPN's default UDP port)
 from an OpenVPN peer at 1.2.3.4.
 
-If you are using HMAC-based packet authentication (the default in any of
+If you are using HMAC\-based packet authentication (the default in any of
 OpenVPN's secure modes), having the firewall filter on source
 address can be considered optional, since HMAC packet authentication
 is a much more secure method of verifying the authenticity of
@@ -7235,11 +7235,11 @@ OpenSSL Project (
 For more information on the TLS protocol, see
 .I http://www.ietf.org/rfc/rfc2246.txt
 
-For more information on the LZO real-time compression library see
+For more information on the LZO real\-time compression library see
 .I http://www.oberhumer.com/opensource/lzo/
 .\"*********************************************************
 .SH COPYRIGHT
-Copyright (C) 2002-2010 OpenVPN Technologies, Inc. This program is free software;
+Copyright (C) 2002\-2010 OpenVPN Technologies, Inc. This program is free software;
 you can redistribute it and/or modify
 it under the terms of the GNU General Public License version 2
 as published by the Free Software Foundation.
-- 
2.13.0


