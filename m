From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 30 Oct 2025 21:03:52 +0000
In-Reply-To: <gerrit.1761756587000.I830b6b27fc3efe707e103ba629c4bfe3796a9cbe@...2715...>
References: <gerrit.1761756587000.I830b6b27fc3efe707e103ba629c4bfe3796a9cbe@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <69a689e5eaa31af2b4c772000597e7283d0a53f7-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="9tF5HpDiacc="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--9tF5HpDiacc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 plaisthos. ( http://gerrit.openvpn.net/c/openvpn/+/1330?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/30/1330/2

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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I830b6b27fc3efe707e103ba629c4bfe3796a9cbe
Gerrit-Change-Number: 1330
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--9tF5HpDiacc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by plaisthos.<=
/p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1330?usp=3Demail">Vi=
ew Change</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">Ensure return value of snprintf is =
correctly checked<br><br>Commit 130548fe4d change the usages of openvpn_snp=
rintf to snprintf. When<br>doing that conversion I did not notice that, des=
pite the function name,<br>openvpn_snprintf had a different semantic for th=
e return value.<br><br>This commit goes through all the usages of snprintf =
and ensures that<br>the return is correctly checked for overruns.<br><br>Re=
ported-by: Joshua Rogers &lt;contact@...2949...&gt;<br>Found-by: ZeroPath (=
https://zeropath.com/)<br>Change-Id: I830b6b27fc3efe707e103ba629c4bfe3796a9=
cbe<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>Acked-by: Ger=
t Doering &lt;gert@...1296...&gt;<br>Gerrit URL: https://gerrit.openvpn.net=
/c/openvpn/+/1330<br>Message-Id: &lt;20251030193638.1010-1-gert@...1296...&=
gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...475...=
t/msg34063.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>-=
--<br>M src/openvpn/crypto_mbedtls.c<br>M src/openvpn/dns.c<br>M src/openvp=
n/env_set.c<br>M src/openvpn/platform.c<br>M src/openvpn/ssl_ncp.c<br>M src=
/openvpn/ssl_verify.c<br>M src/openvpn/ssl_verify_mbedtls.c<br>M src/openvp=
n/win32.c<br>8 files changed, 21 insertions(+), 16 deletions(-)<br><br></pr=
e><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/change=
s/30/1330/2</pre><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;"><span>diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn=
/crypto_mbedtls.c</span><br><span>index 2e328c3..89f0ab9 100644</span><br><=
span>--- a/src/openvpn/crypto_mbedtls.c</span><br><span>+++ b/src/openvpn/c=
rypto_mbedtls.c</span><br><span>@@ -127,7 +127,7 @@</span><br><span> {</spa=
n><br><span>     char prefix[256];</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (!snprintf(prefix, sizeof(prefix), &=
quot;%s:%d&quot;, func, line))</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if (snprintf(prefix, sizeof(prefix), &quot;%s:%d&quot;, func=
, line) &gt;=3D sizeof(prefix))</span><br><span>     {</span><br><span>    =
     return mbed_log_err(flags, errval, func);</span><br><span>     }</span=
><br><span>@@ -243,11 +243,11 @@</span><br><span>     char header[1000 + 1]=
 =3D { 0 };</span><br><span>     char footer[1000 + 1] =3D { 0 };</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!snpr=
intf(header, sizeof(header), &quot;-----BEGIN %s-----\n&quot;, name))</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (snprintf(header, =
sizeof(header), &quot;-----BEGIN %s-----\n&quot;, name) &gt;=3D sizeof(head=
er))</span><br><span>     {</span><br><span>         return false;</span><b=
r><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if =
(!snprintf(footer, sizeof(footer), &quot;-----END %s-----\n&quot;, name))</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (snprintf(foot=
er, sizeof(footer), &quot;-----END %s-----\n&quot;, name) &gt;=3D sizeof(fo=
oter))</span><br><span>     {</span><br><span>         return false;</span>=
<br><span>     }</span><br><span>@@ -280,11 +280,11 @@</span><br><span>    =
 char header[1000 + 1] =3D { 0 };</span><br><span>     char footer[1000 + 1=
] =3D { 0 };</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    if (!snprintf(header, sizeof(header), &quot;-----BEGIN %s-----=
&quot;, name))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f (snprintf(header, sizeof(header), &quot;-----BEGIN %s-----&quot;, name) &=
gt;=3D sizeof(header))</span><br><span>     {</span><br><span>         retu=
rn false;</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    if (!snprintf(footer, sizeof(footer), &quot;-----END %s-----=
&quot;, name))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f (snprintf(footer, sizeof(footer), &quot;-----END %s-----&quot;, name) &gt=
;=3D sizeof(footer))</span><br><span>     {</span><br><span>         return=
 false;</span><br><span>     }</span><br><span>diff --git a/src/openvpn/dns=
.c b/src/openvpn/dns.c</span><br><span>index d2ff670..539023f 100644</span>=
<br><span>--- a/src/openvpn/dns.c</span><br><span>+++ b/src/openvpn/dns.c</=
span><br><span>@@ -485,11 +485,13 @@</span><br><span> </span><br><span>    =
 if (j &lt; 0)</span><br><span>     {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        name_ok =3D snprintf(name, sizeof(name), format, i)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const int =
ret =3D snprintf(name, sizeof(name), format, i);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        name_ok =3D (ret &gt; 0 &amp;&amp; ret=
 &lt; sizeof(name));</span><br><span>     }</span><br><span>     else</span=
><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    name_ok =3D snprintf(name, sizeof(name), format, i, j);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        const int ret =3D snprintf(=
name, sizeof(name), format, i, j);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        name_ok =3D (ret &gt; 0 &amp;&amp; ret &lt; sizeof(n=
ame));</span><br><span>     }</span><br><span> </span><br><span>     if (!n=
ame_ok)</span><br><span>diff --git a/src/openvpn/env_set.c b/src/openvpn/en=
v_set.c</span><br><span>index 2ae71ab..1311e6f 100644</span><br><span>--- a=
/src/openvpn/env_set.c</span><br><span>+++ b/src/openvpn/env_set.c</span><b=
r><span>@@ -334,7 +334,7 @@</span><br><span>     strcpy(tmpname, name);</sp=
an><br><span>     while (NULL !=3D env_set_get(es, tmpname) &amp;&amp; coun=
ter &lt; 1000)</span><br><span>     {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        ASSERT(snprintf(tmpname, tmpname_len, &quot;%s_%u&q=
uot;, name, counter));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        ASSERT(snprintf(tmpname, tmpname_len, &quot;%s_%u&quot;, name, c=
ounter) &lt; tmpname_len);</span><br><span>         counter++;</span><br><s=
pan>     }</span><br><span>     if (counter &lt; 1000)</span><br><span>diff=
 --git a/src/openvpn/platform.c b/src/openvpn/platform.c</span><br><span>in=
dex a1ffdaf..a612237 100644</span><br><span>--- a/src/openvpn/platform.c</s=
pan><br><span>+++ b/src/openvpn/platform.c</span><br><span>@@ -550,8 +550,9=
 @@</span><br><span>     {</span><br><span>         ++attempts;</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (!sn=
printf(fname, sizeof(fname), fname_fmt, max_prefix_len, prefix,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                      (unsigned l=
ong)get_random(), (unsigned long)get_random()))</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        const int ret =3D snprintf(fname, sizeo=
f(fname), fname_fmt, max_prefix_len, prefix,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                                 (unsigned long)ge=
t_random(), (unsigned long)get_random());</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        if (ret &lt; 0 || ret &gt;=3D sizeof(fname))<=
/span><br><span>         {</span><br><span>             msg(M_WARN, &quot;E=
RROR: temporary filename too long&quot;);</span><br><span>             retu=
rn NULL;</span><br><span>diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/s=
sl_ncp.c</span><br><span>index 790e50f..d4519b0 100644</span><br><span>--- =
a/src/openvpn/ssl_ncp.c</span><br><span>+++ b/src/openvpn/ssl_ncp.c</span><=
br><span>@@ -198,7 +198,7 @@</span><br><span>     size_t newlen =3D strlen(=
o-&gt;ncp_ciphers) + 1 + strlen(ciphername) + 1;</span><br><span>     char =
*ncp_ciphers =3D gc_malloc(newlen, false, &amp;o-&gt;gc);</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(snprintf(n=
cp_ciphers, newlen, &quot;%s:%s&quot;, o-&gt;ncp_ciphers, ciphername));</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(snprintf(ncp=
_ciphers, newlen, &quot;%s:%s&quot;, o-&gt;ncp_ciphers, ciphername) &lt; ne=
wlen);</span><br><span>     o-&gt;ncp_ciphers =3D ncp_ciphers;</span><br><s=
pan> }</span><br><span> </span><br><span>diff --git a/src/openvpn/ssl_verif=
y.c b/src/openvpn/ssl_verify.c</span><br><span>index a16f5fa..a11003c 10064=
4</span><br><span>--- a/src/openvpn/ssl_verify.c</span><br><span>+++ b/src/=
openvpn/ssl_verify.c</span><br><span>@@ -548,7 +548,7 @@</span><br><span>  =
       goto cleanup;</span><br><span>     }</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    if (!snprintf(fn, sizeof(fn), &=
quot;%s%c%s&quot;, crl_dir, PATH_SEPARATOR, serial))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (snprintf(fn, sizeof(fn), &quot;%s=
%c%s&quot;, crl_dir, PATH_SEPARATOR, serial) &gt;=3D sizeof(fn))</span><br>=
<span>     {</span><br><span>         msg(D_HANDSHAKE, &quot;VERIFY CRL: fi=
lename overflow&quot;);</span><br><span>         goto cleanup;</span><br><s=
pan>diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_=
mbedtls.c</span><br><span>index 472eb49..9e2aa19 100644</span><br><span>---=
 a/src/openvpn/ssl_verify_mbedtls.c</span><br><span>+++ b/src/openvpn/ssl_v=
erify_mbedtls.c</span><br><span>@@ -85,8 +85,9 @@</span><br><span> </span><=
br><span>         ret =3D mbedtls_x509_crt_verify_info(errstr, sizeof(errst=
r) - 1, &quot;&quot;, *flags);</span><br><span>         if (ret &lt;=3D 0</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            &amp;&amp; =
!snprintf(errstr, sizeof(errstr), &quot;Could not retrieve error string, fl=
ags=3D%&quot; PRIx32,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                         *flags))</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            &amp;&amp; snprintf(errstr, sizeof(errstr), &quot=
;Could not retrieve error string, flags=3D%&quot; PRIx32,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                        *flags)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                   &gt;=
=3D sizeof(errstr))</span><br><span>         {</span><br><span>            =
 errstr[0] =3D &#39;\0&#39;;</span><br><span>         }</span><br><span>dif=
f --git a/src/openvpn/win32.c b/src/openvpn/win32.c</span><br><span>index 3=
c11ec3..df29dd7 100644</span><br><span>--- a/src/openvpn/win32.c</span><br>=
<span>+++ b/src/openvpn/win32.c</span><br><span>@@ -881,8 +881,9 @@</span><=
br><span>     char force_path[256];</span><br><span>     char *sysroot =3D =
get_win_sys_path();</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    if (!snprintf(force_path, sizeof(force_path), &quot;PAT=
H=3D%s\\System32;%s;%s\\System32\\Wbem&quot;,</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                  sysroot, sysroot, sysroot))</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (snprintf(force_pa=
th, sizeof(force_path), &quot;PATH=3D%s\\System32;%s;%s\\System32\\Wbem&quo=
t;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
 sysroot, sysroot, sysroot)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        &gt;=3D sizeof(force_path))</span><br><span>     {</span><b=
r><span>         msg(M_WARN, &quot;env_block: default path truncated to %s&=
quot;, force_path);</span><br><span>     }</span><br><span></span><br></pre=
><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1330?us=
p=3Demail">change 1330</a>. To unsubscribe, or for help writing mail filter=
s, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">setting=
s</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div i=
temscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><lin=
k itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1330?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
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

--9tF5HpDiacc=--

