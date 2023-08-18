From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Fri, 18 Aug 2023 13:15:58 +0000
References: <gerrit.1692364556000.I4f29953b91cf8e8daf2c9503da44073ad96d0ff5@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <4758f7d0ccf8c04488e3f2946b2f27271d05f062-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="fMOT+AsJWas="; charset=UTF-8
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

--fMOT+AsJWas=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/325?usp=3Demail

to review the following change.


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



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/25/325/1

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
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--fMOT+AsJWas=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/325?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Remove ability to use configurations without TLS by default<b=
r><br>OpenVPN 2.6 already warned about this feature being removed. OpenVPN<=
br>2.7 will with this change no longer accept these configurations without<=
br>having a --allow-deprecated-insecure-static-crypto added to the command<=
br>line or the configuration itself. This will server as a last and final<b=
r>warning for people who missed the warning message in OpenVPN 2.6.<br><br>=
This commit also removes the documentation for --secret and the static key<=
br>mode.<br><br>Change-Id: I4f29953b91cf8e8daf2c9503da44073ad96d0ff5<br>---=
<br>M Changes.rst<br>M doc/man-sections/encryption-options.rst<br>M doc/man=
-sections/inline-files.rst<br>M doc/man-sections/link-options.rst<br>M doc/=
man-sections/protocol-options.rst<br>M doc/man-sections/server-options.rst<=
br>M doc/man-sections/tls-options.rst<br>M src/openvpn/options.c<br>M src/o=
penvpn/options.h<br>M tests/t_lpback.sh<br>10 files changed, 64 insertions(=
+), 83 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openv=
pn refs/changes/25/325/1</pre><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;"><span>diff --git a/Changes.rst b/Changes.rst</sp=
an><br><span>index 77bcef2..3676dce 100644</span><br><span>--- a/Changes.rs=
t</span><br><span>+++ b/Changes.rst</span><br><span>@@ -1,3 +1,15 @@</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+Overview of changes in 2.7=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+``secret`` support has been remove=
d by default.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    st=
atic key mode (non-TLS) is no longer considered &quot;good and secure enoug=
h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for toda=
y&#39;s requirements.  Use TLS mode instead.  If deploying a PKI CA</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    is considered &quot;too=
 complicated&quot;, using ``--peer-fingerprint`` makes</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    TLS mode about as easy as using ``--=
secret``.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    This mode can still be en=
abled by using</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    `=
`--allow-deprecated-insecure-static-crypto`` but will be removed in</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    OpenVPN 2.8.</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> Overview of =
changes in 2.6</span><br><span> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</span><br><span> </span><br><span>diff=
 --git a/doc/man-sections/encryption-options.rst b/doc/man-sections/encrypt=
ion-options.rst</span><br><span>index abc73d9..3b26782 100644</span><br><sp=
an>--- a/doc/man-sections/encryption-options.rst</span><br><span>+++ b/doc/=
man-sections/encryption-options.rst</span><br><span>@@ -69,20 +69,20 @@</sp=
an><br><span>      $ openvpn --tls-crypt-v2 v2crypt-server.key --genkey tls=
-crypt-v2-client v2crypt-client-1.key</span><br><span> </span><br><span>   =
* Generating *Shared Secret Keys*</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    Generate a shared secret, for use with the ``--secret``, ``=
--tls-auth``</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    Gen=
erate a shared secret, for use with the ``--tls-auth``</span><br><span>    =
 or ``--tls-crypt`` options.</span><br><span> </span><br><span>     Syntax:=
</span><br><span>     ::</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-       $ openvpn --genkey secret|tls-crypt|tls-auth ke=
yfile</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       $ openv=
pn --genkey tls-crypt|tls-auth keyfile</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    The key is saved in ``keyfile``. All=
 three variants (``--secret``,</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    ``tls-crypt`` and ``tls-auth``) generate the same type of key.=
 The</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    aliases are a=
dded for convenience.</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    The key is saved in ``keyfile``. Both variants (``tls-crypt`` and</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    ``tls-auth``) gener=
ate the same type of key. The aliases are added for</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    convenience.</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    If using this for ``--se=
cret``, this file must be shared with the peer</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    over a pre-existing secure channel such as ``s=
cp``\(1).</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    This f=
ile must be shared with the peer over a pre-existing secure</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    channel such as ``scp``\(1).</s=
pan><br><span> </span><br><span>   * Generating *TLS Crypt v2 Server key*</=
span><br><span>     Generate a ``--tls-crypt-v2`` key to be used by an Open=
VPN server.</span><br><span>diff --git a/doc/man-sections/inline-files.rst =
b/doc/man-sections/inline-files.rst</span><br><span>index 01e4a84..f46301e =
100644</span><br><span>--- a/doc/man-sections/inline-files.rst</span><br><s=
pan>+++ b/doc/man-sections/inline-files.rst</span><br><span>@@ -3,7 +3,7 @@=
</span><br><span> </span><br><span> OpenVPN allows including files in the m=
ain configuration for the ``--ca``,</span><br><span> ``--cert``, ``--dh``, =
``--extra-certs``, ``--key``, ``--pkcs12``,</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-``--secret``, ``--crl-verify``, ``--http-proxy-user-p=
ass``, ``--tls-auth``,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+``--crl-verify``, ``--http-proxy-user-pass``, ``--tls-auth``,</span><br>=
<span> ``--auth-gen-token-secret``, ``--peer-fingerprint``, ``--tls-crypt``=
,</span><br><span> ``--tls-crypt-v2`` and ``--verify-hash`` options.</span>=
<br><span> </span><br><span>diff --git a/doc/man-sections/link-options.rst =
b/doc/man-sections/link-options.rst</span><br><span>index 14e76b4..c3d35b1 =
100644</span><br><span>--- a/doc/man-sections/link-options.rst</span><br><s=
pan>+++ b/doc/man-sections/link-options.rst</span><br><span>@@ -226,10 +226=
,7 @@</span><br><span>   Ping remote over the TCP/UDP control channel if no=
 packets have been</span><br><span>   sent for at least ``n`` seconds (spec=
ify ``--ping`` on both peers to</span><br><span>   cause ping packets to be=
 sent in both directions since OpenVPN ping</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-  packets are not echoed like IP ping packets). When =
used in one of</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  OpenV=
PN&#39;s secure modes (where ``--secret``, ``--tls-server`` or</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-  ``--tls-client`` is specified), =
the ping packet will be</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-  cryptographically secure.</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+  packets are not echoed like IP ping packets).</span><br><span> =
</span><br><span>   This option has two intended uses:</span><br><span> </s=
pan><br><span>@@ -428,8 +425,7 @@</span><br><span>   received by the prior =
session.</span><br><span> </span><br><span>   This option only makes sense =
when replay protection is enabled (the</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-  default) and you are using either ``--secret`` (shared-s=
ecret key mode)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  or T=
LS mode with ``--tls-auth``.</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  default) and you are using TLS mode with ``--tls-auth``.</span><=
br><span> </span><br><span> --session-timeout n</span><br><span>   Raises :=
code:`SIGTERM` for the client instance after ``n`` seconds since</span><br>=
<span>diff --git a/doc/man-sections/protocol-options.rst b/doc/man-sections=
/protocol-options.rst</span><br><span>index 8134157..cac09e4 100644</span><=
br><span>--- a/doc/man-sections/protocol-options.rst</span><br><span>+++ b/=
doc/man-sections/protocol-options.rst</span><br><span>@@ -73,9 +73,7 @@</sp=
an><br><span>   configured on the data channel, however, later versions usu=
ally</span><br><span>   ignored this directive in favour of a negotiated ci=
pher.</span><br><span>   Starting with 2.6.0, this option is always ignored=
 in TLS mode</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  when it=
 comes to configuring the cipher and will only control the</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-  cipher for ``--secret`` pre-shared-k=
ey mode (note: this mode is</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-  deprecated and strictly not recommended).</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+  when it comes to configuring the cipher.</s=
pan><br><span> </span><br><span>   If you wish to specify the cipher to use=
 on the data channel,</span><br><span>   please see ``--data-ciphers`` (for=
 regular negotiation) and</span><br><span>@@ -182,7 +180,7 @@</span><br><sp=
an> </span><br><span> --key-direction</span><br><span>   Alternative way of=
 specifying the optional direction parameter for the</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-  ``--tls-auth`` and ``--secret`` options. =
Useful when using inline files</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+  ``--tls-auth`` option. Useful when using inline files</span><b=
r><span>   (See section on inline files).</span><br><span> </span><br><span=
> --data-ciphers cipher-list</span><br><span>@@ -234,55 +232,6 @@</span><br=
><span>   have been configured with ``--enable-small``</span><br><span>   (=
typically used on routers or other embedded devices).</span><br><span> </sp=
an><br><span>---secret args</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-  **DEPRECATED** Enable Static Key encryption mode (non-TLS). Use pre=
-shared secret</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  ``fil=
e`` which was generated with ``--genkey``.</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
  Valid syntaxes:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  ::=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-     secret file</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-     secret file direction</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-  The optional ``direction`` parameter enables the use of 4 dis=
tinct keys</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  (HMAC-sen=
d, cipher-encrypt, HMAC-receive, cipher-decrypt), so that each</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-  data flow direction has a differ=
ent set of HMAC and cipher keys. This</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-  has a number of desirable security properties including e=
liminating</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  certain k=
inds of DoS and message replay attacks.</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  W=
hen the ``direction`` parameter is omitted, 2 keys are used</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-  bidirectionally, one for HMAC and t=
he other for encryption/decryption.</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  The `=
`direction`` parameter should always be complementary on either</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-  side of the connection, i.e. on=
e side should use :code:`0` and the other</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-  should use :code:`1`, or both sides should omit it al=
together.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-  The ``direction`` parameter req=
uires that ``file`` contains a 2048 bit</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-  key. While pre-1.5 versions of OpenVPN generate 1024 bi=
t key files, any</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  ver=
sion of OpenVPN which supports the ``direction`` parameter, will also</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-  support 2048 bit key file=
 generation using the ``--genkey`` option.</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
  Static key encryption mode has certain advantages, the primary being</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-  ease of configuration.</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-  There are no certificates or certificate =
authorities or complicated</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-  negotiation handshakes and protocols. The only requirement is that y=
ou</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  have a pre-existi=
ng secure channel with your peer (such as ``ssh``) to</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-  initially copy the key. This requirement,=
 along with the fact that your</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-  key never changes unless you manually generate a new one, makes =
it</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  somewhat less sec=
ure than TLS mode (see below). If an attacker manages</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-  to steal your key, everything that was ev=
er encrypted with it is</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-  compromised. Contrast that to the perfect forward secrecy features of</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-  TLS mode (using Diffi=
e Hellman key exchange), where even if an attacker</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-  was able to steal your private key, he would=
 gain no information to help</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-  him decrypt past sessions.</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  Anoth=
er advantageous aspect of Static Key encryption mode is that it is</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-  a handshake-free protocol wi=
thout any distinguishing signature or</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-  feature (such as a header or protocol handshake sequence)=
 that would</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  mark the=
 ciphertext packets as being generated by OpenVPN. Anyone</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-  eavesdropping on the wire would see n=
othing but random-looking data.</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span> --tran-window n</span><br><span>   Transition w=
indow -- our old key can live this many seconds after a new</span><br><span=
>   a key renegotiation begins (default :code:`3600` seconds). This feature=
</span><br><span>diff --git a/doc/man-sections/server-options.rst b/doc/man=
-sections/server-options.rst</span><br><span>index 6b9ad21..c1d3dc8 100644<=
/span><br><span>--- a/doc/man-sections/server-options.rst</span><br><span>+=
++ b/doc/man-sections/server-options.rst</span><br><span>@@ -406,7 +406,7 @=
@</span><br><span>   Options that will be compared for compatibility includ=
e ``dev-type``,</span><br><span>   ``link-mtu``, ``tun-mtu``, ``proto``, ``=
ifconfig``,</span><br><span>   ``comp-lzo``, ``fragment``, ``keydir``, ``ci=
pher``,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  ``auth``, ``=
keysize``, ``secret``, ``no-replay``,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+  ``auth``, ``keysize``, ``no-replay``,</span><br><span> =
  ``tls-auth``, ``key-method``, ``tls-server``</span><br><span>   and ``tls=
-client``.</span><br><span> </span><br><span>diff --git a/doc/man-sections/=
tls-options.rst b/doc/man-sections/tls-options.rst</span><br><span>index d5=
1aff7..908a42a 100644</span><br><span>--- a/doc/man-sections/tls-options.rs=
t</span><br><span>+++ b/doc/man-sections/tls-options.rst</span><br><span>@@=
 -295,8 +295,24 @@</span><br><span>   Older versions (up to OpenVPN 2.3) su=
pported a freeform passphrase file.</span><br><span>   This is no longer su=
pported in newer versions (v2.4+).</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-  See the ``--secret`` option for more info=
rmation on the optional</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-  ``direction`` parameter.</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  The optional ``direction`` parameter enables the use of 2 distin=
ct keys</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  (HMAC-send=
, HMAC-receive), so that each</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+  data flow direction has a different HMAC key. This has a number=
 of desirable</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  secu=
rity properties including eliminating certain kinds of DoS and message</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+  replay attacks.</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+  When the ``direction`` parameter is omitted=
, the same key is used</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+  bidirectionally.</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  The ``direction=
`` parameter should always be complementary on either</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  side of the connection, i.e. one side s=
hould use :code:`0` and the other</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+  should use :code:`1`, or both sides should omit it altogeth=
er.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+  The ``direction`` parameter requi=
res that ``file`` contains a 2048 bit</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+  key. While pre-1.5 versions of OpenVPN generate 1024 bi=
t key files, any</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  v=
ersion of OpenVPN which supports the ``direction`` parameter, will also</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+  support 2048 bit key =
file generation using the ``--genkey`` option.</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span> </span><br><span>   ``--tls-au=
th`` is recommended when you are running OpenVPN in a mode</span><br><span>=
   where it is listening for packets from any IP address, such as when</spa=
n><br><span>diff --git a/src/openvpn/options.c b/src/openvpn/options.c</spa=
n><br><span>index d168163..bce6846 100644</span><br><span>--- a/src/openvpn=
/options.c</span><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -=
532,12 +532,6 @@</span><br><span>     &quot;\n&quot;</span><br><span>     &=
quot;Data Channel Encryption Options (must be compatible between peers):\n&=
quot;</span><br><span>     &quot;(These options are meaningful for both Sta=
tic Key &amp; TLS-mode)\n&quot;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    &quot;--secret f [d]  : (DEPRECATED) Enable Static Key encryp=
tion mode (non-TLS).\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    &quot;                  Use shared secret file f, generate with =
--genkey.\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
&quot;                  The optional d parameter controls key directionalit=
y.\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &quot; =
                 If d is specified, use separate keys for each\n&quot;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    &quot;                =
  direction, set d=3D0 on one side of the connection,\n&quot;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    &quot;                  and d=
=3D1 on the other side.\n&quot;</span><br><span>     &quot;--auth alg      =
: Authenticate packets with HMAC using message\n&quot;</span><br><span>    =
 &quot;                  digest algorithm alg (default=3D%s).\n&quot;</span=
><br><span>     &quot;                  (usually adds 16 or 20 bytes per pa=
cket)\n&quot;</span><br><span>@@ -622,13 +616,11 @@</span><br><span>     &q=
uot;                  and DoS attacks.\n&quot;</span><br><span>     &quot; =
                 f (required) is a shared-secret key file.\n&quot;</span><b=
r><span>     &quot;                  The optional d parameter controls key =
directionality,\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    &quot;                  see --secret option for more info.\n&quot;</s=
pan><br><span>     &quot;--tls-crypt key : Add an additional layer of authe=
nticated encryption on top\n&quot;</span><br><span>     &quot;             =
     of the TLS control channel to hide the TLS certificate,\n&quot;</span>=
<br><span>     &quot;                  provide basic post-quantum security =
and protect against\n&quot;</span><br><span>     &quot;                  at=
tacks on the TLS stack and DoS attacks.\n&quot;</span><br><span>     &quot;=
                  key (required) provides the pre-shared key file.\n&quot;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &quot;            =
      see --secret option for more info.\n&quot;</span><br><span>     &quot=
;--tls-crypt-v2 key : For clients: use key as a client-specific tls-crypt k=
ey.\n&quot;</span><br><span>     &quot;                  For servers: use k=
ey to decrypt client-specific keys.  For\n&quot;</span><br><span>     &quot=
;                  key generation (--genkey tls-crypt-v2-client): use key t=
o\n&quot;</span><br><span>@@ -762,7 +754,7 @@</span><br><span>     &quot;\n=
&quot;</span><br><span>     &quot;Generate a new key :\n&quot;</span><br><s=
pan>     &quot;--genkey secret file   : Generate a new random key of type a=
nd write to file\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    &quot;                         (for use with --secret, --tls-auth or=
 --tls-crypt).&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    &quot;                         (for use with --tls-auth or --tls-crypt=
).&quot;</span><br><span> #ifdef ENABLE_FEATURE_TUN_PERSIST</span><br><span=
>     &quot;\n&quot;</span><br><span>     &quot;Tun/tap config mode (availa=
ble with linux 2.4+):\n&quot;</span><br><span>@@ -2837,11 +2829,20 @@</span=
><br><span> </span><br><span>     if (!options-&gt;tls_server &amp;&amp; !o=
ptions-&gt;tls_client)</span><br><span>     {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        msg(M_INFO, &quot;DEPRECATION: No tls-clien=
t or tls-server option in &quot;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            &quot;configuration detected. OpenVPN 2.7 will remov=
e the &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 int msglevel =3D M_USAGE;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        if (options-&gt;allow_deprecated_insecure_static_crypto)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            msglevel =3D M_INFO;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        msg(msglevel, &quot;DEPRECATION: No tls-c=
lient or tls-server option in &quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            &quot;configuration detected. OpenVPN 2.8 will=
 remove the &quot;</span><br><span>             &quot;functionality to run =
a VPN without TLS. &quot;</span><br><span>             &quot;See the exampl=
es section in the manual page for &quot;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            &quot;examples of a similar quick setup with=
 peer-fingerprint.&quot;);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            &quot;examples of a similar quick setup with peer-finger=
print.&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     &quot;OpenVPN 2.7 allow using this configuration when using &quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;--all=
ow-deprecated-insecure-static-crypto but you should move&quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            &quot;to proper conf=
iguration as soon as possible.&quot;);</span><br><span>     }</span><br><sp=
an> </span><br><span>     if (options-&gt;ssl_flags &amp; (SSLF_CLIENT_CERT=
_NOT_REQUIRED|SSLF_CLIENT_CERT_OPTIONAL))</span><br><span>@@ -8550,6 +8551,=
12 @@</span><br><span>             }</span><br><span>         }</span><br><=
span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else=
 if (streq(p[0], &quot;allow-deprecated-insecure-static-crypto&quot;))</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        VERIFY_PERMISSION(OPT_P_GENERA=
L);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        options-=
&gt;allow_deprecated_insecure_static_crypto =3D true;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span>     else if (streq(p[0], &quot;genkey=
&quot;) &amp;&amp; !p[4])</span><br><span>     {</span><br><span>         V=
ERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span>diff --git a/src/openvpn/o=
ptions.h b/src/openvpn/options.h</span><br><span>index f5890b9..33d17ca 100=
644</span><br><span>--- a/src/openvpn/options.h</span><br><span>+++ b/src/o=
penvpn/options.h</span><br><span>@@ -552,6 +552,7 @@</span><br><span>     /=
* Cipher parms */</span><br><span>     const char *shared_secret_file;</spa=
n><br><span>     bool shared_secret_file_inline;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    bool allow_deprecated_insecure_static_cryp=
to;</span><br><span>     int key_direction;</span><br><span>     const char=
 *ciphername;</span><br><span>     bool enable_ncp_fallback;      /**&lt; I=
f defined fall back to</span><br><span>diff --git a/tests/t_lpback.sh b/tes=
ts/t_lpback.sh</span><br><span>index 482016a..68df2a6 100755</span><br><spa=
n>--- a/tests/t_lpback.sh</span><br><span>+++ b/tests/t_lpback.sh</span><br=
><span>@@ -97,7 +97,7 @@</span><br><span> for cipher in ${CIPHERS}</span><b=
r><span> do</span><br><span>     test_start &quot;Testing cipher ${cipher}.=
.. &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ( &quot;=
${openvpn}&quot; --test-crypto --secret key.$$ --cipher ${cipher} ) &gt;log=
.$$ 2&gt;&amp;1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
( &quot;${openvpn}&quot; --test-crypto --secret key.$$  --allow-deprecated-=
insecure-static-crypto --cipher ${cipher} ) &gt;log.$$ 2&gt;&amp;1</span><b=
r><span>     test_end $? log.$$</span><br><span> done</span><br><span> </sp=
an><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/325?usp=3Demail">change 325</a>. To unsubscribe, or f=
or help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/se=
ttings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Email=
Message"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/V=
iewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/325?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></d=
iv></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4f29953b91cf8e8daf2c9503da4=
4073ad96d0ff5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 325 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--fMOT+AsJWas=--

