From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 19 Apr 2026 15:51:44 +0000
In-Reply-To: <gerrit.1775421558000.I87c40dc94035345add1162e5029e51288811cb09@...2715...>
References: <gerrit.1775421558000.I87c40dc94035345add1162e5029e51288811cb09@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <32de9819b975cf0afa5d24c4726ae37f367d2aba-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="eBNP3lwuIc4="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--eBNP3lwuIc4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#4) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1615?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/15/1615/4

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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I87c40dc94035345add1162e5029e51288811cb09
Gerrit-Change-Number: 1615
Gerrit-PatchSet: 4
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--eBNP3lwuIc4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #4</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1615?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">tapctl: Remove unused function dont=
_mute<br><br>Identified by cppcheck.<br><br>Change-Id: I87c40dc94035345add1=
162e5029e51288811cb09<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2746...=
...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Gerrit URL: ht=
tps://gerrit.openvpn.net/c/openvpn/+/1615<br>Message-Id: &lt;20260419133947=
.21215-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-d=
evel@lists.sourceforge.net/msg36662.html<br>Signed-off-by: Gert Doering &lt=
;gert@...1296...&gt;<br>---<br>M src/tapctl/error.h<br>M src/tapctl/main.c<=
br>2 files changed, 2 insertions(+), 11 deletions(-)<br><br></pre><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/15/1615/4=
</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap=
;"><span>diff --git a/src/tapctl/error.h b/src/tapctl/error.h</span><br><sp=
an>index 9632b2f..f9586dc 100644</span><br><span>--- a/src/tapctl/error.h</=
span><br><span>+++ b/src/tapctl/error.h</span><br><span>@@ -109,11 +109,11 =
@@</span><br><span>     return (level &amp; M_DEBUG_LEVEL) &lt;=3D x_debug_=
level;</span><br><span> }</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-/** Return true if flags represent and enabled, not m=
uted log level */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*=
* Return true if flags represent */</span><br><span> static inline bool</sp=
an><br><span> msg_test(unsigned int flags)</span><br><span> {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    return check_debug_level(flags)=
 &amp;&amp; dont_mute(flags);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    return check_debug_level(flags);</span><br><span> }</span><br=
><span> </span><br><span> #endif /* ifndef ERROR_H */</span><br><span>diff =
--git a/src/tapctl/main.c b/src/tapctl/main.c</span><br><span>index 1d047dd=
..6a4a240 100644</span><br><span>--- a/src/tapctl/main.c</span><br><span>++=
+ b/src/tapctl/main.c</span><br><span>@@ -686,15 +686,6 @@</span><br><span>=
 }</span><br><span> </span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
dont_mute(unsigned int flags)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    UNREFERE=
NCED_PARAMETER(flags);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return true;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span> void</span><br><span> x_msg_va(const unsigned =
int flags, const char *format, va_list arglist)</span><br><span> {</span><b=
r><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/1615?usp=3Demail">change 1615</a>. To unsubscribe, or for =
help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/setti=
ngs?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.=
org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sch=
ema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/1615?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Ch=
ange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
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

--eBNP3lwuIc4=--

