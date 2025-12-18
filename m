From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 18 Dec 2025 10:31:04 +0000
In-Reply-To: <gerrit.1765973388000.I47fc0dc93a7ed6b71feb611194cee02a81d91769@...2715...>
References: <gerrit.1765973388000.I47fc0dc93a7ed6b71feb611194cee02a81d91769@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <675fe996368e1f5e54b25a64fe8abcb2a720fe19-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="mcD+vww6FVw="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Ensure wolfSSL uses
 old pre 1.1.0 OpenSSL path for getting ciphers
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

--mcD+vww6FVw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/14=
48?usp=3Demail )

Change subject: Ensure wolfSSL uses old pre 1.1.0 OpenSSL path for getting =
ciphers
......................................................................

Ensure wolfSSL uses old pre 1.1.0 OpenSSL path for getting ciphers

Normally when wolfSSL is compiled with --enable-openvpn it reports an
OpenSSL version before 1.1.0. When compiled normally it reports an
OpenSSL version higher than this.

So explicitly check for wolfSSL instead of relying on its OpenSSL version
trickery.

Change-Id: I47fc0dc93a7ed6b71feb611194cee02a81d91769
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1448
Message-Id: <20251217130743.28786-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35=
127.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/ssl_openssl.c
1 file changed, 1 insertion(+), 1 deletion(-)




diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 48bbdfc..35b75eb 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -2547,7 +2547,7 @@
         crypto_msg(M_FATAL, "Cannot create SSL object");
     }

-#if OPENSSL_VERSION_NUMBER < 0x1010000fL || defined(OPENSSL_IS_AWSLC)
+#if OPENSSL_VERSION_NUMBER < 0x1010000fL || defined(OPENSSL_IS_AWSLC) || d=
efined(ENABLE_CRYPTO_WOLFSSL)
     STACK_OF(SSL_CIPHER) *sk =3D SSL_get_ciphers(ssl);
 #else
     STACK_OF(SSL_CIPHER) *sk =3D SSL_get1_supported_ciphers(ssl);

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1448?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I47fc0dc93a7ed6b71feb611194cee02a81d91769
Gerrit-Change-Number: 1448
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--mcD+vww6FVw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1448?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">Ensure wolfSSL uses old pre 1.1.0 OpenSSL path f=
or getting ciphers<br><br>Normally when wolfSSL is compiled with --enable-o=
penvpn it reports an<br>OpenSSL version before 1.1.0. When compiled normall=
y it reports an<br>OpenSSL version higher than this.<br><br>So explicitly c=
heck for wolfSSL instead of relying on its OpenSSL version<br>trickery.<br>=
<br>Change-Id: I47fc0dc93a7ed6b71feb611194cee02a81d91769<br>Signed-off-by: =
Arne Schwabe &lt;arne@...1227...&gt;<br>Acked-by: Gert Doering &lt;gert@...493...=
1296...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1448<br>M=
essage-Id: &lt;20251217130743.28786-1-gert@...1296...&gt;<br>URL: https://w=
ww.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35127.html<br>Si=
gned-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/s=
sl_openssl.c<br>1 file changed, 1 insertion(+), 1 deletion(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c</span=
><br><span>index 48bbdfc..35b75eb 100644</span><br><span>--- a/src/openvpn/=
ssl_openssl.c</span><br><span>+++ b/src/openvpn/ssl_openssl.c</span><br><sp=
an>@@ -2547,7 +2547,7 @@</span><br><span>         crypto_msg(M_FATAL, &quot=
;Cannot create SSL object&quot;);</span><br><span>     }</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if OPENSSL_VERSION_NU=
MBER &lt; 0x1010000fL || defined(OPENSSL_IS_AWSLC)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#if OPENSSL_VERSION_NUMBER &lt; 0x1010000fL =
|| defined(OPENSSL_IS_AWSLC) || defined(ENABLE_CRYPTO_WOLFSSL)</span><br><s=
pan>     STACK_OF(SSL_CIPHER) *sk =3D SSL_get_ciphers(ssl);</span><br><span=
> #else</span><br><span>     STACK_OF(SSL_CIPHER) *sk =3D SSL_get1_supporte=
d_ciphers(ssl);</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1448?usp=3Demail">change 1448</a>=
. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:/=
/gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope i=
temtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"actio=
n" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/1448?usp=3Demail"/><meta itemprop=3D=
"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I47fc0dc93a7ed6b71feb611194c=
ee02a81d91769 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1448 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--mcD+vww6FVw=--

