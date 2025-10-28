From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 28 Oct 2025 18:55:17 +0000
In-Reply-To: <gerrit.1760967063000.I2554b9baec6af191b0adb137e64124586dc4331c@...2715...>
References: <gerrit.1760967063000.I2554b9baec6af191b0adb137e64124586dc4331c@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <c7c35572a5c07b0533f9dbe17fa0d6c675be778f-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="svf0B/ZaPpE="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: gremlin: Avoid some
 conversion warnings
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--svf0B/ZaPpE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/12=
86?usp=3Demail )

Change subject: gremlin: Avoid some conversion warnings
......................................................................

gremlin: Avoid some conversion warnings

We know these casts are safe, so make
them explicit.

Change-Id: I2554b9baec6af191b0adb137e64124586dc4331c
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1286
Message-Id: <20251028183945.31901-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33=
964.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/gremlin.c
1 file changed, 2 insertions(+), 11 deletions(-)




diff --git a/src/openvpn/gremlin.c b/src/openvpn/gremlin.c
index 0e5e93f..a3dbff1 100644
--- a/src/openvpn/gremlin.c
+++ b/src/openvpn/gremlin.c
@@ -98,11 +98,6 @@
     return (get_random() % n) =3D=3D 0;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 /*
  * Return uniformly distributed random number between
  * low and high.
@@ -112,7 +107,7 @@
 {
     int ret;
     ASSERT(low <=3D high);
-    ret =3D low + (get_random() % (high - low + 1));
+    ret =3D low + (int)(get_random() % (high - low + 1));
     ASSERT(ret >=3D low && ret <=3D high);
     return ret;
 }
@@ -195,7 +190,7 @@
             {
                 if (buf->len > 0)
                 {
-                    uint8_t r =3D roll(0, 255);
+                    uint8_t r =3D (uint8_t)roll(0, 255);
                     int method =3D roll(0, 5);

                     switch (method)
@@ -235,8 +230,4 @@
     }
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 #endif /* ifdef ENABLE_DEBUG */

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1286?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I2554b9baec6af191b0adb137e64124586dc4331c
Gerrit-Change-Number: 1286
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--svf0B/ZaPpE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1286?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">gremlin: Avoid some conversion warnings<br><br>W=
e know these casts are safe, so make<br>them explicit.<br><br>Change-Id: I2=
554b9baec6af191b0adb137e64124586dc4331c<br>Signed-off-by: Frank Lichtenheld=
 &lt;frank@...2641...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;=
<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1286<br>Message-Id: =
&lt;20251028183945.31901-1-gert@...1296...&gt;<br>URL: https://www.mail-arc=
hive.com/openvpn-devel@lists.sourceforge.net/msg33964.html<br>Signed-off-by=
: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/gremlin.c<br=
>1 file changed, 2 insertions(+), 11 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/gremlin.c b/src/openvpn/gremlin.c</span><br><sp=
an>index 0e5e93f..a3dbff1 100644</span><br><span>--- a/src/openvpn/gremlin.=
c</span><br><span>+++ b/src/openvpn/gremlin.c</span><br><span>@@ -98,11 +98=
,6 @@</span><br><span>     return (get_random() % n) =3D=3D 0;</span><br><s=
pan> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wconv=
ersion&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /*</sp=
an><br><span>  * Return uniformly distributed random number between</span><=
br><span>  * low and high.</span><br><span>@@ -112,7 +107,7 @@</span><br><s=
pan> {</span><br><span>     int ret;</span><br><span>     ASSERT(low &lt;=
=3D high);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ret =3D=
 low + (get_random() % (high - low + 1));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    ret =3D low + (int)(get_random() % (high - low + =
1));</span><br><span>     ASSERT(ret &gt;=3D low &amp;&amp; ret &lt;=3D hig=
h);</span><br><span>     return ret;</span><br><span> }</span><br><span>@@ =
-195,7 +190,7 @@</span><br><span>             {</span><br><span>           =
      if (buf-&gt;len &gt; 0)</span><br><span>                 {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                    uint8_t r =
=3D roll(0, 255);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                  uint8_t r =3D (uint8_t)roll(0, 255);</span><br><span>    =
                 int method =3D roll(0, 5);</span><br><span> </span><br><sp=
an>                     switch (method)</span><br><span>@@ -235,8 +230,4 @@=
</span><br><span>     }</span><br><span> }</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__c=
lang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC di=
agnostic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #endif=
 /* ifdef ENABLE_DEBUG */</span><br><span></span><br></pre><p>To view, visi=
t <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1286?usp=3Demail">change=
 1286</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div i=
temscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"ur=
l" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1286?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2554b9baec6af191b0adb137e64=
124586dc4331c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1286 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--svf0B/ZaPpE=--

