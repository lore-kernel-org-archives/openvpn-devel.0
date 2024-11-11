From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 11 Nov 2024 01:59:37 +0000
References: <gerrit.1731290343000.I993e7fc5609955d271e74370affc2eea340a1e2d@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <05e024ace659f10fd80849bbbf2b5423f140fff8-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="dJ4IR2616JM="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--dJ4IR2616JM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/795?usp=3Demail

to review the following change.


Change subject: Change --reneg-bytes and --reneg-packets to 64 bit counters
......................................................................

Change --reneg-bytes and --reneg-packets to 64 bit counters

reneg-bytes can currently only specify up to a maximum of 2GB.
This makes it even problematic to use without extended counters.

Change-Id: I993e7fc5609955d271e74370affc2eea340a1e2d
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/options.c
M src/openvpn/options.h
M src/openvpn/ssl.c
M src/openvpn/ssl_common.h
4 files changed, 24 insertions(+), 10 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/95/795/1

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
index c48a85c..ab55365 100644
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
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--dJ4IR2616JM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/795?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Change --reneg-bytes and --reneg-packets to 64 bit counters<b=
r><br>reneg-bytes can currently only specify up to a maximum of 2GB.<br>Thi=
s makes it even problematic to use without extended counters.<br><br>Change=
-Id: I993e7fc5609955d271e74370affc2eea340a1e2d<br>Signed-off-by: Arne Schwa=
be &lt;arne@...1227...&gt;<br>---<br>M src/openvpn/options.c<br>M src/openv=
pn/options.h<br>M src/openvpn/ssl.c<br>M src/openvpn/ssl_common.h<br>4 file=
s changed, 24 insertions(+), 10 deletions(-)<br><br></pre><pre style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerri=
t.openvpn.net:29418/openvpn refs/changes/95/795/1</pre><pre style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/=
openvpn/options.c b/src/openvpn/options.c</span><br><span>index 1beb0ee..10=
ee9f6 100644</span><br><span>--- a/src/openvpn/options.c</span><br><span>++=
+ b/src/openvpn/options.c</span><br><span>@@ -2032,8 +2032,8 @@</span><br><=
span> </span><br><span>     SHOW_INT(tls_timeout);</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(renegotiate_byt=
es);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(rene=
gotiate_packets);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  SHOW_INT64(renegotiate_bytes);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    SHOW_INT64(renegotiate_packets);</span><br><span>     SHOW=
_INT(renegotiate_seconds);</span><br><span> </span><br><span>     SHOW_INT(=
handshake_window);</span><br><span>@@ -9187,12 +9187,26 @@</span><br><span>=
     else if (streq(p[0], &quot;reneg-bytes&quot;) &amp;&amp; p[1] &amp;&am=
p; !p[2])</span><br><span>     {</span><br><span>         VERIFY_PERMISSION=
(OPT_P_TLS_PARMS);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     options-&gt;renegotiate_bytes =3D positive_atoi(p[1]);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        char *end;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        long long reneg_bytes =3D st=
rtoll(p[1], &amp;end, 10);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        if (*end !=3D &#39;\0&#39; || reneg_bytes &lt; 0)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            msg(msglevel, &quot;--reneg-=
bytes parameter must be an integer and &gt;=3D 0&quot;);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            goto err;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        options-&gt;renegotiate_bytes =3D rene=
g_bytes;</span><br><span>     }</span><br><span>     else if (streq(p[0], &=
quot;reneg-pkts&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>  =
   {</span><br><span>         VERIFY_PERMISSION(OPT_P_TLS_PARMS);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        options-&gt;renegotiate=
_packets =3D positive_atoi(p[1]);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        char *end;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        long long pkt_max =3D strtoll(p[1], &amp;end, 10);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (*end !=3D &=
#39;\0&#39; || pkt_max &lt; 0)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            msg(msglevel, &quot;--reneg-pkts parameter must be an integer =
and &gt;=3D 0&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  options-&gt;renegotiate_packets =3D pkt_max;</span><br><span>     }</span=
><br><span>     else if (streq(p[0], &quot;reneg-sec&quot;) &amp;&amp; p[1]=
 &amp;&amp; !p[3])</span><br><span>     {</span><br><span>diff --git a/src/=
openvpn/options.h b/src/openvpn/options.h</span><br><span>index ee39dbb..6a=
b92e2 100644</span><br><span>--- a/src/openvpn/options.h</span><br><span>++=
+ b/src/openvpn/options.h</span><br><span>@@ -626,8 +626,8 @@</span><br><sp=
an>     int tls_timeout;</span><br><span> </span><br><span>     /* Data cha=
nnel key renegotiation parameters */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    int renegotiate_bytes;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    int renegotiate_packets;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    int64_t renegotiate_bytes;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    int64_t renegotiate_packets;</s=
pan><br><span>     int renegotiate_seconds;</span><br><span>     int renego=
tiate_seconds_min;</span><br><span> </span><br><span>diff --git a/src/openv=
pn/ssl.c b/src/openvpn/ssl.c</span><br><span>index c48a85c..ab55365 100644<=
/span><br><span>--- a/src/openvpn/ssl.c</span><br><span>+++ b/src/openvpn/s=
sl.c</span><br><span>@@ -118,7 +118,7 @@</span><br><span>  *               =
       May *not* be NULL.</span><br><span>  */</span><br><span> static void=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tls_limit_reneg_bytes=
(const char *ciphername, int *reneg_bytes)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+tls_limit_reneg_bytes(const char *ciphername, int64_=
t *reneg_bytes)</span><br><span> {</span><br><span>     if (cipher_kt_insec=
ure(ciphername))</span><br><span>     {</span><br><span>@@ -3028,7 +3028,7 =
@@</span><br><span>         &amp;&amp; should_trigger_renegotiation(session=
, ks))</span><br><span>    {</span><br><span>         msg(D_TLS_DEBUG_LOW, =
&quot;TLS: soft reset sec=3D%d/%d bytes=3D&quot; counter_format</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            &quot;/%d pkts=3D&quo=
t; counter_format &quot;/%d&quot;,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            &quot;/%&quot; PRIi64 &quot; pkts=3D&quot; count=
er_format &quot;/%&quot; PRIi64,</span><br><span>             (int) (now - =
ks-&gt;established), session-&gt;opt-&gt;renegotiate_seconds,</span><br><sp=
an>             ks-&gt;n_bytes, session-&gt;opt-&gt;renegotiate_bytes,</spa=
n><br><span>             ks-&gt;n_packets, session-&gt;opt-&gt;renegotiate_=
packets);</span><br><span>diff --git a/src/openvpn/ssl_common.h b/src/openv=
pn/ssl_common.h</span><br><span>index 5bc2f2a..5840e2d 100644</span><br><sp=
an>--- a/src/openvpn/ssl_common.h</span><br><span>+++ b/src/openvpn/ssl_com=
mon.h</span><br><span>@@ -331,8 +331,8 @@</span><br><span>     int transiti=
on_window;</span><br><span>     int handshake_window;</span><br><span>     =
interval_t packet_timeout;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    int renegotiate_bytes;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    int renegotiate_packets;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    int64_t renegotiate_bytes;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    int64_t renegotiate_packets;</span><br><s=
pan>     interval_t renegotiate_seconds;</span><br><span> </span><br><span>=
     /* cert verification parms */</span><br><span></span><br></pre><p>To v=
iew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/795?usp=3Demail=
">change 795</a>. To unsubscribe, or for help writing mail filters, visit <=
a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemsco=
pe itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"a=
ction" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" hre=
f=3D"http://gerrit.openvpn.net/c/openvpn/+/795?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I993e7fc5609955d271e74370aff=
c2eea340a1e2d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 795 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--dJ4IR2616JM=--

