From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 11 Nov 2024 16:35:28 +0000
In-Reply-To: <gerrit.1731290343000.I993e7fc5609955d271e74370affc2eea340a1e2d@...2715...>
References: <gerrit.1731290343000.I993e7fc5609955d271e74370affc2eea340a1e2d@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <ac8b7b8a6ab9ab6b5c24e98d706f753ff6b7287f-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="mFpQNTk33ro="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Change --reneg-bytes
 and --reneg-packets to 64 bit counters
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

--mFpQNTk33ro=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/79=
5?usp=3Demail )

Change subject: Change --reneg-bytes and --reneg-packets to 64 bit counters
......................................................................

Change --reneg-bytes and --reneg-packets to 64 bit counters

reneg-bytes can currently only specify up to a maximum of 2GB.
This makes it even problematic to use without extended counters.

Change-Id: I993e7fc5609955d271e74370affc2eea340a1e2d
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20241111094033.16073-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29=
744.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/options.c
M src/openvpn/options.h
M src/openvpn/ssl.c
M src/openvpn/ssl_common.h
4 files changed, 24 insertions(+), 10 deletions(-)




diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 1beb0ee..10ee9f6 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2032,8 +2032,8 @@

     SHOW_INT(tls_timeout);

-    SHOW_INT(renegotiate_bytes);
-    SHOW_INT(renegotiate_packets);
+    SHOW_INT64(renegotiate_bytes);
+    SHOW_INT64(renegotiate_packets);
     SHOW_INT(renegotiate_seconds);

     SHOW_INT(handshake_window);
@@ -9187,12 +9187,26 @@
     else if (streq(p[0], "reneg-bytes") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_TLS_PARMS);
-        options->renegotiate_bytes =3D positive_atoi(p[1]);
+        char *end;
+        long long reneg_bytes =3D strtoll(p[1], &end, 10);
+        if (*end !=3D '\0' || reneg_bytes < 0)
+        {
+            msg(msglevel, "--reneg-bytes parameter must be an integer and =
>=3D 0");
+            goto err;
+        }
+        options->renegotiate_bytes =3D reneg_bytes;
     }
     else if (streq(p[0], "reneg-pkts") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_TLS_PARMS);
-        options->renegotiate_packets =3D positive_atoi(p[1]);
+        char *end;
+        long long pkt_max =3D strtoll(p[1], &end, 10);
+        if (*end !=3D '\0' || pkt_max < 0)
+        {
+            msg(msglevel, "--reneg-pkts parameter must be an integer and >=
=3D 0");
+            goto err;
+        }
+        options->renegotiate_packets =3D pkt_max;
     }
     else if (streq(p[0], "reneg-sec") && p[1] && !p[3])
     {
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index ee39dbb..6ab92e2 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -626,8 +626,8 @@
     int tls_timeout;

     /* Data channel key renegotiation parameters */
-    int renegotiate_bytes;
-    int renegotiate_packets;
+    int64_t renegotiate_bytes;
+    int64_t renegotiate_packets;
     int renegotiate_seconds;
     int renegotiate_seconds_min;

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index d44185e..1f8eb1e 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -118,7 +118,7 @@
  *                      May *not* be NULL.
  */
 static void
-tls_limit_reneg_bytes(const char *ciphername, int *reneg_bytes)
+tls_limit_reneg_bytes(const char *ciphername, int64_t *reneg_bytes)
 {
     if (cipher_kt_insecure(ciphername))
     {
@@ -3028,7 +3028,7 @@
         && should_trigger_renegotiation(session, ks))
     {
         msg(D_TLS_DEBUG_LOW, "TLS: soft reset sec=3D%d/%d bytes=3D" counte=
r_format
-            "/%d pkts=3D" counter_format "/%d",
+            "/%" PRIi64 " pkts=3D" counter_format "/%" PRIi64,
             (int) (now - ks->established), session->opt->renegotiate_secon=
ds,
             ks->n_bytes, session->opt->renegotiate_bytes,
             ks->n_packets, session->opt->renegotiate_packets);
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 5bc2f2a..5840e2d 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -331,8 +331,8 @@
     int transition_window;
     int handshake_window;
     interval_t packet_timeout;
-    int renegotiate_bytes;
-    int renegotiate_packets;
+    int64_t renegotiate_bytes;
+    int64_t renegotiate_packets;
     interval_t renegotiate_seconds;

     /* cert verification parms */

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/795?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I993e7fc5609955d271e74370affc2eea340a1e2d
Gerrit-Change-Number: 795
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--mFpQNTk33ro=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/795?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Change --reneg-bytes and --reneg-packets to 64=
 bit counters<br><br>reneg-bytes can currently only specify up to a maximum=
 of 2GB.<br>This makes it even problematic to use without extended counters=
.<br><br>Change-Id: I993e7fc5609955d271e74370affc2eea340a1e2d<br>Signed-off=
-by: Arne Schwabe &lt;arne@...1227...&gt;<br>Acked-by: Gert Doering &lt;ger=
t@...1296...&gt;<br>Message-Id: &lt;20241111094033.16073-1-gert@...1296...&=
gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...475...=
t/msg29744.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>-=
--<br>M src/openvpn/options.c<br>M src/openvpn/options.h<br>M src/openvpn/s=
sl.c<br>M src/openvpn/ssl_common.h<br>4 files changed, 24 insertions(+), 10=
 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/options.c b/src/openvpn/options.c</span><br><sp=
an>index 1beb0ee..10ee9f6 100644</span><br><span>--- a/src/openvpn/options.=
c</span><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -2032,8 +2=
032,8 @@</span><br><span> </span><br><span>     SHOW_INT(tls_timeout);</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW=
_INT(renegotiate_bytes);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    SHOW_INT(renegotiate_packets);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    SHOW_INT64(renegotiate_bytes);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT64(renegotiate_packets);</spa=
n><br><span>     SHOW_INT(renegotiate_seconds);</span><br><span> </span><br=
><span>     SHOW_INT(handshake_window);</span><br><span>@@ -9187,12 +9187,2=
6 @@</span><br><span>     else if (streq(p[0], &quot;reneg-bytes&quot;) &am=
p;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br><span>     =
    VERIFY_PERMISSION(OPT_P_TLS_PARMS);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        options-&gt;renegotiate_bytes =3D positive_atoi(p=
[1]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        char *=
end;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        long lo=
ng reneg_bytes =3D strtoll(p[1], &amp;end, 10);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        if (*end !=3D &#39;\0&#39; || reneg_byt=
es &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(msg=
level, &quot;--reneg-bytes parameter must be an integer and &gt;=3D 0&quot;=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            goto =
err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        options-&gt;reneg=
otiate_bytes =3D reneg_bytes;</span><br><span>     }</span><br><span>     e=
lse if (streq(p[0], &quot;reneg-pkts&quot;) &amp;&amp; p[1] &amp;&amp; !p[2=
])</span><br><span>     {</span><br><span>         VERIFY_PERMISSION(OPT_P_=
TLS_PARMS);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        op=
tions-&gt;renegotiate_packets =3D positive_atoi(p[1]);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        char *end;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        long long pkt_max =3D strtoll(p[1=
], &amp;end, 10);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      if (*end !=3D &#39;\0&#39; || pkt_max &lt; 0)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            msg(msglevel, &quot;--reneg-pkts parame=
ter must be an integer and &gt;=3D 0&quot;);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            goto err;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        options-&gt;renegotiate_packets =3D pkt_max;</span=
><br><span>     }</span><br><span>     else if (streq(p[0], &quot;reneg-sec=
&quot;) &amp;&amp; p[1] &amp;&amp; !p[3])</span><br><span>     {</span><br>=
<span>diff --git a/src/openvpn/options.h b/src/openvpn/options.h</span><br>=
<span>index ee39dbb..6ab92e2 100644</span><br><span>--- a/src/openvpn/optio=
ns.h</span><br><span>+++ b/src/openvpn/options.h</span><br><span>@@ -626,8 =
+626,8 @@</span><br><span>     int tls_timeout;</span><br><span> </span><br=
><span>     /* Data channel key renegotiation parameters */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    int renegotiate_bytes;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    int renegotiate_packets;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    int64_t renegotiate=
_bytes;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int64_t =
renegotiate_packets;</span><br><span>     int renegotiate_seconds;</span><b=
r><span>     int renegotiate_seconds_min;</span><br><span> </span><br><span=
>diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c</span><br><span>index d=
44185e..1f8eb1e 100644</span><br><span>--- a/src/openvpn/ssl.c</span><br><s=
pan>+++ b/src/openvpn/ssl.c</span><br><span>@@ -118,7 +118,7 @@</span><br><=
span>  *                      May *not* be NULL.</span><br><span>  */</span=
><br><span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-tls_limit_reneg_bytes(const char *ciphername, int *reneg_bytes)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+tls_limit_reneg_bytes(const c=
har *ciphername, int64_t *reneg_bytes)</span><br><span> {</span><br><span> =
    if (cipher_kt_insecure(ciphername))</span><br><span>     {</span><br><s=
pan>@@ -3028,7 +3028,7 @@</span><br><span>         &amp;&amp; should_trigge=
r_renegotiation(session, ks))</span><br><span>     {</span><br><span>      =
   msg(D_TLS_DEBUG_LOW, &quot;TLS: soft reset sec=3D%d/%d bytes=3D&quot; co=
unter_format</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   &quot;/%d pkts=3D&quot; counter_format &quot;/%d&quot;,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            &quot;/%&quot; PRIi64 &q=
uot; pkts=3D&quot; counter_format &quot;/%&quot; PRIi64,</span><br><span>  =
           (int) (now - ks-&gt;established), session-&gt;opt-&gt;renegotiat=
e_seconds,</span><br><span>             ks-&gt;n_bytes, session-&gt;opt-&gt=
;renegotiate_bytes,</span><br><span>             ks-&gt;n_packets, session-=
&gt;opt-&gt;renegotiate_packets);</span><br><span>diff --git a/src/openvpn/=
ssl_common.h b/src/openvpn/ssl_common.h</span><br><span>index 5bc2f2a..5840=
e2d 100644</span><br><span>--- a/src/openvpn/ssl_common.h</span><br><span>+=
++ b/src/openvpn/ssl_common.h</span><br><span>@@ -331,8 +331,8 @@</span><br=
><span>     int transition_window;</span><br><span>     int handshake_windo=
w;</span><br><span>     interval_t packet_timeout;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    int renegotiate_bytes;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    int renegotiate_packets;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    int64_t renegotiate_bytes;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int64_t renegotia=
te_packets;</span><br><span>     interval_t renegotiate_seconds;</span><br>=
<span> </span><br><span>     /* cert verification parms */</span><br><span>=
</span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/795?usp=3Demail">change 795</a>. To unsubscribe, or for help writi=
ng mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">setti=
ngs</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div=
 itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><l=
ink itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/795?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I993e7fc5609955d271e74370aff=
c2eea340a1e2d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 795 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--mFpQNTk33ro=--

