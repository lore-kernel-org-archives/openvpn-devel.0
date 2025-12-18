From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 18 Dec 2025 10:30:58 +0000
In-Reply-To: <gerrit.1765973388000.I47fc0dc93a7ed6b71feb611194cee02a81d91769@...2715...>
References: <gerrit.1765973388000.I47fc0dc93a7ed6b71feb611194cee02a81d91769@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <675fe996368e1f5e54b25a64fe8abcb2a720fe19-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="CGX6vWBtepg="; charset=UTF-8
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

--CGX6vWBtepg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 plaisthos. ( http://gerrit.openvpn.net/c/openvpn/+/1448?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/48/1448/2

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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I47fc0dc93a7ed6b71feb611194cee02a81d91769
Gerrit-Change-Number: 1448
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--CGX6vWBtepg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by plaisthos.<=
/p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1448?usp=3Demail">Vi=
ew Change</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">Ensure wolfSSL uses old pre 1.1.0 O=
penSSL path for getting ciphers<br><br>Normally when wolfSSL is compiled wi=
th --enable-openvpn it reports an<br>OpenSSL version before 1.1.0. When com=
piled normally it reports an<br>OpenSSL version higher than this.<br><br>So=
 explicitly check for wolfSSL instead of relying on its OpenSSL version<br>=
trickery.<br><br>Change-Id: I47fc0dc93a7ed6b71feb611194cee02a81d91769<br>Si=
gned-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>Acked-by: Gert Doering=
 &lt;gert@...1296...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvp=
n/+/1448<br>Message-Id: &lt;20251217130743.28786-1-gert@...1296...&gt;<br>U=
RL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg351=
27.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M =
src/openvpn/ssl_openssl.c<br>1 file changed, 1 insertion(+), 1 deletion(-)<=
br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn =
refs/changes/48/1448/2</pre><pre style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;"><span>diff --git a/src/openvpn/ssl_openssl.c b/src=
/openvpn/ssl_openssl.c</span><br><span>index 48bbdfc..35b75eb 100644</span>=
<br><span>--- a/src/openvpn/ssl_openssl.c</span><br><span>+++ b/src/openvpn=
/ssl_openssl.c</span><br><span>@@ -2547,7 +2547,7 @@</span><br><span>      =
   crypto_msg(M_FATAL, &quot;Cannot create SSL object&quot;);</span><br><sp=
an>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#if OPENSSL_VERSION_NUMBER &lt; 0x1010000fL || defined(OPENSSL_IS_AWS=
LC)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if OPENSSL_VERS=
ION_NUMBER &lt; 0x1010000fL || defined(OPENSSL_IS_AWSLC) || defined(ENABLE_=
CRYPTO_WOLFSSL)</span><br><span>     STACK_OF(SSL_CIPHER) *sk =3D SSL_get_c=
iphers(ssl);</span><br><span> #else</span><br><span>     STACK_OF(SSL_CIPHE=
R) *sk =3D SSL_get1_supported_ciphers(ssl);</span><br><span></span><br></pr=
e><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1448?u=
sp=3Demail">change 1448</a>. To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settin=
gs</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div =
itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><li=
nk itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1448?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
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

--CGX6vWBtepg=--

