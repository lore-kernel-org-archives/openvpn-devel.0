From: Steffan Karger <steffan@...1856...>
Date: Mon, 26 Dec 2016 20:15:43 +0100
Message-Id: <1482779743-9548-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Textual fixes for Changes.rst
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

We will likely refer many people to the Changes.rst file once we've
released 2.4.  This commits tries to polish the language a bit, and
adds two real changes:
 * Remove duplicate mention of the changes --tls-cipher defaults
 * Move the 'redirect-gateway' behavioural change from 'features' to
   'behavioural changes'.

I'm not a native speaker, so if you do not agree with some of the
changes, feel free to pick-and-choose from this commit as you please.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 Changes.rst | 134 ++++++++++++++++++++++++++++++------------------------------
 1 file changed, 66 insertions(+), 68 deletions(-)

diff --git a/Changes.rst b/Changes.rst
index df5ccb6..5ac59e0 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -4,19 +4,22 @@ Version 2.4.0
 
 New features
 ------------
-Peer ID support
-    Added new packet format P_DATA_V2, which includes peer-id. If
-    server and client  support it, client sends all data packets in
-    the new format. When data packet arrives, server identifies peer
+Seamless client IP/port floating
+    Added new packet format P_DATA_V2, which includes peer-id. If both the
+    server and client support it, the client sends all data packets in
+    the new format. When a data packet arrives, the server identifies peer
     by peer-id. If peer's ip/port has changed, server assumes that
     client has floated, verifies HMAC and updates ip/port in internal structs.
+    This allows the connection to be immediatly restored, instead of requiring
+    a TLS handshake before the server accepts packets from the new client
+    ip/port.
 
-Cipher negotiation
-    Data channel ciphers are now by default negotiated.  If a client advertises
-    support for Negotiable Crypto Parameters (NCP), the server will choose a
-    cipher (by default AES-256-GCM) for the data channel, and tell the client
-    to use that cipher.  Data channel cipher negotiation can be controlled
-    using ``--ncp-ciphers`` and ``--ncp-disable``.
+Data channel cipher negotiation
+    Data channel ciphers (``--cipher``) are now by default negotiated.  If a
+    client advertises support for Negotiable Crypto Parameters (NCP), the
+    server will choose a cipher (by default AES-256-GCM) for the data channel,
+    and tell the client to use that cipher.  Data channel cipher negotiation
+    can be controlled using ``--ncp-ciphers`` and ``--ncp-disable``.
 
     A more limited version also works in client-to-server and server-to-client
     scenarios where one of the end points uses a v2.4 client or server and the
@@ -33,29 +36,29 @@ Cipher negotiation
 
 AEAD (GCM) data channel cipher support
     The data channel now supports AEAD ciphers (currently only GCM).  The AEAD
-    packet format has a smaller overhead than the CBC packet format, (e.g. 20
-    bytes per packet for AES-128-GCM instead of 36 bytes per packet for
-    AES-128-CBC + HMAC-SHA1).
+    packet format has a smaller crypto overhead than the CBC packet format,
+    (e.g. 20 bytes per packet for AES-128-GCM instead of 36 bytes per packet
+    for AES-128-CBC + HMAC-SHA1).
 
 ECDH key exchange
     The TLS control channel now supports for elliptic curve diffie-hellmann
     key exchange (ECDH).
 
-Dualstack client connect
+Dualstack round-robin DNS client connect
     Instead of only using the first address of each ``--remote`` OpenVPN
     will now try all addresses (IPv6 and IPv4) of a ``--remote`` entry.
 
 Support for providing IPv6 DNS servers
-     A new DHCP sub-options ``DNS6`` is added alongside with the already existing
-     ``DNS`` sub-option.  This is used to provide DNS resolvers available over
-     IPv6.  This will be pushed to clients and `` --up`` scripts and ``--plugin``
-     can act upon it through the ``foreign_option_<n>`` environment variables.
+    A new DHCP sub-option ``DNS6`` is added alongside with the already existing
+    ``DNS`` sub-option.  This is used to provide DNS resolvers available over
+    IPv6.  This will be pushed to clients and `` --up`` scripts and ``--plugin``
+    can act upon it through the ``foreign_option_<n>`` environment variables.
 
-     Support for the Windows client picking up this new sub-option is added,
-     however IPv6 DNS resolvers needs to be configured via ``netsh`` which requires
-     administrator privileges if the new interactive services on Windows is not
-     being used.  If the interactive services is used, this service will execute
-     ``netsh`` in the background with the proper privileges.
+    Support for the Windows client picking up this new sub-option is added,
+    however IPv6 DNS resolvers need to be configured via ``netsh`` which requires
+    administrator privileges if the new interactive services on Windows is not
+    being used.  If the interactive services is used, this service will execute
+    ``netsh`` in the background with the proper privileges.
 
 New improved Windows Background service
     The new OpenVPNService is based on openvpnserv2, a complete rewrite of the OpenVPN
@@ -79,50 +82,44 @@ New interactive Windows service
     files under %USERPROFILE%\\OpenVPN\\config for use with the
     interactive service.
 
-redirect-gateway
-    if no flags are given, and the interactive service is used, "def1"
-    is implicitly set (because "delete and later reinstall the existing
-    default route" does not work well here).  If not using the service,
-    the old behaviour is kept.
-
 redirect-gateway ipv6
     OpenVPN has now feature parity between IPv4 and IPv6 for redirect
     gateway including the handling of overlapping IPv6 routes with
-    IPv6 remote VPN server address
+    IPv6 remote VPN server address.
 
 LZ4 Compression and pushable compression
     Additionally to LZO compression OpenVPN now also supports LZ4 compression.
     Compression options are now pushable from the server.
 
-pull-filter
+Filter pulled options client-side: pull-filter
     New option to explicitly allow or reject options pushed by the server.
     May be used multiple times and is applied in the order specified.
 
-push-remove
-    new option to remove options on a per-client basis from the "push" list
-    (more fine-grained than ``--push-reset``)
+Per-client remove push options: push-remove
+    New option to remove options on a per-client basis from the "push" list
+    (more fine-grained than ``--push-reset``).
 
 Http proxy password inside config file
     Http proxy passwords can be specified with the inline file option
     ``<http-proxy-user-pass>`` .. ``</http-proxy-user-pass>``
 
-Windows version
+Windows version detection
     Windows version is detected, logged and possibly signalled to server
-    (IV_PLAT_VER=<nn> if ``--push-peer-info`` is set on client)
+    (IV_PLAT_VER=<nn> if ``--push-peer-info`` is set on client).
 
 Authentication tokens
-    In situations where it is not suitable to save users passwords on the client
-    OpenVPN have since v2.3 had support for --auth-token.  This option is
+    In situations where it is not suitable to save user passwords on the client,
+    OpenVPN has support for pushing a --auth-token since v2.3.  This option is
     pushed from the server to the client with a token value to be used instead
     of the users password.  For this to work, the authentication plug-in would
     need to implement this support as well.  In OpenVPN 2.4 --auth-gen-token
     is introduced, which will allow the OpenVPN server to generate a random
     token and push it to the client without any changes to the authentication
     modules.  When the clients need to re-authenticate the OpenVPN server will
-    instead of sending the re-authentication request to the authentication
-    module do the authentication internally.  This feature is especially
-    useful in configurations which adds One Time Password (OTP) authentication
-    schemes, as this allows the tunnel to be renegotiated regularly without
+    do the authentication internally, instead of sending the re-authentication
+    request to the authentication module .  This feature is especially
+    useful in configurations which use One Time Password (OTP) authentication
+    schemes, as this allows the tunnel keys to be renegotiated regularly without
     any need to supply new OTP codes.
 
 keying-material-exporter
@@ -130,12 +127,12 @@ keying-material-exporter
     derived from existing TLS channel.
 
 Mac OS X Keychain management client
-    added contrib/keychain-mcd which allows to use Mac OS X keychain
-    certificates with OpenVPN
+    Added contrib/keychain-mcd which allows to use Mac OS X keychain
+    certificates with OpenVPN.
 
 Android platform support
     Support for running on Android using Android's VPNService API has been added.
-    See doc/android.txt for 	more details. This support is primarily used in
+    See doc/android.txt for more details. This support is primarily used in
     the OpenVPN for Android app (https://github.com/schwabe/ics-openvpn)
 
 AIX platform support
@@ -150,7 +147,7 @@ Control channel encryption (``--tls-crypt``)
 Asynchronous push reply
     Plug-ins providing support for deferred authentication can benefit from a more
     responsive authentication where the server sends PUSH_REPLY immediately once
-    the authentication result is ready instead of waiting for the the client to
+    the authentication result is ready, instead of waiting for the the client to
     to send PUSH_REQUEST once more.  This requires OpenVPN to be built with
     ``./configure --enable-async-push``.  This is a compile-time only switch.
 
@@ -169,23 +166,23 @@ Deprecated features
   that would previously be accepted.  If this occurs, OpenVPN will log the
   crypto library's error description.
 
-- ``--tls-remote`` is removed in 2.4, as indicated in the 2.3 man-pages.  A similar
-  functionality is provided via ``--verify-x509-name`` which does the same job in
+- ``--tls-remote`` is removed in 2.4, as indicated in the 2.3 man-pages.  Similar
+  functionality is provided via ``--verify-x509-name``, which does the same job in
   a better way.
 
-- ``--compat-names`` and ``--no-name-remapping`` was deprecated in 2.3 and will
+- ``--compat-names`` and ``--no-name-remapping`` were deprecated in 2.3 and will
   be removed in 2.5.  All scripts and plug-ins depending on the old non-standard
   X.509 subject formatting must be updated to the standardized formatting.  See
   the man page for more information.
 
-- ``--no-iv`` is deprecated in 2.4 and will be remove in 2.5.
+- ``--no-iv`` is deprecated in 2.4 and will be removed in 2.5.
 
 User-visible Changes
 --------------------
-- When using ciphers with cipher blocks less than 128-bits
+- When using ciphers with cipher blocks less than 128-bits,
   OpenVPN will complain loudly if the configuration uses ciphers considered
   weak, such as the SWEET32 attack vector.  In such scenarios, OpenVPN will by
-  default do a renegotiation for each 64MB of transported data (``--reneg-bytes``).
+  default renegotiate for each 64MB of transported data (``--reneg-bytes``).
   This renegotiation can be disabled, but is HIGHLY DISCOURAGED.
 
 - For certificate DNs with duplicate fields, e.g. "OU=one,OU=two", both fields
@@ -195,18 +192,14 @@ User-visible Changes
   Note that this breaks setups that rely on the fact that OpenVPN would
   previously (incorrectly) only export the last occurence of a field.
 
-- proto udp and proto tcp specify to use IPv4 and IPv6. The new
-  options proto udp4 and tcp4 specify to use IPv4 only.
+- ``proto udp`` and ``proto tcp`` now use both IPv4 and IPv6. The new
+  options ``proto udp4`` and ``proto tcp4`` use IPv4 only.
 
 - ``--sndbuf`` and ``--recvbuf`` default now to OS defaults instead of 64k
 
-- OpenVPN exits with  an error if an option has extra parameters;
+- OpenVPN exits with an error if an option has extra parameters;
   previously they were silently ignored
 
-- The default of ``--tls-cipher`` is now "DEFAULT:!EXP:!PSK:!SRP:!kRSA"
-  instead of "DEFAULT" to always select perfect forward security
-  cipher suites
-
 - ``--tls-auth`` always requires OpenVPN static key files and will no
   longer work with free form files
 
@@ -230,11 +223,11 @@ User-visible Changes
 - mbed TLS builds: minimum RSA key size is now 2048 bits.  Shorter keys will
   not be accepted, both local and from the peer.
 
-- ``--connect-timeout`` specifies now the timeout until the first TLS packet
+- ``--connect-timeout`` now specifies the timeout until the first TLS packet
   is received (identical to ``--server-poll-timeout``) and this timeout now
   includes the removed socks proxy timeout and http proxy timeout.
 
-  In ``--static`` mode connect-timeout specifies the timeout for TCP and
+  In ``--static`` mode ``connect-timeout`` specifies the timeout for TCP and
   proxy connection establishment
 
 - ``--connect-retry-max`` now specifies the maximum number of unsuccessful
@@ -262,26 +255,31 @@ User-visible Changes
   capable. The ``--tun-ipv6`` option is ignored (behaves like it is always
   on).
 
-- On the client side recursively routed packets, which have same destination
-  as the VPN server, are dropped. This could be disabled with
+- On the client side recursively routed packets, which have the same destination
+  as the VPN server, are dropped. This can be disabled with
   --allow-recursive-routing option.
 
-- on Windows, when the ``--register-dns`` option is set, OpenVPN no longer
+- On Windows, when the ``--register-dns`` option is set, OpenVPN no longer
   restarts the ``dnscache`` service - this had unwanted side effects, and
   seems to be no longer necessary with currently supported Windows versions.
 
+- If no flags are given, and the interactive Windows service is used, "def1"
+  is implicitly set (because "delete and later reinstall the existing
+  default route" does not work well here).  If not using the service,
+  the old behaviour is kept.
+
 - OpenVPN now reloads a CRL only if the modication time or file size has
   changed, instead of for each new connection.  This reduces the connection
   setup time, in particular when using large CRLs.
 
-- OpenVPN now ships with more up-to-date systemd unit files which takes advantage
+- OpenVPN now ships with more up-to-date systemd unit files which take advantage
   of the improved service management as well as some hardening steps.  The
   configuration files are picked up from the /etc/openvpn/server/ and
   /etc/openvpn/client/ directories (depending on unit file).  This also avoids
   these new unit files and how they work to collide with older pre-existing
   unit files.
 
-- using ``--no-iv`` (which is generally not a recommended setup) will
+- Using ``--no-iv`` (which is generally not a recommended setup) will
   require explicitly disabling NCP with ``--disable-ncp``.  This is
   intentional because NCP will by default use AES-GCM, which requires
   an IV - so we want users of that option to consciously reconsider.
@@ -299,8 +297,8 @@ Maintainer-visible changes
   files instead of older ones, to provide a unified behaviour across systemd
   based Linux distributions.
 
-- With OpenVPN v2.4, the project have moved over to depend on and actively use
+- With OpenVPN v2.4, the project has moved over to depend on and actively use
   the official C99 standard (-std=c99).  This may on some older compiler/libc
-  headers combinations fail.  On most of these situations it is recommended to
+  header combinations fail.  In most of these situations it is recommended to
   do use -std=gnu99 in CFLAGS.  This is known to be needed when doing
   i386/i686 builds on RHEL5.
-- 
2.7.4


