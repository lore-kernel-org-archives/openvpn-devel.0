From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 16 Nov 2025 22:06:53 +0000
In-Reply-To: <gerrit.1761324750000.I3309265edf8d6bea7bd73b21eef589a92ede6e0a@...2715...>
References: <gerrit.1761324750000.I3309265edf8d6bea7bd73b21eef589a92ede6e0a@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <a093c6230afc02cf528657010965a20d9c912102-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Y4Ns2u4bOWI="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Y4Ns2u4bOWI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/13=
00?usp=3Demail )

Change subject: ssl: Clean up type handling in write_string()
......................................................................

ssl: Clean up type handling in write_string()

Make better checks for the maxlen input value.

Change-Id: I3309265edf8d6bea7bd73b21eef589a92ede6e0a
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1300
Message-Id: <20251104091940.10826-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
191.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/ssl.c
1 file changed, 9 insertions(+), 8 deletions(-)




diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 92a68d0..22a1f52 100644
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

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1300?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3309265edf8d6bea7bd73b21eef589a92ede6e0a
Gerrit-Change-Number: 1300
Gerrit-PatchSet: 7
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Y4Ns2u4bOWI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1300?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">ssl: Clean up type handling in write_string()<br=
><br>Make better checks for the maxlen input value.<br><br>Change-Id: I3309=
265edf8d6bea7bd73b21eef589a92ede6e0a<br>Signed-off-by: Frank Lichtenheld &l=
t;frank@...2641...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br=
>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1300<br>Message-Id: &lt=
;20251104091940.10826-1-gert@...1296...&gt;<br>URL: https://www.mail-archiv=
e.com/openvpn-devel@lists.sourceforge.net/msg34191.html<br>Signed-off-by: G=
ert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/ssl.c<br>1 file=
 changed, 9 insertions(+), 8 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c</span><br><span>index=
 92a68d0..22a1f52 100644</span><br><span>--- a/src/openvpn/ssl.c</span><br>=
<span>+++ b/src/openvpn/ssl.c</span><br><span>@@ -1780,20 +1780,16 @@</span=
><br><span>     return true;</span><br><span> }</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || define=
d(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma G=
CC diagnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pr=
agma GCC diagnostic ignored &quot;-Wconversion&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span> static bool</span><br><span> write_strin=
g(struct buffer *buf, const char *str, const int maxlen)</span><br><span> {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const int len =3D=
 strlen(str) + 1;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
if (len &lt; 1 || (maxlen &gt;=3D 0 &amp;&amp; len &gt; maxlen))</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    const size_t len =3D strle=
n(str) + 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cons=
t size_t real_maxlen =3D (maxlen &gt;=3D 0 &amp;&amp; maxlen &lt;=3D UINT16=
_MAX) ? (size_t)maxlen : UINT16_MAX;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if (len &gt; real_maxlen)</span><br><span>     {</span=
><br><span>         return false;</span><br><span>     }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    if (!buf_write_u16(buf, len))</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!buf_write_u16(buf=
, (uint16_t)len))</span><br><span>     {</span><br><span>         return fa=
lse;</span><br><span>     }</span><br><span>@@ -1833,6 +1829,11 @@</span><b=
r><span>     return len;</span><br><span> }</span><br><span> </span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(=
__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma G=
CC diagnostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
pragma GCC diagnostic ignored &quot;-Wconversion&quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span> static char *</span><br><span> read=
_string_alloc(struct buffer *buf)</span><br><span> {</span><br><span></span=
><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/1300?usp=3Demail">change 1300</a>. To unsubscribe, or for help writing m=
ail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demai=
l">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAc=
tion"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
1300?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div><=
/div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3309265edf8d6bea7bd73b21eef=
589a92ede6e0a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1300 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--Y4Ns2u4bOWI=--

