From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 24 Oct 2025 16:52:51 +0000
References: <gerrit.1761324750000.I3309265edf8d6bea7bd73b21eef589a92ede6e0a@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <6afd005d8c5e7eda1a917810219007636f8133bb-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="bg+v8sdVfFY="; charset=UTF-8
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

--bg+v8sdVfFY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1300?usp=3Demail

to review the following change.


Change subject: ssl: Clean up type handling in write_string()
......................................................................

ssl: Clean up type handling in write_string()

Make better checks for the maxlen input value.

Change-Id: I3309265edf8d6bea7bd73b21eef589a92ede6e0a
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/ssl.c
1 file changed, 9 insertions(+), 8 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/00/1300/1

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 925c5af..39abb59 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1781,20 +1781,16 @@
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
+    if (len < 2 || len > real_maxlen)
     {
         return false;
     }
-    if (!buf_write_u16(buf, len))
+    if (!buf_write_u16(buf, (uint16_t)len))
     {
         return false;
     }
@@ -1834,6 +1830,11 @@
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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3309265edf8d6bea7bd73b21eef589a92ede6e0a
Gerrit-Change-Number: 1300
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--bg+v8sdVfFY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1300?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">ssl: Clean up type handling in write_string=
()<br><br>Make better checks for the maxlen input value.<br><br>Change-Id: =
I3309265edf8d6bea7bd73b21eef589a92ede6e0a<br>Signed-off-by: Frank Lichtenhe=
ld &lt;frank@...2641...&gt;<br>---<br>M src/openvpn/ssl.c<br>1 file changed=
, 9 insertions(+), 8 deletions(-)<br><br></pre><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit.openvpn.net:29418/openvpn refs/changes/00/1300/1</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpn/ssl.c b/src/openvpn/ssl.c</span><br><span>index 925c5af..=
39abb59 100644</span><br><span>--- a/src/openvpn/ssl.c</span><br><span>+++ =
b/src/openvpn/ssl.c</span><br><span>@@ -1781,20 +1781,16 @@</span><br><span=
>     return true;</span><br><span> }</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang_=
_)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnos=
tic push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC d=
iagnostic ignored &quot;-Wconversion&quot;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span> static bool</span><br><span> write_string(struct bu=
ffer *buf, const char *str, const int maxlen)</span><br><span> {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    const int len =3D strlen(str=
) + 1;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (len &lt=
; 1 || (maxlen &gt;=3D 0 &amp;&amp; len &gt; maxlen))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const size_t len =3D strlen(str) + 1;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const size_t re=
al_maxlen =3D (maxlen &gt;=3D 0 &amp;&amp; maxlen &lt;=3D UINT16_MAX) ? (si=
ze_t)maxlen : UINT16_MAX;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    if (len &lt; 2 || len &gt; real_maxlen)</span><br><span>     {</s=
pan><br><span>         return false;</span><br><span>     }</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    if (!buf_write_u16(buf, len))</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!buf_write_u16(=
buf, (uint16_t)len))</span><br><span>     {</span><br><span>         return=
 false;</span><br><span>     }</span><br><span>@@ -1834,6 +1830,11 @@</span=
><br><span>     return len;</span><br><span> }</span><br><span> </span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defin=
ed(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragm=
a GCC diagnostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#pragma GCC diagnostic ignored &quot;-Wconversion&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span> static char *</span><br><span> r=
ead_string_alloc(struct buffer *buf)</span><br><span> {</span><br><span></s=
pan><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/1300?usp=3Demail">change 1300</a>. To unsubscribe, or for help writin=
g mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3De=
mail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/Vie=
wAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/1300?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></di=
v></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3309265edf8d6bea7bd73b21eef=
589a92ede6e0a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1300 </div>
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

--bg+v8sdVfFY=--

