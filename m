From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Fri, 18 Aug 2023 13:16:17 +0000
In-Reply-To: <gerrit.1692364556000.I4f29953b91cf8e8daf2c9503da44073ad96d0ff5@...2715...>
References: <gerrit.1692364556000.I4f29953b91cf8e8daf2c9503da44073ad96d0ff5@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <26073300ad28c5433cc5c2a125b91a3e40eac0d9-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="65ATHCFRy0s="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Remove ability to
 use configurations without TLS by default
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--65ATHCFRy0s=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,=20

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/325?usp=3Demail

to look at the new patch set (#2).


Change subject: Remove ability to use configurations without TLS by default
......................................................................

Remove ability to use configurations without TLS by default

OpenVPN 2.6 already warned about this feature being removed. OpenVPN
2.7 will with this change no longer accept these configurations without
having a --allow-deprecated-insecure-static-crypto added to the command
line or the configuration itself. This will server as a last and final
warning for people who missed the warning message in OpenVPN 2.6.

This commit also removes the documentation for --secret and the static key
mode.

Change-Id: I4f29953b91cf8e8daf2c9503da44073ad96d0ff5
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M Changes.rst
M doc/man-sections/encryption-options.rst
M doc/man-sections/inline-files.rst
M doc/man-sections/link-options.rst
M doc/man-sections/protocol-options.rst
M doc/man-sections/server-options.rst
M doc/man-sections/tls-options.rst
M src/openvpn/options.c
M src/openvpn/options.h
M tests/t_lpback.sh
10 files changed, 64 insertions(+), 83 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/25/325/2

diff --git a/Changes.rst b/Changes.rst
index 77bcef2..3676dce 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -1,3 +1,15 @@
+Overview of changes in 2.7
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
+``secret`` support has been removed by default.
+    static key mode (non-TLS) is no longer considered "good and secure eno=
ugh"
+    for today's requirements.  Use TLS mode instead.  If deploying a PKI CA
+    is considered "too complicated", using ``--peer-fingerprint`` makes
+    TLS mode about as easy as using ``--secret``.
+
+    This mode can still be enabled by using
+    ``--allow-deprecated-insecure-static-crypto`` but will be removed in
+    OpenVPN 2.8.
+
 Overview of changes in 2.6
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

diff --git a/doc/man-sections/encryption-options.rst b/doc/man-sections/enc=
ryption-options.rst
index abc73d9..3b26782 100644
--- a/doc/man-sections/encryption-options.rst
+++ b/doc/man-sections/encryption-options.rst
@@ -69,20 +69,20 @@
      $ openvpn --tls-crypt-v2 v2crypt-server.key --genkey tls-crypt-v2-cli=
ent v2crypt-client-1.key

   * Generating *Shared Secret Keys*
-    Generate a shared secret, for use with the ``--secret``, ``--tls-auth``
+    Generate a shared secret, for use with the ``--tls-auth``
     or ``--tls-crypt`` options.

     Syntax:
     ::

-       $ openvpn --genkey secret|tls-crypt|tls-auth keyfile
+       $ openvpn --genkey tls-crypt|tls-auth keyfile

-    The key is saved in ``keyfile``. All three variants (``--secret``,
-    ``tls-crypt`` and ``tls-auth``) generate the same type of key. The
-    aliases are added for convenience.
+    The key is saved in ``keyfile``. Both variants (``tls-crypt`` and
+    ``tls-auth``) generate the same type of key. The aliases are added for
+    convenience.

-    If using this for ``--secret``, this file must be shared with the peer
-    over a pre-existing secure channel such as ``scp``\(1).
+    This file must be shared with the peer over a pre-existing secure
+    channel such as ``scp``\(1).

   * Generating *TLS Crypt v2 Server key*
     Generate a ``--tls-crypt-v2`` key to be used by an OpenVPN server.
diff --git a/doc/man-sections/inline-files.rst b/doc/man-sections/inline-fi=
les.rst
index 01e4a84..f46301e 100644
--- a/doc/man-sections/inline-files.rst
+++ b/doc/man-sections/inline-files.rst
@@ -3,7 +3,7 @@

 OpenVPN allows including files in the main configuration for the ``--ca``,
 ``--cert``, ``--dh``, ``--extra-certs``, ``--key``, ``--pkcs12``,
-``--secret``, ``--crl-verify``, ``--http-proxy-user-pass``, ``--tls-auth``,
+``--crl-verify``, ``--http-proxy-user-pass``, ``--tls-auth``,
 ``--auth-gen-token-secret``, ``--peer-fingerprint``, ``--tls-crypt``,
 ``--tls-crypt-v2`` and ``--verify-hash`` options.

diff --git a/doc/man-sections/link-options.rst b/doc/man-sections/link-opti=
ons.rst
index 14e76b4..c3d35b1 100644
--- a/doc/man-sections/link-options.rst
+++ b/doc/man-sections/link-options.rst
@@ -226,10 +226,7 @@
   Ping remote over the TCP/UDP control channel if no packets have been
   sent for at least ``n`` seconds (specify ``--ping`` on both peers to
   cause ping packets to be sent in both directions since OpenVPN ping
-  packets are not echoed like IP ping packets). When used in one of
-  OpenVPN's secure modes (where ``--secret``, ``--tls-server`` or
-  ``--tls-client`` is specified), the ping packet will be
-  cryptographically secure.
+  packets are not echoed like IP ping packets).

   This option has two intended uses:

@@ -428,8 +425,7 @@
   received by the prior session.

   This option only makes sense when replay protection is enabled (the
-  default) and you are using either ``--secret`` (shared-secret key mode)
-  or TLS mode with ``--tls-auth``.
+  default) and you are using TLS mode with ``--tls-auth``.

 --session-timeout n
   Raises :code:`SIGTERM` for the client instance after ``n`` seconds since
diff --git a/doc/man-sections/protocol-options.rst b/doc/man-sections/proto=
col-options.rst
index 8134157..cac09e4 100644
--- a/doc/man-sections/protocol-options.rst
+++ b/doc/man-sections/protocol-options.rst
@@ -73,9 +73,7 @@
   configured on the data channel, however, later versions usually
   ignored this directive in favour of a negotiated cipher.
   Starting with 2.6.0, this option is always ignored in TLS mode
-  when it comes to configuring the cipher and will only control the
-  cipher for ``--secret`` pre-shared-key mode (note: this mode is
-  deprecated and strictly not recommended).
+  when it comes to configuring the cipher.

   If you wish to specify the cipher to use on the data channel,
   please see ``--data-ciphers`` (for regular negotiation) and
@@ -182,7 +180,7 @@

 --key-direction
   Alternative way of specifying the optional direction parameter for the
-  ``--tls-auth`` and ``--secret`` options. Useful when using inline files
+  ``--tls-auth`` option. Useful when using inline files
   (See section on inline files).

 --data-ciphers cipher-list
@@ -234,55 +232,6 @@
   have been configured with ``--enable-small``
   (typically used on routers or other embedded devices).

---secret args
-  **DEPRECATED** Enable Static Key encryption mode (non-TLS). Use pre-shar=
ed secret
-  ``file`` which was generated with ``--genkey``.
-
-  Valid syntaxes:
-  ::
-
-     secret file
-     secret file direction
-
-  The optional ``direction`` parameter enables the use of 4 distinct keys
-  (HMAC-send, cipher-encrypt, HMAC-receive, cipher-decrypt), so that each
-  data flow direction has a different set of HMAC and cipher keys. This
-  has a number of desirable security properties including eliminating
-  certain kinds of DoS and message replay attacks.
-
-  When the ``direction`` parameter is omitted, 2 keys are used
-  bidirectionally, one for HMAC and the other for encryption/decryption.
-
-  The ``direction`` parameter should always be complementary on either
-  side of the connection, i.e. one side should use :code:`0` and the other
-  should use :code:`1`, or both sides should omit it altogether.
-
-  The ``direction`` parameter requires that ``file`` contains a 2048 bit
-  key. While pre-1.5 versions of OpenVPN generate 1024 bit key files, any
-  version of OpenVPN which supports the ``direction`` parameter, will also
-  support 2048 bit key file generation using the ``--genkey`` option.
-
-  Static key encryption mode has certain advantages, the primary being
-  ease of configuration.
-
-  There are no certificates or certificate authorities or complicated
-  negotiation handshakes and protocols. The only requirement is that you
-  have a pre-existing secure channel with your peer (such as ``ssh``) to
-  initially copy the key. This requirement, along with the fact that your
-  key never changes unless you manually generate a new one, makes it
-  somewhat less secure than TLS mode (see below). If an attacker manages
-  to steal your key, everything that was ever encrypted with it is
-  compromised. Contrast that to the perfect forward secrecy features of
-  TLS mode (using Diffie Hellman key exchange), where even if an attacker
-  was able to steal your private key, he would gain no information to help
-  him decrypt past sessions.
-
-  Another advantageous aspect of Static Key encryption mode is that it is
-  a handshake-free protocol without any distinguishing signature or
-  feature (such as a header or protocol handshake sequence) that would
-  mark the ciphertext packets as being generated by OpenVPN. Anyone
-  eavesdropping on the wire would see nothing but random-looking data.
-
 --tran-window n
   Transition window -- our old key can live this many seconds after a new
   a key renegotiation begins (default :code:`3600` seconds). This feature
diff --git a/doc/man-sections/server-options.rst b/doc/man-sections/server-=
options.rst
index 6b9ad21..c1d3dc8 100644
--- a/doc/man-sections/server-options.rst
+++ b/doc/man-sections/server-options.rst
@@ -406,7 +406,7 @@
   Options that will be compared for compatibility include ``dev-type``,
   ``link-mtu``, ``tun-mtu``, ``proto``, ``ifconfig``,
   ``comp-lzo``, ``fragment``, ``keydir``, ``cipher``,
-  ``auth``, ``keysize``, ``secret``, ``no-replay``,
+  ``auth``, ``keysize``, ``no-replay``,
   ``tls-auth``, ``key-method``, ``tls-server``
   and ``tls-client``.

diff --git a/doc/man-sections/tls-options.rst b/doc/man-sections/tls-option=
s.rst
index d51aff7..908a42a 100644
--- a/doc/man-sections/tls-options.rst
+++ b/doc/man-sections/tls-options.rst
@@ -295,8 +295,24 @@
   Older versions (up to OpenVPN 2.3) supported a freeform passphrase file.
   This is no longer supported in newer versions (v2.4+).

-  See the ``--secret`` option for more information on the optional
-  ``direction`` parameter.
+  The optional ``direction`` parameter enables the use of 2 distinct keys
+  (HMAC-send, HMAC-receive), so that each
+  data flow direction has a different HMAC key. This has a number of desir=
able
+  security properties including eliminating certain kinds of DoS and messa=
ge
+  replay attacks.
+
+  When the ``direction`` parameter is omitted, the same key is used
+  bidirectionally.
+
+  The ``direction`` parameter should always be complementary on either
+  side of the connection, i.e. one side should use :code:`0` and the other
+  should use :code:`1`, or both sides should omit it altogether.
+
+  The ``direction`` parameter requires that ``file`` contains a 2048 bit
+  key. While pre-1.5 versions of OpenVPN generate 1024 bit key files, any
+  version of OpenVPN which supports the ``direction`` parameter, will also
+  support 2048 bit key file generation using the ``--genkey`` option.
+

   ``--tls-auth`` is recommended when you are running OpenVPN in a mode
   where it is listening for packets from any IP address, such as when
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index d168163..bce6846 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -532,12 +532,6 @@
     "\n"
     "Data Channel Encryption Options (must be compatible between peers):\n"
     "(These options are meaningful for both Static Key & TLS-mode)\n"
-    "--secret f [d]  : (DEPRECATED) Enable Static Key encryption mode (non=
-TLS).\n"
-    "                  Use shared secret file f, generate with --genkey.\n"
-    "                  The optional d parameter controls key directionalit=
y.\n"
-    "                  If d is specified, use separate keys for each\n"
-    "                  direction, set d=3D0 on one side of the connection,=
\n"
-    "                  and d=3D1 on the other side.\n"
     "--auth alg      : Authenticate packets with HMAC using message\n"
     "                  digest algorithm alg (default=3D%s).\n"
     "                  (usually adds 16 or 20 bytes per packet)\n"
@@ -622,13 +616,11 @@
     "                  and DoS attacks.\n"
     "                  f (required) is a shared-secret key file.\n"
     "                  The optional d parameter controls key directionalit=
y,\n"
-    "                  see --secret option for more info.\n"
     "--tls-crypt key : Add an additional layer of authenticated encryption=
 on top\n"
     "                  of the TLS control channel to hide the TLS certific=
ate,\n"
     "                  provide basic post-quantum security and protect aga=
inst\n"
     "                  attacks on the TLS stack and DoS attacks.\n"
     "                  key (required) provides the pre-shared key file.\n"
-    "                  see --secret option for more info.\n"
     "--tls-crypt-v2 key : For clients: use key as a client-specific tls-cr=
ypt key.\n"
     "                  For servers: use key to decrypt client-specific key=
s.  For\n"
     "                  key generation (--genkey tls-crypt-v2-client): use =
key to\n"
@@ -762,7 +754,7 @@
     "\n"
     "Generate a new key :\n"
     "--genkey secret file   : Generate a new random key of type and write =
to file\n"
-    "                         (for use with --secret, --tls-auth or --tls-=
crypt)."
+    "                         (for use with --tls-auth or --tls-crypt)."
 #ifdef ENABLE_FEATURE_TUN_PERSIST
     "\n"
     "Tun/tap config mode (available with linux 2.4+):\n"
@@ -2837,11 +2829,20 @@

     if (!options->tls_server && !options->tls_client)
     {
-        msg(M_INFO, "DEPRECATION: No tls-client or tls-server option in "
-            "configuration detected. OpenVPN 2.7 will remove the "
+        int msglevel =3D M_USAGE;
+        if (options->allow_deprecated_insecure_static_crypto)
+        {
+            msglevel =3D M_INFO;
+        }
+
+        msg(msglevel, "DEPRECATION: No tls-client or tls-server option in "
+            "configuration detected. OpenVPN 2.8 will remove the "
             "functionality to run a VPN without TLS. "
             "See the examples section in the manual page for "
-            "examples of a similar quick setup with peer-fingerprint.");
+            "examples of a similar quick setup with peer-fingerprint."
+            "OpenVPN 2.7 allow using this configuration when using "
+            "--allow-deprecated-insecure-static-crypto but you should move"
+            "to proper configuration as soon as possible.");
     }

     if (options->ssl_flags & (SSLF_CLIENT_CERT_NOT_REQUIRED|SSLF_CLIENT_CE=
RT_OPTIONAL))
@@ -8550,6 +8551,12 @@
             }
         }
     }
+    else if (streq(p[0], "allow-deprecated-insecure-static-crypto"))
+    {
+        VERIFY_PERMISSION(OPT_P_GENERAL);
+        options->allow_deprecated_insecure_static_crypto =3D true;
+
+    }
     else if (streq(p[0], "genkey") && !p[4])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index f5890b9..33d17ca 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -552,6 +552,7 @@
     /* Cipher parms */
     const char *shared_secret_file;
     bool shared_secret_file_inline;
+    bool allow_deprecated_insecure_static_crypto;
     int key_direction;
     const char *ciphername;
     bool enable_ncp_fallback;      /**< If defined fall back to
diff --git a/tests/t_lpback.sh b/tests/t_lpback.sh
index 482016a..68df2a6 100755
--- a/tests/t_lpback.sh
+++ b/tests/t_lpback.sh
@@ -97,7 +97,7 @@
 for cipher in ${CIPHERS}
 do
     test_start "Testing cipher ${cipher}... "
-    ( "${openvpn}" --test-crypto --secret key.$$ --cipher ${cipher} ) >log=
.$$ 2>&1
+    ( "${openvpn}" --test-crypto --secret key.$$  --allow-deprecated-insec=
ure-static-crypto --cipher ${cipher} ) >log.$$ 2>&1
     test_end $? log.$$
 done


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/325?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4f29953b91cf8e8daf2c9503da44073ad96d0ff5
Gerrit-Change-Number: 325
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--65ATHCFRy0s=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos <strong>uploaded patch set #2</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/325?usp=3Demail">View Chang=
e</a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">Remove ability to use configurations without TLS by default<br><br>Op=
enVPN 2.6 already warned about this feature being removed. OpenVPN<br>2.7 w=
ill with this change no longer accept these configurations without<br>havin=
g a --allow-deprecated-insecure-static-crypto added to the command<br>line =
or the configuration itself. This will server as a last and final<br>warnin=
g for people who missed the warning message in OpenVPN 2.6.<br><br>This com=
mit also removes the documentation for --secret and the static key<br>mode.=
<br><br>Change-Id: I4f29953b91cf8e8daf2c9503da44073ad96d0ff5<br>Signed-off-=
by: Arne Schwabe &lt;arne@...1227...&gt;<br>---<br>M Changes.rst<br>M doc/m=
an-sections/encryption-options.rst<br>M doc/man-sections/inline-files.rst<b=
r>M doc/man-sections/link-options.rst<br>M doc/man-sections/protocol-option=
s.rst<br>M doc/man-sections/server-options.rst<br>M doc/man-sections/tls-op=
tions.rst<br>M src/openvpn/options.c<br>M src/openvpn/options.h<br>M tests/=
t_lpback.sh<br>10 files changed, 64 insertions(+), 83 deletions(-)<br><br><=
/pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/25/325/2</pr=
e><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><=
span>diff --git a/Changes.rst b/Changes.rst</span><br><span>index 77bcef2..=
3676dce 100644</span><br><span>--- a/Changes.rst</span><br><span>+++ b/Chan=
ges.rst</span><br><span>@@ -1,3 +1,15 @@</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+Overview of changes in 2.7</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+``secret`` support has been removed by default.</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    static key mode (non-TLS) is =
no longer considered &quot;good and secure enough&quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    for today&#39;s requirements.  Use =
TLS mode instead.  If deploying a PKI CA</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    is considered &quot;too complicated&quot;, using `=
`--peer-fingerprint`` makes</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    TLS mode about as easy as using ``--secret``.</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    This mode can still be enabled by using</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    ``--allow-deprecated-insecur=
e-static-crypto`` but will be removed in</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    OpenVPN 2.8.</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span> Overview of changes in 2.6</span><br><s=
pan> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D</span><br><span> </span><br><span>diff --git a/doc/man-sections/e=
ncryption-options.rst b/doc/man-sections/encryption-options.rst</span><br><=
span>index abc73d9..3b26782 100644</span><br><span>--- a/doc/man-sections/e=
ncryption-options.rst</span><br><span>+++ b/doc/man-sections/encryption-opt=
ions.rst</span><br><span>@@ -69,20 +69,20 @@</span><br><span>      $ openvp=
n --tls-crypt-v2 v2crypt-server.key --genkey tls-crypt-v2-client v2crypt-cl=
ient-1.key</span><br><span> </span><br><span>   * Generating *Shared Secret=
 Keys*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    Generate a =
shared secret, for use with the ``--secret``, ``--tls-auth``</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    Generate a shared secret, for =
use with the ``--tls-auth``</span><br><span>     or ``--tls-crypt`` options=
.</span><br><span> </span><br><span>     Syntax:</span><br><span>     ::</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
 $ openvpn --genkey secret|tls-crypt|tls-auth keyfile</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+       $ openvpn --genkey tls-crypt|tls-a=
uth keyfile</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    The key is saved in ``keyfile``. All three variants (``--secret=
``,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ``tls-crypt`` =
and ``tls-auth``) generate the same type of key. The</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    aliases are added for convenience.</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    The key is saved in =
``keyfile``. Both variants (``tls-crypt`` and</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    ``tls-auth``) generate the same type of key. =
The aliases are added for</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    convenience.</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    If using this for ``--secret``, this file must be sh=
ared with the peer</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 over a pre-existing secure channel such as ``scp``\(1).</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    This file must be shared with the =
peer over a pre-existing secure</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    channel such as ``scp``\(1).</span><br><span> </span><br><s=
pan>   * Generating *TLS Crypt v2 Server key*</span><br><span>     Generate=
 a ``--tls-crypt-v2`` key to be used by an OpenVPN server.</span><br><span>=
diff --git a/doc/man-sections/inline-files.rst b/doc/man-sections/inline-fi=
les.rst</span><br><span>index 01e4a84..f46301e 100644</span><br><span>--- a=
/doc/man-sections/inline-files.rst</span><br><span>+++ b/doc/man-sections/i=
nline-files.rst</span><br><span>@@ -3,7 +3,7 @@</span><br><span> </span><br=
><span> OpenVPN allows including files in the main configuration for the ``=
--ca``,</span><br><span> ``--cert``, ``--dh``, ``--extra-certs``, ``--key``=
, ``--pkcs12``,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-``--se=
cret``, ``--crl-verify``, ``--http-proxy-user-pass``, ``--tls-auth``,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+``--crl-verify``, ``--htt=
p-proxy-user-pass``, ``--tls-auth``,</span><br><span> ``--auth-gen-token-se=
cret``, ``--peer-fingerprint``, ``--tls-crypt``,</span><br><span> ``--tls-c=
rypt-v2`` and ``--verify-hash`` options.</span><br><span> </span><br><span>=
diff --git a/doc/man-sections/link-options.rst b/doc/man-sections/link-opti=
ons.rst</span><br><span>index 14e76b4..c3d35b1 100644</span><br><span>--- a=
/doc/man-sections/link-options.rst</span><br><span>+++ b/doc/man-sections/l=
ink-options.rst</span><br><span>@@ -226,10 +226,7 @@</span><br><span>   Pin=
g remote over the TCP/UDP control channel if no packets have been</span><br=
><span>   sent for at least ``n`` seconds (specify ``--ping`` on both peers=
 to</span><br><span>   cause ping packets to be sent in both directions sin=
ce OpenVPN ping</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  pack=
ets are not echoed like IP ping packets). When used in one of</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-  OpenVPN&#39;s secure modes (where=
 ``--secret``, ``--tls-server`` or</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-  ``--tls-client`` is specified), the ping packet will be</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-  cryptographically secure=
.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  packets are not =
echoed like IP ping packets).</span><br><span> </span><br><span>   This opt=
ion has two intended uses:</span><br><span> </span><br><span>@@ -428,8 +425=
,7 @@</span><br><span>   received by the prior session.</span><br><span> </=
span><br><span>   This option only makes sense when replay protection is en=
abled (the</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  default) =
and you are using either ``--secret`` (shared-secret key mode)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-  or TLS mode with ``--tls-auth``.=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  default) and you =
are using TLS mode with ``--tls-auth``.</span><br><span> </span><br><span> =
--session-timeout n</span><br><span>   Raises :code:`SIGTERM` for the clien=
t instance after ``n`` seconds since</span><br><span>diff --git a/doc/man-s=
ections/protocol-options.rst b/doc/man-sections/protocol-options.rst</span>=
<br><span>index 8134157..cac09e4 100644</span><br><span>--- a/doc/man-secti=
ons/protocol-options.rst</span><br><span>+++ b/doc/man-sections/protocol-op=
tions.rst</span><br><span>@@ -73,9 +73,7 @@</span><br><span>   configured o=
n the data channel, however, later versions usually</span><br><span>   igno=
red this directive in favour of a negotiated cipher.</span><br><span>   Sta=
rting with 2.6.0, this option is always ignored in TLS mode</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-  when it comes to configuring the ci=
pher and will only control the</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-  cipher for ``--secret`` pre-shared-key mode (note: this mode is<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-  deprecated and stric=
tly not recommended).</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+  when it comes to configuring the cipher.</span><br><span> </span><br><s=
pan>   If you wish to specify the cipher to use on the data channel,</span>=
<br><span>   please see ``--data-ciphers`` (for regular negotiation) and</s=
pan><br><span>@@ -182,7 +180,7 @@</span><br><span> </span><br><span> --key-=
direction</span><br><span>   Alternative way of specifying the optional dir=
ection parameter for the</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-  ``--tls-auth`` and ``--secret`` options. Useful when using inline file=
s</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ``--tls-auth`` o=
ption. Useful when using inline files</span><br><span>   (See section on in=
line files).</span><br><span> </span><br><span> --data-ciphers cipher-list<=
/span><br><span>@@ -234,55 +232,6 @@</span><br><span>   have been configure=
d with ``--enable-small``</span><br><span>   (typically used on routers or =
other embedded devices).</span><br><span> </span><br><span>---secret args</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-  **DEPRECATED** Enable=
 Static Key encryption mode (non-TLS). Use pre-shared secret</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-  ``file`` which was generated with =
``--genkey``.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-  Valid syntaxes:</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-  ::</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-     secret file</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
    secret file direction</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  The optional ``=
direction`` parameter enables the use of 4 distinct keys</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-  (HMAC-send, cipher-encrypt, HMAC-recei=
ve, cipher-decrypt), so that each</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-  data flow direction has a different set of HMAC and cipher ke=
ys. This</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  has a numbe=
r of desirable security properties including eliminating</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-  certain kinds of DoS and message repla=
y attacks.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-  When the ``direction`` paramet=
er is omitted, 2 keys are used</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-  bidirectionally, one for HMAC and the other for encryption/decry=
ption.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-  The ``direction`` parameter should=
 always be complementary on either</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-  side of the connection, i.e. one side should use :code:`0` a=
nd the other</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  should =
use :code:`1`, or both sides should omit it altogether.</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-  The ``direction`` parameter requires that ``file`` contains =
a 2048 bit</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  key. Whil=
e pre-1.5 versions of OpenVPN generate 1024 bit key files, any</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-  version of OpenVPN which support=
s the ``direction`` parameter, will also</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-  support 2048 bit key file generation using the ``--gen=
key`` option.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-  Static key encryption mode =
has certain advantages, the primary being</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-  ease of configuration.</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-  There are no certificates or certificate authorities or complicated</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-  negotiation handshakes =
and protocols. The only requirement is that you</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-  have a pre-existing secure channel with your pe=
er (such as ``ssh``) to</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-  initially copy the key. This requirement, along with the fact that your=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  key never changes u=
nless you manually generate a new one, makes it</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-  somewhat less secure than TLS mode (see below).=
 If an attacker manages</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-  to steal your key, everything that was ever encrypted with it is</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-  compromised. Contrast that=
 to the perfect forward secrecy features of</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-  TLS mode (using Diffie Hellman key exchange), where=
 even if an attacker</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
 was able to steal your private key, he would gain no information to help</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-  him decrypt past sess=
ions.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-  Another advantageous aspect of Stat=
ic Key encryption mode is that it is</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-  a handshake-free protocol without any distinguishing signa=
ture or</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  feature (suc=
h as a header or protocol handshake sequence) that would</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-  mark the ciphertext packets as being g=
enerated by OpenVPN. Anyone</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-  eavesdropping on the wire would see nothing but random-looking data=
.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> --=
tran-window n</span><br><span>   Transition window -- our old key can live =
this many seconds after a new</span><br><span>   a key renegotiation begins=
 (default :code:`3600` seconds). This feature</span><br><span>diff --git a/=
doc/man-sections/server-options.rst b/doc/man-sections/server-options.rst</=
span><br><span>index 6b9ad21..c1d3dc8 100644</span><br><span>--- a/doc/man-=
sections/server-options.rst</span><br><span>+++ b/doc/man-sections/server-o=
ptions.rst</span><br><span>@@ -406,7 +406,7 @@</span><br><span>   Options t=
hat will be compared for compatibility include ``dev-type``,</span><br><spa=
n>   ``link-mtu``, ``tun-mtu``, ``proto``, ``ifconfig``,</span><br><span>  =
 ``comp-lzo``, ``fragment``, ``keydir``, ``cipher``,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-  ``auth``, ``keysize``, ``secret``, ``no-r=
eplay``,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ``auth``,=
 ``keysize``, ``no-replay``,</span><br><span>   ``tls-auth``, ``key-method`=
`, ``tls-server``</span><br><span>   and ``tls-client``.</span><br><span> <=
/span><br><span>diff --git a/doc/man-sections/tls-options.rst b/doc/man-sec=
tions/tls-options.rst</span><br><span>index d51aff7..908a42a 100644</span><=
br><span>--- a/doc/man-sections/tls-options.rst</span><br><span>+++ b/doc/m=
an-sections/tls-options.rst</span><br><span>@@ -295,8 +295,24 @@</span><br>=
<span>   Older versions (up to OpenVPN 2.3) supported a freeform passphrase=
 file.</span><br><span>   This is no longer supported in newer versions (v2=
.4+).</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-  See the ``--secret`` option for more information on the optional</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-  ``direction`` parameter.</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+  The optional ``dire=
ction`` parameter enables the use of 2 distinct keys</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  (HMAC-send, HMAC-receive), so that each=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  data flow directi=
on has a different HMAC key. This has a number of desirable</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+  security properties including eli=
minating certain kinds of DoS and message</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+  replay attacks.</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+  When the ``direction`` parameter is omitted, the same key is used</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+  bidirectionally.</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+  The ``direction`` parameter should always be=
 complementary on either</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+  side of the connection, i.e. one side should use :code:`0` and the o=
ther</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  should use :c=
ode:`1`, or both sides should omit it altogether.</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+  The ``direction`` parameter requires that ``file`` contains a =
2048 bit</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  key. Whil=
e pre-1.5 versions of OpenVPN generate 1024 bit key files, any</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+  version of OpenVPN which suppo=
rts the ``direction`` parameter, will also</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+  support 2048 bit key file generation using the ``-=
-genkey`` option.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span> </span><br><span>   ``--tls-auth`` is recommended when you =
are running OpenVPN in a mode</span><br><span>   where it is listening for =
packets from any IP address, such as when</span><br><span>diff --git a/src/=
openvpn/options.c b/src/openvpn/options.c</span><br><span>index d168163..bc=
e6846 100644</span><br><span>--- a/src/openvpn/options.c</span><br><span>++=
+ b/src/openvpn/options.c</span><br><span>@@ -532,12 +532,6 @@</span><br><s=
pan>     &quot;\n&quot;</span><br><span>     &quot;Data Channel Encryption =
Options (must be compatible between peers):\n&quot;</span><br><span>     &q=
uot;(These options are meaningful for both Static Key &amp; TLS-mode)\n&quo=
t;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &quot;--secret =
f [d]  : (DEPRECATED) Enable Static Key encryption mode (non-TLS).\n&quot;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &quot;            =
      Use shared secret file f, generate with --genkey.\n&quot;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    &quot;                  The o=
ptional d parameter controls key directionality.\n&quot;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    &quot;                  If d is spec=
ified, use separate keys for each\n&quot;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    &quot;                  direction, set d=3D0 on one=
 side of the connection,\n&quot;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    &quot;                  and d=3D1 on the other side.\n&quot;=
</span><br><span>     &quot;--auth alg      : Authenticate packets with HMA=
C using message\n&quot;</span><br><span>     &quot;                  digest=
 algorithm alg (default=3D%s).\n&quot;</span><br><span>     &quot;         =
         (usually adds 16 or 20 bytes per packet)\n&quot;</span><br><span>@=
@ -622,13 +616,11 @@</span><br><span>     &quot;                  and DoS a=
ttacks.\n&quot;</span><br><span>     &quot;                  f (required) i=
s a shared-secret key file.\n&quot;</span><br><span>     &quot;            =
      The optional d parameter controls key directionality,\n&quot;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    &quot;                  s=
ee --secret option for more info.\n&quot;</span><br><span>     &quot;--tls-=
crypt key : Add an additional layer of authenticated encryption on top\n&qu=
ot;</span><br><span>     &quot;                  of the TLS control channel=
 to hide the TLS certificate,\n&quot;</span><br><span>     &quot;          =
        provide basic post-quantum security and protect against\n&quot;</sp=
an><br><span>     &quot;                  attacks on the TLS stack and DoS =
attacks.\n&quot;</span><br><span>     &quot;                  key (required=
) provides the pre-shared key file.\n&quot;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    &quot;                  see --secret option for m=
ore info.\n&quot;</span><br><span>     &quot;--tls-crypt-v2 key : For clien=
ts: use key as a client-specific tls-crypt key.\n&quot;</span><br><span>   =
  &quot;                  For servers: use key to decrypt client-specific k=
eys.  For\n&quot;</span><br><span>     &quot;                  key generati=
on (--genkey tls-crypt-v2-client): use key to\n&quot;</span><br><span>@@ -7=
62,7 +754,7 @@</span><br><span>     &quot;\n&quot;</span><br><span>     &qu=
ot;Generate a new key :\n&quot;</span><br><span>     &quot;--genkey secret =
file   : Generate a new random key of type and write to file\n&quot;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    &quot;                  =
       (for use with --secret, --tls-auth or --tls-crypt).&quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    &quot;                    =
     (for use with --tls-auth or --tls-crypt).&quot;</span><br><span> #ifde=
f ENABLE_FEATURE_TUN_PERSIST</span><br><span>     &quot;\n&quot;</span><br>=
<span>     &quot;Tun/tap config mode (available with linux 2.4+):\n&quot;</=
span><br><span>@@ -2837,11 +2829,20 @@</span><br><span> </span><br><span>  =
   if (!options-&gt;tls_server &amp;&amp; !options-&gt;tls_client)</span><b=
r><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 msg(M_INFO, &quot;DEPRECATION: No tls-client or tls-server option in &quot=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            &quot;co=
nfiguration detected. OpenVPN 2.7 will remove the &quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        int msglevel =3D M_USAGE;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (options-&gt;=
allow_deprecated_insecure_static_crypto)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            msglevel =3D M_INFO;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   msg(msglevel, &quot;DEPRECATION: No tls-client or tls-server option in &=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &q=
uot;configuration detected. OpenVPN 2.8 will remove the &quot;</span><br><s=
pan>             &quot;functionality to run a VPN without TLS. &quot;</span=
><br><span>             &quot;See the examples section in the manual page f=
or &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
&quot;examples of a similar quick setup with peer-fingerprint.&quot;);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;exampl=
es of a similar quick setup with peer-fingerprint.&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            &quot;OpenVPN 2.7 allow us=
ing this configuration when using &quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            &quot;--allow-deprecated-insecure-static-c=
rypto but you should move&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            &quot;to proper configuration as soon as possible.&=
quot;);</span><br><span>     }</span><br><span> </span><br><span>     if (o=
ptions-&gt;ssl_flags &amp; (SSLF_CLIENT_CERT_NOT_REQUIRED|SSLF_CLIENT_CERT_=
OPTIONAL))</span><br><span>@@ -8550,6 +8551,12 @@</span><br><span>         =
    }</span><br><span>         }</span><br><span>     }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    else if (streq(p[0], &quot;allow-de=
precated-insecure-static-crypto&quot;))</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        options-&gt;allow_deprecated_insecure_s=
tatic_crypto =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span>     else if (streq(p[0], &quot;genkey&quot;) &amp;&amp; !p[4])</span=
><br><span>     {</span><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL)=
;</span><br><span>diff --git a/src/openvpn/options.h b/src/openvpn/options.=
h</span><br><span>index f5890b9..33d17ca 100644</span><br><span>--- a/src/o=
penvpn/options.h</span><br><span>+++ b/src/openvpn/options.h</span><br><spa=
n>@@ -552,6 +552,7 @@</span><br><span>     /* Cipher parms */</span><br><sp=
an>     const char *shared_secret_file;</span><br><span>     bool shared_se=
cret_file_inline;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  bool allow_deprecated_insecure_static_crypto;</span><br><span>     int ke=
y_direction;</span><br><span>     const char *ciphername;</span><br><span> =
    bool enable_ncp_fallback;      /**&lt; If defined fall back to</span><b=
r><span>diff --git a/tests/t_lpback.sh b/tests/t_lpback.sh</span><br><span>=
index 482016a..68df2a6 100755</span><br><span>--- a/tests/t_lpback.sh</span=
><br><span>+++ b/tests/t_lpback.sh</span><br><span>@@ -97,7 +97,7 @@</span>=
<br><span> for cipher in ${CIPHERS}</span><br><span> do</span><br><span>   =
  test_start &quot;Testing cipher ${cipher}... &quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    ( &quot;${openvpn}&quot; --test-crypto =
--secret key.$$ --cipher ${cipher} ) &gt;log.$$ 2&gt;&amp;1</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    ( &quot;${openvpn}&quot; --test=
-crypto --secret key.$$  --allow-deprecated-insecure-static-crypto --cipher=
 ${cipher} ) &gt;log.$$ 2&gt;&amp;1</span><br><span>     test_end $? log.$$=
</span><br><span> done</span><br><span> </span><br><span></span><br></pre><=
p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/325?usp=
=3Demail">change 325</a>. To unsubscribe, or for help writing mail filters,=
 visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div=
 itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/325?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4f29953b91cf8e8daf2c9503da4=
4073ad96d0ff5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 325 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--65ATHCFRy0s=--

