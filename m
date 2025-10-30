From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 30 Oct 2025 21:03:55 +0000
In-Reply-To: <gerrit.1761756587000.I830b6b27fc3efe707e103ba629c4bfe3796a9cbe@...2715...>
References: <gerrit.1761756587000.I830b6b27fc3efe707e103ba629c4bfe3796a9cbe@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <69a689e5eaa31af2b4c772000597e7283d0a53f7-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="xiT+ASWRUbU="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Ensure return value
 of snprintf is correctly checked
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--xiT+ASWRUbU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/13=
30?usp=3Demail )

Change subject: Ensure return value of snprintf is correctly checked
......................................................................

Ensure return value of snprintf is correctly checked

Commit 130548fe4d change the usages of openvpn_snprintf to snprintf. When
doing that conversion I did not notice that, despite the function name,
openvpn_snprintf had a different semantic for the return value.

This commit goes through all the usages of snprintf and ensures that
the return is correctly checked for overruns.

Reported-by: Joshua Rogers <contact@...2949...>
Found-by: ZeroPath (https://zeropath.com/)
Change-Id: I830b6b27fc3efe707e103ba629c4bfe3796a9cbe
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1330
Message-Id: <20251030193638.1010-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
063.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/crypto_mbedtls.c
M src/openvpn/dns.c
M src/openvpn/env_set.c
M src/openvpn/platform.c
M src/openvpn/ssl_ncp.c
M src/openvpn/ssl_verify.c
M src/openvpn/ssl_verify_mbedtls.c
M src/openvpn/win32.c
8 files changed, 21 insertions(+), 16 deletions(-)




diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index 2e328c3..89f0ab9 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -127,7 +127,7 @@
 {
     char prefix[256];

-    if (!snprintf(prefix, sizeof(prefix), "%s:%d", func, line))
+    if (snprintf(prefix, sizeof(prefix), "%s:%d", func, line) >=3D sizeof(=
prefix))
     {
         return mbed_log_err(flags, errval, func);
     }
@@ -243,11 +243,11 @@
     char header[1000 + 1] =3D { 0 };
     char footer[1000 + 1] =3D { 0 };

-    if (!snprintf(header, sizeof(header), "-----BEGIN %s-----\n", name))
+    if (snprintf(header, sizeof(header), "-----BEGIN %s-----\n", name) >=
=3D sizeof(header))
     {
         return false;
     }
-    if (!snprintf(footer, sizeof(footer), "-----END %s-----\n", name))
+    if (snprintf(footer, sizeof(footer), "-----END %s-----\n", name) >=3D =
sizeof(footer))
     {
         return false;
     }
@@ -280,11 +280,11 @@
     char header[1000 + 1] =3D { 0 };
     char footer[1000 + 1] =3D { 0 };

-    if (!snprintf(header, sizeof(header), "-----BEGIN %s-----", name))
+    if (snprintf(header, sizeof(header), "-----BEGIN %s-----", name) >=3D =
sizeof(header))
     {
         return false;
     }
-    if (!snprintf(footer, sizeof(footer), "-----END %s-----", name))
+    if (snprintf(footer, sizeof(footer), "-----END %s-----", name) >=3D si=
zeof(footer))
     {
         return false;
     }
diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c
index d2ff670..539023f 100644
--- a/src/openvpn/dns.c
+++ b/src/openvpn/dns.c
@@ -485,11 +485,13 @@

     if (j < 0)
     {
-        name_ok =3D snprintf(name, sizeof(name), format, i);
+        const int ret =3D snprintf(name, sizeof(name), format, i);
+        name_ok =3D (ret > 0 && ret < sizeof(name));
     }
     else
     {
-        name_ok =3D snprintf(name, sizeof(name), format, i, j);
+        const int ret =3D snprintf(name, sizeof(name), format, i, j);
+        name_ok =3D (ret > 0 && ret < sizeof(name));
     }

     if (!name_ok)
diff --git a/src/openvpn/env_set.c b/src/openvpn/env_set.c
index 2ae71ab..1311e6f 100644
--- a/src/openvpn/env_set.c
+++ b/src/openvpn/env_set.c
@@ -334,7 +334,7 @@
     strcpy(tmpname, name);
     while (NULL !=3D env_set_get(es, tmpname) && counter < 1000)
     {
-        ASSERT(snprintf(tmpname, tmpname_len, "%s_%u", name, counter));
+        ASSERT(snprintf(tmpname, tmpname_len, "%s_%u", name, counter) < tm=
pname_len);
         counter++;
     }
     if (counter < 1000)
diff --git a/src/openvpn/platform.c b/src/openvpn/platform.c
index a1ffdaf..a612237 100644
--- a/src/openvpn/platform.c
+++ b/src/openvpn/platform.c
@@ -550,8 +550,9 @@
     {
         ++attempts;

-        if (!snprintf(fname, sizeof(fname), fname_fmt, max_prefix_len, pre=
fix,
-                      (unsigned long)get_random(), (unsigned long)get_rand=
om()))
+        const int ret =3D snprintf(fname, sizeof(fname), fname_fmt, max_pr=
efix_len, prefix,
+                                 (unsigned long)get_random(), (unsigned lo=
ng)get_random());
+        if (ret < 0 || ret >=3D sizeof(fname))
         {
             msg(M_WARN, "ERROR: temporary filename too long");
             return NULL;
diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c
index 790e50f..d4519b0 100644
--- a/src/openvpn/ssl_ncp.c
+++ b/src/openvpn/ssl_ncp.c
@@ -198,7 +198,7 @@
     size_t newlen =3D strlen(o->ncp_ciphers) + 1 + strlen(ciphername) + 1;
     char *ncp_ciphers =3D gc_malloc(newlen, false, &o->gc);

-    ASSERT(snprintf(ncp_ciphers, newlen, "%s:%s", o->ncp_ciphers, cipherna=
me));
+    ASSERT(snprintf(ncp_ciphers, newlen, "%s:%s", o->ncp_ciphers, cipherna=
me) < newlen);
     o->ncp_ciphers =3D ncp_ciphers;
 }

diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index a16f5fa..a11003c 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -548,7 +548,7 @@
         goto cleanup;
     }

-    if (!snprintf(fn, sizeof(fn), "%s%c%s", crl_dir, PATH_SEPARATOR, seria=
l))
+    if (snprintf(fn, sizeof(fn), "%s%c%s", crl_dir, PATH_SEPARATOR, serial=
) >=3D sizeof(fn))
     {
         msg(D_HANDSHAKE, "VERIFY CRL: filename overflow");
         goto cleanup;
diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbed=
tls.c
index 472eb49..9e2aa19 100644
--- a/src/openvpn/ssl_verify_mbedtls.c
+++ b/src/openvpn/ssl_verify_mbedtls.c
@@ -85,8 +85,9 @@

         ret =3D mbedtls_x509_crt_verify_info(errstr, sizeof(errstr) - 1, "=
", *flags);
         if (ret <=3D 0
-            && !snprintf(errstr, sizeof(errstr), "Could not retrieve error=
 string, flags=3D%" PRIx32,
-                         *flags))
+            && snprintf(errstr, sizeof(errstr), "Could not retrieve error =
string, flags=3D%" PRIx32,
+                        *flags)
+                   >=3D sizeof(errstr))
         {
             errstr[0] =3D '\0';
         }
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index 3c11ec3..df29dd7 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -881,8 +881,9 @@
     char force_path[256];
     char *sysroot =3D get_win_sys_path();

-    if (!snprintf(force_path, sizeof(force_path), "PATH=3D%s\\System32;%s;=
%s\\System32\\Wbem",
-                  sysroot, sysroot, sysroot))
+    if (snprintf(force_path, sizeof(force_path), "PATH=3D%s\\System32;%s;%=
s\\System32\\Wbem",
+                 sysroot, sysroot, sysroot)
+        >=3D sizeof(force_path))
     {
         msg(M_WARN, "env_block: default path truncated to %s", force_path);
     }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1330?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I830b6b27fc3efe707e103ba629c4bfe3796a9cbe
Gerrit-Change-Number: 1330
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--xiT+ASWRUbU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1330?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">Ensure return value of snprintf is correctly che=
cked<br><br>Commit 130548fe4d change the usages of openvpn_snprintf to snpr=
intf. When<br>doing that conversion I did not notice that, despite the func=
tion name,<br>openvpn_snprintf had a different semantic for the return valu=
e.<br><br>This commit goes through all the usages of snprintf and ensures t=
hat<br>the return is correctly checked for overruns.<br><br>Reported-by: Jo=
shua Rogers &lt;contact@...2949...&gt;<br>Found-by: ZeroPath (https://zerop=
ath.com/)<br>Change-Id: I830b6b27fc3efe707e103ba629c4bfe3796a9cbe<br>Signed=
-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>Acked-by: Gert Doering &lt=
;gert@...1296...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/=
1330<br>Message-Id: &lt;20251030193638.1010-1-gert@...1296...&gt;<br>URL: h=
ttps://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34063.ht=
ml<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/o=
penvpn/crypto_mbedtls.c<br>M src/openvpn/dns.c<br>M src/openvpn/env_set.c<b=
r>M src/openvpn/platform.c<br>M src/openvpn/ssl_ncp.c<br>M src/openvpn/ssl_=
verify.c<br>M src/openvpn/ssl_verify_mbedtls.c<br>M src/openvpn/win32.c<br>=
8 files changed, 21 insertions(+), 16 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c=
</span><br><span>index 2e328c3..89f0ab9 100644</span><br><span>--- a/src/op=
envpn/crypto_mbedtls.c</span><br><span>+++ b/src/openvpn/crypto_mbedtls.c</=
span><br><span>@@ -127,7 +127,7 @@</span><br><span> {</span><br><span>     =
char prefix[256];</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    if (!snprintf(prefix, sizeof(prefix), &quot;%s:%d&quot;, =
func, line))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if =
(snprintf(prefix, sizeof(prefix), &quot;%s:%d&quot;, func, line) &gt;=3D si=
zeof(prefix))</span><br><span>     {</span><br><span>         return mbed_l=
og_err(flags, errval, func);</span><br><span>     }</span><br><span>@@ -243=
,11 +243,11 @@</span><br><span>     char header[1000 + 1] =3D { 0 };</span>=
<br><span>     char footer[1000 + 1] =3D { 0 };</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    if (!snprintf(header, sizeo=
f(header), &quot;-----BEGIN %s-----\n&quot;, name))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (snprintf(header, sizeof(header), =
&quot;-----BEGIN %s-----\n&quot;, name) &gt;=3D sizeof(header))</span><br><=
span>     {</span><br><span>         return false;</span><br><span>     }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!snprintf(foote=
r, sizeof(footer), &quot;-----END %s-----\n&quot;, name))</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (snprintf(footer, sizeof(foote=
r), &quot;-----END %s-----\n&quot;, name) &gt;=3D sizeof(footer))</span><br=
><span>     {</span><br><span>         return false;</span><br><span>     }=
</span><br><span>@@ -280,11 +280,11 @@</span><br><span>     char header[100=
0 + 1] =3D { 0 };</span><br><span>     char footer[1000 + 1] =3D { 0 };</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if =
(!snprintf(header, sizeof(header), &quot;-----BEGIN %s-----&quot;, name))</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (snprintf(head=
er, sizeof(header), &quot;-----BEGIN %s-----&quot;, name) &gt;=3D sizeof(he=
ader))</span><br><span>     {</span><br><span>         return false;</span>=
<br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    i=
f (!snprintf(footer, sizeof(footer), &quot;-----END %s-----&quot;, name))</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (snprintf(foot=
er, sizeof(footer), &quot;-----END %s-----&quot;, name) &gt;=3D sizeof(foot=
er))</span><br><span>     {</span><br><span>         return false;</span><b=
r><span>     }</span><br><span>diff --git a/src/openvpn/dns.c b/src/openvpn=
/dns.c</span><br><span>index d2ff670..539023f 100644</span><br><span>--- a/=
src/openvpn/dns.c</span><br><span>+++ b/src/openvpn/dns.c</span><br><span>@=
@ -485,11 +485,13 @@</span><br><span> </span><br><span>     if (j &lt; 0)</=
span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        name_ok =3D snprintf(name, sizeof(name), format, i);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        const int ret =3D snprintf=
(name, sizeof(name), format, i);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        name_ok =3D (ret &gt; 0 &amp;&amp; ret &lt; sizeof(nam=
e));</span><br><span>     }</span><br><span>     else</span><br><span>     =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        name_ok =3D =
snprintf(name, sizeof(name), format, i, j);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        const int ret =3D snprintf(name, sizeof(nam=
e), format, i, j);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       name_ok =3D (ret &gt; 0 &amp;&amp; ret &lt; sizeof(name));</span><br=
><span>     }</span><br><span> </span><br><span>     if (!name_ok)</span><b=
r><span>diff --git a/src/openvpn/env_set.c b/src/openvpn/env_set.c</span><b=
r><span>index 2ae71ab..1311e6f 100644</span><br><span>--- a/src/openvpn/env=
_set.c</span><br><span>+++ b/src/openvpn/env_set.c</span><br><span>@@ -334,=
7 +334,7 @@</span><br><span>     strcpy(tmpname, name);</span><br><span>   =
  while (NULL !=3D env_set_get(es, tmpname) &amp;&amp; counter &lt; 1000)</=
span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        ASSERT(snprintf(tmpname, tmpname_len, &quot;%s_%u&quot;, name, coun=
ter));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ASSER=
T(snprintf(tmpname, tmpname_len, &quot;%s_%u&quot;, name, counter) &lt; tmp=
name_len);</span><br><span>         counter++;</span><br><span>     }</span=
><br><span>     if (counter &lt; 1000)</span><br><span>diff --git a/src/ope=
nvpn/platform.c b/src/openvpn/platform.c</span><br><span>index a1ffdaf..a61=
2237 100644</span><br><span>--- a/src/openvpn/platform.c</span><br><span>++=
+ b/src/openvpn/platform.c</span><br><span>@@ -550,8 +550,9 @@</span><br><s=
pan>     {</span><br><span>         ++attempts;</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        if (!snprintf(fname, si=
zeof(fname), fname_fmt, max_prefix_len, prefix,</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                      (unsigned long)get_random()=
, (unsigned long)get_random()))</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        const int ret =3D snprintf(fname, sizeof(fname), fname_=
fmt, max_prefix_len, prefix,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                                 (unsigned long)get_random(), (uns=
igned long)get_random());</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        if (ret &lt; 0 || ret &gt;=3D sizeof(fname))</span><br><span>=
         {</span><br><span>             msg(M_WARN, &quot;ERROR: temporary =
filename too long&quot;);</span><br><span>             return NULL;</span><=
br><span>diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c</span><=
br><span>index 790e50f..d4519b0 100644</span><br><span>--- a/src/openvpn/ss=
l_ncp.c</span><br><span>+++ b/src/openvpn/ssl_ncp.c</span><br><span>@@ -198=
,7 +198,7 @@</span><br><span>     size_t newlen =3D strlen(o-&gt;ncp_cipher=
s) + 1 + strlen(ciphername) + 1;</span><br><span>     char *ncp_ciphers =3D=
 gc_malloc(newlen, false, &amp;o-&gt;gc);</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(snprintf(ncp_ciphers, newl=
en, &quot;%s:%s&quot;, o-&gt;ncp_ciphers, ciphername));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    ASSERT(snprintf(ncp_ciphers, newlen=
, &quot;%s:%s&quot;, o-&gt;ncp_ciphers, ciphername) &lt; newlen);</span><br=
><span>     o-&gt;ncp_ciphers =3D ncp_ciphers;</span><br><span> }</span><br=
><span> </span><br><span>diff --git a/src/openvpn/ssl_verify.c b/src/openvp=
n/ssl_verify.c</span><br><span>index a16f5fa..a11003c 100644</span><br><spa=
n>--- a/src/openvpn/ssl_verify.c</span><br><span>+++ b/src/openvpn/ssl_veri=
fy.c</span><br><span>@@ -548,7 +548,7 @@</span><br><span>         goto clea=
nup;</span><br><span>     }</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    if (!snprintf(fn, sizeof(fn), &quot;%s%c%s&quot=
;, crl_dir, PATH_SEPARATOR, serial))</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if (snprintf(fn, sizeof(fn), &quot;%s%c%s&quot;, crl_d=
ir, PATH_SEPARATOR, serial) &gt;=3D sizeof(fn))</span><br><span>     {</spa=
n><br><span>         msg(D_HANDSHAKE, &quot;VERIFY CRL: filename overflow&q=
uot;);</span><br><span>         goto cleanup;</span><br><span>diff --git a/=
src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbedtls.c</span><=
br><span>index 472eb49..9e2aa19 100644</span><br><span>--- a/src/openvpn/ss=
l_verify_mbedtls.c</span><br><span>+++ b/src/openvpn/ssl_verify_mbedtls.c</=
span><br><span>@@ -85,8 +85,9 @@</span><br><span> </span><br><span>        =
 ret =3D mbedtls_x509_crt_verify_info(errstr, sizeof(errstr) - 1, &quot;&qu=
ot;, *flags);</span><br><span>         if (ret &lt;=3D 0</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            &amp;&amp; !snprintf(errstr,=
 sizeof(errstr), &quot;Could not retrieve error string, flags=3D%&quot; PRI=
x32,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
        *flags))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         &amp;&amp; snprintf(errstr, sizeof(errstr), &quot;Could not retrie=
ve error string, flags=3D%&quot; PRIx32,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                        *flags)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                   &gt;=3D sizeof(errstr)=
)</span><br><span>         {</span><br><span>             errstr[0] =3D &#3=
9;\0&#39;;</span><br><span>         }</span><br><span>diff --git a/src/open=
vpn/win32.c b/src/openvpn/win32.c</span><br><span>index 3c11ec3..df29dd7 10=
0644</span><br><span>--- a/src/openvpn/win32.c</span><br><span>+++ b/src/op=
envpn/win32.c</span><br><span>@@ -881,8 +881,9 @@</span><br><span>     char=
 force_path[256];</span><br><span>     char *sysroot =3D get_win_sys_path()=
;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  if (!snprintf(force_path, sizeof(force_path), &quot;PATH=3D%s\\System32;%=
s;%s\\System32\\Wbem&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                  sysroot, sysroot, sysroot))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (snprintf(force_path, sizeof(force=
_path), &quot;PATH=3D%s\\System32;%s;%s\\System32\\Wbem&quot;,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                 sysroot, sysroo=
t, sysroot)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
&gt;=3D sizeof(force_path))</span><br><span>     {</span><br><span>        =
 msg(M_WARN, &quot;env_block: default path truncated to %s&quot;, force_pat=
h);</span><br><span>     }</span><br><span></span><br></pre><p>To view, vis=
it <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1330?usp=3Demail">chang=
e 1330</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div i=
temscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"ur=
l" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1330?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I830b6b27fc3efe707e103ba629c=
4bfe3796a9cbe </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1330 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--xiT+ASWRUbU=--

