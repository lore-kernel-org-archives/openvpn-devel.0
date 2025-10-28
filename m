From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 28 Oct 2025 18:55:15 +0000
In-Reply-To: <gerrit.1760967063000.I2554b9baec6af191b0adb137e64124586dc4331c@...2715...>
References: <gerrit.1760967063000.I2554b9baec6af191b0adb137e64124586dc4331c@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <c7c35572a5c07b0533f9dbe17fa0d6c675be778f-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="H1kfxLix0Ss="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--H1kfxLix0Ss=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#3) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1286?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/86/1286/3

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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I2554b9baec6af191b0adb137e64124586dc4331c
Gerrit-Change-Number: 1286
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--H1kfxLix0Ss=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #3</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1286?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">gremlin: Avoid some conversion warn=
ings<br><br>We know these casts are safe, so make<br>them explicit.<br><br>=
Change-Id: I2554b9baec6af191b0adb137e64124586dc4331c<br>Signed-off-by: Fran=
k Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doering &lt;gert@...220...=
..1296...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1286<br=
>Message-Id: &lt;20251028183945.31901-1-gert@...1296...&gt;<br>URL: https:/=
/www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33964.html<br>=
Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn=
/gremlin.c<br>1 file changed, 2 insertions(+), 11 deletions(-)<br><br></pre=
><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes=
/86/1286/3</pre><pre style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;"><span>diff --git a/src/openvpn/gremlin.c b/src/openvpn/gremlin=
.c</span><br><span>index 0e5e93f..a3dbff1 100644</span><br><span>--- a/src/=
openvpn/gremlin.c</span><br><span>+++ b/src/openvpn/gremlin.c</span><br><sp=
an>@@ -98,11 +98,6 @@</span><br><span>     return (get_random() % n) =3D=3D=
 0;</span><br><span> }</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignor=
ed &quot;-Wconversion&quot;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span> /*</span><br><span>  * Return uniformly distributed random number =
between</span><br><span>  * low and high.</span><br><span>@@ -112,7 +107,7 =
@@</span><br><span> {</span><br><span>     int ret;</span><br><span>     AS=
SERT(low &lt;=3D high);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    ret =3D low + (get_random() % (high - low + 1));</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    ret =3D low + (int)(get_random() % (=
high - low + 1));</span><br><span>     ASSERT(ret &gt;=3D low &amp;&amp; re=
t &lt;=3D high);</span><br><span>     return ret;</span><br><span> }</span>=
<br><span>@@ -195,7 +190,7 @@</span><br><span>             {</span><br><spa=
n>                 if (buf-&gt;len &gt; 0)</span><br><span>                =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
 uint8_t r =3D roll(0, 255);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                    uint8_t r =3D (uint8_t)roll(0, 255);</span><br=
><span>                     int method =3D roll(0, 5);</span><br><span> </s=
pan><br><span>                     switch (method)</span><br><span>@@ -235,=
8 +230,4 @@</span><br><span>     }</span><br><span> }</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || =
defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pr=
agma GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan> #endif /* ifdef ENABLE_DEBUG */</span><br><span></span><br></pre><p>To=
 view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1286?usp=3Dem=
ail">change 1286</a>. To unsubscribe, or for help writing mail filters, vis=
it <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.=
</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemsco=
pe itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link item=
prop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1286?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
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

--H1kfxLix0Ss=--

