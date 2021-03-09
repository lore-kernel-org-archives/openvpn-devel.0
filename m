MIME-Version: 1.0
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Tue, 9 Mar 2021 16:54:13 +0500
Message-ID: <CAFHpkQFzOBMUC+qX7vV8jeHxg2MdP6_DCwiUZ=seX7r3DE=cBg@...278...>
Content-Type: multipart/alternative; boundary="00000000000030844805bd19367a"
Subject: [Openvpn-devel] using openssl feature wherever possible
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--00000000000030844805bd19367a
Content-Type: text/plain; charset="UTF-8"

Hello,

if nobody minds, I can send several patches that eliminates comparison of
OPENSSL_VERSION, for example


diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 49698e4b..316cca6f 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -51,7 +51,8 @@
 #include <openssl/rand.h>
 #include <openssl/ssl.h>

-#if (OPENSSL_VERSION_NUMBER >= 0x10100000L) &&
!defined(LIBRESSL_VERSION_NUMBER)
+#ifdef EVP_PKEY_TLS1_PRF
 #include <openssl/kdf.h>
 #endif




Ilya

--00000000000030844805bd19367a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello,</div><div><br></div><div>if nobody minds, I ca=
n send several patches that eliminates comparison of OPENSSL_VERSION, for e=
xample</div><div><br></div><div><br></div><div>diff --git a/src/openvpn/cry=
pto_openssl.c b/src/openvpn/crypto_openssl.c<br>index 49698e4b..316cca6f 10=
0644<br>--- a/src/openvpn/crypto_openssl.c<br>+++ b/src/openvpn/crypto_open=
ssl.c<br>@@ -51,7 +51,8 @@<br>=C2=A0#include &lt;openssl/rand.h&gt;<br>=C2=
=A0#include &lt;openssl/ssl.h&gt;<br>=C2=A0<br>-#if (OPENSSL_VERSION_NUMBER=
 &gt;=3D 0x10100000L) &amp;&amp; !defined(LIBRESSL_VERSION_NUMBER)<br>+#ifd=
ef EVP_PKEY_TLS1_PRF<br>=C2=A0#include &lt;openssl/kdf.h&gt;<br>=C2=A0#endi=
f</div><div><br></div><div><br></div><div><br></div><div><br></div><div>Ily=
a<br></div></div>

--00000000000030844805bd19367a--

