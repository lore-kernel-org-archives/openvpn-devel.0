From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 16 Feb 2026 18:57:59 +0000
In-Reply-To: <gerrit.1771268251000.Ie3f209a641c2f56494dfc7720b13f2a2ba3001a8@...2715...>
References: <gerrit.1771268251000.Ie3f209a641c2f56494dfc7720b13f2a2ba3001a8@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <f7f9e830d8ff11c39395b31bb6724cd6c05638dc-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="XSKqNmddIlo="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--XSKqNmddIlo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1535?usp=3Demail

to look at the new patch set (#2).


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
---
M configure.ac
1 file changed, 1 insertion(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/35/1535/2

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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie3f209a641c2f56494dfc7720b13f2a2ba3001a8
Gerrit-Change-Number: 1535
Gerrit-PatchSet: 2
Gerrit-Owner: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--XSKqNmddIlo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>cron2 <strong>uploaded patch set #2</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1535?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">configure.ac: adjust to native inotify support for Free=
BSD 15+<br><br>FreeBSD 15 has native inotify support, and no &quot;libinoti=
fy.pc&quot; pkg config<br>file anymore, plus no extra includes are needed. =
 This works fine if we<br>conditionalize the FreeBSD check to &quot;freebsd=
-1[0-4]&quot;.<br><br>Due to m4 involvement double braces are needed for qu=
oting.<br><br>See https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=3D29317=
6<br><br>Reported-by: Ivo Karabojkov &lt;karabojkov@...2996...&gt;<br>Repor=
ted-by: Marek Zarychta &lt;zarychtam@...2997...&gt;<br><br>Change-Id: Ie3f2=
09a641c2f56494dfc7720b13f2a2ba3001a8<br>Signed-off-by: Gert Doering &lt;ger=
t@...1296...&gt;<br>---<br>M configure.ac<br>1 file changed, 1 insertion(+)=
, 1 deletion(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.ne=
t:29418/openvpn refs/changes/35/1535/2</pre><pre style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;"><span>diff --git a/configure.ac b/=
configure.ac</span><br><span>index 9fa6a41..e151816 100644</span><br><span>=
--- a/configure.ac</span><br><span>+++ b/configure.ac</span><br><span>@@ -1=
294,7 +1294,7 @@</span><br><span> </span><br><span> if test &quot;${enable_=
async_push}&quot; =3D &quot;yes&quot;; then</span><br><span> 	case &quot;$h=
ost&quot; in</span><br><span style=3D"color: hsl(0, 100%, 40%);">-		*-*-fre=
ebsd*)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+		*-*-freebsd=
1[[0-4]]*)</span><br><span> 			PKG_CHECK_MODULES(</span><br><span> 				[OPT=
IONAL_INOTIFY],</span><br><span> 				[libinotify],</span><br><span></span><=
br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/1535?usp=3Demail">change 1535</a>. To unsubscribe, or for help writing mai=
l filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail"=
>settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage=
"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewActi=
on"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/15=
35?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></d=
iv>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie3f209a641c2f56494dfc7720b1=
3f2a2ba3001a8 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1535 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@...1296...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--XSKqNmddIlo=--

