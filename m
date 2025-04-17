From: "stipa (Code Review)" <gerrit@...515...>
Date: Thu, 17 Apr 2025 11:51:44 +0000
In-Reply-To: <gerrit.1744889440000.I4507be07cd5573b2117e837ef03187535a38a4b1@...2715...>
References: <gerrit.1744889440000.I4507be07cd5573b2117e837ef03187535a38a4b1@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 antonio@...2726...
Message-ID: <b655c2abe2118afa719c429a6595ea884195cba2-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="lW71ceocA2E="; charset=UTF-8
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

--lW71ceocA2E=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, ordex, plaisthos, stipa.

Hello flichtenheld, ordex, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/942?usp=3Demail

to look at the new patch set (#4).

The following approvals got outdated and were removed:
Code-Review-1 by ordex


Change subject: ssl_openssl.c: Prevent potential double-free
......................................................................

ssl_openssl.c: Prevent potential double-free

Fixes a potential double-free issue in tls_ctx_load_cert_uri()
by explicitly nullifying the pointer immediately after calling OSSL_STORE_I=
NFO_free(info).

This ensures that subsequent cleanup won't attempt to free the same pointer=
 again.

GitHub: #726

Change-Id: I4507be07cd5573b2117e837ef03187535a38a4b1
Signed-off-by: Lev Stipakov <lev@...515...>
---
M src/openvpn/ssl_openssl.c
1 file changed, 2 insertions(+), 0 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/42/942/4

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index d1d5d3e..f7be50c 100644
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

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/942?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4507be07cd5573b2117e837ef03187535a38a4b1
Gerrit-Change-Number: 942
Gerrit-PatchSet: 4
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: ordex <antonio@...2726...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: ordex <antonio@...2726...>
Gerrit-Attention: stipa <lstipakov@...277...>
Gerrit-MessageType: newpatchset

--lW71ceocA2E=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, ordex, plaisthos, s=
tipa. </p>
<p>stipa <strong>uploaded patch set #4</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/942?usp=3Demail">View Change</a=
></p><p>The following approvals got outdated and were removed:
Code-Review-1 by ordex</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">ssl_openssl.c: Prevent potential double-free<br><br>=
Fixes a potential double-free issue in tls_ctx_load_cert_uri()<br>by explic=
itly nullifying the pointer immediately after calling OSSL_STORE_INFO_free(=
info).<br><br>This ensures that subsequent cleanup won&#39;t attempt to fre=
e the same pointer again.<br><br>GitHub: #726<br><br>Change-Id: I4507be07cd=
5573b2117e837ef03187535a38a4b1<br>Signed-off-by: Lev Stipakov &lt;lev@...1387...=
5...&gt;<br>---<br>M src/openvpn/ssl_openssl.c<br>1 file changed, 2 inserti=
ons(+), 0 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/op=
envpn refs/changes/42/942/4</pre><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/ssl_openssl.c =
b/src/openvpn/ssl_openssl.c</span><br><span>index d1d5d3e..f7be50c 100644</=
span><br><span>--- a/src/openvpn/ssl_openssl.c</span><br><span>+++ b/src/op=
envpn/ssl_openssl.c</span><br><span>@@ -1152,6 +1152,7 @@</span><br><span> =
        goto end;</span><br><span>     }</span><br><span>     OSSL_STORE_IN=
FO_free(info);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
nfo =3D NULL;</span><br><span> </span><br><span>     /* iterate through the=
 store and add extra certificates if any to the chain */</span><br><span>  =
   while (!OSSL_STORE_eof(store_ctx))</span><br><span>@@ -1170,6 +1171,7 @@=
</span><br><span>             break;</span><br><span>         }</span><br><=
span>         OSSL_STORE_INFO_free(info);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        info =3D NULL;</span><br><span>     }</span><=
br><span> </span><br><span> end:</span><br><span></span><br></pre><p>To vie=
w, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/942?usp=3Demail">=
change 942</a>. To unsubscribe, or for help writing mail filters, visit <a =
href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope=
 itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"act=
ion" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/942?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4507be07cd5573b2117e837ef03=
187535a38a4b1 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 942 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;antonio@...2726...&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;antonio@...2726...=
&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--lW71ceocA2E=--

