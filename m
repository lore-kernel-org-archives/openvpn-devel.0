From: Gert Doering <gert@...1296...>
Date: Mon,  8 Dec 2025 12:42:18 +0100
Message-ID: <20251208114224.10223-1-gert@...1296...>
In-Reply-To: <gerrit.1764771975000.Iee535f1502ab3dcb7bde7f2593c2e122d27d9189@...2715...>
References: <gerrit.1764771975000.Iee535f1502ab3dcb7bde7f2593c2e122d27d9189@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Documentation: Various syntax fixes and
 text improvements
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

From: Frank Lichtenheld <frank@...2641...>

This started as a fix for OpenVPN/openvpn#606 but while
reviewing the documentation referenced from there I
identified more and more issues.

There a few classes of changes in here:
- Fix wrong `...` syntax, which makes no sense in rst.
- Remove some very old references to OpenVPN v1 behavior.
- Fix typos or other small text issues.

Note: The usage of ``...`` vs :code:`...` is very
inconsistent, but fixing that is outside of the scope
of this patch. I have tried to make it at least
locally consistent.

Github: Fixes #606
Change-Id: Iee535f1502ab3dcb7bde7f2593c2e122d27d9189
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1414
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1414
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/doc/man-sections/cipher-negotiation.rst b/doc/man-sections/cipher-negotiation.rst
index 1285e82..1023236 100644
--- a/doc/man-sections/cipher-negotiation.rst
+++ b/doc/man-sections/cipher-negotiation.rst
@@ -30,13 +30,13 @@
 and still had some quirks. Its main goal was "upgrade to AES-256-GCM when possible".
 An OpenVPN 2.4 client that is built against a crypto library that supports AES in GCM
 mode and does not have ``--ncp-disable`` will always announce support for
-`AES-256-GCM` and `AES-128-GCM` to a server by sending :code:`IV_NCP=2`.
+``AES-256-GCM`` and ``AES-128-GCM`` to a server by sending :code:`IV_NCP=2`.
 
 This only causes a problem if ``--ncp-ciphers`` option has been changed from the
 default of :code:`AES-256-GCM:AES-128-GCM` to a value that does not include
-these two ciphers. When an OpenVPN server tries to use `AES-256-GCM` or
-`AES-128-GCM` the connection will then fail. It is therefore recommended to
-always have the `AES-256-GCM` and `AES-128-GCM` ciphers to the ``--ncp-ciphers``
+these two ciphers. When an OpenVPN server tries to use ``AES-256-GCM`` or
+``AES-128-GCM`` the connection will then fail. It is therefore recommended to
+always have the ``AES-256-GCM`` and ``AES-128-GCM`` ciphers to the ``--ncp-ciphers``
 options to avoid this behaviour.
 
 OpenVPN 3 clients
@@ -45,7 +45,7 @@
 do not have a configurable ``--ncp-ciphers`` or ``--data-ciphers`` option. Newer
 versions by default disable legacy AES-CBC, BF-CBC, and DES-CBC ciphers.
 These clients will always announce support for all their supported AEAD ciphers
-(`AES-256-GCM`, `AES-128-GCM` and in newer versions also `Chacha20-Poly1305`).
+(``AES-256-GCM``, ``AES-128-GCM`` and in newer versions also ``Chacha20-Poly1305``).
 
 To support OpenVPN 3.x based clients at least one of these ciphers needs to be
 included in the server's ``--data-ciphers`` option.
@@ -66,12 +66,12 @@
 
 OpenVPN 2.4 server
 ``````````````````
-When a client indicates support for `AES-128-GCM` and `AES-256-GCM`
+When a client indicates support for ``AES-128-GCM`` and ``AES-256-GCM``
 (with ``IV_NCP=2``) an OpenVPN 2.4 server will send the first
 cipher of the ``--ncp-ciphers`` to the OpenVPN client regardless of what
 the cipher is. To emulate the behaviour of an OpenVPN 2.4 client as close
 as possible and have compatibility to a setup that depends on this quirk,
-adding  `AES-128-GCM` and `AES-256-GCM` to the client's ``--data-ciphers``
+adding ``AES-128-GCM`` and ``AES-256-GCM`` to the client's ``--data-ciphers``
 option is required. OpenVPN 2.5+ will only announce the ``IV_NCP=2`` flag if
 those ciphers are present.
 
@@ -90,10 +90,10 @@
 
 Blowfish in CBC mode (BF-CBC) deprecation
 `````````````````````````````````````````
-The ``--cipher`` option defaulted to `BF-CBC` in OpenVPN 2.4 and older
+The ``--cipher`` option defaulted to ``BF-CBC`` in OpenVPN 2.4 and older
 version. The default was never changed to ensure backwards compatibility.
 In OpenVPN 2.5 this behaviour has now been changed so that if the ``--cipher``
-is not explicitly set it does not allow the weak `BF-CBC` cipher any more
+is not explicitly set it does not allow the weak ``BF-CBC`` cipher any more
 and needs to explicitly added as ``--cipher BFC-CBC`` or added to
 ``--data-ciphers``.
 
diff --git a/doc/man-sections/client-options.rst b/doc/man-sections/client-options.rst
index e8523d9..ca4c8e9 100644
--- a/doc/man-sections/client-options.rst
+++ b/doc/man-sections/client-options.rst
@@ -437,8 +437,8 @@
         This may be set by the client UI/GUI using ``--setenv``.
         On Windows systems it is automatically determined by openvpn
         itself.  On other platforms OpenVPN will default to sending
-        the information returned by the `uname()` system call in
-        the `release` field, which is usually the currently running
+        the information returned by the ``uname()`` system call in
+        the ``release`` field, which is usually the currently running
         kernel version.  This is highly system specific, though.
 
   :code:`UV_<name>=<value>`
diff --git a/doc/man-sections/example-fingerprint.rst b/doc/man-sections/example-fingerprint.rst
index 31ca0c1..7bd322d 100644
--- a/doc/man-sections/example-fingerprint.rst
+++ b/doc/man-sections/example-fingerprint.rst
@@ -12,29 +12,26 @@
 ------------
 1. Install openvpn
 
-   Compile from source-code (see `INSTALL` file) or install via a distribution (apt/yum/ports)
+   Compile from source-code (see ``INSTALL`` file) or install via a distribution (apt/yum/ports)
    or via installer (Windows).
 
-2. Generate a self-signed certificate for the server:
-   ::
+2. Generate a self-signed certificate for the server::
 
     openssl req -x509 -newkey ec -pkeyopt ec_paramgen_curve:secp384r1 -keyout server.key -out server.crt -nodes -sha256 -days 3650 -subj '/CN=server'
 
 3. Generate SHA256 fingerprint of the server certificate
 
    Use the OpenSSL command line utility to view the fingerprint of just
-   created certificate:
-   ::
+   created certificate::
 
     openssl x509 -fingerprint -sha256 -in server.crt -noout
 
-   This outputs something similar to:
-   ::
+   This outputs something similar to::
 
      SHA256 Fingerprint=00:11:22:33:44:55:66:77:88:99:aa:bb:cc:dd:ee:ff:00:11:22:33:44:55:66:77:88:99:aa:bb:cc:dd:ee:ff
 
 
-4. Write a server configuration (`server.conf`)::
+4. Write a server configuration (``server.conf``)::
 
     # The server certificate we created in step 1
     cert server.crt
@@ -73,10 +70,8 @@
 5. Add at least one client as described in the client section.
 
 6. Start the server.
-    - On systemd based distributions move `server.crt`, `server.key` and
-      `server.conf` to :code:`/etc/openvpn/server` and start it via systemctl
-
-      ::
+    - On systemd based distributions move ``server.crt``, ``server.key`` and
+      ``server.conf`` to ``/etc/openvpn/server`` and start it via systemctl::
 
           sudo mv server.conf server.key server.crt /etc/openvpn/server
 
@@ -94,8 +89,7 @@
       openssl req -x509 -newkey ec -pkeyopt ec_paramgen_curve:secp384r1 -keyout - -nodes -sha256 -days 3650 -subj '/CN=alice'
 
    This generate a certificate and a key for the client. The output of the command will look
-   something like this:
-   ::
+   something like this::
 
       -----BEGIN PRIVATE KEY-----
       [base64 content]
@@ -107,9 +101,7 @@
 
 
 3. Create a new client configuration file. In this example we will name the file
-   `alice.ovpn`:
-
-   ::
+   ``alice.ovpn``::
 
       # The name of your server to connect to
       remote yourserver.example.net
@@ -146,24 +138,19 @@
 
 4. Generate the fingerprint of the client certificate. For that we will
    let OpenSSL read the client configuration file as the x509 command will
-   ignore anything that is not between the begin and end markers of the certificate:
-
-   ::
+   ignore anything that is not between the begin and end markers of the certificate::
 
       openssl x509 -fingerprint -sha256 -noout -in alice.ovpn
 
-   This will again output something like
-   ::
+   This will again output something like::
 
         SHA256 Fingerprint=ff:ee:dd:cc:bb:aa:99:88:77:66:55:44:33:22:11:00:ff:ee:dd:cc:bb:aa:99:88:77:66:55:44:33:22:11:00
 
-5. Edit the `server.conf` configuration file and add this new client
+5. Edit the ``server.conf`` configuration file and add this new client
    fingerprint as additional line  between :code:`<peer-fingerprint>`
    and :code:`</peer-fingerprint>`
 
-   After adding *two* clients the part of configuration would look like this:
-
-   ::
+   After adding *two* clients the part of configuration would look like this::
 
       <peer-fingerprint>
       ff:ee:dd:cc:bb:aa:99:88:77:66:55:44:33:22:11:00:ff:ee:dd:cc:bb:aa:99:88:77:66:55:44:33:22:11:00
@@ -172,15 +159,13 @@
 
 6. (optional) if the client is an older client that does not support the
    :code:`peer-fingerprint` (e.g. OpenVPN 2.5 and older, OpenVPN Connect 3.3
-   and older), the client config `alice.ovpn` can be modified to still work with
+   and older), the client config ``alice.ovpn`` can be modified to still work with
    these clients.
 
    Remove the line starting with :code:`peer-fingerprint`. Then
    add a new :code:`<ca>` section at the end of the configuration file
-   with the contents of the :code:`server.crt` created in step 2 of the
-   server setup. The end of `alice.ovpn` file should like:
-
-   ::
+   with the contents of the ``server.crt`` created in step 2 of the
+   server setup. The end of ``alice.ovpn`` file should look like::
 
       [...]  # Beginning of the file skipped
       </cert>
diff --git a/doc/man-sections/examples.rst b/doc/man-sections/examples.rst
index 94cc726..80ef2df 100644
--- a/doc/man-sections/examples.rst
+++ b/doc/man-sections/examples.rst
@@ -132,7 +132,7 @@
 
    ping 10.4.0.1
 
-Note: This example use a elliptic curve (`secp384`), which allows
+Note: This example use a elliptic curve (``secp384``), which allows
 ``--dh`` to be set to ``none``.
 
 Example 3: A tunnel with full PKI and TLS-based security
diff --git a/doc/man-sections/protocol-options.rst b/doc/man-sections/protocol-options.rst
index 6eac14c..52ce5a8 100644
--- a/doc/man-sections/protocol-options.rst
+++ b/doc/man-sections/protocol-options.rst
@@ -185,7 +185,7 @@
   :code:`AES-192-CBC`.
 
   Cipher negotiation is enabled in client-server mode only. I.e. if
-  ``--mode`` is set to `server` (server-side, implied by setting
+  ``--mode`` is set to ``server`` (server-side, implied by setting
   ``--server`` ), or if ``--pull`` is specified (client-side, implied by
   setting ``--client``).
 
diff --git a/doc/man-sections/script-options.rst b/doc/man-sections/script-options.rst
index cadd464..58baf1e 100644
--- a/doc/man-sections/script-options.rst
+++ b/doc/man-sections/script-options.rst
@@ -149,7 +149,7 @@
   :code:`auth_pending_file`. The first line must be the timeout in
   seconds, the required method on the second line (e.g. crtext) and
   third line must be the EXTRA as documented in the
-  ``client-pending-auth`` section of `doc/management.txt`.
+  ``client-pending-auth`` section of ``doc/management.txt``.
 
   This directive is designed to enable a plugin-style interface for
   extending OpenVPN's authentication capabilities.
@@ -588,7 +588,7 @@
 
 *--auth-user-pass username*
    Same as Common Name, with one exception:
-   starting with OpenVPN 2.0.1, the username is passed to the
+   The username is passed to the
    :code:`OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY` plugin in its raw form,
    without string remapping.
 
@@ -597,11 +597,9 @@
    a character which will cause the C library isprint() function to
    return true.
 
-*--client-config-dir filename as derived from common name or`username*
-   Alphanumeric, underbar ('\_'), dash ('-'), and dot ('.') except for "."
-   or ".." as standalone strings. As of v2.0.1-rc6, the at ('@') character
-   has been added as well for compatibility with the common name character
-   class.
+*--client-config-dir filename as derived from common name or username*
+   Alphanumeric, underbar ('\_'), dash ('-'), at ('@'), and dot ('.')
+   except for "." or ".." as standalone strings.
 
 *Environmental variable names*
    Alphanumeric or underbar ('\_').
@@ -620,7 +618,7 @@
 Once set, a variable is persisted indefinitely until it is reset by a
 new value or a restart,
 
-As of OpenVPN 2.0-beta12, in server mode, environmental variables set by
+In server mode, environmental variables set by
 OpenVPN are scoped according to the client objects they are associated
 with, so there should not be any issues with scripts having access to
 stale, previously set variables which refer to different client
@@ -861,7 +859,7 @@
 
 :code:`route_ipv6_{parm}_{n}`
     A set of variables which define each IPv6 route to be added, and are
-    set prior to **--up** script execution.
+    set prior to ``--up`` script execution.
 
     ``parm`` will be one of :code:`network`, :code:`gateway` or
     :code:`metric`. ``route_ipv6_network_{n}`` contains :code:`netmask`
@@ -877,9 +875,9 @@
 :code:`route_redirect_gateway_ipv4`
 
 :code:`route_redirect_gateway_ipv6`
-    Set to `1` if the corresponding default gateway should be redirected
-    into the tunnel, and to `2` if also the local LAN segment should be
-    blocked (`block-local`).  Not set otherwise.  Set prior to **--up** script
+    Set to :code:`1` if the corresponding default gateway should be redirected
+    into the tunnel, and to :code:`2` if also the local LAN segment should be
+    blocked (:code:`block-local`).  Not set otherwise.  Set prior to ``--up`` script
     execution.
 
 :code:`script_context`
diff --git a/doc/man-sections/server-options.rst b/doc/man-sections/server-options.rst
index 3760694..370c670 100644
--- a/doc/man-sections/server-options.rst
+++ b/doc/man-sections/server-options.rst
@@ -509,7 +509,7 @@
   ``--rcvbuf``, ``--session-timeout``
 
   Note: using ``--push`` requires OpenVPN to run in ``--mode server`` (or
-  using of one of `--server`, `--server-bridge` helper directives).
+  using of one of ``--server``, ``--server-bridge`` helper directives).
 
 --push-remove opt
   Selectively remove all ``--push`` options matching "opt" from the option
diff --git a/doc/man-sections/signals.rst b/doc/man-sections/signals.rst
index 01e8e5b..35617aa 100644
--- a/doc/man-sections/signals.rst
+++ b/doc/man-sections/signals.rst
@@ -7,7 +7,7 @@
     connections.
 
 :code:`SIGUSR1`
-    Like :code:`SIGHUP``, except don't re-read configuration file, and
+    Like :code:`SIGHUP`, except don't re-read configuration file, and
     possibly don't close and reopen TUN/TAP device, re-read key files,
     preserve local IP address/port, or preserve most recently authenticated
     remote IP address/port based on ``--persist-tun``, ``--persist-local-ip``
diff --git a/doc/man-sections/tls-options.rst b/doc/man-sections/tls-options.rst
index 63cb32f..846dfdd 100644
--- a/doc/man-sections/tls-options.rst
+++ b/doc/man-sections/tls-options.rst
@@ -220,7 +220,7 @@
   Local peer's private key in .pem format or a URI. Use the private key
   which was generated when you built your peer's certificate (see
   ``--cert file`` above). URI is supported only when built with OpenSSL 3.0
-  or later and any required providers are loaded. (See `--cert` for more details).
+  or later and any required providers are loaded. (See ``--cert`` for more details).
 
 --pkcs12 file
   Specify a PKCS #12 file containing local private key, local certificate,
@@ -390,7 +390,7 @@
     by using ``--ecdh-curve``, the groups for ecdh will also be picked
     from this list.
 
-    OpenVPN maps the curve name `secp256r1` to `prime256v1` to allow
+    OpenVPN maps the curve name ``secp256r1`` to ``prime256v1`` to allow
     specifying the same tls-groups option for mbedTLS and OpenSSL.
 
     Warning: this option not only affects elliptic curve certificates
@@ -404,7 +404,7 @@
   The following profiles are supported:
 
   :code:`insecure`
-      Identical for mbed TLS to `legacy`
+      Identical for mbed TLS to :code:`legacy`
 
   :code:`legacy` (default)
       SHA1 and newer, RSA 2048-bit+, any elliptic curve.
@@ -433,7 +433,7 @@
   OpenVPN will migrate to 'preferred' as default in the future. Please
   ensure that your keys already comply.
 
-*WARNING:* ``--tls-ciphers``, ``--tls-ciphersuites`` and ``tls-groups``
+*WARNING:* ``--tls-cipher``, ``--tls-ciphersuites`` and ``tls-groups``
     These options are expert features, which - if used correctly - can
     improve the security of your VPN connection. But it is also easy to
     unwittingly use them to carefully align a gun with your foot, or just
@@ -442,7 +442,7 @@
 --tls-cipher l
   A list ``l`` of allowable TLS ciphers delimited by a colon (":code:`:`").
 
-  These setting can be used to ensure that certain cipher suites are used
+  This setting can be used to ensure that certain cipher suites are used
   (or not used) for the TLS connection. OpenVPN uses TLS to secure the
   control channel, over which the keys that are used to protect the actual
   VPN traffic are exchanged.
@@ -452,7 +452,7 @@
   OpenSSL and/or mbed TLS documentation for details on the cipher list
   interpretation.
 
-  For OpenSSL, the ``--tls-cipher`` is used for TLS 1.2 and below.
+  For OpenSSL, the ``--tls-cipher`` option is used for TLS 1.2 and below.
 
   Use ``--show-tls`` to see a list of TLS ciphers supported by your crypto
   library.
@@ -466,7 +466,7 @@
   Same as ``--tls-cipher`` but for TLS 1.3 and up. mbed TLS has no
   TLS 1.3 support yet and only the ``--tls-cipher`` setting is used.
 
-  The default for `--tls-ciphersuites` is to use the crypto library's
+  The default for ``--tls-ciphersuites`` is to use the crypto library's
   default.
 
 --tls-client
diff --git a/doc/man-sections/virtual-routing-and-forwarding.rst b/doc/man-sections/virtual-routing-and-forwarding.rst
index db5f1ab..bb599fc 100644
--- a/doc/man-sections/virtual-routing-and-forwarding.rst
+++ b/doc/man-sections/virtual-routing-and-forwarding.rst
@@ -35,7 +35,7 @@
       ip link set master vrf_external dev eth0
 
 Any prefixes configured on :code:`eth0` will be moved from the :code`main`
-routing table into routing table `1023`
+routing table into routing table :code:`1023`
 
 
 VRF setup with ifupdown
diff --git a/doc/openvpn.8.rst b/doc/openvpn.8.rst
index 81cfe27..65130b1 100644
--- a/doc/openvpn.8.rst
+++ b/doc/openvpn.8.rst
@@ -161,7 +161,7 @@
 COPYRIGHT
 =========
 
-Copyright (C) 2002-2020 OpenVPN Inc This program is free software; you
+Copyright (C) 2002-2025 OpenVPN Inc This program is free software; you
 can redistribute it and/or modify it under the terms of the GNU General
 Public License version 2 as published by the Free Software Foundation.
 
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 8501693..741f40a 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -4108,8 +4108,8 @@
     show_available_tls_ciphers_list(cipher_list, tls_cert_profile, false);
 
     printf("\n"
-           "Be aware that that whether a cipher suite in this list can actually work\n"
-           "depends on the specific setup of both peers. See the man page entries of\n"
+           "Note: Whether a cipher suite in this list can actually work depends\n"
+           "on the specific setup of both peers. See the man page entries of\n"
            "--tls-cipher and --show-tls for more details.\n\n");
 }
 

