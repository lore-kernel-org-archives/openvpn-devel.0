From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 28 Jul 2025 13:53:02 +0000
In-Reply-To: <gerrit.1753360288000.I03e5ece7580ca4ebd41a7928ead544df46e8bad1@...2715...>
References: <gerrit.1753360288000.I03e5ece7580ca4ebd41a7928ead544df46e8bad1@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <2f7025852bdbea14f52fd23861c74084d093d9b7-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="MMp5zoHdtEY="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: ssl_common: Make
 sure ssl flags are treated as unsigned
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

--MMp5zoHdtEY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1104?usp=3Demail

to look at the new patch set (#2).


Change subject: ssl_common: Make sure ssl flags are treated as unsigned
......................................................................

ssl_common: Make sure ssl flags are treated as unsigned

tls_options.ssl_flags is already unsigned, make sure the
flags are as well to avoid spurious conversion warnings.

Also fix various warning regarding the use of the flags
for TLS version handling.

Change-Id: I03e5ece7580ca4ebd41a7928ead544df46e8bad1
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/options.c
M src/openvpn/ssl_common.h
2 files changed, 20 insertions(+), 22 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/04/1104/2

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 0662b49..6ad1170 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2722,14 +2722,14 @@
             "may accept clients which do not present a certificate");
     }

-    const int tls_version_max =3D
+    const unsigned int tls_version_max =3D
         (options->ssl_flags >> SSLF_TLS_VERSION_MAX_SHIFT)
         & SSLF_TLS_VERSION_MAX_MASK;
-    const int tls_version_min =3D
+    const unsigned int tls_version_min =3D
         (options->ssl_flags >> SSLF_TLS_VERSION_MIN_SHIFT)
         & SSLF_TLS_VERSION_MIN_MASK;

-    if (tls_version_max > 0 && tls_version_max < tls_version_min)
+    if (tls_version_max < tls_version_min)
     {
         msg(M_USAGE, "--tls-version-min bigger than --tls-version-max");
     }
@@ -3387,12 +3387,12 @@
 options_set_backwards_compatible_options(struct options *o)
 {
     /* TLS min version is not set */
-    int tls_ver_min =3D (o->ssl_flags >> SSLF_TLS_VERSION_MIN_SHIFT)
-                      & SSLF_TLS_VERSION_MIN_MASK;
+    unsigned int tls_ver_min =3D (o->ssl_flags >> SSLF_TLS_VERSION_MIN_SHI=
FT)
+        & SSLF_TLS_VERSION_MIN_MASK;
     if (tls_ver_min =3D=3D 0)
     {
-        int tls_ver_max =3D (o->ssl_flags >> SSLF_TLS_VERSION_MAX_SHIFT)
-                          & SSLF_TLS_VERSION_MAX_MASK;
+        unsigned int tls_ver_max =3D (o->ssl_flags >> SSLF_TLS_VERSION_MAX=
_SHIFT)
+            & SSLF_TLS_VERSION_MAX_MASK;
         if (need_compatibility_before(o, 20307))
         {
             /* 2.3.6 and earlier have TLS 1.0 only, set minimum to TLS 1.0=
 */
@@ -9074,9 +9074,8 @@
     }
     else if (streq(p[0], "tls-version-min") && p[1] && !p[3])
     {
-        int ver;
         VERIFY_PERMISSION(OPT_P_GENERAL);
-        ver =3D tls_version_parse(p[1], p[2]);
+        int ver =3D tls_version_parse(p[1], p[2]);
         if (ver =3D=3D TLS_VER_BAD)
         {
             msg(msglevel, "unknown tls-version-min parameter: %s", p[1]);
@@ -9093,13 +9092,12 @@

         options->ssl_flags &=3D
             ~(SSLF_TLS_VERSION_MIN_MASK << SSLF_TLS_VERSION_MIN_SHIFT);
-        options->ssl_flags |=3D (ver << SSLF_TLS_VERSION_MIN_SHIFT);
+        options->ssl_flags |=3D ((unsigned int)ver << SSLF_TLS_VERSION_MIN=
_SHIFT);
     }
     else if (streq(p[0], "tls-version-max") && p[1] && !p[2])
     {
-        int ver;
         VERIFY_PERMISSION(OPT_P_GENERAL);
-        ver =3D tls_version_parse(p[1], NULL);
+        int ver =3D tls_version_parse(p[1], NULL);
         if (ver =3D=3D TLS_VER_BAD)
         {
             msg(msglevel, "unknown tls-version-max parameter: %s", p[1]);
@@ -9107,7 +9105,7 @@
         }
         options->ssl_flags &=3D
             ~(SSLF_TLS_VERSION_MAX_MASK << SSLF_TLS_VERSION_MAX_SHIFT);
-        options->ssl_flags |=3D (ver << SSLF_TLS_VERSION_MAX_SHIFT);
+        options->ssl_flags |=3D ((unsigned int)ver << SSLF_TLS_VERSION_MAX=
_SHIFT);
     }
 #ifndef ENABLE_CRYPTO_MBEDTLS
     else if (streq(p[0], "pkcs12") && p[1] && !p[2])
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index e9e50da..750891c 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -415,17 +415,17 @@
 #endif

     /* configuration file SSL-related boolean and low-permutation options =
*/
-#define SSLF_CLIENT_CERT_NOT_REQUIRED (1<<0)
-#define SSLF_CLIENT_CERT_OPTIONAL     (1<<1)
-#define SSLF_USERNAME_AS_COMMON_NAME  (1<<2)
-#define SSLF_AUTH_USER_PASS_OPTIONAL  (1<<3)
-#define SSLF_OPT_VERIFY               (1<<4)
-#define SSLF_CRL_VERIFY_DIR           (1<<5)
+#define SSLF_CLIENT_CERT_NOT_REQUIRED (1u<<0)
+#define SSLF_CLIENT_CERT_OPTIONAL     (1u<<1)
+#define SSLF_USERNAME_AS_COMMON_NAME  (1u<<2)
+#define SSLF_AUTH_USER_PASS_OPTIONAL  (1u<<3)
+#define SSLF_OPT_VERIFY               (1u<<4)
+#define SSLF_CRL_VERIFY_DIR           (1u<<5)
 #define SSLF_TLS_VERSION_MIN_SHIFT    6
-#define SSLF_TLS_VERSION_MIN_MASK     0xF  /* (uses bit positions 6 to 9) =
*/
+#define SSLF_TLS_VERSION_MIN_MASK     0xFu  /* (uses bit positions 6 to 9)=
 */
 #define SSLF_TLS_VERSION_MAX_SHIFT    10
-#define SSLF_TLS_VERSION_MAX_MASK     0xF  /* (uses bit positions 10 to 13=
) */
-#define SSLF_TLS_DEBUG_ENABLED        (1<<14)
+#define SSLF_TLS_VERSION_MAX_MASK     0xFu  /* (uses bit positions 10 to 1=
3) */
+#define SSLF_TLS_DEBUG_ENABLED        (1u<<14)
     unsigned int ssl_flags;
=20
 #ifdef ENABLE_MANAGEMENT

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1104?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I03e5ece7580ca4ebd41a7928ead544df46e8bad1
Gerrit-Change-Number: 1104
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newpatchset

--MMp5zoHdtEY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #2</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1104?usp=3Demail">View C=
hange</a></p><pre style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">ssl_common: Make sure ssl flags are treated as unsigned<br><br>tl=
s_options.ssl_flags is already unsigned, make sure the<br>flags are as well=
 to avoid spurious conversion warnings.<br><br>Also fix various warning reg=
arding the use of the flags<br>for TLS version handling.<br><br>Change-Id: =
I03e5ece7580ca4ebd41a7928ead544df46e8bad1<br>Signed-off-by: Frank Lichtenhe=
ld &lt;frank@...2641...&gt;<br>---<br>M src/openvpn/options.c<br>M src/open=
vpn/ssl_common.h<br>2 files changed, 20 insertions(+), 22 deletions(-)<br><=
br></pre><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/04/1104/=
2</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;"><span>diff --git a/src/openvpn/options.c b/src/openvpn/options.c</span>=
<br><span>index 0662b49..6ad1170 100644</span><br><span>--- a/src/openvpn/o=
ptions.c</span><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -27=
22,14 +2722,14 @@</span><br><span>             &quot;may accept clients whi=
ch do not present a certificate&quot;);</span><br><span>     }</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const int tl=
s_version_max =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  const unsigned int tls_version_max =3D</span><br><span>         (options-=
&gt;ssl_flags &gt;&gt; SSLF_TLS_VERSION_MAX_SHIFT)</span><br><span>        =
 &amp; SSLF_TLS_VERSION_MAX_MASK;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    const int tls_version_min =3D</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    const unsigned int tls_version_min =3D</span>=
<br><span>         (options-&gt;ssl_flags &gt;&gt; SSLF_TLS_VERSION_MIN_SHI=
FT)</span><br><span>         &amp; SSLF_TLS_VERSION_MIN_MASK;</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (tls_versi=
on_max &gt; 0 &amp;&amp; tls_version_max &lt; tls_version_min)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if (tls_version_max &lt; tls=
_version_min)</span><br><span>     {</span><br><span>         msg(M_USAGE, =
&quot;--tls-version-min bigger than --tls-version-max&quot;);</span><br><sp=
an>     }</span><br><span>@@ -3387,12 +3387,12 @@</span><br><span> options_=
set_backwards_compatible_options(struct options *o)</span><br><span> {</spa=
n><br><span>     /* TLS min version is not set */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    int tls_ver_min =3D (o-&gt;ssl_flags &gt;&g=
t; SSLF_TLS_VERSION_MIN_SHIFT)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                      &amp; SSLF_TLS_VERSION_MIN_MASK;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    unsigned int tls_ver_min =
=3D (o-&gt;ssl_flags &gt;&gt; SSLF_TLS_VERSION_MIN_SHIFT)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        &amp; SSLF_TLS_VERSION_MIN_MA=
SK;</span><br><span>     if (tls_ver_min =3D=3D 0)</span><br><span>     {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        int tls_ver_max=
 =3D (o-&gt;ssl_flags &gt;&gt; SSLF_TLS_VERSION_MAX_SHIFT)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                          &amp; SSLF_T=
LS_VERSION_MAX_MASK;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        unsigned int tls_ver_max =3D (o-&gt;ssl_flags &gt;&gt; SSLF_TLS_VE=
RSION_MAX_SHIFT)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         &amp; SSLF_TLS_VERSION_MAX_MASK;</span><br><span>         if (need=
_compatibility_before(o, 20307))</span><br><span>         {</span><br><span=
>             /* 2.3.6 and earlier have TLS 1.0 only, set minimum to TLS 1.=
0 */</span><br><span>@@ -9074,9 +9074,8 @@</span><br><span>     }</span><br=
><span>     else if (streq(p[0], &quot;tls-version-min&quot;) &amp;&amp; p[=
1] &amp;&amp; !p[3])</span><br><span>     {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        int ver;</span><br><span>         VERIFY_PERM=
ISSION(OPT_P_GENERAL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        ver =3D tls_version_parse(p[1], p[2]);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        int ver =3D tls_version_parse(p[1], p[2=
]);</span><br><span>         if (ver =3D=3D TLS_VER_BAD)</span><br><span>  =
       {</span><br><span>             msg(msglevel, &quot;unknown tls-versi=
on-min parameter: %s&quot;, p[1]);</span><br><span>@@ -9093,13 +9092,12 @@<=
/span><br><span> </span><br><span>         options-&gt;ssl_flags &amp;=3D</=
span><br><span>             ~(SSLF_TLS_VERSION_MIN_MASK &lt;&lt; SSLF_TLS_V=
ERSION_MIN_SHIFT);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     options-&gt;ssl_flags |=3D (ver &lt;&lt; SSLF_TLS_VERSION_MIN_SHIFT);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        options-&gt;=
ssl_flags |=3D ((unsigned int)ver &lt;&lt; SSLF_TLS_VERSION_MIN_SHIFT);</sp=
an><br><span>     }</span><br><span>     else if (streq(p[0], &quot;tls-ver=
sion-max&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        int ver;</span><=
br><span>         VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        ver =3D tls_version_parse(p[1], NUL=
L);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        int ver =
=3D tls_version_parse(p[1], NULL);</span><br><span>         if (ver =3D=3D =
TLS_VER_BAD)</span><br><span>         {</span><br><span>             msg(ms=
glevel, &quot;unknown tls-version-max parameter: %s&quot;, p[1]);</span><br=
><span>@@ -9107,7 +9105,7 @@</span><br><span>         }</span><br><span>   =
      options-&gt;ssl_flags &amp;=3D</span><br><span>             ~(SSLF_TL=
S_VERSION_MAX_MASK &lt;&lt; SSLF_TLS_VERSION_MAX_SHIFT);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        options-&gt;ssl_flags |=3D (ver =
&lt;&lt; SSLF_TLS_VERSION_MAX_SHIFT);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        options-&gt;ssl_flags |=3D ((unsigned int)ver &lt=
;&lt; SSLF_TLS_VERSION_MAX_SHIFT);</span><br><span>     }</span><br><span> =
#ifndef ENABLE_CRYPTO_MBEDTLS</span><br><span>     else if (streq(p[0], &qu=
ot;pkcs12&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>diff --g=
it a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h</span><br><span>in=
dex e9e50da..750891c 100644</span><br><span>--- a/src/openvpn/ssl_common.h<=
/span><br><span>+++ b/src/openvpn/ssl_common.h</span><br><span>@@ -415,17 +=
415,17 @@</span><br><span> #endif</span><br><span> </span><br><span>     /*=
 configuration file SSL-related boolean and low-permutation options */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#define SSLF_CLIENT_CERT_N=
OT_REQUIRED (1&lt;&lt;0)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#define SSLF_CLIENT_CERT_OPTIONAL     (1&lt;&lt;1)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define SSLF_USERNAME_AS_COMMON_NAME  (1&lt=
;&lt;2)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define SSLF_A=
UTH_USER_PASS_OPTIONAL  (1&lt;&lt;3)</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#define SSLF_OPT_VERIFY               (1&lt;&lt;4)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#define SSLF_CRL_VERIFY_DIR    =
       (1&lt;&lt;5)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#define SSLF_CLIENT_CERT_NOT_REQUIRED (1u&lt;&lt;0)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define SSLF_CLIENT_CERT_OPTIONAL     (1u=
&lt;&lt;1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define S=
SLF_USERNAME_AS_COMMON_NAME  (1u&lt;&lt;2)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#define SSLF_AUTH_USER_PASS_OPTIONAL  (1u&lt;&lt;3)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define SSLF_OPT_VER=
IFY               (1u&lt;&lt;4)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#define SSLF_CRL_VERIFY_DIR           (1u&lt;&lt;5)</span><br><=
span> #define SSLF_TLS_VERSION_MIN_SHIFT    6</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#define SSLF_TLS_VERSION_MIN_MASK     0xF  /* (uses=
 bit positions 6 to 9) */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#define SSLF_TLS_VERSION_MIN_MASK     0xFu  /* (uses bit positions 6 =
to 9) */</span><br><span> #define SSLF_TLS_VERSION_MAX_SHIFT    10</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#define SSLF_TLS_VERSION_MAX_M=
ASK     0xF  /* (uses bit positions 10 to 13) */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#define SSLF_TLS_DEBUG_ENABLED        (1&lt;&lt;=
14)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define SSLF_TLS=
_VERSION_MAX_MASK     0xFu  /* (uses bit positions 10 to 13) */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#define SSLF_TLS_DEBUG_ENABLED =
       (1u&lt;&lt;14)</span><br><span>     unsigned int ssl_flags;</span><b=
r><span> </span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span></span>=
<br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/1104?usp=3Demail">change 1104</a>. To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</=
a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div item=
scope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link i=
temprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1104?usp=3Dem=
ail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I03e5ece7580ca4ebd41a7928ead=
544df46e8bad1 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1104 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--MMp5zoHdtEY=--

