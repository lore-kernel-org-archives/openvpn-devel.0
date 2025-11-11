From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 11 Nov 2025 14:26:54 +0000
In-Reply-To: <gerrit.1761324750000.I3309265edf8d6bea7bd73b21eef589a92ede6e0a@...2715...>
References: <gerrit.1761324750000.I3309265edf8d6bea7bd73b21eef589a92ede6e0a@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, gert@...1296...
Message-ID: <87eaf1f820572f81e7b792dd4722111f72e1c111-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="KWHo23bZ5qs="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: ssl: Clean up type
 handling in write_string()
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

--KWHo23bZ5qs=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello cron2, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1300?usp=3Demail

to look at the new patch set (#6).

The change is no longer submittable: checks~ChecksSubmitRule is unsatisfied=
 now.


Change subject: ssl: Clean up type handling in write_string()
......................................................................

ssl: Clean up type handling in write_string()

Make better checks for the maxlen input value.

Change-Id: I3309265edf8d6bea7bd73b21eef589a92ede6e0a
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/ssl.c
1 file changed, 9 insertions(+), 8 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/00/1300/6

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 355ab46..86f6f59 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1780,20 +1780,16 @@
     return true;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 static bool
 write_string(struct buffer *buf, const char *str, const int maxlen)
 {
-    const int len =3D strlen(str) + 1;
-    if (len < 1 || (maxlen >=3D 0 && len > maxlen))
+    const size_t len =3D strlen(str) + 1;
+    const size_t real_maxlen =3D (maxlen >=3D 0 && maxlen <=3D UINT16_MAX)=
 ? (size_t)maxlen : UINT16_MAX;
+    if (len > real_maxlen)
     {
         return false;
     }
-    if (!buf_write_u16(buf, len))
+    if (!buf_write_u16(buf, (uint16_t)len))
     {
         return false;
     }
@@ -1833,6 +1829,11 @@
     return len;
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 static char *
 read_string_alloc(struct buffer *buf)
 {

--=20
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1300?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3309265edf8d6bea7bd73b21eef589a92ede6e0a
Gerrit-Change-Number: 1300
Gerrit-PatchSet: 6
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>

--KWHo23bZ5qs=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld. </p>
<p>flichtenheld <strong>uploaded patch set #6</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1300?usp=3Demail">View C=
hange</a></p><p>The change is no longer submittable: checks~ChecksSubmitRul=
e is unsatisfied now.</p><pre class=3D"blocks" style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;">ssl: Clean up type handling in write=
_string()<br><br>Make better checks for the maxlen input value.<br><br>Chan=
ge-Id: I3309265edf8d6bea7bd73b21eef589a92ede6e0a<br>Signed-off-by: Frank Li=
chtenheld &lt;frank@...2641...&gt;<br>---<br>M src/openvpn/ssl.c<br>1 file =
changed, 9 insertions(+), 8 deletions(-)<br><br></pre><pre class=3D"blocks"=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pul=
l ssh://gerrit.openvpn.net:29418/openvpn refs/changes/00/1300/6</pre><pre s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>dif=
f --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c</span><br><span>index 355ab=
46..86f6f59 100644</span><br><span>--- a/src/openvpn/ssl.c</span><br><span>=
+++ b/src/openvpn/ssl.c</span><br><span>@@ -1780,20 +1780,16 @@</span><br><=
span>     return true;</span><br><span> }</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__cl=
ang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC dia=
gnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma G=
CC diagnostic ignored &quot;-Wconversion&quot;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span> static bool</span><br><span> write_string(struc=
t buffer *buf, const char *str, const int maxlen)</span><br><span> {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    const int len =3D strlen=
(str) + 1;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (len=
 &lt; 1 || (maxlen &gt;=3D 0 &amp;&amp; len &gt; maxlen))</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    const size_t len =3D strlen(str) =
+ 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const size_=
t real_maxlen =3D (maxlen &gt;=3D 0 &amp;&amp; maxlen &lt;=3D UINT16_MAX) ?=
 (size_t)maxlen : UINT16_MAX;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if (len &gt; real_maxlen)</span><br><span>     {</span><br><s=
pan>         return false;</span><br><span>     }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    if (!buf_write_u16(buf, len))</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    if (!buf_write_u16(buf, (uint=
16_t)len))</span><br><span>     {</span><br><span>         return false;</s=
pan><br><span>     }</span><br><span>@@ -1833,6 +1829,11 @@</span><br><span=
>     return len;</span><br><span> }</span><br><span> </span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang=
__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diag=
nostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma =
GCC diagnostic ignored &quot;-Wconversion&quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span> static char *</span><br><span> read_string=
_alloc(struct buffer *buf)</span><br><span> {</span><br><span></span><br></=
pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1300=
?usp=3Demail">change 1300</a>. To unsubscribe, or for help writing mail fil=
ters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">sett=
ings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><di=
v itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><=
link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1300?us=
p=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3309265edf8d6bea7bd73b21eef=
589a92ede6e0a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1300 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>

</body></html>=

--KWHo23bZ5qs=--

