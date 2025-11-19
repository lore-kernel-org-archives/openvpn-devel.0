From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 19 Nov 2025 16:48:33 +0000
In-Reply-To: <gerrit.1761488400000.I0579d18c784e2ac16973d5553992c28f281a0900@...2715...>
References: <gerrit.1761488400000.I0579d18c784e2ac16973d5553992c28f281a0900@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 max@...2606...
Message-ID: <3d0fe4122616e80dd8baea67cff446d1441b2016-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="4SLtM//4S7A="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Add option to check
 tls-crypt-v2 key timestamps
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: MaxF <max@...2606...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--4SLtM//4S7A=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#7) to the change originally created by=
 MaxF. ( http://gerrit.openvpn.net/c/openvpn/+/1304?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by plaisthos


Change subject: Add option to check tls-crypt-v2 key timestamps
......................................................................

Add option to check tls-crypt-v2 key timestamps

This commit adds the option --tls-crypt-v2-max-age n. When a client key
is older than n days or has no timestamp, the server rejects it.

Based on work by Rein van Baaren for Sentyron.

Co-authored-by: Rein van Baaren <revaban04@...2783...>
Change-Id: I0579d18c784e2ac16973d5553992c28f281a0900
Signed-off-by: Max Fillinger <max@...2606...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1304
Message-Id: <20251119140149.31867-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
545.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M doc/man-sections/tls-options.rst
M doc/tls-crypt-v2.txt
M src/openvpn/init.c
M src/openvpn/options.c
M src/openvpn/options.h
M src/openvpn/ssl_common.h
M src/openvpn/tls_crypt.c
7 files changed, 57 insertions(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/04/1304/7

diff --git a/doc/man-sections/tls-options.rst b/doc/man-sections/tls-option=
s.rst
index db107e6..63cb32f 100644
--- a/doc/man-sections/tls-options.rst
+++ b/doc/man-sections/tls-options.rst
@@ -568,6 +568,10 @@
   The command can reject the connection by exiting with a non-zero exit
   code.

+--tls-crypt-v2-max-age n
+  Reject tls-crypt-v2 client keys that are older than n days or have
+  no timestamp.
+
 --tls-exit
   Exit on TLS negotiation failure. This option can be useful when you only
   want to make one attempt at connecting, e.g. in a test or monitoring scr=
ipt.
diff --git a/doc/tls-crypt-v2.txt b/doc/tls-crypt-v2.txt
index 7dcd041..c2e9deb 100644
--- a/doc/tls-crypt-v2.txt
+++ b/doc/tls-crypt-v2.txt
@@ -139,7 +139,10 @@
    The message is dropped and no error response is sent when either 3.1, 3=
.2 or
    3.3 fails (DoS protection).

-4. Server optionally checks metadata using a --tls-crypt-v2-verify script
+4. The server optionally checks if the client key contains a timestamp tha=
t is
+   below a maximum age configured with the --tls-crypt-v2-max-age option.
+
+5. Server optionally checks metadata using a --tls-crypt-v2-verify script

    This allows early abort of connection, *before* we expose any of the
    notoriously dangerous TLS, X.509 and ASN.1 parsers and thereby reduces =
the
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 8d95d5c..fc079e1 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -3418,6 +3418,7 @@
         {
             to.tls_wrap.tls_crypt_v2_server_key =3D c->c1.ks.tls_crypt_v2_=
server_key;
             to.tls_crypt_v2_verify_script =3D c->options.tls_crypt_v2_veri=
fy_script;
+            to.tls_crypt_v2_max_age =3D c->options.tls_crypt_v2_max_age;
             if (options->ce.tls_crypt_v2_force_cookie)
             {
                 to.tls_wrap.opt.flags |=3D CO_FORCE_TLSCRYPTV2_COOKIE;
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 683543a..4794315 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -648,6 +648,8 @@
     "                  fresh tls-crypt-v2 server key, and store to keyfile=
\n"
     "--tls-crypt-v2-verify cmd : Run command cmd to verify the metadata of=
 the\n"
     "                  client-supplied tls-crypt-v2 client key\n"
+    "--tls-crypt-v2-max-age n : Only accept tls-crypt-v2 client keys that =
have a\n"
+    "                  timestamp which is at most n days old.\n"
     "--askpass [file]: Get PEM password from controlling tty before we dae=
monize.\n"
     "--auth-nocache  : Don't cache --askpass or --auth-user-pass passwords=
.\n"
     "--crl-verify crl ['dir']: Check peer certificate against a CRL.\n"
@@ -9079,6 +9081,14 @@
         VERIFY_PERMISSION(OPT_P_GENERAL);
         options->tls_crypt_v2_verify_script =3D p[1];
     }
+    else if (streq(p[0], "tls-crypt-v2-max-age") && p[1])
+    {
+        VERIFY_PERMISSION(OPT_P_GENERAL);
+        if (!atoi_constrained(p[1], &options->tls_crypt_v2_max_age, "tls-c=
rypt-v2-max-age", 1, INT_MAX, msglevel))
+        {
+            goto err;
+        }
+    }
     else if (streq(p[0], "x509-track") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 9d2ff9f..42db9ca 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -678,6 +678,8 @@

     const char *tls_crypt_v2_verify_script;

+    int tls_crypt_v2_max_age;
+
     /* Allow only one session */
     bool single_session;

diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 23da8cf..3129299 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -383,6 +383,7 @@

     bool tls_crypt_v2;
     const char *tls_crypt_v2_verify_script;
+    int tls_crypt_v2_max_age;

     /** TLS handshake wrapping state */
     struct tls_wrap_ctx tls_wrap;
diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index ab719b3..318c939 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -29,6 +29,7 @@
 #include "argv.h"
 #include "base64.h"
 #include "crypto.h"
+#include "integer.h"
 #include "platform.h"
 #include "run_command.h"
 #include "session_id.h"
@@ -520,6 +521,34 @@
 }

 static bool
+tls_crypt_v2_check_client_key_age(const struct tls_wrap_ctx *ctx, int max_=
days)
+{
+    if (ctx->tls_crypt_v2_metadata.len < 1 + sizeof(int64_t))
+    {
+        msg(M_WARN, "ERROR: Client key metadata is too small to contain a =
timestamp.");
+        return false;
+    }
+
+    const uint8_t *metadata =3D ctx->tls_crypt_v2_metadata.data;
+    if (*metadata !=3D TLS_CRYPT_METADATA_TYPE_TIMESTAMP)
+    {
+        msg(M_WARN, "ERROR: Client key does not have a timestamp.");
+        return false;
+    }
+
+    int64_t timestamp;
+    memcpy(&timestamp, metadata + 1, sizeof(int64_t));
+    timestamp =3D (int64_t)ntohll((uint64_t)timestamp);
+    int64_t max_age_in_seconds =3D max_days * 24 * 60 * 60;
+    if (now - timestamp > max_age_in_seconds)
+    {
+        msg(M_WARN, "ERROR: Client key is too old.");
+        return false;
+    }
+    return true;
+}
+
+static bool
 tls_crypt_v2_verify_metadata(const struct tls_wrap_ctx *ctx, const struct =
tls_options *opt)
 {
     bool ret =3D false;
@@ -634,6 +663,12 @@
         return false;
     }

+    if (opt && opt->tls_crypt_v2_max_age > 0 && !tls_crypt_v2_check_client=
_key_age(ctx, opt->tls_crypt_v2_max_age))
+    {
+        secure_memzero(&ctx->original_wrap_keydata, sizeof(ctx->original_w=
rap_keydata));
+        return false;
+    }
+
     if (opt && opt->tls_crypt_v2_verify_script && !tls_crypt_v2_verify_met=
adata(ctx, opt))
     {
         secure_memzero(&ctx->original_wrap_keydata, sizeof(ctx->original_w=
rap_keydata));

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1304?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0579d18c784e2ac16973d5553992c28f281a0900
Gerrit-Change-Number: 1304
Gerrit-PatchSet: 7
Gerrit-Owner: MaxF <max@...2606...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--4SLtM//4S7A=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #7</strong> to the change originally created by MaxF.</p><p=
><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1304?usp=3Demail">View Ch=
ange</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by plaisthos</p><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">Add option to check tls-crypt-v=
2 key timestamps<br><br>This commit adds the option --tls-crypt-v2-max-age =
n. When a client key<br>is older than n days or has no timestamp, the serve=
r rejects it.<br><br>Based on work by Rein van Baaren for Sentyron.<br><br>=
Co-authored-by: Rein van Baaren &lt;revaban04@...2783...&gt;<br>Change-Id: =
I0579d18c784e2ac16973d5553992c28f281a0900<br>Signed-off-by: Max Fillinger &=
lt;max@...2606...&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@...1227...=
&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1304<br>Message-=
Id: &lt;20251119140149.31867-1-gert@...1296...&gt;<br>URL: https://www.mail=
-archive.com/openvpn-devel@lists.sourceforge.net/msg34545.html<br>Signed-of=
f-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M doc/man-sections/tls=
-options.rst<br>M doc/tls-crypt-v2.txt<br>M src/openvpn/init.c<br>M src/ope=
nvpn/options.c<br>M src/openvpn/options.h<br>M src/openvpn/ssl_common.h<br>=
M src/openvpn/tls_crypt.c<br>7 files changed, 57 insertions(+), 1 deletion(=
-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openv=
pn refs/changes/04/1304/7</pre><pre style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;"><span>diff --git a/doc/man-sections/tls-options=
.rst b/doc/man-sections/tls-options.rst</span><br><span>index db107e6..63cb=
32f 100644</span><br><span>--- a/doc/man-sections/tls-options.rst</span><br=
><span>+++ b/doc/man-sections/tls-options.rst</span><br><span>@@ -568,6 +56=
8,10 @@</span><br><span>   The command can reject the connection by exiting=
 with a non-zero exit</span><br><span>   code.</span><br><span> </span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+--tls-crypt-v2-max-age n</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+  Reject tls-crypt-v2 cli=
ent keys that are older than n days or have</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+  no timestamp.</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span> --tls-exit</span><br><span>   Exit on=
 TLS negotiation failure. This option can be useful when you only</span><br=
><span>   want to make one attempt at connecting, e.g. in a test or monitor=
ing script.</span><br><span>diff --git a/doc/tls-crypt-v2.txt b/doc/tls-cry=
pt-v2.txt</span><br><span>index 7dcd041..c2e9deb 100644</span><br><span>---=
 a/doc/tls-crypt-v2.txt</span><br><span>+++ b/doc/tls-crypt-v2.txt</span><b=
r><span>@@ -139,7 +139,10 @@</span><br><span>    The message is dropped and=
 no error response is sent when either 3.1, 3.2 or</span><br><span>    3.3 =
fails (DoS protection).</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-4. Server optionally checks metadata using a --tls-cryp=
t-v2-verify script</span><br><span style=3D"color: hsl(120, 100%, 40%);">+4=
. The server optionally checks if the client key contains a timestamp that =
is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   below a maximu=
m age configured with the --tls-crypt-v2-max-age option.</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+5. Server optionally checks metadata using a --tls-crypt-=
v2-verify script</span><br><span> </span><br><span>    This allows early ab=
ort of connection, *before* we expose any of the</span><br><span>    notori=
ously dangerous TLS, X.509 and ASN.1 parsers and thereby reduces the</span>=
<br><span>diff --git a/src/openvpn/init.c b/src/openvpn/init.c</span><br><s=
pan>index 8d95d5c..fc079e1 100644</span><br><span>--- a/src/openvpn/init.c<=
/span><br><span>+++ b/src/openvpn/init.c</span><br><span>@@ -3418,6 +3418,7=
 @@</span><br><span>         {</span><br><span>             to.tls_wrap.tls=
_crypt_v2_server_key =3D c-&gt;c1.ks.tls_crypt_v2_server_key;</span><br><sp=
an>             to.tls_crypt_v2_verify_script =3D c-&gt;options.tls_crypt_v=
2_verify_script;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         to.tls_crypt_v2_max_age =3D c-&gt;options.tls_crypt_v2_max_age;</s=
pan><br><span>             if (options-&gt;ce.tls_crypt_v2_force_cookie)</s=
pan><br><span>             {</span><br><span>                 to.tls_wrap.o=
pt.flags |=3D CO_FORCE_TLSCRYPTV2_COOKIE;</span><br><span>diff --git a/src/=
openvpn/options.c b/src/openvpn/options.c</span><br><span>index 683543a..47=
94315 100644</span><br><span>--- a/src/openvpn/options.c</span><br><span>++=
+ b/src/openvpn/options.c</span><br><span>@@ -648,6 +648,8 @@</span><br><sp=
an>     &quot;                  fresh tls-crypt-v2 server key, and store to=
 keyfile\n&quot;</span><br><span>     &quot;--tls-crypt-v2-verify cmd : Run=
 command cmd to verify the metadata of the\n&quot;</span><br><span>     &qu=
ot;                  client-supplied tls-crypt-v2 client key\n&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;--tls-crypt-v2-m=
ax-age n : Only accept tls-crypt-v2 client keys that have a\n&quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;                 =
 timestamp which is at most n days old.\n&quot;</span><br><span>     &quot;=
--askpass [file]: Get PEM password from controlling tty before we daemonize=
.\n&quot;</span><br><span>     &quot;--auth-nocache  : Don&#39;t cache --as=
kpass or --auth-user-pass passwords.\n&quot;</span><br><span>     &quot;--c=
rl-verify crl [&#39;dir&#39;]: Check peer certificate against a CRL.\n&quot=
;</span><br><span>@@ -9079,6 +9081,14 @@</span><br><span>         VERIFY_PE=
RMISSION(OPT_P_GENERAL);</span><br><span>         options-&gt;tls_crypt_v2_=
verify_script =3D p[1];</span><br><span>     }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    else if (streq(p[0], &quot;tls-crypt-v2-max-=
age&quot;) &amp;&amp; p[1])</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        if (!atoi_constrained(p[1], &amp;options-&gt;tls_cr=
ypt_v2_max_age, &quot;tls-crypt-v2-max-age&quot;, 1, INT_MAX, msglevel))</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            goto err;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>     else if (stre=
q(p[0], &quot;x509-track&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br=
><span>     {</span><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL);</s=
pan><br><span>diff --git a/src/openvpn/options.h b/src/openvpn/options.h</s=
pan><br><span>index 9d2ff9f..42db9ca 100644</span><br><span>--- a/src/openv=
pn/options.h</span><br><span>+++ b/src/openvpn/options.h</span><br><span>@@=
 -678,6 +678,8 @@</span><br><span> </span><br><span>     const char *tls_cr=
ypt_v2_verify_script;</span><br><span> </span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    int tls_crypt_v2_max_age;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span>     /* Allow only one sessi=
on */</span><br><span>     bool single_session;</span><br><span> </span><br=
><span>diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h</sp=
an><br><span>index 23da8cf..3129299 100644</span><br><span>--- a/src/openvp=
n/ssl_common.h</span><br><span>+++ b/src/openvpn/ssl_common.h</span><br><sp=
an>@@ -383,6 +383,7 @@</span><br><span> </span><br><span>     bool tls_cryp=
t_v2;</span><br><span>     const char *tls_crypt_v2_verify_script;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    int tls_crypt_v2_max_age=
;</span><br><span> </span><br><span>     /** TLS handshake wrapping state *=
/</span><br><span>     struct tls_wrap_ctx tls_wrap;</span><br><span>diff -=
-git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c</span><br><span>in=
dex ab719b3..318c939 100644</span><br><span>--- a/src/openvpn/tls_crypt.c</=
span><br><span>+++ b/src/openvpn/tls_crypt.c</span><br><span>@@ -29,6 +29,7=
 @@</span><br><span> #include &quot;argv.h&quot;</span><br><span> #include =
&quot;base64.h&quot;</span><br><span> #include &quot;crypto.h&quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;integer.h&qu=
ot;</span><br><span> #include &quot;platform.h&quot;</span><br><span> #incl=
ude &quot;run_command.h&quot;</span><br><span> #include &quot;session_id.h&=
quot;</span><br><span>@@ -520,6 +521,34 @@</span><br><span> }</span><br><sp=
an> </span><br><span> static bool</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+tls_crypt_v2_check_client_key_age(const struct tls_wrap_ctx *=
ctx, int max_days)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ctx-&gt;tls=
_crypt_v2_metadata.len &lt; 1 + sizeof(int64_t))</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        msg(M_WARN, &quot;ERROR: Client key metadata is too =
small to contain a timestamp.&quot;);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        return false;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const uin=
t8_t *metadata =3D ctx-&gt;tls_crypt_v2_metadata.data;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    if (*metadata !=3D TLS_CRYPT_METADAT=
A_TYPE_TIMESTAMP)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WA=
RN, &quot;ERROR: Client key does not have a timestamp.&quot;);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    int64_t timestamp;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    memcpy(&amp;timestamp, metadata + 1, sizeof(int64_t));</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    timestamp =3D (in=
t64_t)ntohll((uint64_t)timestamp);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    int64_t max_age_in_seconds =3D max_days * 24 * 60 * 60;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (now - timest=
amp &gt; max_age_in_seconds)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   msg(M_WARN, &quot;ERROR: Client key is too old.&quot;);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    return true;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</=
span><br><span> tls_crypt_v2_verify_metadata(const struct tls_wrap_ctx *ctx=
, const struct tls_options *opt)</span><br><span> {</span><br><span>     bo=
ol ret =3D false;</span><br><span>@@ -634,6 +663,12 @@</span><br><span>    =
     return false;</span><br><span>     }</span><br><span> </span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if (opt &amp;&amp; opt-&gt;tls_=
crypt_v2_max_age &gt; 0 &amp;&amp; !tls_crypt_v2_check_client_key_age(ctx, =
opt-&gt;tls_crypt_v2_max_age))</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     secure_memzero(&amp;ctx-&gt;original_wrap_keydata, sizeof(ctx-&gt;orig=
inal_wrap_keydata));</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span>     if (opt &amp;&amp; opt-&gt;tls_crypt_v2_verify_script &amp;&amp;=
 !tls_crypt_v2_verify_metadata(ctx, opt))</span><br><span>     {</span><br>=
<span>         secure_memzero(&amp;ctx-&gt;original_wrap_keydata, sizeof(ct=
x-&gt;original_wrap_keydata));</span><br><span></span><br></pre><p>To view,=
 visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1304?usp=3Demail">c=
hange 1304</a>. To unsubscribe, or for help writing mail filters, visit <a =
href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><d=
iv itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1304?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0579d18c784e2ac16973d555399=
2c28f281a0900 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1304 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>
<div style=3D"display:none"> Gerrit-Owner: MaxF &lt;max@...2606...&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--4SLtM//4S7A=--

