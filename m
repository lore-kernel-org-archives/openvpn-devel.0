From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 3 Dec 2025 14:26:19 +0000
References: <gerrit.1764771975000.Iee535f1502ab3dcb7bde7f2593c2e122d27d9189@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <e30cbb5d62a3e527e79249c10662d5b7f36ada7e-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="jtOb7m7bFTc="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Documentation:
 Various syntax fixes and text improvements
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--jtOb7m7bFTc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1414?usp=3Demail

to review the following change.


Change subject: Documentation: Various syntax fixes and text improvements
......................................................................

Documentation: Various syntax fixes and text improvements

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
---
M doc/man-sections/cipher-negotiation.rst
M doc/man-sections/client-options.rst
M doc/man-sections/example-fingerprint.rst
M doc/man-sections/examples.rst
M doc/man-sections/protocol-options.rst
M doc/man-sections/script-options.rst
M doc/man-sections/server-options.rst
M doc/man-sections/signals.rst
M doc/man-sections/tls-options.rst
M doc/man-sections/virtual-routing-and-forwarding.rst
M doc/openvpn.8.rst
M src/openvpn/ssl.c
12 files changed, 52 insertions(+), 69 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/14/1414/1

diff --git a/doc/man-sections/cipher-negotiation.rst b/doc/man-sections/cip=
her-negotiation.rst
index 1285e82..1023236 100644
--- a/doc/man-sections/cipher-negotiation.rst
+++ b/doc/man-sections/cipher-negotiation.rst
@@ -30,13 +30,13 @@
 and still had some quirks. Its main goal was "upgrade to AES-256-GCM when =
possible".
 An OpenVPN 2.4 client that is built against a crypto library that supports=
 AES in GCM
 mode and does not have ``--ncp-disable`` will always announce support for
-`AES-256-GCM` and `AES-128-GCM` to a server by sending :code:`IV_NCP=3D2`.
+``AES-256-GCM`` and ``AES-128-GCM`` to a server by sending :code:`IV_NCP=
=3D2`.

 This only causes a problem if ``--ncp-ciphers`` option has been changed fr=
om the
 default of :code:`AES-256-GCM:AES-128-GCM` to a value that does not include
-these two ciphers. When an OpenVPN server tries to use `AES-256-GCM` or
-`AES-128-GCM` the connection will then fail. It is therefore recommended to
-always have the `AES-256-GCM` and `AES-128-GCM` ciphers to the ``--ncp-cip=
hers``
+these two ciphers. When an OpenVPN server tries to use ``AES-256-GCM`` or
+``AES-128-GCM`` the connection will then fail. It is therefore recommended=
 to
+always have the ``AES-256-GCM`` and ``AES-128-GCM`` ciphers to the ``--ncp=
-ciphers``
 options to avoid this behaviour.

 OpenVPN 3 clients
@@ -45,7 +45,7 @@
 do not have a configurable ``--ncp-ciphers`` or ``--data-ciphers`` option.=
 Newer
 versions by default disable legacy AES-CBC, BF-CBC, and DES-CBC ciphers.
 These clients will always announce support for all their supported AEAD ci=
phers
-(`AES-256-GCM`, `AES-128-GCM` and in newer versions also `Chacha20-Poly130=
5`).
+(``AES-256-GCM``, ``AES-128-GCM`` and in newer versions also ``Chacha20-Po=
ly1305``).

 To support OpenVPN 3.x based clients at least one of these ciphers needs t=
o be
 included in the server's ``--data-ciphers`` option.
@@ -66,12 +66,12 @@

 OpenVPN 2.4 server
 ``````````````````
-When a client indicates support for `AES-128-GCM` and `AES-256-GCM`
+When a client indicates support for ``AES-128-GCM`` and ``AES-256-GCM``
 (with ``IV_NCP=3D2``) an OpenVPN 2.4 server will send the first
 cipher of the ``--ncp-ciphers`` to the OpenVPN client regardless of what
 the cipher is. To emulate the behaviour of an OpenVPN 2.4 client as close
 as possible and have compatibility to a setup that depends on this quirk,
-adding  `AES-128-GCM` and `AES-256-GCM` to the client's ``--data-ciphers``
+adding ``AES-128-GCM`` and ``AES-256-GCM`` to the client's ``--data-cipher=
s``
 option is required. OpenVPN 2.5+ will only announce the ``IV_NCP=3D2`` fla=
g if
 those ciphers are present.

@@ -90,10 +90,10 @@

 Blowfish in CBC mode (BF-CBC) deprecation
 `````````````````````````````````````````
-The ``--cipher`` option defaulted to `BF-CBC` in OpenVPN 2.4 and older
+The ``--cipher`` option defaulted to ``BF-CBC`` in OpenVPN 2.4 and older
 version. The default was never changed to ensure backwards compatibility.
 In OpenVPN 2.5 this behaviour has now been changed so that if the ``--ciph=
er``
-is not explicitly set it does not allow the weak `BF-CBC` cipher any more
+is not explicitly set it does not allow the weak ``BF-CBC`` cipher any more
 and needs to explicitly added as ``--cipher BFC-CBC`` or added to
 ``--data-ciphers``.

diff --git a/doc/man-sections/client-options.rst b/doc/man-sections/client-=
options.rst
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

   :code:`UV_<name>=3D<value>`
diff --git a/doc/man-sections/example-fingerprint.rst b/doc/man-sections/ex=
ample-fingerprint.rst
index 31ca0c1..7bd322d 100644
--- a/doc/man-sections/example-fingerprint.rst
+++ b/doc/man-sections/example-fingerprint.rst
@@ -12,29 +12,26 @@
 ------------
 1. Install openvpn

-   Compile from source-code (see `INSTALL` file) or install via a distribu=
tion (apt/yum/ports)
+   Compile from source-code (see ``INSTALL`` file) or install via a distri=
bution (apt/yum/ports)
    or via installer (Windows).

-2. Generate a self-signed certificate for the server:
-   ::
+2. Generate a self-signed certificate for the server::

     openssl req -x509 -newkey ec -pkeyopt ec_paramgen_curve:secp384r1 -key=
out server.key -out server.crt -nodes -sha256 -days 3650 -subj '/CN=3Dserve=
r'

 3. Generate SHA256 fingerprint of the server certificate

    Use the OpenSSL command line utility to view the fingerprint of just
-   created certificate:
-   ::
+   created certificate::

     openssl x509 -fingerprint -sha256 -in server.crt -noout

-   This outputs something similar to:
-   ::
+   This outputs something similar to::

      SHA256 Fingerprint=3D00:11:22:33:44:55:66:77:88:99:aa:bb:cc:dd:ee:ff:=
00:11:22:33:44:55:66:77:88:99:aa:bb:cc:dd:ee:ff


-4. Write a server configuration (`server.conf`)::
+4. Write a server configuration (``server.conf``)::

     # The server certificate we created in step 1
     cert server.crt
@@ -73,10 +70,8 @@
 5. Add at least one client as described in the client section.

 6. Start the server.
-    - On systemd based distributions move `server.crt`, `server.key` and
-      `server.conf` to :code:`/etc/openvpn/server` and start it via system=
ctl
-
-      ::
+    - On systemd based distributions move ``server.crt``, ``server.key`` a=
nd
+      ``server.conf`` to ``/etc/openvpn/server`` and start it via systemct=
l::

           sudo mv server.conf server.key server.crt /etc/openvpn/server

@@ -94,8 +89,7 @@
       openssl req -x509 -newkey ec -pkeyopt ec_paramgen_curve:secp384r1 -k=
eyout - -nodes -sha256 -days 3650 -subj '/CN=3Dalice'

    This generate a certificate and a key for the client. The output of the=
 command will look
-   something like this:
-   ::
+   something like this::

       -----BEGIN PRIVATE KEY-----
       [base64 content]
@@ -107,9 +101,7 @@

=20
 3. Create a new client configuration file. In this example we will name th=
e file
-   `alice.ovpn`:
-
-   ::
+   ``alice.ovpn``::

       # The name of your server to connect to
       remote yourserver.example.net
@@ -146,24 +138,19 @@

 4. Generate the fingerprint of the client certificate. For that we will
    let OpenSSL read the client configuration file as the x509 command will
-   ignore anything that is not between the begin and end markers of the ce=
rtificate:
-
-   ::
+   ignore anything that is not between the begin and end markers of the ce=
rtificate::

       openssl x509 -fingerprint -sha256 -noout -in alice.ovpn

-   This will again output something like
-   ::
+   This will again output something like::

         SHA256 Fingerprint=3Dff:ee:dd:cc:bb:aa:99:88:77:66:55:44:33:22:11:=
00:ff:ee:dd:cc:bb:aa:99:88:77:66:55:44:33:22:11:00

-5. Edit the `server.conf` configuration file and add this new client
+5. Edit the ``server.conf`` configuration file and add this new client
    fingerprint as additional line  between :code:`<peer-fingerprint>`
    and :code:`</peer-fingerprint>`

-   After adding *two* clients the part of configuration would look like th=
is:
-
-   ::
+   After adding *two* clients the part of configuration would look like th=
is::

       <peer-fingerprint>
       ff:ee:dd:cc:bb:aa:99:88:77:66:55:44:33:22:11:00:ff:ee:dd:cc:bb:aa:99=
:88:77:66:55:44:33:22:11:00
@@ -172,15 +159,13 @@

 6. (optional) if the client is an older client that does not support the
    :code:`peer-fingerprint` (e.g. OpenVPN 2.5 and older, OpenVPN Connect 3=
.3
-   and older), the client config `alice.ovpn` can be modified to still wor=
k with
+   and older), the client config ``alice.ovpn`` can be modified to still w=
ork with
    these clients.

    Remove the line starting with :code:`peer-fingerprint`. Then
    add a new :code:`<ca>` section at the end of the configuration file
-   with the contents of the :code:`server.crt` created in step 2 of the
-   server setup. The end of `alice.ovpn` file should like:
-
-   ::
+   with the contents of the ``server.crt`` created in step 2 of the
+   server setup. The end of ``alice.ovpn`` file should look like::
=20
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
diff --git a/doc/man-sections/protocol-options.rst b/doc/man-sections/proto=
col-options.rst
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

diff --git a/doc/man-sections/script-options.rst b/doc/man-sections/script-=
options.rst
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
-    blocked (`block-local`).  Not set otherwise.  Set prior to **--up** sc=
ript
+    Set to :code:`1` if the corresponding default gateway should be redire=
cted
+    into the tunnel, and to :code:`2` if also the local LAN segment should=
 be
+    blocked (:code:`block-local`).  Not set otherwise.  Set prior to ``--u=
p`` script
     execution.

 :code:`script_context`
diff --git a/doc/man-sections/server-options.rst b/doc/man-sections/server-=
options.rst
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
     remote IP address/port based on ``--persist-tun``, ``--persist-local-i=
p``
diff --git a/doc/man-sections/tls-options.rst b/doc/man-sections/tls-option=
s.rst
index 63cb32f..846dfdd 100644
--- a/doc/man-sections/tls-options.rst
+++ b/doc/man-sections/tls-options.rst
@@ -220,7 +220,7 @@
   Local peer's private key in .pem format or a URI. Use the private key
   which was generated when you built your peer's certificate (see
   ``--cert file`` above). URI is supported only when built with OpenSSL 3.0
-  or later and any required providers are loaded. (See `--cert` for more d=
etails).
+  or later and any required providers are loaded. (See ``--cert`` for more=
 details).

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
diff --git a/doc/man-sections/virtual-routing-and-forwarding.rst b/doc/man-=
sections/virtual-routing-and-forwarding.rst
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
 =3D=3D=3D=3D=3D=3D=3D=3D=3D

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
-           "Be aware that that whether a cipher suite in this list can act=
ually work\n"
-           "depends on the specific setup of both peers. See the man page =
entries of\n"
+           "Note: Whether a cipher suite in this list can actually work de=
pends\n"
+           "on the specific setup of both peers. See the man page entries =
of\n"
            "--tls-cipher and --show-tls for more details.\n\n");
 }


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1414?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iee535f1502ab3dcb7bde7f2593c2e122d27d9189
Gerrit-Change-Number: 1414
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--jtOb7m7bFTc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1414?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">Documentation: Various syntax fixes and tex=
t improvements<br><br>This started as a fix for OpenVPN/openvpn#606 but whi=
le<br>reviewing the documentation referenced from there I<br>identified mor=
e and more issues.<br><br>There a few classes of changes in here:<br>- Fix =
wrong `...` syntax, which makes no sense in rst.<br>- Remove some very old =
references to OpenVPN v1 behavior.<br>- Fix typos or other small text issue=
s.<br><br>Note: The usage of ``...`` vs :code:`...` is very<br>inconsistent=
, but fixing that is outside of the scope<br>of this patch. I have tried to=
 make it at least<br>locally consistent.<br><br>Github: Fixes #606<br>Chang=
e-Id: Iee535f1502ab3dcb7bde7f2593c2e122d27d9189<br>Signed-off-by: Frank Lic=
htenheld &lt;frank@...2641...&gt;<br>---<br>M doc/man-sections/cipher-negot=
iation.rst<br>M doc/man-sections/client-options.rst<br>M doc/man-sections/e=
xample-fingerprint.rst<br>M doc/man-sections/examples.rst<br>M doc/man-sect=
ions/protocol-options.rst<br>M doc/man-sections/script-options.rst<br>M doc=
/man-sections/server-options.rst<br>M doc/man-sections/signals.rst<br>M doc=
/man-sections/tls-options.rst<br>M doc/man-sections/virtual-routing-and-for=
warding.rst<br>M doc/openvpn.8.rst<br>M src/openvpn/ssl.c<br>12 files chang=
ed, 52 insertions(+), 69 deletions(-)<br><br></pre><pre class=3D"blocks" st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull s=
sh://gerrit.openvpn.net:29418/openvpn refs/changes/14/1414/1</pre><pre styl=
e=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff -=
-git a/doc/man-sections/cipher-negotiation.rst b/doc/man-sections/cipher-ne=
gotiation.rst</span><br><span>index 1285e82..1023236 100644</span><br><span=
>--- a/doc/man-sections/cipher-negotiation.rst</span><br><span>+++ b/doc/ma=
n-sections/cipher-negotiation.rst</span><br><span>@@ -30,13 +30,13 @@</span=
><br><span> and still had some quirks. Its main goal was &quot;upgrade to A=
ES-256-GCM when possible&quot;.</span><br><span> An OpenVPN 2.4 client that=
 is built against a crypto library that supports AES in GCM</span><br><span=
> mode and does not have ``--ncp-disable`` will always announce support for=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-`AES-256-GCM` and `AE=
S-128-GCM` to a server by sending :code:`IV_NCP=3D2`.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+``AES-256-GCM`` and ``AES-128-GCM`` to a =
server by sending :code:`IV_NCP=3D2`.</span><br><span> </span><br><span> Th=
is only causes a problem if ``--ncp-ciphers`` option has been changed from =
the</span><br><span> default of :code:`AES-256-GCM:AES-128-GCM` to a value =
that does not include</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
these two ciphers. When an OpenVPN server tries to use `AES-256-GCM` or</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-`AES-128-GCM` the connect=
ion will then fail. It is therefore recommended to</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-always have the `AES-256-GCM` and `AES-128-GCM=
` ciphers to the ``--ncp-ciphers``</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+these two ciphers. When an OpenVPN server tries to use ``AES=
-256-GCM`` or</span><br><span style=3D"color: hsl(120, 100%, 40%);">+``AES-=
128-GCM`` the connection will then fail. It is therefore recommended to</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+always have the ``AES-2=
56-GCM`` and ``AES-128-GCM`` ciphers to the ``--ncp-ciphers``</span><br><sp=
an> options to avoid this behaviour.</span><br><span> </span><br><span> Ope=
nVPN 3 clients</span><br><span>@@ -45,7 +45,7 @@</span><br><span> do not ha=
ve a configurable ``--ncp-ciphers`` or ``--data-ciphers`` option. Newer</sp=
an><br><span> versions by default disable legacy AES-CBC, BF-CBC, and DES-C=
BC ciphers.</span><br><span> These clients will always announce support for=
 all their supported AEAD ciphers</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-(`AES-256-GCM`, `AES-128-GCM` and in newer versions also `Chach=
a20-Poly1305`).</span><br><span style=3D"color: hsl(120, 100%, 40%);">+(``A=
ES-256-GCM``, ``AES-128-GCM`` and in newer versions also ``Chacha20-Poly130=
5``).</span><br><span> </span><br><span> To support OpenVPN 3.x based clien=
ts at least one of these ciphers needs to be</span><br><span> included in t=
he server&#39;s ``--data-ciphers`` option.</span><br><span>@@ -66,12 +66,12=
 @@</span><br><span> </span><br><span> OpenVPN 2.4 server</span><br><span> =
``````````````````</span><br><span style=3D"color: hsl(0, 100%, 40%);">-Whe=
n a client indicates support for `AES-128-GCM` and `AES-256-GCM`</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+When a client indicates suppor=
t for ``AES-128-GCM`` and ``AES-256-GCM``</span><br><span> (with ``IV_NCP=
=3D2``) an OpenVPN 2.4 server will send the first</span><br><span> cipher o=
f the ``--ncp-ciphers`` to the OpenVPN client regardless of what</span><br>=
<span> the cipher is. To emulate the behaviour of an OpenVPN 2.4 client as =
close</span><br><span> as possible and have compatibility to a setup that d=
epends on this quirk,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
adding  `AES-128-GCM` and `AES-256-GCM` to the client&#39;s ``--data-cipher=
s``</span><br><span style=3D"color: hsl(120, 100%, 40%);">+adding ``AES-128=
-GCM`` and ``AES-256-GCM`` to the client&#39;s ``--data-ciphers``</span><br=
><span> option is required. OpenVPN 2.5+ will only announce the ``IV_NCP=3D=
2`` flag if</span><br><span> those ciphers are present.</span><br><span> </=
span><br><span>@@ -90,10 +90,10 @@</span><br><span> </span><br><span> Blowf=
ish in CBC mode (BF-CBC) deprecation</span><br><span> `````````````````````=
````````````````````</span><br><span style=3D"color: hsl(0, 100%, 40%);">-T=
he ``--cipher`` option defaulted to `BF-CBC` in OpenVPN 2.4 and older</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+The ``--cipher`` option d=
efaulted to ``BF-CBC`` in OpenVPN 2.4 and older</span><br><span> version. T=
he default was never changed to ensure backwards compatibility.</span><br><=
span> In OpenVPN 2.5 this behaviour has now been changed so that if the ``-=
-cipher``</span><br><span style=3D"color: hsl(0, 100%, 40%);">-is not expli=
citly set it does not allow the weak `BF-CBC` cipher any more</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+is not explicitly set it does not=
 allow the weak ``BF-CBC`` cipher any more</span><br><span> and needs to ex=
plicitly added as ``--cipher BFC-CBC`` or added to</span><br><span> ``--dat=
a-ciphers``.</span><br><span> </span><br><span>diff --git a/doc/man-section=
s/client-options.rst b/doc/man-sections/client-options.rst</span><br><span>=
index e8523d9..ca4c8e9 100644</span><br><span>--- a/doc/man-sections/client=
-options.rst</span><br><span>+++ b/doc/man-sections/client-options.rst</spa=
n><br><span>@@ -437,8 +437,8 @@</span><br><span>         This may be set by=
 the client UI/GUI using ``--setenv``.</span><br><span>         On Windows =
systems it is automatically determined by openvpn</span><br><span>         =
itself.  On other platforms OpenVPN will default to sending</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        the information returned by t=
he `uname()` system call in</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        the `release` field, which is usually the currently running</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        the informati=
on returned by the ``uname()`` system call in</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        the ``release`` field, which is usually t=
he currently running</span><br><span>         kernel version.  This is high=
ly system specific, though.</span><br><span> </span><br><span>   :code:`UV_=
&lt;name&gt;=3D&lt;value&gt;`</span><br><span>diff --git a/doc/man-sections=
/example-fingerprint.rst b/doc/man-sections/example-fingerprint.rst</span><=
br><span>index 31ca0c1..7bd322d 100644</span><br><span>--- a/doc/man-sectio=
ns/example-fingerprint.rst</span><br><span>+++ b/doc/man-sections/example-f=
ingerprint.rst</span><br><span>@@ -12,29 +12,26 @@</span><br><span> -------=
-----</span><br><span> 1. Install openvpn</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-   Compile from source-code (see `INS=
TALL` file) or install via a distribution (apt/yum/ports)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+   Compile from source-code (see ``IN=
STALL`` file) or install via a distribution (apt/yum/ports)</span><br><span=
>    or via installer (Windows).</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-2. Generate a self-signed certificate for the =
server:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   ::</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+2. Generate a self-signed ce=
rtificate for the server::</span><br><span> </span><br><span>     openssl r=
eq -x509 -newkey ec -pkeyopt ec_paramgen_curve:secp384r1 -keyout server.key=
 -out server.crt -nodes -sha256 -days 3650 -subj &#39;/CN=3Dserver&#39;</sp=
an><br><span> </span><br><span> 3. Generate SHA256 fingerprint of the serve=
r certificate</span><br><span> </span><br><span>    Use the OpenSSL command=
 line utility to view the fingerprint of just</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-   created certificate:</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-   ::</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+   created certificate::</span><br><span> </span><br><span>    =
 openssl x509 -fingerprint -sha256 -in server.crt -noout</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-   This outputs someth=
ing similar to:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   ::<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+   This outputs some=
thing similar to::</span><br><span> </span><br><span>      SHA256 Fingerpri=
nt=3D00:11:22:33:44:55:66:77:88:99:aa:bb:cc:dd:ee:ff:00:11:22:33:44:55:66:7=
7:88:99:aa:bb:cc:dd:ee:ff</span><br><span> </span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-4. Write a server configuration (`s=
erver.conf`)::</span><br><span style=3D"color: hsl(120, 100%, 40%);">+4. Wr=
ite a server configuration (``server.conf``)::</span><br><span> </span><br>=
<span>     # The server certificate we created in step 1</span><br><span>  =
   cert server.crt</span><br><span>@@ -73,10 +70,8 @@</span><br><span> 5. A=
dd at least one client as described in the client section.</span><br><span>=
 </span><br><span> 6. Start the server.</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    - On systemd based distributions move `server.crt`, `=
server.key` and</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
`server.conf` to :code:`/etc/openvpn/server` and start it via systemctl</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-      ::</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    - On systemd based distributions move ``server.crt``,=
 ``server.key`` and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
      ``server.conf`` to ``/etc/openvpn/server`` and start it via systemctl=
::</span><br><span> </span><br><span>           sudo mv server.conf server.=
key server.crt /etc/openvpn/server</span><br><span> </span><br><span>@@ -94=
,8 +89,7 @@</span><br><span>       openssl req -x509 -newkey ec -pkeyopt ec=
_paramgen_curve:secp384r1 -keyout - -nodes -sha256 -days 3650 -subj &#39;/C=
N=3Dalice&#39;</span><br><span> </span><br><span>    This generate a certif=
icate and a key for the client. The output of the command will look</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-   something like this:</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-   ::</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+   something like this::</span><br><span>=
 </span><br><span>       -----BEGIN PRIVATE KEY-----</span><br><span>      =
 [base64 content]</span><br><span>@@ -107,9 +101,7 @@</span><br><span> </sp=
an><br><span> </span><br><span> 3. Create a new client configuration file. =
In this example we will name the file</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-   `alice.ovpn`:</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   ::</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+   ``alice.ovpn``::</spa=
n><br><span> </span><br><span>       # The name of your server to connect t=
o</span><br><span>       remote yourserver.example.net</span><br><span>@@ -=
146,24 +138,19 @@</span><br><span> </span><br><span> 4. Generate the finger=
print of the client certificate. For that we will</span><br><span>    let O=
penSSL read the client configuration file as the x509 command will</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-   ignore anything that is not=
 between the begin and end markers of the certificate:</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-   ::</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
 ignore anything that is not between the begin and end markers of the certi=
ficate::</span><br><span> </span><br><span>       openssl x509 -fingerprint=
 -sha256 -noout -in alice.ovpn</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-   This will again output something like</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-   ::</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+   This will again output something like:=
:</span><br><span> </span><br><span>         SHA256 Fingerprint=3Dff:ee:dd:=
cc:bb:aa:99:88:77:66:55:44:33:22:11:00:ff:ee:dd:cc:bb:aa:99:88:77:66:55:44:=
33:22:11:00</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-5. Edit the `server.conf` configuration file and add this new clien=
t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+5. Edit the ``serv=
er.conf`` configuration file and add this new client</span><br><span>    fi=
ngerprint as additional line  between :code:`&lt;peer-fingerprint&gt;`</spa=
n><br><span>    and :code:`&lt;/peer-fingerprint&gt;`</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-   After adding *two* cli=
ents the part of configuration would look like this:</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-   ::</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
After adding *two* clients the part of configuration would look like this::=
</span><br><span> </span><br><span>       &lt;peer-fingerprint&gt;</span><b=
r><span>       ff:ee:dd:cc:bb:aa:99:88:77:66:55:44:33:22:11:00:ff:ee:dd:cc:=
bb:aa:99:88:77:66:55:44:33:22:11:00</span><br><span>@@ -172,15 +159,13 @@</=
span><br><span> </span><br><span> 6. (optional) if the client is an older c=
lient that does not support the</span><br><span>    :code:`peer-fingerprint=
` (e.g. OpenVPN 2.5 and older, OpenVPN Connect 3.3</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-   and older), the client config `alice.ovpn` =
can be modified to still work with</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+   and older), the client config ``alice.ovpn`` can be modif=
ied to still work with</span><br><span>    these clients.</span><br><span> =
</span><br><span>    Remove the line starting with :code:`peer-fingerprint`=
. Then</span><br><span>    add a new :code:`&lt;ca&gt;` section at the end =
of the configuration file</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-   with the contents of the :code:`server.crt` created in step 2 of the=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   server setup. The =
end of `alice.ovpn` file should like:</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   ::=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   with the content=
s of the ``server.crt`` created in step 2 of the</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+   server setup. The end of ``alice.ovpn`` fil=
e should look like::</span><br><span> </span><br><span>       [...]  # Begi=
nning of the file skipped</span><br><span>       &lt;/cert&gt;</span><br><s=
pan>diff --git a/doc/man-sections/examples.rst b/doc/man-sections/examples.=
rst</span><br><span>index 94cc726..80ef2df 100644</span><br><span>--- a/doc=
/man-sections/examples.rst</span><br><span>+++ b/doc/man-sections/examples.=
rst</span><br><span>@@ -132,7 +132,7 @@</span><br><span> </span><br><span> =
   ping 10.4.0.1</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-Note: This example use a elliptic curve (`secp384`), which all=
ows</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Note: This examp=
le use a elliptic curve (``secp384``), which allows</span><br><span> ``--dh=
`` to be set to ``none``.</span><br><span> </span><br><span> Example 3: A t=
unnel with full PKI and TLS-based security</span><br><span>diff --git a/doc=
/man-sections/protocol-options.rst b/doc/man-sections/protocol-options.rst<=
/span><br><span>index 6eac14c..52ce5a8 100644</span><br><span>--- a/doc/man=
-sections/protocol-options.rst</span><br><span>+++ b/doc/man-sections/proto=
col-options.rst</span><br><span>@@ -185,7 +185,7 @@</span><br><span>   :cod=
e:`AES-192-CBC`.</span><br><span> </span><br><span>   Cipher negotiation is=
 enabled in client-server mode only. I.e. if</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-  ``--mode`` is set to `server` (server-side, implie=
d by setting</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ``--m=
ode`` is set to ``server`` (server-side, implied by setting</span><br><span=
>   ``--server`` ), or if ``--pull`` is specified (client-side, implied by<=
/span><br><span>   setting ``--client``).</span><br><span> </span><br><span=
>diff --git a/doc/man-sections/script-options.rst b/doc/man-sections/script=
-options.rst</span><br><span>index cadd464..58baf1e 100644</span><br><span>=
--- a/doc/man-sections/script-options.rst</span><br><span>+++ b/doc/man-sec=
tions/script-options.rst</span><br><span>@@ -149,7 +149,7 @@</span><br><spa=
n>   :code:`auth_pending_file`. The first line must be the timeout in</span=
><br><span>   seconds, the required method on the second line (e.g. crtext)=
 and</span><br><span>   third line must be the EXTRA as documented in the</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-  ``client-pending-auth=
`` section of `doc/management.txt`.</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+  ``client-pending-auth`` section of ``doc/management.txt``=
.</span><br><span> </span><br><span>   This directive is designed to enable=
 a plugin-style interface for</span><br><span>   extending OpenVPN&#39;s au=
thentication capabilities.</span><br><span>@@ -588,7 +588,7 @@</span><br><s=
pan> </span><br><span> *--auth-user-pass username*</span><br><span>    Same=
 as Common Name, with one exception:</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-   starting with OpenVPN 2.0.1, the username is passed to th=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   The username is=
 passed to the</span><br><span>    :code:`OPENVPN_PLUGIN_AUTH_USER_PASS_VER=
IFY` plugin in its raw form,</span><br><span>    without string remapping.<=
/span><br><span> </span><br><span>@@ -597,11 +597,9 @@</span><br><span>    =
a character which will cause the C library isprint() function to</span><br>=
<span>    return true.</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-*--client-config-dir filename as derived from common nam=
e or`username*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   Alph=
anumeric, underbar (&#39;\_&#39;), dash (&#39;-&#39;), and dot (&#39;.&#39;=
) except for &quot;.&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-   or &quot;..&quot; as standalone strings. As of v2.0.1-rc6, the at (=
&#39;@&#39;) character</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-   has been added as well for compatibility with the common name character=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   class.</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+*--client-config-dir filename a=
s derived from common name or username*</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+   Alphanumeric, underbar (&#39;\_&#39;), dash (&#39;-&=
#39;), at (&#39;@&#39;), and dot (&#39;.&#39;)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+   except for &quot;.&quot; or &quot;..&quot; as=
 standalone strings.</span><br><span> </span><br><span> *Environmental vari=
able names*</span><br><span>    Alphanumeric or underbar (&#39;\_&#39;).</s=
pan><br><span>@@ -620,7 +618,7 @@</span><br><span> Once set, a variable is =
persisted indefinitely until it is reset by a</span><br><span> new value or=
 a restart,</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-As of OpenVPN 2.0-beta12, in server mode, environmental variables s=
et by</span><br><span style=3D"color: hsl(120, 100%, 40%);">+In server mode=
, environmental variables set by</span><br><span> OpenVPN are scoped accord=
ing to the client objects they are associated</span><br><span> with, so the=
re should not be any issues with scripts having access to</span><br><span> =
stale, previously set variables which refer to different client</span><br><=
span>@@ -861,7 +859,7 @@</span><br><span> </span><br><span> :code:`route_ip=
v6_{parm}_{n}`</span><br><span>     A set of variables which define each IP=
v6 route to be added, and are</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    set prior to **--up** script execution.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    set prior to ``--up`` script executio=
n.</span><br><span> </span><br><span>     ``parm`` will be one of :code:`ne=
twork`, :code:`gateway` or</span><br><span>     :code:`metric`. ``route_ipv=
6_network_{n}`` contains :code:`netmask`</span><br><span>@@ -877,9 +875,9 @=
@</span><br><span> :code:`route_redirect_gateway_ipv4`</span><br><span> </s=
pan><br><span> :code:`route_redirect_gateway_ipv6`</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    Set to `1` if the corresponding default ga=
teway should be redirected</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    into the tunnel, and to `2` if also the local LAN segment should b=
e</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    blocked (`block-=
local`).  Not set otherwise.  Set prior to **--up** script</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    Set to :code:`1` if the correspo=
nding default gateway should be redirected</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    into the tunnel, and to :code:`2` if also the lo=
cal LAN segment should be</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    blocked (:code:`block-local`).  Not set otherwise.  Set prior to =
``--up`` script</span><br><span>     execution.</span><br><span> </span><br=
><span> :code:`script_context`</span><br><span>diff --git a/doc/man-section=
s/server-options.rst b/doc/man-sections/server-options.rst</span><br><span>=
index 3760694..370c670 100644</span><br><span>--- a/doc/man-sections/server=
-options.rst</span><br><span>+++ b/doc/man-sections/server-options.rst</spa=
n><br><span>@@ -509,7 +509,7 @@</span><br><span>   ``--rcvbuf``, ``--sessio=
n-timeout``</span><br><span> </span><br><span>   Note: using ``--push`` req=
uires OpenVPN to run in ``--mode server`` (or</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-  using of one of `--server`, `--server-bridge` hel=
per directives).</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  u=
sing of one of ``--server``, ``--server-bridge`` helper directives).</span>=
<br><span> </span><br><span> --push-remove opt</span><br><span>   Selective=
ly remove all ``--push`` options matching &quot;opt&quot; from the option</=
span><br><span>diff --git a/doc/man-sections/signals.rst b/doc/man-sections=
/signals.rst</span><br><span>index 01e8e5b..35617aa 100644</span><br><span>=
--- a/doc/man-sections/signals.rst</span><br><span>+++ b/doc/man-sections/s=
ignals.rst</span><br><span>@@ -7,7 +7,7 @@</span><br><span>     connections=
.</span><br><span> </span><br><span> :code:`SIGUSR1`</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    Like :code:`SIGHUP``, except don&#39;t =
re-read configuration file, and</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    Like :code:`SIGHUP`, except don&#39;t re-read configuration=
 file, and</span><br><span>     possibly don&#39;t close and reopen TUN/TAP=
 device, re-read key files,</span><br><span>     preserve local IP address/=
port, or preserve most recently authenticated</span><br><span>     remote I=
P address/port based on ``--persist-tun``, ``--persist-local-ip``</span><br=
><span>diff --git a/doc/man-sections/tls-options.rst b/doc/man-sections/tls=
-options.rst</span><br><span>index 63cb32f..846dfdd 100644</span><br><span>=
--- a/doc/man-sections/tls-options.rst</span><br><span>+++ b/doc/man-sectio=
ns/tls-options.rst</span><br><span>@@ -220,7 +220,7 @@</span><br><span>   L=
ocal peer&#39;s private key in .pem format or a URI. Use the private key</s=
pan><br><span>   which was generated when you built your peer&#39;s certifi=
cate (see</span><br><span>   ``--cert file`` above). URI is supported only =
when built with OpenSSL 3.0</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-  or later and any required providers are loaded. (See `--cert` for m=
ore details).</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  or l=
ater and any required providers are loaded. (See ``--cert`` for more detail=
s).</span><br><span> </span><br><span> --pkcs12 file</span><br><span>   Spe=
cify a PKCS #12 file containing local private key, local certificate,</span=
><br><span>@@ -390,7 +390,7 @@</span><br><span>     by using ``--ecdh-curve=
``, the groups for ecdh will also be picked</span><br><span>     from this =
list.</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    OpenVPN maps the curve name `secp256r1` to `prime256v1` to allow</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    OpenVPN maps the cur=
ve name ``secp256r1`` to ``prime256v1`` to allow</span><br><span>     speci=
fying the same tls-groups option for mbedTLS and OpenSSL.</span><br><span> =
</span><br><span>     Warning: this option not only affects elliptic curve =
certificates</span><br><span>@@ -404,7 +404,7 @@</span><br><span>   The fol=
lowing profiles are supported:</span><br><span> </span><br><span>   :code:`=
insecure`</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      Identi=
cal for mbed TLS to `legacy`</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+      Identical for mbed TLS to :code:`legacy`</span><br><span> </=
span><br><span>   :code:`legacy` (default)</span><br><span>       SHA1 and =
newer, RSA 2048-bit+, any elliptic curve.</span><br><span>@@ -433,7 +433,7 =
@@</span><br><span>   OpenVPN will migrate to &#39;preferred&#39; as defaul=
t in the future. Please</span><br><span>   ensure that your keys already co=
mply.</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-*WARNING:* ``--tls-ciphers``, ``--tls-ciphersuites`` and ``tls-groups``</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+*WARNING:* ``--tls-ci=
pher``, ``--tls-ciphersuites`` and ``tls-groups``</span><br><span>     Thes=
e options are expert features, which - if used correctly - can</span><br><s=
pan>     improve the security of your VPN connection. But it is also easy t=
o</span><br><span>     unwittingly use them to carefully align a gun with y=
our foot, or just</span><br><span>@@ -442,7 +442,7 @@</span><br><span> --tl=
s-cipher l</span><br><span>   A list ``l`` of allowable TLS ciphers delimit=
ed by a colon (&quot;:code:`:`&quot;).</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-  These setting can be used to ensure th=
at certain cipher suites are used</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+  This setting can be used to ensure that certain cipher suit=
es are used</span><br><span>   (or not used) for the TLS connection. OpenVP=
N uses TLS to secure the</span><br><span>   control channel, over which the=
 keys that are used to protect the actual</span><br><span>   VPN traffic ar=
e exchanged.</span><br><span>@@ -452,7 +452,7 @@</span><br><span>   OpenSSL=
 and/or mbed TLS documentation for details on the cipher list</span><br><sp=
an>   interpretation.</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-  For OpenSSL, the ``--tls-cipher`` is used for TLS 1.2 a=
nd below.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  For Open=
SSL, the ``--tls-cipher`` option is used for TLS 1.2 and below.</span><br><=
span> </span><br><span>   Use ``--show-tls`` to see a list of TLS ciphers s=
upported by your crypto</span><br><span>   library.</span><br><span>@@ -466=
,7 +466,7 @@</span><br><span>   Same as ``--tls-cipher`` but for TLS 1.3 an=
d up. mbed TLS has no</span><br><span>   TLS 1.3 support yet and only the `=
`--tls-cipher`` setting is used.</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-  The default for `--tls-ciphersuites` is to u=
se the crypto library&#39;s</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+  The default for ``--tls-ciphersuites`` is to use the crypto libra=
ry&#39;s</span><br><span>   default.</span><br><span> </span><br><span> --t=
ls-client</span><br><span>diff --git a/doc/man-sections/virtual-routing-and=
-forwarding.rst b/doc/man-sections/virtual-routing-and-forwarding.rst</span=
><br><span>index db5f1ab..bb599fc 100644</span><br><span>--- a/doc/man-sect=
ions/virtual-routing-and-forwarding.rst</span><br><span>+++ b/doc/man-secti=
ons/virtual-routing-and-forwarding.rst</span><br><span>@@ -35,7 +35,7 @@</s=
pan><br><span>       ip link set master vrf_external dev eth0</span><br><sp=
an> </span><br><span> Any prefixes configured on :code:`eth0` will be moved=
 from the :code`main`</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
routing table into routing table `1023`</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+routing table into routing table :code:`1023`</span><br=
><span> </span><br><span> </span><br><span> VRF setup with ifupdown</span><=
br><span>diff --git a/doc/openvpn.8.rst b/doc/openvpn.8.rst</span><br><span=
>index 81cfe27..65130b1 100644</span><br><span>--- a/doc/openvpn.8.rst</spa=
n><br><span>+++ b/doc/openvpn.8.rst</span><br><span>@@ -161,7 +161,7 @@</sp=
an><br><span> COPYRIGHT</span><br><span> =3D=3D=3D=3D=3D=3D=3D=3D=3D</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-Copyright =
(C) 2002-2020 OpenVPN Inc This program is free software; you</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+Copyright (C) 2002-2025 OpenVPN In=
c This program is free software; you</span><br><span> can redistribute it a=
nd/or modify it under the terms of the GNU General</span><br><span> Public =
License version 2 as published by the Free Software Foundation.</span><br><=
span> </span><br><span>diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c</=
span><br><span>index 8501693..741f40a 100644</span><br><span>--- a/src/open=
vpn/ssl.c</span><br><span>+++ b/src/openvpn/ssl.c</span><br><span>@@ -4108,=
8 +4108,8 @@</span><br><span>     show_available_tls_ciphers_list(cipher_li=
st, tls_cert_profile, false);</span><br><span> </span><br><span>     printf=
(&quot;\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
     &quot;Be aware that that whether a cipher suite in this list can actua=
lly work\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
      &quot;depends on the specific setup of both peers. See the man page e=
ntries of\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
         &quot;Note: Whether a cipher suite in this list can actually work =
depends\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
       &quot;on the specific setup of both peers. See the man page entries =
of\n&quot;</span><br><span>            &quot;--tls-cipher and --show-tls fo=
r more details.\n\n&quot;);</span><br><span> }</span><br><span> </span><br>=
<span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/1414?usp=3Demail">change 1414</a>. To unsubscribe, or for he=
lp writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/setting=
s?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.or=
g/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schem=
a.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/=
c/openvpn/+/1414?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chan=
ge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iee535f1502ab3dcb7bde7f2593c=
2e122d27d9189 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1414 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--jtOb7m7bFTc=--

