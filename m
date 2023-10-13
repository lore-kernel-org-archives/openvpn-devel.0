From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 13 Oct 2023 17:43:55 +0000
In-Reply-To: <gerrit.1692364556000.I4f29953b91cf8e8daf2c9503da44073ad96d0ff5@...2715...>
References: <gerrit.1692364556000.I4f29953b91cf8e8daf2c9503da44073ad96d0ff5@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <72a7a48b3c0b927fc5e81937f173359a328a38e4-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="TzauBlBEj8o="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--TzauBlBEj8o=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/32=
5?usp=3Demail )

Change subject: Remove ability to use configurations without TLS by default
......................................................................

Remove ability to use configurations without TLS by default

OpenVPN 2.6 already warned about this feature being removed. OpenVPN
2.7 will with this change no longer accept these configurations without
having a --allow-deprecated-insecure-static-crypto added to the command
line or the configuration itself. This will serve as a last and final
warning for people who missed the warning message in OpenVPN 2.6.

This commit also removes the documentation for --secret and the static key
mode.

Change-Id: I4f29953b91cf8e8daf2c9503da44073ad96d0ff5
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20231009105832.34762-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27=
194.html
Signed-off-by: Gert Doering <gert@...1296...>
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
10 files changed, 70 insertions(+), 83 deletions(-)




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
index 675fee4..ca26bfe 100644
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

@@ -427,8 +424,7 @@
   received by the prior session.

   This option only makes sense when replay protection is enabled (the
-  default) and you are using either ``--secret`` (shared-secret key mode)
-  or TLS mode with ``--tls-auth``.
+  default) and you are using TLS mode with ``--tls-auth``.

 --session-timeout n
   Raises :code:`SIGTERM` for the client instance after ``n`` seconds since
diff --git a/doc/man-sections/protocol-options.rst b/doc/man-sections/proto=
col-options.rst
index 8134157..948c0c8 100644
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
@@ -234,54 +232,10 @@
   have been configured with ``--enable-small``
   (typically used on routers or other embedded devices).

---secret args
-  **DEPRECATED** Enable Static Key encryption mode (non-TLS). Use pre-shar=
ed secret
-  ``file`` which was generated with ``--genkey``.

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
+--allow-deprecated-insecure-static-crypto
+   **DEPRECATED** This allow using OpenVPN without TLS. This is deprecated
+   and will be removed in OpenVPN 2.8.

 --tran-window n
   Transition window -- our old key can live this many seconds after a new
diff --git a/doc/man-sections/server-options.rst b/doc/man-sections/server-=
options.rst
index 80dc77d..14a9480 100644
--- a/doc/man-sections/server-options.rst
+++ b/doc/man-sections/server-options.rst
@@ -406,7 +406,7 @@
   Options that will be compared for compatibility include ``dev-type``,
   ``link-mtu``, ``tun-mtu``, ``proto``, ``ifconfig``,
   ``comp-lzo``, ``fragment``, ``keydir``, ``cipher``,
-  ``auth``, ``keysize``, ``secret``,
+  ``auth``, ``keysize``,
   ``tls-auth``, ``key-method``, ``tls-server``
   and ``tls-client``.
=20
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
index c6f9ac3..134bb72 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -531,12 +531,6 @@
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
@@ -619,14 +613,12 @@
     "                  control channel to protect against attacks on the T=
LS stack\n"
     "                  and DoS attacks.\n"
     "                  f (required) is a shared-secret key file.\n"
-    "                  The optional d parameter controls key directionalit=
y,\n"
-    "                  see --secret option for more info.\n"
+    "                  The optional d parameter controls key directionalit=
y.\n"
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
@@ -759,8 +751,8 @@
 #endif /* ifdef _WIN32 */
     "\n"
     "Generate a new key :\n"
-    "--genkey secret file   : Generate a new random key of type and write =
to file\n"
-    "                         (for use with --secret, --tls-auth or --tls-=
crypt)."
+    "--genkey tls-auth file   : Generate a new random key of type and writ=
e to file\n"
+    "                         (for use with --tls-auth or --tls-crypt)."
 #ifdef ENABLE_FEATURE_TUN_PERSIST
     "\n"
     "Tun/tap config mode (available with linux 2.4+):\n"
@@ -2823,11 +2815,21 @@

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
+            "OpenVPN 2.7 allows using this configuration when using "
+            "--allow-deprecated-insecure-static-crypto but you should move"
+            "to a proper configuration using TLS as soon as possible."
+            );
     }

     if (options->ssl_flags & (SSLF_CLIENT_CERT_NOT_REQUIRED|SSLF_CLIENT_CE=
RT_OPTIONAL))
@@ -8515,6 +8517,12 @@
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
index 5810fd1..5a37316 100644
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
Gerrit-PatchSet: 5
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--TzauBlBEj8o=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/325?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Remove ability to use configurations without T=
LS by default<br><br>OpenVPN 2.6 already warned about this feature being re=
moved. OpenVPN<br>2.7 will with this change no longer accept these configur=
ations without<br>having a --allow-deprecated-insecure-static-crypto added =
to the command<br>line or the configuration itself. This will serve as a la=
st and final<br>warning for people who missed the warning message in OpenVP=
N 2.6.<br><br>This commit also removes the documentation for --secret and t=
he static key<br>mode.<br><br>Change-Id: I4f29953b91cf8e8daf2c9503da44073ad=
96d0ff5<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>Acked-by:=
 Frank Lichtenheld &lt;frank@...2641...&gt;<br>Message-Id: &lt;202310091058=
32.34762-1-frank@...2641...&gt;<br>URL: https://www.mail-archive.com/openvp=
n-devel@lists.sourceforge.net/msg27194.html<br>Signed-off-by: Gert Doering =
&lt;gert@...1296...&gt;<br>---<br>M Changes.rst<br>M doc/man-sections/encry=
ption-options.rst<br>M doc/man-sections/inline-files.rst<br>M doc/man-secti=
ons/link-options.rst<br>M doc/man-sections/protocol-options.rst<br>M doc/ma=
n-sections/server-options.rst<br>M doc/man-sections/tls-options.rst<br>M sr=
c/openvpn/options.c<br>M src/openvpn/options.h<br>M tests/t_lpback.sh<br>10=
 files changed, 70 insertions(+), 83 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/Changes.rst b/Changes.rst</span><br><span>index 77bcef2..36=
76dce 100644</span><br><span>--- a/Changes.rst</span><br><span>+++ b/Change=
s.rst</span><br><span>@@ -1,3 +1,15 @@</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+Overview of changes in 2.7</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+``secret`` support has been removed by default.</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    static key mode (non-TLS) is no =
longer considered &quot;good and secure enough&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    for today&#39;s requirements.  Use TL=
S mode instead.  If deploying a PKI CA</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    is considered &quot;too complicated&quot;, using ``-=
-peer-fingerprint`` makes</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    TLS mode about as easy as using ``--secret``.</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    This mode can still be enabled by using</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    ``--allow-deprecated-insecure-=
static-crypto`` but will be removed in</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    OpenVPN 2.8.</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span> Overview of changes in 2.6</span><br><spa=
n> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D</span><br><span> </span><br><span>diff --git a/doc/man-sections/encr=
yption-options.rst b/doc/man-sections/encryption-options.rst</span><br><spa=
n>index abc73d9..3b26782 100644</span><br><span>--- a/doc/man-sections/encr=
yption-options.rst</span><br><span>+++ b/doc/man-sections/encryption-option=
s.rst</span><br><span>@@ -69,20 +69,20 @@</span><br><span>      $ openvpn -=
-tls-crypt-v2 v2crypt-server.key --genkey tls-crypt-v2-client v2crypt-clien=
t-1.key</span><br><span> </span><br><span>   * Generating *Shared Secret Ke=
ys*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    Generate a sha=
red secret, for use with the ``--secret``, ``--tls-auth``</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    Generate a shared secret, for use=
 with the ``--tls-auth``</span><br><span>     or ``--tls-crypt`` options.</=
span><br><span> </span><br><span>     Syntax:</span><br><span>     ::</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-       $ =
openvpn --genkey secret|tls-crypt|tls-auth keyfile</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+       $ openvpn --genkey tls-crypt|tls-auth=
 keyfile</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    The key is saved in ``keyfile``. All three variants (``--secret``,=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ``tls-crypt`` and=
 ``tls-auth``) generate the same type of key. The</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    aliases are added for convenience.</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    The key is saved in ``ke=
yfile``. Both variants (``tls-crypt`` and</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    ``tls-auth``) generate the same type of key. The =
aliases are added for</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    convenience.</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    If using this for ``--secret``, this file must be shared=
 with the peer</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ove=
r a pre-existing secure channel such as ``scp``\(1).</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    This file must be shared with the pee=
r over a pre-existing secure</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    channel such as ``scp``\(1).</span><br><span> </span><br><span=
>   * Generating *TLS Crypt v2 Server key*</span><br><span>     Generate a =
``--tls-crypt-v2`` key to be used by an OpenVPN server.</span><br><span>dif=
f --git a/doc/man-sections/inline-files.rst b/doc/man-sections/inline-files=
.rst</span><br><span>index 01e4a84..f46301e 100644</span><br><span>--- a/do=
c/man-sections/inline-files.rst</span><br><span>+++ b/doc/man-sections/inli=
ne-files.rst</span><br><span>@@ -3,7 +3,7 @@</span><br><span> </span><br><s=
pan> OpenVPN allows including files in the main configuration for the ``--c=
a``,</span><br><span> ``--cert``, ``--dh``, ``--extra-certs``, ``--key``, `=
`--pkcs12``,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-``--secre=
t``, ``--crl-verify``, ``--http-proxy-user-pass``, ``--tls-auth``,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+``--crl-verify``, ``--http-p=
roxy-user-pass``, ``--tls-auth``,</span><br><span> ``--auth-gen-token-secre=
t``, ``--peer-fingerprint``, ``--tls-crypt``,</span><br><span> ``--tls-cryp=
t-v2`` and ``--verify-hash`` options.</span><br><span> </span><br><span>dif=
f --git a/doc/man-sections/link-options.rst b/doc/man-sections/link-options=
.rst</span><br><span>index 675fee4..ca26bfe 100644</span><br><span>--- a/do=
c/man-sections/link-options.rst</span><br><span>+++ b/doc/man-sections/link=
-options.rst</span><br><span>@@ -226,10 +226,7 @@</span><br><span>   Ping r=
emote over the TCP/UDP control channel if no packets have been</span><br><s=
pan>   sent for at least ``n`` seconds (specify ``--ping`` on both peers to=
</span><br><span>   cause ping packets to be sent in both directions since =
OpenVPN ping</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  packets=
 are not echoed like IP ping packets). When used in one of</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-  OpenVPN&#39;s secure modes (where ``=
--secret``, ``--tls-server`` or</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-  ``--tls-client`` is specified), the ping packet will be</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-  cryptographically secure.</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+  packets are not ech=
oed like IP ping packets).</span><br><span> </span><br><span>   This option=
 has two intended uses:</span><br><span> </span><br><span>@@ -427,8 +424,7 =
@@</span><br><span>   received by the prior session.</span><br><span> </spa=
n><br><span>   This option only makes sense when replay protection is enabl=
ed (the</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  default) and=
 you are using either ``--secret`` (shared-secret key mode)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-  or TLS mode with ``--tls-auth``.</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+  default) and you are=
 using TLS mode with ``--tls-auth``.</span><br><span> </span><br><span> --s=
ession-timeout n</span><br><span>   Raises :code:`SIGTERM` for the client i=
nstance after ``n`` seconds since</span><br><span>diff --git a/doc/man-sect=
ions/protocol-options.rst b/doc/man-sections/protocol-options.rst</span><br=
><span>index 8134157..948c0c8 100644</span><br><span>--- a/doc/man-sections=
/protocol-options.rst</span><br><span>+++ b/doc/man-sections/protocol-optio=
ns.rst</span><br><span>@@ -73,9 +73,7 @@</span><br><span>   configured on t=
he data channel, however, later versions usually</span><br><span>   ignored=
 this directive in favour of a negotiated cipher.</span><br><span>   Starti=
ng with 2.6.0, this option is always ignored in TLS mode</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-  when it comes to configuring the ciphe=
r and will only control the</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-  cipher for ``--secret`` pre-shared-key mode (note: this mode is</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-  deprecated and strictly=
 not recommended).</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
 when it comes to configuring the cipher.</span><br><span> </span><br><span=
>   If you wish to specify the cipher to use on the data channel,</span><br=
><span>   please see ``--data-ciphers`` (for regular negotiation) and</span=
><br><span>@@ -182,7 +180,7 @@</span><br><span> </span><br><span> --key-dir=
ection</span><br><span>   Alternative way of specifying the optional direct=
ion parameter for the</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
  ``--tls-auth`` and ``--secret`` options. Useful when using inline files</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ``--tls-auth`` opti=
on. Useful when using inline files</span><br><span>   (See section on inlin=
e files).</span><br><span> </span><br><span> --data-ciphers cipher-list</sp=
an><br><span>@@ -234,54 +232,10 @@</span><br><span>   have been configured =
with ``--enable-small``</span><br><span>   (typically used on routers or ot=
her embedded devices).</span><br><span> </span><br><span>---secret args</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-  **DEPRECATED** Enable S=
tatic Key encryption mode (non-TLS). Use pre-shared secret</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-  ``file`` which was generated with ``=
--genkey``.</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-  Valid syntaxes:</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-  ::</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-     secret file</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-     secret file direction</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-  The optional ``direction`` parameter enables the use =
of 4 distinct keys</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  (=
HMAC-send, cipher-encrypt, HMAC-receive, cipher-decrypt), so that each</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-  data flow direction has =
a different set of HMAC and cipher keys. This</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-  has a number of desirable security properties inc=
luding eliminating</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  c=
ertain kinds of DoS and message replay attacks.</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-  When the ``direction`` parameter is omitted, 2 keys are used</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-  bidirectionally, one for HM=
AC and the other for encryption/decryption.</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-  The ``direction`` parameter should always be complementary on either</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-  side of the connection,=
 i.e. one side should use :code:`0` and the other</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-  should use :code:`1`, or both sides should om=
it it altogether.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-  The ``direction`` param=
eter requires that ``file`` contains a 2048 bit</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-  key. While pre-1.5 versions of OpenVPN generate=
 1024 bit key files, any</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-  version of OpenVPN which supports the ``direction`` parameter, will al=
so</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  support 2048 bit =
key file generation using the ``--genkey`` option.</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-  Static key encryption mode has certain advantages, the primary be=
ing</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  ease of configur=
ation.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-  There are no certificates or certi=
ficate authorities or complicated</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-  negotiation handshakes and protocols. The only requirement is=
 that you</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  have a pre=
-existing secure channel with your peer (such as ``ssh``) to</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-  initially copy the key. This requi=
rement, along with the fact that your</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-  key never changes unless you manually generate a new one,=
 makes it</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  somewhat l=
ess secure than TLS mode (see below). If an attacker manages</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-  to steal your key, everything that=
 was ever encrypted with it is</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-  compromised. Contrast that to the perfect forward secrecy featur=
es of</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  TLS mode (usin=
g Diffie Hellman key exchange), where even if an attacker</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-  was able to steal your private key, h=
e would gain no information to help</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-  him decrypt past sessions.</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
  Another advantageous aspect of Static Key encryption mode is that it is</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-  a handshake-free prot=
ocol without any distinguishing signature or</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-  feature (such as a header or protocol handshake se=
quence) that would</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  m=
ark the ciphertext packets as being generated by OpenVPN. Anyone</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-  eavesdropping on the wire woul=
d see nothing but random-looking data.</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+--allow-deprecated-insecure-static-crypto</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+   **DEPRECATED** This allow using=
 OpenVPN without TLS. This is deprecated</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+   and will be removed in OpenVPN 2.8.</span><br><span=
> </span><br><span> --tran-window n</span><br><span>   Transition window --=
 our old key can live this many seconds after a new</span><br><span>diff --=
git a/doc/man-sections/server-options.rst b/doc/man-sections/server-options=
.rst</span><br><span>index 80dc77d..14a9480 100644</span><br><span>--- a/do=
c/man-sections/server-options.rst</span><br><span>+++ b/doc/man-sections/se=
rver-options.rst</span><br><span>@@ -406,7 +406,7 @@</span><br><span>   Opt=
ions that will be compared for compatibility include ``dev-type``,</span><b=
r><span>   ``link-mtu``, ``tun-mtu``, ``proto``, ``ifconfig``,</span><br><s=
pan>   ``comp-lzo``, ``fragment``, ``keydir``, ``cipher``,</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-  ``auth``, ``keysize``, ``secret``,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ``auth``, ``keysize=
``,</span><br><span>   ``tls-auth``, ``key-method``, ``tls-server``</span><=
br><span>   and ``tls-client``.</span><br><span> </span><br><span>diff --gi=
t a/doc/man-sections/tls-options.rst b/doc/man-sections/tls-options.rst</sp=
an><br><span>index d51aff7..908a42a 100644</span><br><span>--- a/doc/man-se=
ctions/tls-options.rst</span><br><span>+++ b/doc/man-sections/tls-options.r=
st</span><br><span>@@ -295,8 +295,24 @@</span><br><span>   Older versions (=
up to OpenVPN 2.3) supported a freeform passphrase file.</span><br><span>  =
 This is no longer supported in newer versions (v2.4+).</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-  See the ``--secret`` =
option for more information on the optional</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-  ``direction`` parameter.</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+  The optional ``direction`` parameter enables=
 the use of 2 distinct keys</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+  (HMAC-send, HMAC-receive), so that each</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+  data flow direction has a different HMAC ke=
y. This has a number of desirable</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+  security properties including eliminating certain kinds of =
DoS and message</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  re=
play attacks.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+  When the ``direction`` =
parameter is omitted, the same key is used</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+  bidirectionally.</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+  The ``direction`` parameter should always be complementary on either</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+  side of the connect=
ion, i.e. one side should use :code:`0` and the other</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  should use :code:`1`, or both sides sho=
uld omit it altogether.</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  The ``directi=
on`` parameter requires that ``file`` contains a 2048 bit</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+  key. While pre-1.5 versions of Open=
VPN generate 1024 bit key files, any</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+  version of OpenVPN which supports the ``direction`` para=
meter, will also</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  s=
upport 2048 bit key file generation using the ``--genkey`` option.</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> </span><br=
><span>   ``--tls-auth`` is recommended when you are running OpenVPN in a m=
ode</span><br><span>   where it is listening for packets from any IP addres=
s, such as when</span><br><span>diff --git a/src/openvpn/options.c b/src/op=
envpn/options.c</span><br><span>index c6f9ac3..134bb72 100644</span><br><sp=
an>--- a/src/openvpn/options.c</span><br><span>+++ b/src/openvpn/options.c<=
/span><br><span>@@ -531,12 +531,6 @@</span><br><span>     &quot;\n&quot;</s=
pan><br><span>     &quot;Data Channel Encryption Options (must be compatibl=
e between peers):\n&quot;</span><br><span>     &quot;(These options are mea=
ningful for both Static Key &amp; TLS-mode)\n&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    &quot;--secret f [d]  : (DEPRECATED) En=
able Static Key encryption mode (non-TLS).\n&quot;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    &quot;                  Use shared secret =
file f, generate with --genkey.\n&quot;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    &quot;                  The optional d parameter cont=
rols key directionality.\n&quot;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    &quot;                  If d is specified, use separate keys=
 for each\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
&quot;                  direction, set d=3D0 on one side of the connection,=
\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &quot;   =
               and d=3D1 on the other side.\n&quot;</span><br><span>     &q=
uot;--auth alg      : Authenticate packets with HMAC using message\n&quot;<=
/span><br><span>     &quot;                  digest algorithm alg (default=
=3D%s).\n&quot;</span><br><span>     &quot;                  (usually adds =
16 or 20 bytes per packet)\n&quot;</span><br><span>@@ -619,14 +613,12 @@</s=
pan><br><span>     &quot;                  control channel to protect again=
st attacks on the TLS stack\n&quot;</span><br><span>     &quot;            =
      and DoS attacks.\n&quot;</span><br><span>     &quot;                 =
 f (required) is a shared-secret key file.\n&quot;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    &quot;                  The optional d par=
ameter controls key directionality,\n&quot;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    &quot;                  see --secret option for m=
ore info.\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  &quot;                  The optional d parameter controls key directional=
ity.\n&quot;</span><br><span>     &quot;--tls-crypt key : Add an additional=
 layer of authenticated encryption on top\n&quot;</span><br><span>     &quo=
t;                  of the TLS control channel to hide the TLS certificate,=
\n&quot;</span><br><span>     &quot;                  provide basic post-qu=
antum security and protect against\n&quot;</span><br><span>     &quot;     =
             attacks on the TLS stack and DoS attacks.\n&quot;</span><br><s=
pan>     &quot;                  key (required) provides the pre-shared key=
 file.\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &qu=
ot;                  see --secret option for more info.\n&quot;</span><br><=
span>     &quot;--tls-crypt-v2 key : For clients: use key as a client-speci=
fic tls-crypt key.\n&quot;</span><br><span>     &quot;                  For=
 servers: use key to decrypt client-specific keys.  For\n&quot;</span><br><=
span>     &quot;                  key generation (--genkey tls-crypt-v2-cli=
ent): use key to\n&quot;</span><br><span>@@ -759,8 +751,8 @@</span><br><spa=
n> #endif /* ifdef _WIN32 */</span><br><span>     &quot;\n&quot;</span><br>=
<span>     &quot;Generate a new key :\n&quot;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    &quot;--genkey secret file   : Generate a new r=
andom key of type and write to file\n&quot;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    &quot;                         (for use with --se=
cret, --tls-auth or --tls-crypt).&quot;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    &quot;--genkey tls-auth file   : Generate a new ran=
dom key of type and write to file\n&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    &quot;                         (for use with --tl=
s-auth or --tls-crypt).&quot;</span><br><span> #ifdef ENABLE_FEATURE_TUN_PE=
RSIST</span><br><span>     &quot;\n&quot;</span><br><span>     &quot;Tun/ta=
p config mode (available with linux 2.4+):\n&quot;</span><br><span>@@ -2823=
,11 +2815,21 @@</span><br><span> </span><br><span>     if (!options-&gt;tls=
_server &amp;&amp; !options-&gt;tls_client)</span><br><span>     {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_INFO, &quot;DEPR=
ECATION: No tls-client or tls-server option in &quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            &quot;configuration detected. O=
penVPN 2.7 will remove the &quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        int msglevel =3D M_USAGE;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        if (options-&gt;allow_deprecated_insecu=
re_static_crypto)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
msglevel =3D M_INFO;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        msg(msglevel, &quot;=
DEPRECATION: No tls-client or tls-server option in &quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            &quot;configuration detec=
ted. OpenVPN 2.8 will remove the &quot;</span><br><span>             &quot;=
functionality to run a VPN without TLS. &quot;</span><br><span>            =
 &quot;See the examples section in the manual page for &quot;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            &quot;examples of a sim=
ilar quick setup with peer-fingerprint.&quot;);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            &quot;examples of a similar quick s=
etup with peer-fingerprint.&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            &quot;OpenVPN 2.7 allows using this configuration=
 when using &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           &quot;--allow-deprecated-insecure-static-crypto but you should m=
ove&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  &quot;to a proper configuration using TLS as soon as possible.&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            );</span><br=
><span>     }</span><br><span> </span><br><span>     if (options-&gt;ssl_fl=
ags &amp; (SSLF_CLIENT_CERT_NOT_REQUIRED|SSLF_CLIENT_CERT_OPTIONAL))</span>=
<br><span>@@ -8515,6 +8517,12 @@</span><br><span>             }</span><br><=
span>         }</span><br><span>     }</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    else if (streq(p[0], &quot;allow-deprecated-insecure=
-static-crypto&quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        VER=
IFY_PERMISSION(OPT_P_GENERAL);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        options-&gt;allow_deprecated_insecure_static_crypto =3D =
true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>     else i=
f (streq(p[0], &quot;genkey&quot;) &amp;&amp; !p[4])</span><br><span>     {=
</span><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span=
>diff --git a/src/openvpn/options.h b/src/openvpn/options.h</span><br><span=
>index 5810fd1..5a37316 100644</span><br><span>--- a/src/openvpn/options.h<=
/span><br><span>+++ b/src/openvpn/options.h</span><br><span>@@ -552,6 +552,=
7 @@</span><br><span>     /* Cipher parms */</span><br><span>     const cha=
r *shared_secret_file;</span><br><span>     bool shared_secret_file_inline;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool allow_depr=
ecated_insecure_static_crypto;</span><br><span>     int key_direction;</spa=
n><br><span>     const char *ciphername;</span><br><span>     bool enable_n=
cp_fallback;      /**&lt; If defined fall back to</span><br><span>diff --gi=
t a/tests/t_lpback.sh b/tests/t_lpback.sh</span><br><span>index 482016a..68=
df2a6 100755</span><br><span>--- a/tests/t_lpback.sh</span><br><span>+++ b/=
tests/t_lpback.sh</span><br><span>@@ -97,7 +97,7 @@</span><br><span> for ci=
pher in ${CIPHERS}</span><br><span> do</span><br><span>     test_start &quo=
t;Testing cipher ${cipher}... &quot;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    ( &quot;${openvpn}&quot; --test-crypto --secret key.$$ -=
-cipher ${cipher} ) &gt;log.$$ 2&gt;&amp;1</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    ( &quot;${openvpn}&quot; --test-crypto --secret =
key.$$  --allow-deprecated-insecure-static-crypto --cipher ${cipher} ) &gt;=
log.$$ 2&gt;&amp;1</span><br><span>     test_end $? log.$$</span><br><span>=
 done</span><br><span> </span><br><span></span><br></pre><p>To view, visit =
<a href=3D"http://gerrit.openvpn.net/c/openvpn/+/325?usp=3Demail">change 32=
5</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"h=
ttp://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/325?usp=3Demail"/><meta itemprop=3D"name" c=
ontent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4f29953b91cf8e8daf2c9503da4=
4073ad96d0ff5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 325 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--TzauBlBEj8o=--

