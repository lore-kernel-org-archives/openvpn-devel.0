From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 19 Apr 2026 15:51:46 +0000
In-Reply-To: <gerrit.1775421558000.I87c40dc94035345add1162e5029e51288811cb09@...2715...>
References: <gerrit.1775421558000.I87c40dc94035345add1162e5029e51288811cb09@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <32de9819b975cf0afa5d24c4726ae37f367d2aba-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="YtSzIrXOFms="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: tapctl: Remove
 unused function dont_mute
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

--YtSzIrXOFms=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/16=
15?usp=3Demail )

Change subject: tapctl: Remove unused function dont_mute
......................................................................

tapctl: Remove unused function dont_mute

Identified by cppcheck.

Change-Id: I87c40dc94035345add1162e5029e51288811cb09
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1615
Message-Id: <20260419133947.21215-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36=
662.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/tapctl/error.h
M src/tapctl/main.c
2 files changed, 2 insertions(+), 11 deletions(-)




diff --git a/src/tapctl/error.h b/src/tapctl/error.h
index 9632b2f..f9586dc 100644
--- a/src/tapctl/error.h
+++ b/src/tapctl/error.h
@@ -109,11 +109,11 @@
     return (level & M_DEBUG_LEVEL) <=3D x_debug_level;
 }

-/** Return true if flags represent and enabled, not muted log level */
+/** Return true if flags represent */
 static inline bool
 msg_test(unsigned int flags)
 {
-    return check_debug_level(flags) && dont_mute(flags);
+    return check_debug_level(flags);
 }

 #endif /* ifndef ERROR_H */
diff --git a/src/tapctl/main.c b/src/tapctl/main.c
index 1d047dd..6a4a240 100644
--- a/src/tapctl/main.c
+++ b/src/tapctl/main.c
@@ -686,15 +686,6 @@
 }


-bool
-dont_mute(unsigned int flags)
-{
-    UNREFERENCED_PARAMETER(flags);
-
-    return true;
-}
-
-
 void
 x_msg_va(const unsigned int flags, const char *format, va_list arglist)
 {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1615?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I87c40dc94035345add1162e5029e51288811cb09
Gerrit-Change-Number: 1615
Gerrit-PatchSet: 4
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--YtSzIrXOFms=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1615?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">tapctl: Remove unused function dont_mute<br><br>=
Identified by cppcheck.<br><br>Change-Id: I87c40dc94035345add1162e5029e5128=
8811cb09<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Ac=
ked-by: Gert Doering &lt;gert@...1296...&gt;<br>Gerrit URL: https://gerrit.=
openvpn.net/c/openvpn/+/1615<br>Message-Id: &lt;20260419133947.21215-1-gert=
@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1466...=
urceforge.net/msg36662.html<br>Signed-off-by: Gert Doering &lt;gert@...1726...=
...&gt;<br>---<br>M src/tapctl/error.h<br>M src/tapctl/main.c<br>2 files ch=
anged, 2 insertions(+), 11 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/tapctl/error.h b/src/tapctl/error.h</span><br><span>ind=
ex 9632b2f..f9586dc 100644</span><br><span>--- a/src/tapctl/error.h</span><=
br><span>+++ b/src/tapctl/error.h</span><br><span>@@ -109,11 +109,11 @@</sp=
an><br><span>     return (level &amp; M_DEBUG_LEVEL) &lt;=3D x_debug_level;=
</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-/** Return true if flags represent and enabled, not muted l=
og level */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/** Retu=
rn true if flags represent */</span><br><span> static inline bool</span><br=
><span> msg_test(unsigned int flags)</span><br><span> {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    return check_debug_level(flags) &amp;=
&amp; dont_mute(flags);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    return check_debug_level(flags);</span><br><span> }</span><br><span=
> </span><br><span> #endif /* ifndef ERROR_H */</span><br><span>diff --git =
a/src/tapctl/main.c b/src/tapctl/main.c</span><br><span>index 1d047dd..6a4a=
240 100644</span><br><span>--- a/src/tapctl/main.c</span><br><span>+++ b/sr=
c/tapctl/main.c</span><br><span>@@ -686,15 +686,6 @@</span><br><span> }</sp=
an><br><span> </span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dont_m=
ute(unsigned int flags)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    UNREFERENCED_P=
ARAMETER(flags);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    return true;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span> void</span><br><span> x_msg_va(const unsigned int flag=
s, const char *format, va_list arglist)</span><br><span> {</span><br><span>=
</span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1615?usp=3Demail">change 1615</a>. To unsubscribe, or for help wri=
ting mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=
=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org=
/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/1615?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I87c40dc94035345add1162e5029=
e51288811cb09 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1615 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--YtSzIrXOFms=--

