From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 14 Sep 2025 12:21:32 +0000
In-Reply-To: <gerrit.1753360288000.I03e5ece7580ca4ebd41a7928ead544df46e8bad1@...2715...>
References: <gerrit.1753360288000.I03e5ece7580ca4ebd41a7928ead544df46e8bad1@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 max@...2606...
Message-ID: <d50900a836869b9af445275ec0b7a450c858ef07-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="7Izx2au8vlc="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: MaxF <max@...2606...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--7Izx2au8vlc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/11=
04?usp=3Demail )

Change subject: ssl_common: Make sure ssl flags are treated as unsigned
......................................................................

ssl_common: Make sure ssl flags are treated as unsigned

tls_options.ssl_flags is already unsigned, make sure the
flags are as well to avoid spurious conversion warnings.

Also fix various warning regarding the use of the flags
for TLS version handling.

Change-Id: I03e5ece7580ca4ebd41a7928ead544df46e8bad1
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: MaxF <max@...2606...>
Message-Id: <20250911201658.25736-1-gert@...1296...>
URL: https://sourceforge.net/p/openvpn/mailman/message/59232184/
URL: https://gerrit.openvpn.net/c/openvpn/+/1104
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/options.c
M src/openvpn/ssl_common.h
2 files changed, 17 insertions(+), 19 deletions(-)




diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 6858a69..18cc1d9 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2717,9 +2717,9 @@
                     "may accept clients which do not present a certificate=
");
     }

-    const int tls_version_max =3D
+    const unsigned int tls_version_max =3D
         (options->ssl_flags >> SSLF_TLS_VERSION_MAX_SHIFT) & SSLF_TLS_VERS=
ION_MAX_MASK;
-    const int tls_version_min =3D
+    const unsigned int tls_version_min =3D
         (options->ssl_flags >> SSLF_TLS_VERSION_MIN_SHIFT) & SSLF_TLS_VERS=
ION_MIN_MASK;

     if (tls_version_max > 0 && tls_version_max < tls_version_min)
@@ -3385,10 +3385,10 @@
 options_set_backwards_compatible_options(struct options *o)
 {
     /* TLS min version is not set */
-    int tls_ver_min =3D (o->ssl_flags >> SSLF_TLS_VERSION_MIN_SHIFT) & SSL=
F_TLS_VERSION_MIN_MASK;
+    unsigned int tls_ver_min =3D (o->ssl_flags >> SSLF_TLS_VERSION_MIN_SHI=
FT) & SSLF_TLS_VERSION_MIN_MASK;
     if (tls_ver_min =3D=3D 0)
     {
-        int tls_ver_max =3D (o->ssl_flags >> SSLF_TLS_VERSION_MAX_SHIFT) &=
 SSLF_TLS_VERSION_MAX_MASK;
+        unsigned int tls_ver_max =3D (o->ssl_flags >> SSLF_TLS_VERSION_MAX=
_SHIFT) & SSLF_TLS_VERSION_MAX_MASK;
         if (need_compatibility_before(o, 20307))
         {
             /* 2.3.6 and earlier have TLS 1.0 only, set minimum to TLS 1.0=
 */
@@ -9302,9 +9302,8 @@
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
@@ -9320,20 +9319,19 @@
 #endif

         options->ssl_flags &=3D ~(SSLF_TLS_VERSION_MIN_MASK << SSLF_TLS_VE=
RSION_MIN_SHIFT);
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
             goto err;
         }
         options->ssl_flags &=3D ~(SSLF_TLS_VERSION_MAX_MASK << SSLF_TLS_VE=
RSION_MAX_SHIFT);
-        options->ssl_flags |=3D (ver << SSLF_TLS_VERSION_MAX_SHIFT);
+        options->ssl_flags |=3D ((unsigned int)ver << SSLF_TLS_VERSION_MAX=
_SHIFT);
     }
 #ifndef ENABLE_CRYPTO_MBEDTLS
     else if (streq(p[0], "pkcs12") && p[1] && !p[2])
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 428bf5a..a40f18d 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -421,17 +421,17 @@
 #endif

     /* configuration file SSL-related boolean and low-permutation options =
*/
-#define SSLF_CLIENT_CERT_NOT_REQUIRED (1 << 0)
-#define SSLF_CLIENT_CERT_OPTIONAL     (1 << 1)
-#define SSLF_USERNAME_AS_COMMON_NAME  (1 << 2)
-#define SSLF_AUTH_USER_PASS_OPTIONAL  (1 << 3)
-#define SSLF_OPT_VERIFY               (1 << 4)
-#define SSLF_CRL_VERIFY_DIR           (1 << 5)
+#define SSLF_CLIENT_CERT_NOT_REQUIRED (1u << 0)
+#define SSLF_CLIENT_CERT_OPTIONAL     (1u << 1)
+#define SSLF_USERNAME_AS_COMMON_NAME  (1u << 2)
+#define SSLF_AUTH_USER_PASS_OPTIONAL  (1u << 3)
+#define SSLF_OPT_VERIFY               (1u << 4)
+#define SSLF_CRL_VERIFY_DIR           (1u << 5)
 #define SSLF_TLS_VERSION_MIN_SHIFT    6
-#define SSLF_TLS_VERSION_MIN_MASK     0xF /* (uses bit positions 6 to 9) */
+#define SSLF_TLS_VERSION_MIN_MASK     0xFu /* (uses bit positions 6 to 9) =
*/
 #define SSLF_TLS_VERSION_MAX_SHIFT    10
-#define SSLF_TLS_VERSION_MAX_MASK     0xF /* (uses bit positions 10 to 13)=
 */
-#define SSLF_TLS_DEBUG_ENABLED        (1 << 14)
+#define SSLF_TLS_VERSION_MAX_MASK     0xFu /* (uses bit positions 10 to 13=
) */
+#define SSLF_TLS_DEBUG_ENABLED        (1u << 14)
     unsigned int ssl_flags;

 #ifdef ENABLE_MANAGEMENT

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1104?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I03e5ece7580ca4ebd41a7928ead544df46e8bad1
Gerrit-Change-Number: 1104
Gerrit-PatchSet: 10
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: MaxF <max@...2606...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--7Izx2au8vlc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1104?usp=3Demail">View Change</a></p><div styl=
e=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">ssl_common: Make sure ssl flags are treated a=
s unsigned<br><br>tls_options.ssl_flags is already unsigned, make sure the<=
br>flags are as well to avoid spurious conversion warnings.<br><br>Also fix=
 various warning regarding the use of the flags<br>for TLS version handling=
.<br><br>Change-Id: I03e5ece7580ca4ebd41a7928ead544df46e8bad1<br>Signed-off=
-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: MaxF &lt;max@...220...=
..2606...&gt;<br>Message-Id: &lt;20250911201658.25736-1-gert@...1296...&gt;=
<br>URL: https://sourceforge.net/p/openvpn/mailman/message/59232184/<br>URL=
: https://gerrit.openvpn.net/c/openvpn/+/1104<br>Signed-off-by: Gert Doerin=
g &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/options.c<br>M src/openvp=
n/ssl_common.h<br>2 files changed, 17 insertions(+), 19 deletions(-)<br><br=
></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/options.c b/src/openvpn/options.c</span><br><sp=
an>index 6858a69..18cc1d9 100644</span><br><span>--- a/src/openvpn/options.=
c</span><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -2717,9 +2=
717,9 @@</span><br><span>                     &quot;may accept clients whic=
h do not present a certificate&quot;);</span><br><span>     }</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const int tls=
_version_max =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 const unsigned int tls_version_max =3D</span><br><span>         (options-&=
gt;ssl_flags &gt;&gt; SSLF_TLS_VERSION_MAX_SHIFT) &amp; SSLF_TLS_VERSION_MA=
X_MASK;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const int =
tls_version_min =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    const unsigned int tls_version_min =3D</span><br><span>         (option=
s-&gt;ssl_flags &gt;&gt; SSLF_TLS_VERSION_MIN_SHIFT) &amp; SSLF_TLS_VERSION=
_MIN_MASK;</span><br><span> </span><br><span>     if (tls_version_max &gt; =
0 &amp;&amp; tls_version_max &lt; tls_version_min)</span><br><span>@@ -3385=
,10 +3385,10 @@</span><br><span> options_set_backwards_compatible_options(s=
truct options *o)</span><br><span> {</span><br><span>     /* TLS min versio=
n is not set */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    in=
t tls_ver_min =3D (o-&gt;ssl_flags &gt;&gt; SSLF_TLS_VERSION_MIN_SHIFT) &am=
p; SSLF_TLS_VERSION_MIN_MASK;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    unsigned int tls_ver_min =3D (o-&gt;ssl_flags &gt;&gt; SSLF_T=
LS_VERSION_MIN_SHIFT) &amp; SSLF_TLS_VERSION_MIN_MASK;</span><br><span>    =
 if (tls_ver_min =3D=3D 0)</span><br><span>     {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        int tls_ver_max =3D (o-&gt;ssl_flags &g=
t;&gt; SSLF_TLS_VERSION_MAX_SHIFT) &amp; SSLF_TLS_VERSION_MAX_MASK;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        unsigned int tls_ve=
r_max =3D (o-&gt;ssl_flags &gt;&gt; SSLF_TLS_VERSION_MAX_SHIFT) &amp; SSLF_=
TLS_VERSION_MAX_MASK;</span><br><span>         if (need_compatibility_befor=
e(o, 20307))</span><br><span>         {</span><br><span>             /* 2.3=
.6 and earlier have TLS 1.0 only, set minimum to TLS 1.0 */</span><br><span=
>@@ -9302,9 +9302,8 @@</span><br><span>     }</span><br><span>     else if =
(streq(p[0], &quot;tls-version-min&quot;) &amp;&amp; p[1] &amp;&amp; !p[3])=
</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        int ver;</span><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ver =3D tls=
_version_parse(p[1], p[2]);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        int ver =3D tls_version_parse(p[1], p[2]);</span><br><span>=
         if (ver =3D=3D TLS_VER_BAD)</span><br><span>         {</span><br><=
span>             msg(msglevel, &quot;unknown tls-version-min parameter: %s=
&quot;, p[1]);</span><br><span>@@ -9320,20 +9319,19 @@</span><br><span> #en=
dif</span><br><span> </span><br><span>         options-&gt;ssl_flags &amp;=
=3D ~(SSLF_TLS_VERSION_MIN_MASK &lt;&lt; SSLF_TLS_VERSION_MIN_SHIFT);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        options-&gt;ssl_fla=
gs |=3D (ver &lt;&lt; SSLF_TLS_VERSION_MIN_SHIFT);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        options-&gt;ssl_flags |=3D ((unsigne=
d int)ver &lt;&lt; SSLF_TLS_VERSION_MIN_SHIFT);</span><br><span>     }</spa=
n><br><span>     else if (streq(p[0], &quot;tls-version-max&quot;) &amp;&am=
p; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        int ver;</span><br><span>         VERIFY=
_PERMISSION(OPT_P_GENERAL);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        ver =3D tls_version_parse(p[1], NULL);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        int ver =3D tls_version_parse(p[1=
], NULL);</span><br><span>         if (ver =3D=3D TLS_VER_BAD)</span><br><s=
pan>         {</span><br><span>             msg(msglevel, &quot;unknown tls=
-version-max parameter: %s&quot;, p[1]);</span><br><span>             goto =
err;</span><br><span>         }</span><br><span>         options-&gt;ssl_fl=
ags &amp;=3D ~(SSLF_TLS_VERSION_MAX_MASK &lt;&lt; SSLF_TLS_VERSION_MAX_SHIF=
T);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        options-&g=
t;ssl_flags |=3D (ver &lt;&lt; SSLF_TLS_VERSION_MAX_SHIFT);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        options-&gt;ssl_flags |=3D =
((unsigned int)ver &lt;&lt; SSLF_TLS_VERSION_MAX_SHIFT);</span><br><span>  =
   }</span><br><span> #ifndef ENABLE_CRYPTO_MBEDTLS</span><br><span>     el=
se if (streq(p[0], &quot;pkcs12&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</s=
pan><br><span>diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_commo=
n.h</span><br><span>index 428bf5a..a40f18d 100644</span><br><span>--- a/src=
/openvpn/ssl_common.h</span><br><span>+++ b/src/openvpn/ssl_common.h</span>=
<br><span>@@ -421,17 +421,17 @@</span><br><span> #endif</span><br><span> </=
span><br><span>     /* configuration file SSL-related boolean and low-permu=
tation options */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#def=
ine SSLF_CLIENT_CERT_NOT_REQUIRED (1 &lt;&lt; 0)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#define SSLF_CLIENT_CERT_OPTIONAL     (1 &lt;&lt=
; 1)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define SSLF_USER=
NAME_AS_COMMON_NAME  (1 &lt;&lt; 2)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#define SSLF_AUTH_USER_PASS_OPTIONAL  (1 &lt;&lt; 3)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#define SSLF_OPT_VERIFY       =
        (1 &lt;&lt; 4)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#define SSLF_CRL_VERIFY_DIR           (1 &lt;&lt; 5)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define SSLF_CLIENT_CERT_NOT_REQUIRED (1u=
 &lt;&lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define=
 SSLF_CLIENT_CERT_OPTIONAL     (1u &lt;&lt; 1)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#define SSLF_USERNAME_AS_COMMON_NAME  (1u &lt;&l=
t; 2)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define SSLF_A=
UTH_USER_PASS_OPTIONAL  (1u &lt;&lt; 3)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#define SSLF_OPT_VERIFY               (1u &lt;&lt; 4)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define SSLF_CRL_VERI=
FY_DIR           (1u &lt;&lt; 5)</span><br><span> #define SSLF_TLS_VERSION_=
MIN_SHIFT    6</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define=
 SSLF_TLS_VERSION_MIN_MASK     0xF /* (uses bit positions 6 to 9) */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#define SSLF_TLS_VERSION_M=
IN_MASK     0xFu /* (uses bit positions 6 to 9) */</span><br><span> #define=
 SSLF_TLS_VERSION_MAX_SHIFT    10</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#define SSLF_TLS_VERSION_MAX_MASK     0xF /* (uses bit position=
s 10 to 13) */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define=
 SSLF_TLS_DEBUG_ENABLED        (1 &lt;&lt; 14)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#define SSLF_TLS_VERSION_MAX_MASK     0xFu /* (u=
ses bit positions 10 to 13) */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#define SSLF_TLS_DEBUG_ENABLED        (1u &lt;&lt; 14)</span><br=
><span>     unsigned int ssl_flags;</span><br><span> </span><br><span> #ifd=
ef ENABLE_MANAGEMENT</span><br><span></span><br></pre><p>To view, visit <a =
href=3D"http://gerrit.openvpn.net/c/openvpn/+/1104?usp=3Demail">change 1104=
</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"ht=
tp://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1104?usp=3Demail"/><meta itemprop=3D"name" =
content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I03e5ece7580ca4ebd41a7928ead=
544df46e8bad1 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1104 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 10 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: MaxF &lt;max@...2606...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--7Izx2au8vlc=--

