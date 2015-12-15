From: samuli@...515...
Date: Tue, 15 Dec 2015 17:00:26 +0200
Message-Id: <1450191626-24633-1-git-send-email-samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Updates to Changes.rst
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

This patch is for the release/2.3 branch

Signed-off-by: Samuli Sepp=C3=A4nen <samuli@...515...>
---
 Changes.rst | 390 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++--
 1 file changed, 383 insertions(+), 7 deletions(-)

diff --git a/Changes.rst b/Changes.rst
index 0188323..38f42b6 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -1,24 +1,400 @@
-Version 2.3.9
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
+Overview of changes in 2.3
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
=20
 New features
 ------------
=20
-Peer ID support
+Windows DNS leak fix
+    This feature allows blocking all out-of-tunnel communication on TCP/UD=
P port
+    53 (except for OpenVPN itself), preventing DNS Leaks on Windows 8.1 an=
d 10.
+
+Client-only support for Peer ID
     Added new packet format P_DATA_V2, which includes peer-id. If
     server and client  support it, client sends all data packets in
     the new format. When data packet arrives, server identifies peer
     by peer-id. If peer's ip/port has changed, server assumes that
     client has floated, verifies HMAC and updates ip/port in internal stru=
cts.
+    OpenvPN 2.3.x has client-side functionality only, server needs 2.4.
+
+TLS version negotiation
+    Updated the TLS negotiation logic to adaptively try to connect using
+    the highest TLS version supported by both client and server. The behav=
ior
+    of this feature can be adjusted as necessary.
+
+Push peer info
+    Always push basic set of peer info values to server. This allows the
+    server to make informed choices based on the capabilities of the clien=
t.
+    The capabilities include things like supported compression algorithms,
+    SSL library version and GUI version. The amount of data transmitted in=
 peer
+    information can be adjusted.
+
+PolarSSL support
+    Allow use of PolarSSL in OpenVPN as the crypto library, the SSL librar=
y and
+    for providing PKCS#11 support.
+
+Plug-in API v3
+    This is a new, more flexible plug-in API.
+
+IPv6 payload and transport support
+    Allow tunneling IPv6 traffic inside an IPv6 tunnel, as well as using I=
Pv6
+    as the transport for OpenVPN traffic.
+
+Client-side one-to-one NAT support
+    This feature allows using SNAT or DNAT internally in OpenVPN to work a=
round
+    IP numbering conflicts with pushed routes.
+
+Support for a challenge/response protocol
+    Allows an OpenVPN server to generate challenge questions for the user.=
 This
+    can be used to implement multi-factor authentication. Both dynamic and
+    static challenges are supported.
+
+Improved UTF-8 support
+    OpenVPN can now manage UTF-8 characters, for example in usernames,
+    passwords, X.509 DNs and Windows paths.
+
+Behavioral changes
+------------------
+
+- Remove --enable-password-save option, which was seen as universally usef=
ul
+
+- Disallow usage of --server-poll-timeout in --secret key mode
+
+- The second parameter of --ifconfig is no longer a "remote address" but a
+  "netmask" when using --dev tun and --topology subnet
+
+- Automatic TLS version negotiation may cause issues in certain cases.
+
+- Don't exit daemon if opening or parsing the CRL fails
+
+- Do not upcase x509-username-field for mixed-case arguments
+
+- Allow use of connection block variables after connection blocks: this may
+  cause issues in some cases
+
+- Always load intermediate certificates from a PKCS#12 file, instead of ig=
noring
+  them
+
+- Remove the --disable-eurephia configure option
+
+- Remove the support for using system() when executing external programs or
+  scripts
+
+- Inline files are now always enabled
+
+- Remove the --auto-proxy option
+
+- Directory layout restructuring
+
+- A Windows buildsystem is no longer bundled with OpenVPN=20
+
+- Easy-rsa is no longer bundled with OpenVPN
+
+- Tap-windows driver sources are no longer bundled with OpenVPN
+
+- Made some options connection-entry specific
+
+- Make '--win-sys env' default
+
+-  Do not randomize resolving of IP addresses in getaddr()
+
+Version 2.3.9
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+New features
+------------
=20
-    (2.3.x has client-side functionality only, server needs 2.4)
+- Windows DNS leak fix
=20
+- Client-only Peer ID support
=20
-User-visible Changes
---------------------
+Behavioral changes
+------------------
=20
 - sndbuf and recvbuf default now to OS default instead of 64k
=20
 - Removed --enable-password-save from configure. This option is now
   always enabled.
+
+
+Version 2.3.8
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Bug fixes
+---------
+
+- Lots of bug fixes and documentation improvements
+
+Version 2.3.7
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Bug fixes
+---------
+
+- Lots of bug fixes and documentation improvements
+
+New features
+------------
+
+- include ifconfig\_ environment variables in --up-restart env set
+- Re-read auth-user-pass file on (re)connect if required
+
+Behavioral changes
+------------------
+
+- Disallow usage of --server-poll-timeout in --secret key mode
+- Re-enable TLS version negotiation by default
+
+Version 2.3.6
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Bug fixes
+---------
+
+- A few bug fixes and documentation improvement
+
+New features
+------------
+
+- Add client-only support for peer-id
+- Add --tls-version-max
+
+Version 2.3.5
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Bug fixes
+---------
+
+- Fix server routes not working in topology subnet with --server [v3]
+- Fix regression with password protected private keys (polarssl)
+- Fix "code=3D995" bug with windows NDIS6 tap driver
+- Lots of other bug fixes
+
+Version 2.3.4
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Bug fixes
+---------
+
+- When tls-version-min is unspecified, revert to original versioning appro=
ach
+- IPv6 address/route delete fix for Win8
+- Fix SOCKSv5 method selection
+- Lots of other bug fixes and documentation improvements
+
+Version 2.3.3
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Bug fixes
+---------
+
+- Fix slow memory drain on each client renegotiation
+- Fix spurious ignoring of pushed config options (trac#349)
+- Lots of bug fixes and documentation improvements
+
+New features
+------------
+
+- Add reporting of UI version to basic push-peer-info set
+- Add support to ignore specific options
+- Add support of utun devices under Mac OS X
+- Support non-ASCII TAP adapter names on Windows
+- Support non-ASCII characters in Windows tmp path
+- Added "setenv opt" directive prefix
+- --management-external-key for PolarSSL
+- Add support for client-cert-not-required for PolarSSL
+
+Behavioral changes
+------------------
+
+- TLS version negotiation
+- Require polarssl >=3D 1.2.10 for polarssl-builds, which fixes CVE-2013-5=
915
+
+Version 2.3.2
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Bug fixes
+---------
+
+- Fix proto tcp6 for server & non-P2MP modes
+- Fix NULL-pointer crash in route_list_add_vpn_gateway()
+- Fix problem with UDP tunneling due to mishandled pktinfo structures
+- Fix segfault when enabling pf plug-ins
+- Lots of other bug fixes
+
+New features
+------------
+
+- Always push basic set of peer info values to server
+- make 'explicit-exit-notify' pullable again
+
+Version 2.3.1
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Bug fixes
+---------
+
+- Repair "tcp server queue overflow" brokenness, more <stdbool.h> fallout
+- Fix directly connected routes for "topology subnet" on Solaris
+- Use constant time memcmp when comparing HMACs in openvpn_decrypt
+- Repair "tcp server queue overflow" brokenness, more <stdbool.h> fallout
+- Lots of other bug fixes and documentation improvements
+
+New features
+------------
+
+- reintroduce --no-name-remapping option
+- make --tls-remote compatible with pre 2.3 configs
+- add new option for X.509 name verification
+- PolarSSL-1.2 support
+- Enable TCP_NODELAY configuration on FreeBSD
+- Permit pool size of /64.../112 for ifconfig-ipv6-pool
+
+Behavioral changes
+------------------
+
+- Switch to IANA names for TLS ciphers
+
+Version 2.3.0
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Bug fixes
+---------
+
+- Fix parameter type for IP_TOS setsockopt on non-Linux systems
+- Fix client crash on double PUSH_REPLY
+
+Version 2.3_rc2
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Bug fixes
+---------
+
+- Fix --show-pkcs11-ids (Bug #239)
+- Lots of other bug fixes and documentation improvements
+
+New features
+------------
+
+- Implement --mssfix handling for IPv6 packets
+
+Version 2.3_rc1
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Bug fixes
+---------
+
+- Fixed a bug where PolarSSL gave an error when using an inline file tag
+- Fix v3 plugins to support returning values back to OpenVPN
+- Lots of other bug fixes and documentation improvements
+
+New features
+------------
+
+- Support UTF-8 --client-config-dir
+
+Behavioral changes
+------------------
+
+- Remove the support for using system() when executing external programs or
+  scripts
+
+Version 2.3_beta1
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Bug fixes
+---------
+
+- Fixes error: --key fails with EXTERNAL_PRIVATE_KEY: No such file or dire=
ctory=20
+  if --management-external-key is used
+- fix regression with --http-proxy[\-\*] options
+- Lots of other bug fixes and documentation improvements
+
+New features
+------------
+
+- Add --compat-names option
+- add API for plug-ins to write to openvpn log
+
+Behavioral changes
+------------------
+
+- Keep pre-existing tun/tap devices around on \*BSD
+
+Version 2.3_alpha3
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Bug fixes
+---------
+
+- Repair "tap server" mode brokenness caused by <stdbool.h> fallout
+- make non-blocking connect work on Windows
+- A few other bug fixes
+
+New features
+------------
+
+- add option --management-query-proxy
+
+Version 2.3_alpha2
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Bug fixes
+---------
+
+- Lots of other bug fixes and documentation improvements
+
+New features
+------------
+
+- Add missing pieces to IPv6 route gateway handling
+
+Behavioral changes
+------------------
+
+- Removed support for PolarSSL < 1.1
+- Complete overhaul of the project structure and the buildsystem
+- remove the --auto-proxy option from openvpn
+
+Version 2.3-alpha1
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Bug fixes
+---------
+
+- Many \*BSD and Windows bug fixes
+- Many Windows installer fixes
+- Properly handle certificate serial numbers > 32 bits
+- Fixed bug in port-share that could cause port share process to crash
+- Fixed issue where a client might receive multiple push replies
+- Lots of other bug fixes and documentation improvements
+
+New features
+------------
+
+- PolarSSL support
+- Add plug-in API v3
+- IPv6 payload and transport support
+- New feauture: Add --stale-routes-check
+- Add support to forward console query to systemd
+- Windows UTF-8 input/output
+- Added "management-external-key" option
+- Added --x509-track option
+- Added "client-nat" option for stateless, one-to-one NAT on the client si=
de
+- Extended "client-kill" management interface command
+- Client will now try to reconnect if no push reply received within
+  handshake-window seconds
+- Added "management-external-key" option
+- Added "auth-token" client directive
+- Added 'dir' flag to "crl-verify"
+- Added support for static challenge/response protocol
+- Changed CC_PRINT character class to allow UTF-8 chars
+- Extend output of "status" management interface command to include userna=
mes
+- Added "memstats" option to maintain real-time operating stats
+- Added support for "on-link" routes on Linux client
+- Add extv3 X509 field support to --x509-username-field
+
+Behavioral changes
+------------------
+
+- Remove support for Linux 2.2
+- Make '--win-sys env' default
+- Remove --enable-osxipconfig configure option
--=20
2.1.0


