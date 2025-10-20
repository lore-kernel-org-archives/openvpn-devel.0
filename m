From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 20 Oct 2025 13:31:08 +0000
References: <gerrit.1760967063000.I2554b9baec6af191b0adb137e64124586dc4331c@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <30188dd1aca239001c1f2be6e69a9554263ddbcc-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="000P+CYSx+c="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000P+CYSx+c=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1286?usp=3Demail

to review the following change.


Change subject: gremlin: Avoid some conversion warnings
......................................................................

gremlin: Avoid some conversion warnings

We know these casts are safe, so make
them explicit.

Change-Id: I2554b9baec6af191b0adb137e64124586dc4331c
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/gremlin.c
1 file changed, 2 insertions(+), 11 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/86/1286/1

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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I2554b9baec6af191b0adb137e64124586dc4331c
Gerrit-Change-Number: 1286
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--000P+CYSx+c=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1286?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">gremlin: Avoid some conversion warnings<br>=
<br>We know these casts are safe, so make<br>them explicit.<br><br>Change-I=
d: I2554b9baec6af191b0adb137e64124586dc4331c<br>Signed-off-by: Frank Lichte=
nheld &lt;frank@...2641...&gt;<br>---<br>M src/openvpn/gremlin.c<br>1 file =
changed, 2 insertions(+), 11 deletions(-)<br><br></pre><pre class=3D"blocks=
" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pu=
ll ssh://gerrit.openvpn.net:29418/openvpn refs/changes/86/1286/1</pre><pre =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>di=
ff --git a/src/openvpn/gremlin.c b/src/openvpn/gremlin.c</span><br><span>in=
dex 0e5e93f..a3dbff1 100644</span><br><span>--- a/src/openvpn/gremlin.c</sp=
an><br><span>+++ b/src/openvpn/gremlin.c</span><br><span>@@ -98,11 +98,6 @@=
</span><br><span>     return (get_random() % n) =3D=3D 0;</span><br><span> =
}</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#i=
f defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wconversion=
&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /*</span><br=
><span>  * Return uniformly distributed random number between</span><br><sp=
an>  * low and high.</span><br><span>@@ -112,7 +107,7 @@</span><br><span> {=
</span><br><span>     int ret;</span><br><span>     ASSERT(low &lt;=3D high=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ret =3D low + (=
get_random() % (high - low + 1));</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    ret =3D low + (int)(get_random() % (high - low + 1));</sp=
an><br><span>     ASSERT(ret &gt;=3D low &amp;&amp; ret &lt;=3D high);</spa=
n><br><span>     return ret;</span><br><span> }</span><br><span>@@ -195,7 +=
190,7 @@</span><br><span>             {</span><br><span>                 if=
 (buf-&gt;len &gt; 0)</span><br><span>                 {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                    uint8_t r =3D roll(0=
, 255);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
        uint8_t r =3D (uint8_t)roll(0, 255);</span><br><span>              =
       int method =3D roll(0, 5);</span><br><span> </span><br><span>       =
              switch (method)</span><br><span>@@ -235,8 +230,4 @@</span><br=
><span>     }</span><br><span> }</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic p=
op</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #endif /* ifdef =
ENABLE_DEBUG */</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1286?usp=3Demail">change 1286</a>=
. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:/=
/gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope i=
temtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"actio=
n" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/1286?usp=3Demail"/><meta itemprop=3D=
"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2554b9baec6af191b0adb137e64=
124586dc4331c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1286 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--000P+CYSx+c=--

