From: "MaxF (Code Review)" <gerrit@...515...>
Date: Wed, 19 Jun 2024 15:06:54 +0000
References: <gerrit.1718809612000.Ifc589854816842e46969a76e2845084b3aaa962f@...2715...>
Reply-To: max@...2606..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <cf94dffabc7185383871976251fb7021aadfa84d-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="iJRL4Moard8="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Check that
 tls-version-min is supported on startup
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

--iJRL4Moard8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/683?usp=3Demail

to review the following change.


Change subject: Check that tls-version-min is supported on startup
......................................................................

Check that tls-version-min is supported on startup

After disabling TLS 1.0 and 1.1 in the mbedtls build, the client would
error out during startup if tls-version-min was set to 1.0 or 1.1, but
the server would start up and only error out when a client attempts to
connect.

This commit checks that tls-version-min is supported during startup so
that both the client and server error out on startup.

Change-Id: Ifc589854816842e46969a76e2845084b3aaa962f
Signed-off-by: Max Fillinger <maximilian.fillinger@...2507...>
---
M src/openvpn/options.c
M src/openvpn/ssl.c
M src/openvpn/ssl_backend.h
M src/openvpn/ssl_mbedtls.c
M src/openvpn/ssl_openssl.c
5 files changed, 31 insertions(+), 6 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/83/683/1

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index f2c7536..f8287f2 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -8933,7 +8933,7 @@
         ver =3D tls_version_parse(p[1], p[2]);
         if (ver =3D=3D TLS_VER_BAD)
         {
-            msg(msglevel, "unknown tls-version-min parameter: %s", p[1]);
+            msg(msglevel, "unknown or unsupported tls-version-min paramete=
r: %s", p[1]);
             goto err;
         }
         options->ssl_flags &=3D
@@ -8947,7 +8947,7 @@
         ver =3D tls_version_parse(p[1], NULL);
         if (ver =3D=3D TLS_VER_BAD)
         {
-            msg(msglevel, "unknown tls-version-max parameter: %s", p[1]);
+            msg(msglevel, "unknown or unsupported tls-version-max paramete=
r: %s", p[1]);
             goto err;
         }
         options->ssl_flags &=3D
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 2054eb4..1d3fdcd 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -405,20 +405,21 @@
 int
 tls_version_parse(const char *vstr, const char *extra)
 {
+    const int min_version =3D tls_version_min();
     const int max_version =3D tls_version_max();
-    if (!strcmp(vstr, "1.0") && TLS_VER_1_0 <=3D max_version)
+    if (!strcmp(vstr, "1.0") && min_version <=3D TLS_VER_1_0 && TLS_VER_1_=
0 <=3D max_version)
     {
         return TLS_VER_1_0;
     }
-    else if (!strcmp(vstr, "1.1") && TLS_VER_1_1 <=3D max_version)
+    else if (!strcmp(vstr, "1.1") && min_version <=3D TLS_VER_1_1 && TLS_V=
ER_1_1 <=3D max_version)
     {
         return TLS_VER_1_1;
     }
-    else if (!strcmp(vstr, "1.2") && TLS_VER_1_2 <=3D max_version)
+    else if (!strcmp(vstr, "1.2") && min_version <=3D TLS_VER_1_2 && TLS_V=
ER_1_2 <=3D max_version)
     {
         return TLS_VER_1_2;
     }
-    else if (!strcmp(vstr, "1.3") && TLS_VER_1_3 <=3D max_version)
+    else if (!strcmp(vstr, "1.3") && min_version <=3D TLS_VER_1_3 && TLS_V=
ER_1_3 <=3D max_version)
     {
         return TLS_VER_1_3;
     }
diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h
index 285705f..ef1347b 100644
--- a/src/openvpn/ssl_backend.h
+++ b/src/openvpn/ssl_backend.h
@@ -117,6 +117,14 @@
 int tls_version_max(void);

 /**
+ * Return the minimum TLS version (as a TLS_VER_x constant)
+ * supported by current SSL implementation
+ *
+ * @return              One of the TLS_VER_x constants (but not TLS_VER_BA=
D).
+ */
+int tls_version_min(void);
+
+/**
  * Initialise a library-specific TLS context for a server.
  *
  * @param ctx           TLS context to initialise
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index bb88da9..de7efed 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -1049,6 +1049,16 @@
 #endif /* defined(MBEDTLS_SSL_PROTO_TLS1_2) */
 }

+int
+tls_version_min(void)
+{
+#if defined(MBEDTLS_SSL_PROTO_TLS1_2)
+    return TLS_VER_1_2;
+#else
+    #error "mbedtls is compiled without support for TLS 1.2."
+#endif /* defined(MBEDTLS_SSL_PROTO_TLS1_2) */
+}
+
 /**
  * Convert an OpenVPN tls-version variable to mbed TLS format
  *
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index e8a30a3..352f7fb 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -231,6 +231,12 @@
 #endif
 }

+int
+tls_version_min(void)
+{
+    return TLS_VER_1_0;
+}
+
 /** Convert internal version number to openssl version number */
 static int
 openssl_tls_version(int ver)

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/683?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ifc589854816842e46969a76e2845084b3aaa962f
Gerrit-Change-Number: 683
Gerrit-PatchSet: 1
Gerrit-Owner: MaxF <max@...2606...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--iJRL4Moard8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>MaxF would like plaisthos and flichtenheld to <strong>review</strong> th=
is change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/683?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Check that tls-version-min is supported on startup<br><br>Aft=
er disabling TLS 1.0 and 1.1 in the mbedtls build, the client would<br>erro=
r out during startup if tls-version-min was set to 1.0 or 1.1, but<br>the s=
erver would start up and only error out when a client attempts to<br>connec=
t.<br><br>This commit checks that tls-version-min is supported during start=
up so<br>that both the client and server error out on startup.<br><br>Chang=
e-Id: Ifc589854816842e46969a76e2845084b3aaa962f<br>Signed-off-by: Max Filli=
nger &lt;maximilian.fillinger@...2507...&gt;<br>---<br>M src/openvpn/option=
s.c<br>M src/openvpn/ssl.c<br>M src/openvpn/ssl_backend.h<br>M src/openvpn/=
ssl_mbedtls.c<br>M src/openvpn/ssl_openssl.c<br>5 files changed, 31 inserti=
ons(+), 6 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/op=
envpn refs/changes/83/683/1</pre><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/options.c b/sr=
c/openvpn/options.c</span><br><span>index f2c7536..f8287f2 100644</span><br=
><span>--- a/src/openvpn/options.c</span><br><span>+++ b/src/openvpn/option=
s.c</span><br><span>@@ -8933,7 +8933,7 @@</span><br><span>         ver =3D =
tls_version_parse(p[1], p[2]);</span><br><span>         if (ver =3D=3D TLS_=
VER_BAD)</span><br><span>         {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            msg(msglevel, &quot;unknown tls-version-min param=
eter: %s&quot;, p[1]);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            msg(msglevel, &quot;unknown or unsupported tls-version-min p=
arameter: %s&quot;, p[1]);</span><br><span>             goto err;</span><br=
><span>         }</span><br><span>         options-&gt;ssl_flags &amp;=3D</=
span><br><span>@@ -8947,7 +8947,7 @@</span><br><span>         ver =3D tls_v=
ersion_parse(p[1], NULL);</span><br><span>         if (ver =3D=3D TLS_VER_B=
AD)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            msg(msglevel, &quot;unknown tls-version-max parameter:=
 %s&quot;, p[1]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          msg(msglevel, &quot;unknown or unsupported tls-version-max parame=
ter: %s&quot;, p[1]);</span><br><span>             goto err;</span><br><spa=
n>         }</span><br><span>         options-&gt;ssl_flags &amp;=3D</span>=
<br><span>diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c</span><br><spa=
n>index 2054eb4..1d3fdcd 100644</span><br><span>--- a/src/openvpn/ssl.c</sp=
an><br><span>+++ b/src/openvpn/ssl.c</span><br><span>@@ -405,20 +405,21 @@<=
/span><br><span> int</span><br><span> tls_version_parse(const char *vstr, c=
onst char *extra)</span><br><span> {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    const int min_version =3D tls_version_min();</span><br=
><span>     const int max_version =3D tls_version_max();</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    if (!strcmp(vstr, &quot;1.0&quot;) &=
amp;&amp; TLS_VER_1_0 &lt;=3D max_version)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    if (!strcmp(vstr, &quot;1.0&quot;) &amp;&amp; mi=
n_version &lt;=3D TLS_VER_1_0 &amp;&amp; TLS_VER_1_0 &lt;=3D max_version)</=
span><br><span>     {</span><br><span>         return TLS_VER_1_0;</span><b=
r><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    els=
e if (!strcmp(vstr, &quot;1.1&quot;) &amp;&amp; TLS_VER_1_1 &lt;=3D max_ver=
sion)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (!=
strcmp(vstr, &quot;1.1&quot;) &amp;&amp; min_version &lt;=3D TLS_VER_1_1 &a=
mp;&amp; TLS_VER_1_1 &lt;=3D max_version)</span><br><span>     {</span><br>=
<span>         return TLS_VER_1_1;</span><br><span>     }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    else if (!strcmp(vstr, &quot;1.2&qu=
ot;) &amp;&amp; TLS_VER_1_2 &lt;=3D max_version)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    else if (!strcmp(vstr, &quot;1.2&quot;) &a=
mp;&amp; min_version &lt;=3D TLS_VER_1_2 &amp;&amp; TLS_VER_1_2 &lt;=3D max=
_version)</span><br><span>     {</span><br><span>         return TLS_VER_1_=
2;</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    else if (!strcmp(vstr, &quot;1.3&quot;) &amp;&amp; TLS_VER_1_3 &lt;=
=3D max_version)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 else if (!strcmp(vstr, &quot;1.3&quot;) &amp;&amp; min_version &lt;=3D TLS=
_VER_1_3 &amp;&amp; TLS_VER_1_3 &lt;=3D max_version)</span><br><span>     {=
</span><br><span>         return TLS_VER_1_3;</span><br><span>     }</span>=
<br><span>diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.=
h</span><br><span>index 285705f..ef1347b 100644</span><br><span>--- a/src/o=
penvpn/ssl_backend.h</span><br><span>+++ b/src/openvpn/ssl_backend.h</span>=
<br><span>@@ -117,6 +117,14 @@</span><br><span> int tls_version_max(void);<=
/span><br><span> </span><br><span> /**</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * Return the minimum TLS version (as a TLS_VER_x consta=
nt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * supported by =
current SSL implementation</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return=
              One of the TLS_VER_x constants (but not TLS_VER_BAD).</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+int tls_version_min(void);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+/**</span><br><span>  * Initialise a library-specific=
 TLS context for a server.</span><br><span>  *</span><br><span>  * @param c=
tx           TLS context to initialise</span><br><span>diff --git a/src/ope=
nvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c</span><br><span>index bb88da=
9..de7efed 100644</span><br><span>--- a/src/openvpn/ssl_mbedtls.c</span><br=
><span>+++ b/src/openvpn/ssl_mbedtls.c</span><br><span>@@ -1049,6 +1049,16 =
@@</span><br><span> #endif /* defined(MBEDTLS_SSL_PROTO_TLS1_2) */</span><b=
r><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tls_ver=
sion_min(void)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(MBEDTLS_SSL=
_PROTO_TLS1_2)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r=
eturn TLS_VER_1_2;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    #error &quo=
t;mbedtls is compiled without support for TLS 1.2.&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#endif /* defined(MBEDTLS_SSL_PROTO_TL=
S1_2) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /**</span><=
br><span>  * Convert an OpenVPN tls-version variable to mbed TLS format</sp=
an><br><span>  *</span><br><span>diff --git a/src/openvpn/ssl_openssl.c b/s=
rc/openvpn/ssl_openssl.c</span><br><span>index e8a30a3..352f7fb 100644</spa=
n><br><span>--- a/src/openvpn/ssl_openssl.c</span><br><span>+++ b/src/openv=
pn/ssl_openssl.c</span><br><span>@@ -231,6 +231,12 @@</span><br><span> #end=
if</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+tls_version_min(void)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return T=
LS_VER_1_0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /** Conv=
ert internal version number to openssl version number */</span><br><span> s=
tatic int</span><br><span> openssl_tls_version(int ver)</span><br><span></s=
pan><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/683?usp=3Demail">change 683</a>. To unsubscribe, or for help writing =
mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings=
</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link=
 itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/683?usp=3De=
mail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ifc589854816842e46969a76e284=
5084b3aaa962f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 683 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: MaxF &lt;max@...2606...&gt; </di=
v>
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


--iJRL4Moard8=--

