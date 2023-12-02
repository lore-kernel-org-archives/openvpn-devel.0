From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 2 Dec 2023 16:02:48 +0000
In-Reply-To: <gerrit.1700571255000.I7da7c2d7d34c7e5efd52d448646b4398a1005e77@...2715...>
References: <gerrit.1700571255000.I7da7c2d7d34c7e5efd52d448646b4398a1005e77@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <4e3851a4c33f93a5ace85629494d0580bed22306-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="vecF7GT7lRc="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: configure.ac:
 Remove unused AC_TYPE_SIGNAL macro
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

--vecF7GT7lRc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/45=
3?usp=3Demail )

Change subject: configure.ac: Remove unused AC_TYPE_SIGNAL macro
......................................................................

configure.ac: Remove unused AC_TYPE_SIGNAL macro

Recent autoconf warns:
configure.ac:448: warning: The macro `AC_TYPE_SIGNAL' is obsolete.

And it turns out that we do not actually use RETSIGTYPE.
Additionally, there is no reason to do so since as the
autoconf documentation says:
"These days, it is portable to assume C89, and that signal
handlers return void, without needing to use this macro or
RETSIGTYPE."

Change-Id: I7da7c2d7d34c7e5efd52d448646b4398a1005e77
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Message-Id: <20231128103740.61160-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27=
572.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M configure.ac
1 file changed, 0 insertions(+), 1 deletion(-)




diff --git a/configure.ac b/configure.ac
index 141acc6..0f667dc 100644
--- a/configure.ac
+++ b/configure.ac
@@ -445,7 +445,6 @@
 AC_TYPE_PID_T
 AC_TYPE_SIZE_T
 AC_TYPE_UID_T
-AC_TYPE_SIGNAL
 AX_TYPE_SOCKLEN_T
 AC_CHECK_SIZEOF([unsigned int])
 AC_CHECK_SIZEOF([unsigned long])

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/453?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7da7c2d7d34c7e5efd52d448646b4398a1005e77
Gerrit-Change-Number: 453
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--vecF7GT7lRc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/453?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">configure.ac: Remove unused AC_TYPE_SIGNAL mac=
ro<br><br>Recent autoconf warns:<br>configure.ac:448: warning: The macro `A=
C_TYPE_SIGNAL&#39; is obsolete.<br><br>And it turns out that we do not actu=
ally use RETSIGTYPE.<br>Additionally, there is no reason to do so since as =
the<br>autoconf documentation says:<br>&quot;These days, it is portable to =
assume C89, and that signal<br>handlers return void, without needing to use=
 this macro or<br>RETSIGTYPE.&quot;<br><br>Change-Id: I7da7c2d7d34c7e5efd52=
d448646b4398a1005e77<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2724...=
..&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@...1227...&gt;<br>Message=
-Id: &lt;20231128103740.61160-1-frank@...2641...&gt;<br>URL: https://www.ma=
il-archive.com/openvpn-devel@lists.sourceforge.net/msg27572.html<br>Signed-=
off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M configure.ac<br>1 =
file changed, 0 insertions(+), 1 deletion(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/configure.ac b/configure.ac</span><br><span>index 141acc6..=
0f667dc 100644</span><br><span>--- a/configure.ac</span><br><span>+++ b/con=
figure.ac</span><br><span>@@ -445,7 +445,6 @@</span><br><span> AC_TYPE_PID_=
T</span><br><span> AC_TYPE_SIZE_T</span><br><span> AC_TYPE_UID_T</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-AC_TYPE_SIGNAL</span><br><span> =
AX_TYPE_SOCKLEN_T</span><br><span> AC_CHECK_SIZEOF([unsigned int])</span><b=
r><span> AC_CHECK_SIZEOF([unsigned long])</span><br><span></span><br></pre>=
<p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/453?usp=
=3Demail">change 453</a>. To unsubscribe, or for help writing mail filters,=
 visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div=
 itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/453?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7da7c2d7d34c7e5efd52d448646=
b4398a1005e77 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 453 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--vecF7GT7lRc=--

