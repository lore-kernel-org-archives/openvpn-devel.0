From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 20 Feb 2026 14:25:06 +0000
In-Reply-To: <gerrit.1771268251000.Ie3f209a641c2f56494dfc7720b13f2a2ba3001a8@...2715...>
References: <gerrit.1771268251000.Ie3f209a641c2f56494dfc7720b13f2a2ba3001a8@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, antonio@...2726...
Message-ID: <04dbc9ca58d2f959b5a4c270237f951a6fb65e60-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="XBLX/00/jOI="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: configure.ac:
 adjust to native inotify support for FreeBSD 15+
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--XBLX/00/jOI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/15=
35?usp=3Demail )

Change subject: configure.ac: adjust to native inotify support for FreeBSD =
15+
......................................................................

configure.ac: adjust to native inotify support for FreeBSD 15+

FreeBSD 15 has native inotify support, and no "libinotify.pc" pkg config
file anymore, plus no extra includes are needed.  This works fine if we
conditionalize the FreeBSD check to "freebsd-1[0-4]".

Due to m4 involvement double braces are needed for quoting.

See https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=3D293176

Reported-by: Ivo Karabojkov <karabojkov@...2996...>
Reported-by: Marek Zarychta <zarychtam@...2997...>

Change-Id: Ie3f209a641c2f56494dfc7720b13f2a2ba3001a8
Signed-off-by: Gert Doering <gert@...1296...>
Acked-by: Antonio Quartulli <antonio@...2726...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1535
Message-Id: <20260220102106.32024-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35=
761.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M configure.ac
1 file changed, 1 insertion(+), 1 deletion(-)




diff --git a/configure.ac b/configure.ac
index 9fa6a41..e151816 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1294,7 +1294,7 @@

 if test "${enable_async_push}" =3D "yes"; then
 	case "$host" in
-		*-*-freebsd*)
+		*-*-freebsd1[[0-4]]*)
 			PKG_CHECK_MODULES(
 				[OPTIONAL_INOTIFY],
 				[libinotify],

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1535?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie3f209a641c2f56494dfc7720b13f2a2ba3001a8
Gerrit-Change-Number: 1535
Gerrit-PatchSet: 3
Gerrit-Owner: cron2 <gert@...1296...>
Gerrit-Reviewer: ordex <antonio@...2726...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--XBLX/00/jOI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1535?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">configure.ac: adjust to native inotify support f=
or FreeBSD 15+<br><br>FreeBSD 15 has native inotify support, and no &quot;l=
ibinotify.pc&quot; pkg config<br>file anymore, plus no extra includes are n=
eeded.  This works fine if we<br>conditionalize the FreeBSD check to &quot;=
freebsd-1[0-4]&quot;.<br><br>Due to m4 involvement double braces are needed=
 for quoting.<br><br>See https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=
=3D293176<br><br>Reported-by: Ivo Karabojkov &lt;karabojkov@...2996...&gt;<=
br>Reported-by: Marek Zarychta &lt;zarychtam@...2997...&gt;<br><br>Change-I=
d: Ie3f209a641c2f56494dfc7720b13f2a2ba3001a8<br>Signed-off-by: Gert Doering=
 &lt;gert@...1296...&gt;<br>Acked-by: Antonio Quartulli &lt;antonio@...2787...=
...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1535<br>Messa=
ge-Id: &lt;20260220102106.32024-1-gert@...1296...&gt;<br>URL: https://www.m=
ail-archive.com/openvpn-devel@lists.sourceforge.net/msg35761.html<br>Signed=
-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M configure.ac<br>1=
 file changed, 1 insertion(+), 1 deletion(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/configure.ac b/configure.ac</span><br><span>index 9fa6a41..=
e151816 100644</span><br><span>--- a/configure.ac</span><br><span>+++ b/con=
figure.ac</span><br><span>@@ -1294,7 +1294,7 @@</span><br><span> </span><br=
><span> if test &quot;${enable_async_push}&quot; =3D &quot;yes&quot;; then<=
/span><br><span> 	case &quot;$host&quot; in</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-		*-*-freebsd*)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+		*-*-freebsd1[[0-4]]*)</span><br><span> 			PKG_CHECK_MOD=
ULES(</span><br><span> 				[OPTIONAL_INOTIFY],</span><br><span> 				[libino=
tify],</span><br><span></span><br></pre><p>To view, visit <a href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1535?usp=3Demail">change 1535</a>. To unsub=
scribe, or for help writing mail filters, visit <a href=3D"http://gerrit.op=
envpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D=
"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtyp=
e=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1535?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie3f209a641c2f56494dfc7720b1=
3f2a2ba3001a8 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1535 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@...1296...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;antonio@...2726...&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--XBLX/00/jOI=--

