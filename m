From: David Sommerseth <davids@...515...>
Date: Thu, 16 Jul 2020 00:30:09 +0200
Message-Id: <20200715223013.11726-13-davids@...515...>
In-Reply-To: <20200715223013.11726-1-davids@...515...>
References: <20200715223013.11726-1-davids@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 12/16] doc/man: Misc grammar and typo fixes
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

From: Richard Bonhomme <tincanteksup@...277...>

Signed-off-by: Richard Bonhomme <tincanteksup@...277...>
Signed-off-by: David Sommerseth <davids@...515...>
---
 doc/man-sections/advanced-options.rst    |  4 +--
 doc/man-sections/client-options.rst      | 17 +++++-----
 doc/man-sections/connection-profiles.rst |  2 +-
 doc/man-sections/encryption-options.rst  |  8 ++---
 doc/man-sections/examples.rst            |  2 +-
 doc/man-sections/pkcs11-options.rst      |  2 +-
 doc/man-sections/plugin-options.rst      |  4 +--
 doc/man-sections/protocol-options.rst    | 18 +++++------
 doc/man-sections/script-options.rst      | 18 +++++------
 doc/man-sections/server-options.rst      | 40 ++++++++++++------------
 doc/man-sections/signals.rst             |  2 +-
 doc/man-sections/tls-options.rst         |  6 ++--
 doc/man-sections/unsupported-options.rst |  4 +--
 doc/man-sections/vpn-network-options.rst |  4 +--
 doc/man-sections/windows-options.rst     |  4 +--
 15 files changed, 67 insertions(+), 68 deletions(-)

diff --git a/doc/man-sections/advanced-options.rst b/doc/man-sections/advanced-options.rst
index 262e568c..dbf7799c 100644
--- a/doc/man-sections/advanced-options.rst
+++ b/doc/man-sections/advanced-options.rst
@@ -60,7 +60,7 @@ used when debugging or testing out special usage scenarios.
   needs.
 
 --rcvbuf size
-  Set the TCP/UDP socket receive buffer size. Defaults to operation system
+  Set the TCP/UDP socket receive buffer size. Defaults to operating system
   default.
 
 --shaper n
@@ -88,7 +88,7 @@ used when debugging or testing out special usage scenarios.
   OpenVPN allows ``n`` to be between 100 bytes/sec and 100 Mbytes/sec.
 
 --sndbuf size
-  Set the TCP/UDP socket send buffer size. Defaults to operation system
+  Set the TCP/UDP socket send buffer size. Defaults to operating system
   default.
 
 --tcp-queue-limit n
diff --git a/doc/man-sections/client-options.rst b/doc/man-sections/client-options.rst
index 966ede1e..98b80cb1 100644
--- a/doc/man-sections/client-options.rst
+++ b/doc/man-sections/client-options.rst
@@ -26,9 +26,9 @@ configuration.
   pass over this token as the password instead of the password the user
   provided. The authentication token can only be reset by a full reconnect
   where the server can push new options to the client. The password the
-  user entered is never preserved once an authentication token have been
-  set. If the OpenVPN server side rejects the authentication token, the
-  client will receive an ``AUTH_FAIL`` and disconnect.
+  user entered is never preserved once an authentication token has been
+  set. If the OpenVPN server side rejects the authentication token then
+  the client will receive an ``AUTH_FAIL`` and disconnect.
 
   The purpose of this is to enable two factor authentication methods, such
   as HOTP or TOTP, to be used without needing to retrieve a new OTP code
@@ -130,7 +130,7 @@ configuration.
   Set ``--verb 6`` for debugging info showing the transformation of
   src/dest addresses in packets.
 
---connect-retry args
+--connect-retry n
   Wait ``n`` seconds between connection attempts (default :code:`5`).
   Repeated reconnection attempts are slowed down after 5 retries per
   remote by doubling the wait time after each unsuccessful attempt. An
@@ -139,8 +139,8 @@ configuration.
 
 --connect-retry-max n
   ``n`` specifies the number of times each ``--remote`` or
-  ``<connection>`` entry is tried. Specifying ``n`` as one would try each
-  entry exactly once. A successful connection resets the counter.
+  ``<connection>`` entry is tried. Specifying ``n`` as :code:`1` would try
+  each entry exactly once. A successful connection resets the counter.
   (default *unlimited*).
 
 --connect-timeout n
@@ -331,9 +331,8 @@ configuration.
 
 --server-poll-timeout n
   When connecting to a remote server do not wait for more than ``n``
-  seconds waiting for a response before trying the next server. The
-  default value is 120s. This timeout includes proxy and TCP connect
-  timeouts.
+  seconds for a response before trying the next server. The default value
+  is 120s. This timeout includes proxy and TCP connect timeouts.
 
 --static-challenge args
   Enable static challenge/response protocol
diff --git a/doc/man-sections/connection-profiles.rst b/doc/man-sections/connection-profiles.rst
index f72db56e..fd3382b2 100644
--- a/doc/man-sections/connection-profiles.rst
+++ b/doc/man-sections/connection-profiles.rst
@@ -4,7 +4,7 @@ CONNECTION PROFILES
 Client configuration files may contain multiple remote servers which
 it will attempt to connect against.  But there are some configuration
 options which are related to specific ``--remote`` options.  For these
-use cases, connection profiles is the solution.
+use cases, connection profiles are the solution.
 
 By enacpulating the ``--remote`` option and related options within
 ``<connection>`` and ``</connection>``, these options are handled as a
diff --git a/doc/man-sections/encryption-options.rst b/doc/man-sections/encryption-options.rst
index 42c80eb8..076b5fd3 100644
--- a/doc/man-sections/encryption-options.rst
+++ b/doc/man-sections/encryption-options.rst
@@ -85,7 +85,7 @@ Generating key material
     over a pre-existing secure channel such as ``scp``\(1).
 
   * Generating *TLS Crypt v2 Server key*
-    Generate a ``--tls-crypt-v2`` key tp be used by an OpenVPN server.
+    Generate a ``--tls-crypt-v2`` key to be used by an OpenVPN server.
     The key is stored in ``keyfile``.
 
     Syntax:
@@ -126,9 +126,9 @@ Generating key material
        --genkey auth-token [keyfile]
 
     *Note:*
-       This file should be kept secret to the server as anyone that
-       access to this file will be to generate auth tokens that the OpenVPN
-       server will accept as valid.
+       This file should be kept secret to the server as anyone that has
+       access to this file will be able to generate auth tokens that the
+       OpenVPN server will accept as valid.
 
 .. include:: renegotiation.rst
 .. include:: tls-options.rst
diff --git a/doc/man-sections/examples.rst b/doc/man-sections/examples.rst
index ecc2a29f..20cc55ef 100644
--- a/doc/man-sections/examples.rst
+++ b/doc/man-sections/examples.rst
@@ -218,7 +218,7 @@ This setting is not persistent.  Please see your operating systems
 documentation how to properly configure IP forwarding, which is also
 persistent through system boots.
 
-If you system is configured with a firewall.  Please see your operating
+If your system is configured with a firewall.  Please see your operating
 systems guide on how to configure the firewall.  You typically want to
 allow traffic coming from and going to the tun/tap adapter OpenVPN is
 configured to use.
diff --git a/doc/man-sections/pkcs11-options.rst b/doc/man-sections/pkcs11-options.rst
index 5495c187..d40ce9ea 100644
--- a/doc/man-sections/pkcs11-options.rst
+++ b/doc/man-sections/pkcs11-options.rst
@@ -52,7 +52,7 @@ PKCS#11 / SmartCard options
      pkcs11-protected-authentication 1
 
 --pkcs11-providers provider
-  Specify a RSA Security Inc. PKCS #11 Cryptographic Token Interface
+  Specify an RSA Security Inc. PKCS #11 Cryptographic Token Interface
   (Cryptoki) providers to load. This option can be used instead of
   ``--cert``, ``--key`` and ``--pkcs12``.
 
diff --git a/doc/man-sections/plugin-options.rst b/doc/man-sections/plugin-options.rst
index 75dfd5c0..20b74edd 100644
--- a/doc/man-sections/plugin-options.rst
+++ b/doc/man-sections/plugin-options.rst
@@ -2,10 +2,10 @@ Plug-in Interface Options
 -------------------------
 
 OpenVPN can be extended by loading external plug-in modules at runtime.  These
-plug-ins must be prebuild and adhere to the OpenVPN Plug-In API.
+plug-ins must be prebuilt and adhere to the OpenVPN Plug-In API.
 
 --plugin args
-  Loads a given plug-in module.  The ``module-name`` need to be the first
+  Loads a given plug-in module.  The ``module-name`` needs to be the first
   argument, indicating the plug-in to load.  The second argument is an
   optional init string which will be passed directly to the plug-in.
   If the init consists of multiple arguments it must be enclosed in
diff --git a/doc/man-sections/protocol-options.rst b/doc/man-sections/protocol-options.rst
index 5bc072af..a5a1253a 100644
--- a/doc/man-sections/protocol-options.rst
+++ b/doc/man-sections/protocol-options.rst
@@ -1,7 +1,7 @@
 Protocol options
 ----------------
-Options in this section affects features available in the OpenVPN wire
-protocol.  Many of these options also defines the encryption options
+Options in this section affect features available in the OpenVPN wire
+protocol.  Many of these options also define the encryption options
 of the data channel in the OpenVPN wire protocol.  These options must be
 configured in a compatible way between both the local and remote side.
 
@@ -9,15 +9,15 @@ configured in a compatible way between both the local and remote side.
   Authenticate data channel packets and (if enabled) ``tls-auth`` control
   channel packets with HMAC using message digest algorithm ``alg``. (The
   default is ``SHA1`` ). HMAC is a commonly used message authentication
-  algorithm (MAC) that uses a data string, a secure hash algorithm, and a
-  key, to produce a digital signature.
+  algorithm (MAC) that uses a data string, a secure hash algorithm and a
+  key to produce a digital signature.
 
   The OpenVPN data channel protocol uses encrypt-then-mac (i.e. first
-  encrypt a packet, then HMAC the resulting ciphertext), which prevents
+  encrypt a packet then HMAC the resulting ciphertext), which prevents
   padding oracle attacks.
 
-  If an AEAD cipher mode (e.g. GCM) is chosen, the specified ``--auth``
-  algorithm is ignored for the data channel, and the authentication method
+  If an AEAD cipher mode (e.g. GCM) is chosen then the specified ``--auth``
+  algorithm is ignored for the data channel and the authentication method
   of the AEAD cipher is used instead. Note that ``alg`` still specifies
   the digest used for ``tls-auth``.
 
@@ -55,7 +55,7 @@ configured in a compatible way between both the local and remote side.
 
 --compress algorithm
   **DEPRECATED** Enable a compression algorithm.  Compression is generally
-  not recommended.  VPN tunnels which uses compression are suspectible to
+  not recommended.  VPN tunnels which use compression are susceptible to
   the VORALCE attack vector.
 
   The ``algorithm`` parameter may be :code:`lzo`, :code:`lz4`, or empty.
@@ -161,7 +161,7 @@ configured in a compatible way between both the local and remote side.
   either specify ``--cipher BF-CBC`` or ``--cipher AES-256-CBC`` and both
   will work.
 
-  Note, for using NCP with a OpenVPN 2.4 peer this list must include the
+  Note for using NCP with an OpenVPN 2.4 peer: This list must include the
   :code:`AES-256-GCM` and :code:`AES-128-GCM` ciphers.
 
   This list is restricted to be 127 chars long after conversion to OpenVPN
diff --git a/doc/man-sections/script-options.rst b/doc/man-sections/script-options.rst
index 280127b1..8ea5b4a7 100644
--- a/doc/man-sections/script-options.rst
+++ b/doc/man-sections/script-options.rst
@@ -67,7 +67,7 @@ SCRIPT HOOKS
   OpenVPN will run command ``cmd`` to validate the username/password
   provided by the client.
 
-  ``cmd`` consists of a path to script (or executable program), optionally
+  ``cmd`` consists of a path to a script (or executable program), optionally
   followed by arguments. The path and arguments may be single- or
   double-quoted and/or escaped using a backslash, and should be separated
   by one or more spaces.
@@ -114,7 +114,7 @@ SCRIPT HOOKS
 --client-connect cmd
   Run command ``cmd`` on client connection.
 
-  ``cmd`` consists of a path to script (or executable program), optionally
+  ``cmd`` consists of a path to a script (or executable program), optionally
   followed by arguments. The path and arguments may be single- or
   double-quoted and/or escaped using a backslash, and should be separated
   by one or more spaces.
@@ -174,7 +174,7 @@ SCRIPT HOOKS
   Run command ``cmd`` when our remote ip-address is initially
   authenticated or changes.
 
-  ``cmd`` consists of a path to script (or executable program), optionally
+  ``cmd`` consists of a path to a script (or executable program), optionally
   followed by arguments. The path and arguments may be single- or
   double-quoted and/or escaped using a backslash, and should be separated
   by one or more spaces.
@@ -200,13 +200,13 @@ SCRIPT HOOKS
   Similarly if *our* IP address changes due to DHCP, we should configure
   our IP address change script (see man page for ``dhcpcd``\(8)) to
   deliver a ``SIGHUP`` or ``SIGUSR1`` signal to OpenVPN. OpenVPN will
-  then reestablish a connection with its most recently authenticated
+  then re-establish a connection with its most recently authenticated
   peer on its new IP address.
 
 --learn-address cmd
   Run command ``cmd`` to validate client virtual addresses or routes.
 
-  ``cmd`` consists of a path to script (or executable program), optionally
+  ``cmd`` consists of a path to a script (or executable program), optionally
   followed by arguments. The path and arguments may be single- or
   double-quoted and/or escaped using a backslash, and should be separated
   by one or more spaces.
@@ -244,7 +244,7 @@ SCRIPT HOOKS
 --route-up cmd
   Run command ``cmd`` after routes are added, subject to ``--route-delay``.
 
-  ``cmd`` consists of a path to script (or executable program), optionally
+  ``cmd`` consists of a path to a script (or executable program), optionally
   followed by arguments. The path and arguments may be single- or
   double-quoted and/or escaped using a backslash, and should be separated
   by one or more spaces.
@@ -255,7 +255,7 @@ SCRIPT HOOKS
 --route-pre-down cmd
   Run command ``cmd`` before routes are removed upon disconnection.
 
-  ``cmd`` consists of a path to script (or executable program), optionally
+  ``cmd`` consists of a path to a script (or executable program), optionally
   followed by arguments. The path and arguments may be single- or
   double-quoted and/or escaped using a backslash, and should be separated
   by one or more spaces.
@@ -316,7 +316,7 @@ SCRIPT HOOKS
   ``cmd`` should return :code:`0` to allow the TLS handshake to proceed,
   or :code:`1` to fail.
 
-  ``cmd`` consists of a path to script (or executable program), optionally
+  ``cmd`` consists of a path to a script (or executable program), optionally
   followed by arguments. The path and arguments may be single- or
   double-quoted and/or escaped using a backslash, and should be separated
   by one or more spaces.
@@ -346,7 +346,7 @@ SCRIPT HOOKS
   Run command ``cmd`` after successful TUN/TAP device open (pre ``--user``
   UID change).
 
-  ``cmd`` consists of a path to script (or executable program), optionally
+  ``cmd`` consists of a path to a script (or executable program), optionally
   followed by arguments. The path and arguments may be single- or
   double-quoted and/or escaped using a backslash, and should be separated
   by one or more spaces.
diff --git a/doc/man-sections/server-options.rst b/doc/man-sections/server-options.rst
index ada387a2..976fe9c7 100644
--- a/doc/man-sections/server-options.rst
+++ b/doc/man-sections/server-options.rst
@@ -18,13 +18,13 @@ fast hardware. SSL/TLS authentication must be used in this mode.
 
   After successful user/password authentication, the OpenVPN server will
   with this option generate a temporary authentication token and push that
-  to client. On the following renegotiations, the OpenVPN client will pass
+  to the client. On the following renegotiations, the OpenVPN client will pass
   this token instead of the users password. On the server side the server
   will do the token authentication internally and it will NOT do any
   additional authentications against configured external user/password
   authentication mechanisms.
 
-  The tokens implemented by this mechanism include a initial timestamp and
+  The tokens implemented by this mechanism include an initial timestamp and
   a renew timestamp and are secured by HMAC.
 
   The ``lifetime`` argument defines how long the generated token is valid.
@@ -39,7 +39,7 @@ fast hardware. SSL/TLS authentication must be used in this mode.
   time, while at the same time permitting much longer token lifetimes for
   active clients.
 
-  This feature is useful for environments which is configured to use One
+  This feature is useful for environments which are configured to use One
   Time Passwords (OTP) as part of the user/password authentications and
   that authentication mechanism does not implement any auth-token support.
 
@@ -49,12 +49,12 @@ fast hardware. SSL/TLS authentication must be used in this mode.
   verification suceeds or fails.
 
   This option postpones this decision to the external authentication
-  methods and check the validity of the account and do other checks.
+  methods and checks the validity of the account and do other checks.
 
-  In this mode the environment will have a session\_id variable that hold
-  the session id from auth-gen-token. Also a environment variable
-  session\_state is present. This variable tells whether the auth-token
-  has succeeded or not. It can have the following values:
+  In this mode the environment will have a ``session_id`` variable that
+  holds the session id from auth-gen-token. Also an environment variable
+  ``session_state`` is present. This variable indicates whether the
+  auth-token has succeeded or not. It can have the following values:
 
   :code:`Initial`
       No token from client.
@@ -69,9 +69,9 @@ fast hardware. SSL/TLS authentication must be used in this mode.
       Token is invalid (failed HMAC or wrong length)
 
   :code:`AuthenticatedEmptyUser` / :code:`ExpiredEmptyUser`
-      The token is not valid with the username send from the client but
-      would be valid (or expired) if we assume an  empty  username was
-      used instead.  These two  cases are a workaround for behaviour in
+      The token is not valid with the username sent from the client but
+      would be valid (or expired) if we assume an empty username was
+      used instead.  These two cases are a workaround for behaviour in
       OpenVPN 3.  If this workaround is not needed these two cases should
       be handled in the same way as :code:`Invalid`.
 
@@ -86,16 +86,16 @@ fast hardware. SSL/TLS authentication must be used in this mode.
   password from a script).
 
 --auth-gen-token-secret file
-  Specifies a file that hold a secret for the HMAC used in
+  Specifies a file that holds a secret for the HMAC used in
   ``--auth-gen-token`` If ``file`` is not present OpenVPN will generate a
   random secret on startup. This file should be used if auth-token should
-  valid after restarting a server or if client should be able to roam
-  between multiple OpenVPN server with their auth-token.
+  validate after restarting a server or if client should be able to roam
+  between multiple OpenVPN servers with their auth-token.
 
 --auth-user-pass-optional
   Allow connections by clients that do not specify a username/password.
   Normally, when ``--auth-user-pass-verify`` or
-  ``--management-client-auth`` is specified (or an authentication plugin
+  ``--management-client-auth`` are specified (or an authentication plugin
   module), the OpenVPN server daemon will require connecting clients to
   specify a username and password. This option makes the submission of a
   username/password by clients optional, passing the responsibility to the
@@ -626,8 +626,8 @@ fast hardware. SSL/TLS authentication must be used in this mode.
     tls-server
 
 --stale-routes-check args
-  Remove routes haven't had activity for ``n`` seconds (i.e. the ageing
-  time).  This check is ran every ``t`` seconds (i.e. check interval).
+  Remove routes which haven't had activity for ``n`` seconds (i.e. the ageing
+  time).  This check is run every ``t`` seconds (i.e. check interval).
 
   Valid syntax:
   ::
@@ -650,7 +650,7 @@ fast hardware. SSL/TLS authentication must be used in this mode.
   Possible ``mode`` options are:
 
   :code:`none`
-      A client certificate is not required. the client need to
+      A client certificate is not required. the client needs to
       authenticate using username/password only. Be aware that using this
       directive is less secure than requiring certificates from all
       clients.
@@ -675,7 +675,7 @@ fast hardware. SSL/TLS authentication must be used in this mode.
       script could potentially compromise the security of your VPN.
 
   :code:`require`
-      This is the default option. A client is required topresent a
+      This is the default option. A client is required to present a
       certificate, otherwise VPN access is refused.
 
   If you don't use this directive (or use ``--verify-client-cert require``)
@@ -712,7 +712,7 @@ fast hardware. SSL/TLS authentication must be used in this mode.
   OpenVPN accepts any Ethernet frame and does not perform any special
   processing for VLAN-tagged packets.
 
-  The option can only be activated in ``--dev tap mode``.
+  This option can only be activated in ``--dev tap mode``.
 
 --vlan-accept args
   Configure the VLAN tagging policy for the server TAP device.
diff --git a/doc/man-sections/signals.rst b/doc/man-sections/signals.rst
index fce43d84..63611b3c 100644
--- a/doc/man-sections/signals.rst
+++ b/doc/man-sections/signals.rst
@@ -20,7 +20,7 @@ SIGNALS
     This signal, when combined with ``--persist-remote-ip``, may be sent
     when the underlying parameters of the host's network interface change
     such as when the host is a DHCP client and is assigned a new IP address.
-    See ``--ipchange`` above for more information.
+    See ``--ipchange`` for more information.
 
 :code:`SIGUSR2`
     Causes OpenVPN to display its current statistics (to the syslog file if
diff --git a/doc/man-sections/tls-options.rst b/doc/man-sections/tls-options.rst
index bb8fc986..92b832cd 100644
--- a/doc/man-sections/tls-options.rst
+++ b/doc/man-sections/tls-options.rst
@@ -81,7 +81,7 @@ certificates and keys: https://github.com/OpenVPN/easy-rsa
   ``openssl crl`` and ``X509_LOOKUP_hash_dir()``\(3)
   for more information.
 
-  Similarly to the ``--crl-verify`` option CRLs are not mandatory -
+  Similar to the ``--crl-verify`` option, CRLs are not mandatory -
   OpenVPN will log the usual warning in the logs if the relevant CRL is
   missing, but the connection will be allowed.
 
@@ -491,11 +491,11 @@ certificates and keys: https://github.com/OpenVPN/easy-rsa
   Exit on TLS negotiation failure.
 
 --tls-export-cert directory
-  Store the certificates the clients uses upon connection to this
+  Store the certificates the clients use upon connection to this
   directory. This will be done before ``--tls-verify`` is called. The
   certificates will use a temporary name and will be deleted when the
   tls-verify script returns. The file name used for the certificate is
-  available via the peer\_cert environment variable.
+  available via the ``peer_cert`` environment variable.
 
 --tls-server
   Enable TLS and assume server role during TLS handshake. Note that
diff --git a/doc/man-sections/unsupported-options.rst b/doc/man-sections/unsupported-options.rst
index ae7c1bcc..67d3f54e 100644
--- a/doc/man-sections/unsupported-options.rst
+++ b/doc/man-sections/unsupported-options.rst
@@ -2,7 +2,7 @@
 UNSUPPORTED OPTIONS
 ===================
 
-Options listed in this section has been removed from OpenVPN and is no
+Options listed in this section have been removed from OpenVPN and are no
 longer supported
 
 --client-cert-not-required
@@ -21,7 +21,7 @@ longer supported
   Removed in OpenVPN 2.5.  This option should not be used as it weakens the
   VPN tunnel security.
 
---no-reply
+--no-replay
   Removed in OpenVPN 2.5.  This option should not be used as it weakens the
   VPN tunnel security.
 
diff --git a/doc/man-sections/vpn-network-options.rst b/doc/man-sections/vpn-network-options.rst
index d75cf540..894df367 100644
--- a/doc/man-sections/vpn-network-options.rst
+++ b/doc/man-sections/vpn-network-options.rst
@@ -91,7 +91,7 @@ routing.
 --dhcp-option args
   Set additional network settings via DHCP.  On Windows, this is parsed by
   the ``tap-windows6`` or ``wintun`` driver.  On other platforms these
-  options can be picked up by a ``--up`` script or plug-in if it has been
+  options can be picked up by an ``--up`` script or plug-in if it has been
   pushed by the OpenVPN server.  The option will then be saved in the
   client's environment before the ``--up`` script is called, under the name
   :code:`foreign_option_{n}`.
@@ -475,7 +475,7 @@ routing.
 
   The MTU (Maximum Transmission Units) is the maximum datagram size in
   bytes that can be sent unfragmented over a particular network path.
-  OpenVPN requires that packets on the control or data channels be sent
+  OpenVPN requires that packets on the control and data channels be sent
   unfragmented.
 
   MTU problems often manifest themselves as connections which hang during
diff --git a/doc/man-sections/windows-options.rst b/doc/man-sections/windows-options.rst
index 5ae7116c..72424d6b 100644
--- a/doc/man-sections/windows-options.rst
+++ b/doc/man-sections/windows-options.rst
@@ -231,7 +231,7 @@ Windows-Specific Options
   directive is not specified, OpenVPN will use the SystemRoot environment
   variable.
 
-  This option have changed behaviour in OpenVPN 2.3. Earlier you had to
+  This option has changed behaviour since OpenVPN 2.3. Earlier you had to
   define ``--win-sys env`` to use the SystemRoot environment variable,
   otherwise it defaulted to :code:`C:\\WINDOWS`. It is not needed to use
   the ``env`` keyword any more, and it will just be ignored. A warning is
@@ -239,7 +239,7 @@ Windows-Specific Options
 
 --windows-driver drv
   Specifies which tun driver to use. Values are :code:`tap-windows6`
-  (default) and :code:`wintun`.  This is Windows-only option.
+  (default) and :code:`wintun`.  This is a Windows-only option.
   :code:`wintun`" requires ``--dev tun`` and the OpenVPN process to run
   elevated, or be invoked using the Interactive Service.
 
-- 
2.26.0


