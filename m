From: Arne Schwabe <arne@...1227...>
Date: Fri, 21 Oct 2016 16:42:37 +0200
Message-Id: <1477060957-6423-1-git-send-email-arne@...1227...>
In-Reply-To: <3ec690d6-41a7-ea60-a350-7691b9a6d191@...515...>
References: <3ec690d6-41a7-ea60-a350-7691b9a6d191@...515...>
Subject: [Openvpn-devel] [Patch v2] Make Changes.rst nicer for 2.4 release
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

- Add `` to all options
- Sort and group new features
- Group changes a bit better
- Fix some formatting/formulation

Patch V2:
- add missing quote, noticed by Samuli
- add new windows services
- add ECDH
- add pushable compression
- add Android and AIX platform support
---
 Changes.rst     | 162 ++++++++++++++++++++++++++++++++++----------------------
 doc/android.txt |   2 +-
 2 files changed, 99 insertions(+), 65 deletions(-)

diff --git a/Changes.rst b/Changes.rst
index 27dc99e..01ff832 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -4,64 +4,98 @@ Version 2.4.0
 
 New features
 ------------
+Peer ID support
+    Added new packet format P_DATA_V2, which includes peer-id. If
+    server and client  support it, client sends all data packets in
+    the new format. When data packet arrives, server identifies peer
+    by peer-id. If peer's ip/port has changed, server assumes that
+    client has floated, verifies HMAC and updates ip/port in internal structs.
+    
+Cipher negotiation
+    Data channel ciphers are now by default negotiated.  If a client advertises
+    support for Negotiable Crypto Parameters (NCP), the server will choose a
+    cipher (by default AES-256-GCM) for the data channel, and tell the client
+    to use that cipher.  Data channel cipher negotiation can be controlled
+    using ``--ncp-ciphers`` and ``--ncp-disable``.
 
-pull-filter
-    New option to explicitly allow or reject options pushed by the server.
-    May be used multiple times and is applied in the order specified.
+AEAD (GCM) data channel cipher support
+    The data channel now supports AEAD ciphers (currently only GCM).  The AEAD
+    packet format has a smaller overhead than the CBC packet format, (e.g. 20
+    bytes per packet for AES-128-GCM instead of 36 bytes per packet for
+    AES-128-CBC + HMAC-SHA1).
 
-push-remove
-    new option to remove options on a per-client basis from the "push" list
-    (more fine-grained than "push-reset")
+ECDH key exchange
+	The TLS control channel now supports for elliptic curve diffie-hellmann
+    key exchange (ECDH).
 
-keying-material-exporter
-    Keying Material Exporter [RFC-5705] allow additional keying material to be
-    derived from existing TLS channel.
+Dualstack client connect
+    Instead of only using the first address of each ``--remote`` OpenVPN
+    will now try all addresses (IPv6 and IPv4) of a ``--remote`` entry.
+    
+New improved Windows Background service
+	The new OpenVPNService is based on openvpnserv2, a complete rewrite of the OpenVPN 
+    service wrapper. It is intended for launching OpenVPN instances that should be 
+    up at all times, instead of being manually launched by a user. OpenVPNService is 
+    able to restart individual OpenVPN processes if they crash, and it also works 
+    properly on recent Windows versions. OpenVPNServiceLegacy tends to work poorly, 
+    if at all, on newer Windows versions (8+) and its use is not recommended.
+
+New interactive Windows service
+	The installer starts OpenVPNServiceInteractive automatically and configures
+    it to start	at system startup.
+
+    The interactive Windows service allows unprivileged users to start
+	OpenVPN connections in the global config directory (usually
+	C:\Program Files\OpenVPN\config) using OpenVPN GUI without any
+	extra configuration.
+
+	Users who belong to the built-in Administrator group or to the
+	local "OpenVPN Administrator" group can also store configuration
+	files under %USERPROFILE%\OpenVPN\config for use with the
+	interactive service.
 
 redirect-gateway ipv6
     OpenVPN has now feature parity between IPv4 and IPv6 for redirect
     gateway including the handling of overlapping IPv6 routes with
     IPv6 remote VPN server address
 
-Mac OS X Keychain management client
-    add contrib/keychain-mcd which allows to use Mac OS X keychain
-    certificates with OpenVPN
+LZ4 Compression and pushable compression 
+	Additionally to LZO compression OpenVPN now also supports LZ4 compression. 
+    Compression options are now pushable from the server.
 
-Peer ID support
-    Added new packet format P_DATA_V2, which includes peer-id. If
-    server and client  support it, client sends all data packets in
-    the new format. When data packet arrives, server identifies peer
-    by peer-id. If peer's ip/port has changed, server assumes that
-    client has floated, verifies HMAC and updates ip/port in internal structs.
+pull-filter
+    New option to explicitly allow or reject options pushed by the server.
+    May be used multiple times and is applied in the order specified.
 
-Dualstack client connect
-    Instead of only using the first address of each --remote OpenVPN
-    will now try all addresses (IPv6 and IPv4) of a --remote entry.
+push-remove
+    new option to remove options on a per-client basis from the "push" list
+    (more fine-grained than ``--push-reset``)
 
-LZ4 Compression
-    Additionally to LZO compression OpenVPN now also supports LZ4
-    compression.
+Http proxy password inside config file
+    Http proxy passwords can be specified with the inline file option
+    ``<http-proxy-user-pass>`` .. ``</http-proxy-user-pass>``
 
 Windows version
     Windows version is detected, logged and possibly signalled to server
-    (IV_PLAT_VER=<nn> if --push-peer-info is set on client)
+    (IV_PLAT_VER=<nn> if ``--push-peer-info`` is set on client)
 
-AEAD (GCM) data channel cipher support
-    The data channel now supports AEAD ciphers (currently only GCM).  The AEAD
-    packet format has a smaller overhead than the CBC packet format, (e.g. 20
-    bytes per packet for AES-128-GCM instead of 36 bytes per packet for
-    AES-128-CBC + HMAC-SHA1).
+keying-material-exporter
+    Keying Material Exporter [RFC-5705] allow additional keying material to be
+    derived from existing TLS channel.
 
-Http proxy password inside config file
-	Http proxy passwords can be specified with the inline file option
-    http-proxy-user-pass
+Mac OS X Keychain management client
+    added contrib/keychain-mcd which allows to use Mac OS X keychain
+    certificates with OpenVPN
 
-Cipher negotiation
-    Data channel ciphers are now by default negotiated.  If a client advertises
-    support for Negotiable Crypto Parameters (NCP), the server will choose a
-    cipher (by default AES-256-GCM) for the data channel, and tell the client
-    to use that cipher.  Data channel cipher negotiation can be controlled
-    using --ncp-ciphers and --ncp-disable.
+Android platform support
+    Support for running on Android using Android's VPNService API has been added.
+    See doc/android.txt for 	more details. This support is primarily used in
+    the OpenVPN for Android app (https://github.com/schwabe/ics-openvpn)
 
+AIX platform support
+	AIX platform support has been added. The support only includes tap
+    devices since AIX does not provide tun interface.
+	
 
 User-visible Changes
 --------------------
@@ -75,33 +109,23 @@ User-visible Changes
 - proto udp and proto tcp specify to use IPv4 and IPv6. The new
   options proto udp4 and tcp4 specify to use IPv4 only.
 
-- connect-timeout specifies now the timeout until the first TLS packet
-  is received (identical to server-poll-timeout) and this timeout now
-  includes the removed socks proxy timeout and http proxy timeout.
-
-  In --static mode connect-timeout specifies the timeout for TCP and
-  proxy connection establishment
-
-- connect-retry-max now specifies the maximum number of unsuccessful
-  attempts of each remote/connection entry before exiting.
-
-- sndbuf and recvbuf default now to OS default instead of 64k
+- ``--sndbuf`` and ``--recvbuf`` default now to OS defaults instead of 64k
 
 - OpenVPN exits with  an error if an option has extra parameters;
   previously they were silently ignored
 
-- The default of tls-cipher is now "DEFAULT:!EXP:!PSK:!SRP:!kRSA"
+- The default of ``--tls-cipher`` is now "DEFAULT:!EXP:!PSK:!SRP:!kRSA"
   instead of "DEFAULT" to always select perfect forward security
   cipher suites
 
-- --tls-auth always requires OpenVPN static key files and will no
+- ``--tls-auth`` always requires OpenVPN static key files and will no
   longer work with free form files
 
-- proto udp6/tcp6 in server mode will now try to always listen to
-  both IPv4 and IPv6 on platforms that allow it. Use bind ipv6only
+- ``--proto udp6/tcp6`` in server mode will now try to always listen to
+  both IPv4 and IPv6 on platforms that allow it. Use ``--bind ipv6only`` 
   to explicitly listen only on IPv6.
 
-- Removed --enable-password-save from configure. This option is now
+- Removed ``--enable-password-save`` from configure. This option is now
   always enabled.
 
 - Stricter default TLS cipher list (override with ``--tls-cipher``), that now
@@ -117,26 +141,36 @@ User-visible Changes
 - mbed TLS builds: minimum RSA key size is now 2048 bits.  Shorter keys will
   not be accepted, both local and from the peer.
 
-- --http-proxy-timeout and the static non-changeable socks timeout (5s)
-  have been folded into a "unified" --connect-timeout which covers all
+- ``--connect-timeout`` specifies now the timeout until the first TLS packet
+  is received (identical to ``--server-poll-timeout``) and this timeout now
+  includes the removed socks proxy timeout and http proxy timeout.
+
+  In ``--static`` mode connect-timeout specifies the timeout for TCP and
+  proxy connection establishment
+
+- ``--connect-retry-max`` now specifies the maximum number of unsuccessful
+  attempts of each remote/connection entry before exiting.
+
+- ``--http-proxy-timeout`` and the static non-changeable socks timeout (5s)
+  have been folded into a "unified" ``--connect-timeout`` which covers all
   steps needed to connect to the server, up to the start of the TLS exchange.
   The default value has been raised to 120s, to handle slow http/socks
   proxies graciously.  The old "fail TCP fast" behaviour can be achieved by
-  adding "--connect-timeout 10" to the client config.
+  adding "``--connect-timeout 10``" to the client config.
 
-- --http-proxy-retry and --sock-proxy-retry have been removed. Proxy connections
-    will now behave like regular connection entries and generate a USR1 on failure.
+- ``--http-proxy-retry`` and ``--sock-proxy-retry`` have been removed. Proxy connections
+  will now behave like regular connection entries and generate a USR1 on failure.
 
-- --connect-retry gets an optional second argument that specifies the maximum
+- ``--connect-retry`` gets an optional second argument that specifies the maximum
   time in seconds to wait between reconnection attempts when an exponential
   backoff is triggered due to repeated retries. Default = 300 seconds.
 
 - Data channel cipher negotiation (see New features section) can override
-  ciphers configured in the config file.  Use --ncp-disable if you don't want
-  that.
+  ciphers configured in the config file.  Use ``--ncp-disable`` if you do not want
+  this behavior.
 
 - All tun devices on all platforms are always considered to be IPv6
-  capable. The --tun-ipv6 option is ignored (behaves like it is always
+  capable. The ``--tun-ipv6`` option is ignored (behaves like it is always
   on).
 
 
diff --git a/doc/android.txt b/doc/android.txt
index 3a096dd..5f4ee95 100644
--- a/doc/android.txt
+++ b/doc/android.txt
@@ -1,7 +1,7 @@
 This file documents the support in OpenVPN for Android 4.0 and up.
 
 This support is primarily used in the "OpenVPN for Android" app
-(http://code.google.com/p/ics-openvpn/). For building see the developer
+(https://github.com/schwabe/ics-openvpn). For building see the developer
 README: https://github.com/schwabe/ics-openvpn/blob/master/doc/README.txt
 
 Android provides the VPNService API
-- 
2.8.4 (Apple Git-73)


