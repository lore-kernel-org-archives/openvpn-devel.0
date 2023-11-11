From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 11 Nov 2023 08:46:07 +0000
In-Reply-To: <gerrit.1699637918000.I0c78ce452135fe2c80275da449215ba926471018@...2715...>
References: <gerrit.1699637918000.I0c78ce452135fe2c80275da449215ba926471018@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <5d5922a2f2248e160c8cd3e87c63dd7cee72ccb8-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="dJi4q3c0T1c="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: platform.c: Do not
 depend Windows build on HAVE_CHDIR
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, stipa <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--dJi4q3c0T1c=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/425?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by stipa


Change subject: platform.c: Do not depend Windows build on HAVE_CHDIR
......................................................................

platform.c: Do not depend Windows build on HAVE_CHDIR

This broke in the CMake build since previously we
just always set HAVE_CHDIR to 1 in the MSVC build.
But actually the code should just not check HAVE_CHDIR
on Windows.

Github: fixes OpenVPN/openvpn#448

Change-Id: I0c78ce452135fe2c80275da449215ba926471018
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Lev Stipakov <lstipakov@...277...>
Message-Id: <20231111081808.30967-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27=
362.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/platform.c
1 file changed, 2 insertions(+), 2 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/25/425/2

diff --git a/src/openvpn/platform.c b/src/openvpn/platform.c
index 32c4fe6..62acabe 100644
--- a/src/openvpn/platform.c
+++ b/src/openvpn/platform.c
@@ -392,7 +392,6 @@
 int
 platform_chdir(const char *dir)
 {
-#ifdef HAVE_CHDIR
 #ifdef _WIN32
     int res;
     struct gc_arena gc =3D gc_new();
@@ -400,11 +399,12 @@
     gc_free(&gc);
     return res;
 #else  /* ifdef _WIN32 */
+#ifdef HAVE_CHDIR
     return chdir(dir);
-#endif
 #else  /* ifdef HAVE_CHDIR */
     return -1;
 #endif
+#endif
 }

 /*

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/425?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0c78ce452135fe2c80275da449215ba926471018
Gerrit-Change-Number: 425
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: cron2 <gert@...1296...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--dJi4q3c0T1c=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/425?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by stipa</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">platform.c: Do not depend Windows build on HAVE_CHDI=
R<br><br>This broke in the CMake build since previously we<br>just always s=
et HAVE_CHDIR to 1 in the MSVC build.<br>But actually the code should just =
not check HAVE_CHDIR<br>on Windows.<br><br>Github: fixes OpenVPN/openvpn#44=
8<br><br>Change-Id: I0c78ce452135fe2c80275da449215ba926471018<br>Signed-off=
-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Lev Stipakov &=
lt;lstipakov@...277...&gt;<br>Message-Id: &lt;20231111081808.30967-1-gert@...220...=
..1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1439...=
ceforge.net/msg27362.html<br>Signed-off-by: Gert Doering &lt;gert@...2132...=
.&gt;<br>---<br>M src/openvpn/platform.c<br>1 file changed, 2 insertions(+)=
, 2 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn =
refs/changes/25/425/2</pre><pre style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;"><span>diff --git a/src/openvpn/platform.c b/src/ope=
nvpn/platform.c</span><br><span>index 32c4fe6..62acabe 100644</span><br><sp=
an>--- a/src/openvpn/platform.c</span><br><span>+++ b/src/openvpn/platform.=
c</span><br><span>@@ -392,7 +392,6 @@</span><br><span> int</span><br><span>=
 platform_chdir(const char *dir)</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#ifdef HAVE_CHDIR</span><br><span> #ifdef _=
WIN32</span><br><span>     int res;</span><br><span>     struct gc_arena gc=
 =3D gc_new();</span><br><span>@@ -400,11 +399,12 @@</span><br><span>     g=
c_free(&amp;gc);</span><br><span>     return res;</span><br><span> #else  /=
* ifdef _WIN32 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#i=
fdef HAVE_CHDIR</span><br><span>     return chdir(dir);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span> #else  /* ifdef H=
AVE_CHDIR */</span><br><span>     return -1;</span><br><span> #endif</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span> }<=
/span><br><span> </span><br><span> /*</span><br><span></span><br></pre><p>T=
o view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/425?usp=3Dem=
ail">change 425</a>. To unsubscribe, or for help writing mail filters, visi=
t <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div item=
scope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url=
" href=3D"http://gerrit.openvpn.net/c/openvpn/+/425?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0c78ce452135fe2c80275da4492=
15ba926471018 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 425 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@...277...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@...1296...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--dJi4q3c0T1c=--

