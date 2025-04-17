From: "stipa (Code Review)" <gerrit@...515...>
Date: Thu, 17 Apr 2025 11:30:44 +0000
References: <gerrit.1744889440000.I4507be07cd5573b2117e837ef03187535a38a4b1@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <a13935d8ab5f4f70a541b4aab7888b5546000b97-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="tzsUY1Sb/iI="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: ssl_openssl.c:
 Prevent potential double-free
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--tzsUY1Sb/iI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/942?usp=3Demail

to review the following change.


Change subject: ssl_openssl.c: Prevent potential double-free
......................................................................

ssl_openssl.c: Prevent potential double-free

Fixes a potential double-free issue in tls_ctx_load_cert_uri()
by explicitly nullifying the pointer immediately after calling OSSL_STORE_I=
NFO_free(info).

This ensures that subsequent cleanup won't attempt to free the same pointer=
 again.

Change-Id: I4507be07cd5573b2117e837ef03187535a38a4b1
Signed-off-by: Lev Stipakov <lev@...515...>
---
M src/openvpn/ssl_openssl.c
1 file changed, 7 insertions(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/42/942/1

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index d1d5d3e..524cc00 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -1152,6 +1152,7 @@
         goto end;
     }
     OSSL_STORE_INFO_free(info);
+    info =3D NULL;

     /* iterate through the store and add extra certificates if any to the =
chain */
     while (!OSSL_STORE_eof(store_ctx))
@@ -1170,6 +1171,7 @@
             break;
         }
         OSSL_STORE_INFO_free(info);
+        info =3D NULL;
     }

 end:
@@ -1184,7 +1186,11 @@
     }

     UI_destroy_method(ui_method);
-    OSSL_STORE_INFO_free(info);
+    if (info)
+    {
+        OSSL_STORE_INFO_free(info);
+        info =3D NULL;
+    }
     OSSL_STORE_close(store_ctx);
 #else /* defined(HAVE_OPENSSL_STORE_API */
     ASSERT(0);

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/942?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4507be07cd5573b2117e837ef03187535a38a4b1
Gerrit-Change-Number: 942
Gerrit-PatchSet: 1
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--tzsUY1Sb/iI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>stipa would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/942?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">ssl_openssl.c: Prevent potential double-free<br><br>Fixes a p=
otential double-free issue in tls_ctx_load_cert_uri()<br>by explicitly null=
ifying the pointer immediately after calling OSSL_STORE_INFO_free(info).<br=
><br>This ensures that subsequent cleanup won&#39;t attempt to free the sam=
e pointer again.<br><br>Change-Id: I4507be07cd5573b2117e837ef03187535a38a4b=
1<br>Signed-off-by: Lev Stipakov &lt;lev@...515...&gt;<br>---<br>M src/open=
vpn/ssl_openssl.c<br>1 file changed, 7 insertions(+), 1 deletion(-)<br><br>=
</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap=
;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/42/942/1</p=
re><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
<span>diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c</s=
pan><br><span>index d1d5d3e..524cc00 100644</span><br><span>--- a/src/openv=
pn/ssl_openssl.c</span><br><span>+++ b/src/openvpn/ssl_openssl.c</span><br>=
<span>@@ -1152,6 +1152,7 @@</span><br><span>         goto end;</span><br><s=
pan>     }</span><br><span>     OSSL_STORE_INFO_free(info);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    info =3D NULL;</span><br><span>=
 </span><br><span>     /* iterate through the store and add extra certifica=
tes if any to the chain */</span><br><span>     while (!OSSL_STORE_eof(stor=
e_ctx))</span><br><span>@@ -1170,6 +1171,7 @@</span><br><span>             =
break;</span><br><span>         }</span><br><span>         OSSL_STORE_INFO_=
free(info);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
info =3D NULL;</span><br><span>     }</span><br><span> </span><br><span> en=
d:</span><br><span>@@ -1184,7 +1186,11 @@</span><br><span>     }</span><br>=
<span> </span><br><span>     UI_destroy_method(ui_method);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    OSSL_STORE_INFO_free(info);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    if (info)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        OSSL_STORE_INFO_free(info);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        info =3D NULL;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>     =
OSSL_STORE_close(store_ctx);</span><br><span> #else /* defined(HAVE_OPENSSL=
_STORE_API */</span><br><span>     ASSERT(0);</span><br><span></span><br></=
pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/942?=
usp=3Demail">change 942</a>. To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><=
div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope it=
emprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/942?usp=3Demail"/><m=
eta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4507be07cd5573b2117e837ef03=
187535a38a4b1 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 942 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--tzsUY1Sb/iI=--

