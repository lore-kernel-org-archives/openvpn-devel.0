From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Sun, 5 Apr 2026 20:39:33 +0000
References: <gerrit.1775421558000.I87c40dc94035345add1162e5029e51288811cb09@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <e36ea95c12a6e1fb99726a2de49ed674c2c896e0-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="el4+xRR0M6U="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--el4+xRR0M6U=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1615?usp=3Demail

to review the following change.


Change subject: tapctl: Remove unused function dont_mute
......................................................................

tapctl: Remove unused function dont_mute

Identified by cppcheck.

Change-Id: I87c40dc94035345add1162e5029e51288811cb09
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/tapctl/error.h
M src/tapctl/main.c
2 files changed, 2 insertions(+), 11 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/15/1615/1

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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I87c40dc94035345add1162e5029e51288811cb09
Gerrit-Change-Number: 1615
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--el4+xRR0M6U=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1615?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">tapctl: Remove unused function dont_mute<br=
><br>Identified by cppcheck.<br><br>Change-Id: I87c40dc94035345add1162e5029=
e51288811cb09<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<=
br>---<br>M src/tapctl/error.h<br>M src/tapctl/main.c<br>2 files changed, 2=
 insertions(+), 11 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://g=
errit.openvpn.net:29418/openvpn refs/changes/15/1615/1</pre><pre style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a=
/src/tapctl/error.h b/src/tapctl/error.h</span><br><span>index 9632b2f..f95=
86dc 100644</span><br><span>--- a/src/tapctl/error.h</span><br><span>+++ b/=
src/tapctl/error.h</span><br><span>@@ -109,11 +109,11 @@</span><br><span>  =
   return (level &amp; M_DEBUG_LEVEL) &lt;=3D x_debug_level;</span><br><spa=
n> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-/** Return true if flags represent and enabled, not muted log level */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+/** Return true if flag=
s represent */</span><br><span> static inline bool</span><br><span> msg_tes=
t(unsigned int flags)</span><br><span> {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    return check_debug_level(flags) &amp;&amp; dont_mute=
(flags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return =
check_debug_level(flags);</span><br><span> }</span><br><span> </span><br><s=
pan> #endif /* ifndef ERROR_H */</span><br><span>diff --git a/src/tapctl/ma=
in.c b/src/tapctl/main.c</span><br><span>index 1d047dd..6a4a240 100644</spa=
n><br><span>--- a/src/tapctl/main.c</span><br><span>+++ b/src/tapctl/main.c=
</span><br><span>@@ -686,15 +686,6 @@</span><br><span> }</span><br><span> <=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dont_mute(unsigned in=
t flags)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    UNREFERENCED_PARAMETER(flags)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    return true;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span> void</span><br><span> x_msg_va(const unsigned int flags, const char *=
format, va_list arglist)</span><br><span> {</span><br><span></span><br></pr=
e><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1615?u=
sp=3Demail">change 1615</a>. To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settin=
gs</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div =
itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><li=
nk itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1615?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I87c40dc94035345add1162e5029=
e51288811cb09 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1615 </div>
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

--el4+xRR0M6U=--

