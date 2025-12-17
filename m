From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Wed, 17 Dec 2025 12:09:50 +0000
References: <gerrit.1765973388000.I47fc0dc93a7ed6b71feb611194cee02a81d91769@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net
Message-ID: <3b2377a9b9fc6f81c5c33fb0a7df572e0e5a1c6e-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="dgtZc98FhQc="; charset=UTF-8
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
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--dgtZc98FhQc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded this change for review. ( http://gerrit.openvpn.net/=
c/openvpn/+/1448?usp=3Demail )


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
---
M src/openvpn/ssl_openssl.c
1 file changed, 1 insertion(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/48/1448/1

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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I47fc0dc93a7ed6b71feb611194cee02a81d91769
Gerrit-Change-Number: 1448
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--dgtZc98FhQc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos has upl=
oaded this change for <strong>review</strong>.</p><p><a href=3D"http://gerr=
it.openvpn.net/c/openvpn/+/1448?usp=3Demail">View Change</a></p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">Ensure wolfSSL uses old pre 1.1.0 OpenSSL path for getting ciphers<br><=
br>Normally when wolfSSL is compiled with --enable-openvpn it reports an<br=
>OpenSSL version before 1.1.0. When compiled normally it reports an<br>Open=
SSL version higher than this.<br><br>So explicitly check for wolfSSL instea=
d of relying on its OpenSSL version<br>trickery.<br><br>Change-Id: I47fc0dc=
93a7ed6b71feb611194cee02a81d91769<br>Signed-off-by: Arne Schwabe &lt;arne@...220...=
..1227...&gt;<br>---<br>M src/openvpn/ssl_openssl.c<br>1 file changed, 1 in=
sertion(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks" style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.=
openvpn.net:29418/openvpn refs/changes/48/1448/1</pre><pre style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/o=
penvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c</span><br><span>index 48bb=
dfc..35b75eb 100644</span><br><span>--- a/src/openvpn/ssl_openssl.c</span><=
br><span>+++ b/src/openvpn/ssl_openssl.c</span><br><span>@@ -2547,7 +2547,7=
 @@</span><br><span>         crypto_msg(M_FATAL, &quot;Cannot create SSL ob=
ject&quot;);</span><br><span>     }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#if OPENSSL_VERSION_NUMBER &lt; 0x1010000fL=
 || defined(OPENSSL_IS_AWSLC)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#if OPENSSL_VERSION_NUMBER &lt; 0x1010000fL || defined(OPENSSL_IS=
_AWSLC) || defined(ENABLE_CRYPTO_WOLFSSL)</span><br><span>     STACK_OF(SSL=
_CIPHER) *sk =3D SSL_get_ciphers(ssl);</span><br><span> #else</span><br><sp=
an>     STACK_OF(SSL_CIPHER) *sk =3D SSL_get1_supported_ciphers(ssl);</span=
><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/1448?usp=3Demail">change 1448</a>. To unsubscribe, or f=
or help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/se=
ttings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://sche=
ma.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/1448?usp=3Demail"/><meta itemprop=3D"name" content=3D"View=
 Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I47fc0dc93a7ed6b71feb611194c=
ee02a81d91769 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1448 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--dgtZc98FhQc=--

