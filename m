From: "selvanair (Code Review)" <gerrit@...515...>
Date: Wed, 11 Sep 2024 03:19:07 +0000
References: <gerrit.1726024745000.I2bfa9ffbd17d0599014d38b2a2fd319766cdb1e3@...2715...>
Reply-To: selva.nair@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <3ba839f6d29460d1c132a0beee5f11cfaa93aac8-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="7C+JEcCky4Q="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--7C+JEcCky4Q=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/742?usp=3Demail

to review the following change.


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
---
M src/openvpn/ssl_openssl.c
1 file changed, 42 insertions(+), 5 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/42/742/1

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
Gerrit-PatchSet: 1
Gerrit-Owner: selvanair <selva.nair@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--7C+JEcCky4Q=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>selvanair would like plaisthos and flichtenheld to <strong>review</stron=
g> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/742?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Do not stop reading from file/uri when OPENSSL_STORE_load() r=
eturns error<br><br>OPENSSL_STORE_load() can error and return NULL even whe=
n the file or URI<br>still has readable objects left.<br><br>Fix by iterati=
ng until OPENSSL_STORE_eof(). Also clear such errors to avoid<br>misleading=
 messages printed at the end by crypto_print_openssl_errors().<br><br>Chang=
e-Id: I2bfa9ffbd17d0599014d38b2a2fd319766cdb1e3<br>Signed-off-by: Selva Nai=
r &lt;selva.nair@...277...&gt;<br>---<br>M src/openvpn/ssl_openssl.c<br>1 f=
ile changed, 42 insertions(+), 5 deletions(-)<br><br></pre><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerr=
it.openvpn.net:29418/openvpn refs/changes/42/742/1</pre><pre style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src=
/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c</span><br><span>index 0d=
845f4..5fd6572 100644</span><br><span>--- a/src/openvpn/ssl_openssl.c</span=
><br><span>+++ b/src/openvpn/ssl_openssl.c</span><br><span>@@ -813,6 +813,1=
5 @@</span><br><span>     }</span><br><span>     return 0;</span><br><span>=
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+clear_ossl_store_error(OSSL_STORE_CTX *store=
_ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if (OSSL_STORE_error(store_c=
tx))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        ERR_clear_error();</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span> #endif /* defined=
(HAVE_OPENSSL_STORE_API) */</span><br><span> </span><br><span> /**</span><b=
r><span>@@ -864,7 +873,19 @@</span><br><span>     {</span><br><span>       =
  goto end;</span><br><span>     }</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    info =3D OSSL_STORE_load(store_ctx);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    while (1)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        info =3D OSSL_STORE_load(store_ctx);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        if (info || OSSL_STORE_eof(s=
tore_ctx))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            break;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        /* OPENSSL_STORE_load =
can return error and still have usable objects to follow.</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+         * ref: man OPENSSL_STORE_ope=
n</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * Clear e=
rror and recurse through the file if info =3D NULL and eof not reached</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+         */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        clear_ossl_store_error(s=
tore_ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span>     if (!info)</span><br><span>     {</span><br><span>       =
  goto end;</span><br><span>@@ -1099,7 +1120,19 @@</span><br><span>        =
 goto end;</span><br><span>     }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    info =3D OSSL_STORE_load(store_ctx);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    while (1)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        info =3D OSSL_STORE_load(store_ct=
x);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (info=
 || OSSL_STORE_eof(store_ctx))</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /*=
 OPENSSL_STORE_load can return error and still have usable objects to follo=
w.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * ref: m=
an OPENSSL_STORE_open</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+         * Clear error and recurse through the file if info =3D NULL and =
eof not reached.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
      */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cle=
ar_ossl_store_error(store_ctx);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span>     if (!info)</span><br><span>     {</s=
pan><br><span>         goto end;</span><br><span>@@ -1120,9 +1153,14 @@</sp=
an><br><span>     OSSL_STORE_INFO_free(info);</span><br><span> </span><br><=
span>     /* iterate through the store and add extra certificates if any to=
 the chain */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    info=
 =3D OSSL_STORE_load(store_ctx);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    while (info &amp;&amp; !OSSL_STORE_eof(store_ctx))</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    while (!OSSL_STORE_eof(st=
ore_ctx))</span><br><span>     {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        info =3D OSSL_STORE_load(store_ctx);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        if (!info)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            clear_ossl_store_error(store_ctx);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            continue;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br=
><span>         x =3D OSSL_STORE_INFO_get1_CERT(info);</span><br><span>    =
     if (x &amp;&amp; SSL_CTX_add_extra_chain_cert(tls_ctx-&gt;ctx, x) !=3D=
 1)</span><br><span>         {</span><br><span>@@ -1131,7 +1169,6 @@</span>=
<br><span>             break;</span><br><span>         }</span><br><span>  =
       OSSL_STORE_INFO_free(info);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        info =3D OSSL_STORE_load(store_ctx);</span><br><span> =
    }</span><br><span> </span><br><span> end:</span><br><span></span><br></=
pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/742?=
usp=3Demail">change 742</a>. To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><=
div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope it=
emprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/742?usp=3Demail"/><m=
eta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2bfa9ffbd17d0599014d38b2a2f=
d319766cdb1e3 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 742 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: selvanair &lt;selva.nair@...1354...=
..&gt; </div>
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


--7C+JEcCky4Q=--

