From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 11 Sep 2024 12:26:19 +0000
In-Reply-To: <gerrit.1726024745000.I2bfa9ffbd17d0599014d38b2a2fd319766cdb1e3@...2715...>
References: <gerrit.1726024745000.I2bfa9ffbd17d0599014d38b2a2fd319766cdb1e3@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., selva.nair@...277...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <431245170daec358e009d3be500a9370e31a6ad5-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="OwMY2+e0+ew="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Do not stop reading
 from file/uri when OPENSSL_STORE_load() returns e...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: selvanair <selva.nair@...277...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--OwMY2+e0+ew=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 selvanair. ( http://gerrit.openvpn.net/c/openvpn/+/742?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by plaisthos


Change subject: Do not stop reading from file/uri when OPENSSL_STORE_load()=
 returns error
......................................................................

Do not stop reading from file/uri when OPENSSL_STORE_load() returns error

OPENSSL_STORE_load() can error and return NULL even when the file or URI
still has readable objects left.

Fix by iterating until OPENSSL_STORE_eof(). Also clear such errors to avoid
misleading messages printed at the end by crypto_print_openssl_errors().

Change-Id: I2bfa9ffbd17d0599014d38b2a2fd319766cdb1e3
Signed-off-by: Selva Nair <selva.nair@...277...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Message-Id: <20240911104941.19429-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29=
187.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/ssl_openssl.c
1 file changed, 42 insertions(+), 5 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/42/742/2

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 0d845f4..5fd6572 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -813,6 +813,15 @@
     }
     return 0;
 }
+
+static void
+clear_ossl_store_error(OSSL_STORE_CTX *store_ctx)
+{
+    if (OSSL_STORE_error(store_ctx))
+    {
+        ERR_clear_error();
+    }
+}
 #endif /* defined(HAVE_OPENSSL_STORE_API) */

 /**
@@ -864,7 +873,19 @@
     {
         goto end;
     }
-    info =3D OSSL_STORE_load(store_ctx);
+    while (1)
+    {
+        info =3D OSSL_STORE_load(store_ctx);
+        if (info || OSSL_STORE_eof(store_ctx))
+        {
+            break;
+        }
+        /* OPENSSL_STORE_load can return error and still have usable objec=
ts to follow.
+         * ref: man OPENSSL_STORE_open
+         * Clear error and recurse through the file if info =3D NULL and e=
of not reached
+         */
+        clear_ossl_store_error(store_ctx);
+    }
     if (!info)
     {
         goto end;
@@ -1099,7 +1120,19 @@
         goto end;
     }

-    info =3D OSSL_STORE_load(store_ctx);
+    while (1)
+    {
+        info =3D OSSL_STORE_load(store_ctx);
+        if (info || OSSL_STORE_eof(store_ctx))
+        {
+            break;
+        }
+        /* OPENSSL_STORE_load can return error and still have usable objec=
ts to follow.
+         * ref: man OPENSSL_STORE_open
+         * Clear error and recurse through the file if info =3D NULL and e=
of not reached.
+         */
+        clear_ossl_store_error(store_ctx);
+    }
     if (!info)
     {
         goto end;
@@ -1120,9 +1153,14 @@
     OSSL_STORE_INFO_free(info);

     /* iterate through the store and add extra certificates if any to the =
chain */
-    info =3D OSSL_STORE_load(store_ctx);
-    while (info && !OSSL_STORE_eof(store_ctx))
+    while (!OSSL_STORE_eof(store_ctx))
     {
+        info =3D OSSL_STORE_load(store_ctx);
+        if (!info)
+        {
+            clear_ossl_store_error(store_ctx);
+            continue;
+        }
         x =3D OSSL_STORE_INFO_get1_CERT(info);
         if (x && SSL_CTX_add_extra_chain_cert(tls_ctx->ctx, x) !=3D 1)
         {
@@ -1131,7 +1169,6 @@
             break;
         }
         OSSL_STORE_INFO_free(info);
-        info =3D OSSL_STORE_load(store_ctx);
     }

 end:

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/742?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I2bfa9ffbd17d0599014d38b2a2fd319766cdb1e3
Gerrit-Change-Number: 742
Gerrit-PatchSet: 2
Gerrit-Owner: selvanair <selva.nair@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--OwMY2+e0+ew=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by selvanair.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
742?usp=3Demail">View Change</a></p><p>The following approvals got outdated=
 and were removed:
Code-Review+2 by plaisthos</p><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">Do not stop reading from file/uri when OPENSSL_S=
TORE_load() returns error<br><br>OPENSSL_STORE_load() can error and return =
NULL even when the file or URI<br>still has readable objects left.<br><br>F=
ix by iterating until OPENSSL_STORE_eof(). Also clear such errors to avoid<=
br>misleading messages printed at the end by crypto_print_openssl_errors().=
<br><br>Change-Id: I2bfa9ffbd17d0599014d38b2a2fd319766cdb1e3<br>Signed-off-=
by: Selva Nair &lt;selva.nair@...277...&gt;<br>Acked-by: Arne Schwabe &lt;a=
rne-openvpn@...1227...&gt;<br>Message-Id: &lt;20240911104941.19429-1-gert@...220...=
..1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1439...=
ceforge.net/msg29187.html<br>Signed-off-by: Gert Doering &lt;gert@...2132...=
.&gt;<br>---<br>M src/openvpn/ssl_openssl.c<br>1 file changed, 42 insertion=
s(+), 5 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/open=
vpn refs/changes/42/742/2</pre><pre style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;"><span>diff --git a/src/openvpn/ssl_openssl.c b/=
src/openvpn/ssl_openssl.c</span><br><span>index 0d845f4..5fd6572 100644</sp=
an><br><span>--- a/src/openvpn/ssl_openssl.c</span><br><span>+++ b/src/open=
vpn/ssl_openssl.c</span><br><span>@@ -813,6 +813,15 @@</span><br><span>    =
 }</span><br><span>     return 0;</span><br><span> }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+clear_ossl_store_error(OSSL_STORE_CTX *store_ctx)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    if (OSSL_STORE_error(store_ctx))</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        ERR_clear_error();</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+}</span><br><span> #endif /* defined(HAVE_OPENSSL_STORE_API)=
 */</span><br><span> </span><br><span> /**</span><br><span>@@ -864,7 +873,1=
9 @@</span><br><span>     {</span><br><span>         goto end;</span><br><s=
pan>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    info =
=3D OSSL_STORE_load(store_ctx);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    while (1)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
info =3D OSSL_STORE_load(store_ctx);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        if (info || OSSL_STORE_eof(store_ctx))</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            break;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        /* OPENSSL_STORE_load can return error and =
still have usable objects to follow.</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+         * ref: man OPENSSL_STORE_open</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+         * Clear error and recurse thro=
ugh the file if info =3D NULL and eof not reached</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+         */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        clear_ossl_store_error(store_ctx);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>     if =
(!info)</span><br><span>     {</span><br><span>         goto end;</span><br=
><span>@@ -1099,7 +1120,19 @@</span><br><span>         goto end;</span><br>=
<span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    info =3D OSSL_STORE_load(store_ctx);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    while (1)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        info =3D OSSL_STORE_load(store_ctx);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        if (info || OSSL_STORE_eof(store=
_ctx))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            break;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        /* OPENSSL_STORE_load can =
return error and still have usable objects to follow.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+         * ref: man OPENSSL_STORE_open</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+         * Clear error=
 and recurse through the file if info =3D NULL and eof not reached.</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+         */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        clear_ossl_store_error(stor=
e_ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span>     if (!info)</span><br><span>     {</span><br><span>         g=
oto end;</span><br><span>@@ -1120,9 +1153,14 @@</span><br><span>     OSSL_S=
TORE_INFO_free(info);</span><br><span> </span><br><span>     /* iterate thr=
ough the store and add extra certificates if any to the chain */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    info =3D OSSL_STORE_load(sto=
re_ctx);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    while (in=
fo &amp;&amp; !OSSL_STORE_eof(store_ctx))</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    while (!OSSL_STORE_eof(store_ctx))</span><br><spa=
n>     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        inf=
o =3D OSSL_STORE_load(store_ctx);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        if (!info)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            clear_ossl_store_error(store_ctx);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            continue;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>         x =3D =
OSSL_STORE_INFO_get1_CERT(info);</span><br><span>         if (x &amp;&amp; =
SSL_CTX_add_extra_chain_cert(tls_ctx-&gt;ctx, x) !=3D 1)</span><br><span>  =
       {</span><br><span>@@ -1131,7 +1169,6 @@</span><br><span>            =
 break;</span><br><span>         }</span><br><span>         OSSL_STORE_INFO=
_free(info);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        i=
nfo =3D OSSL_STORE_load(store_ctx);</span><br><span>     }</span><br><span>=
 </span><br><span> end:</span><br><span></span><br></pre><p>To view, visit =
<a href=3D"http://gerrit.openvpn.net/c/openvpn/+/742?usp=3Demail">change 74=
2</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"h=
ttp://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/742?usp=3Demail"/><meta itemprop=3D"name" c=
ontent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2bfa9ffbd17d0599014d38b2a2f=
d319766cdb1e3 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 742 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: selvanair &lt;selva.nair@...1354...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--OwMY2+e0+ew=--

