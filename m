From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 21 Nov 2023 12:54:17 +0000
References: <gerrit.1700571255000.I7da7c2d7d34c7e5efd52d448646b4398a1005e77@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <e6dea37a1b9d7bf9e4a05eb769f794b4920f6e3d-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/4miw9+dozI="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--/4miw9+dozI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/453?usp=3Demail

to review the following change.


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
---
M configure.ac
1 file changed, 0 insertions(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/53/453/1

diff --git a/configure.ac b/configure.ac
index 84eaad6..5cc55c3 100644
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
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--/4miw9+dozI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/453?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">configure.ac: Remove unused AC_TYPE_SIGNAL macro<br><br>Recen=
t autoconf warns:<br>configure.ac:448: warning: The macro `AC_TYPE_SIGNAL&#=
39; is obsolete.<br><br>And it turns out that we do not actually use RETSIG=
TYPE.<br>Additionally, there is no reason to do so since as the<br>autoconf=
 documentation says:<br>&quot;These days, it is portable to assume C89, and=
 that signal<br>handlers return void, without needing to use this macro or<=
br>RETSIGTYPE.&quot;<br><br>Change-Id: I7da7c2d7d34c7e5efd52d448646b4398a10=
05e77<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<b=
r>M configure.ac<br>1 file changed, 0 insertions(+), 1 deletion(-)<br><br><=
/pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/53/453/1</pr=
e><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><=
span>diff --git a/configure.ac b/configure.ac</span><br><span>index 84eaad6=
..5cc55c3 100644</span><br><span>--- a/configure.ac</span><br><span>+++ b/c=
onfigure.ac</span><br><span>@@ -445,7 +445,6 @@</span><br><span> AC_TYPE_PI=
D_T</span><br><span> AC_TYPE_SIZE_T</span><br><span> AC_TYPE_UID_T</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-AC_TYPE_SIGNAL</span><br><span=
> AX_TYPE_SOCKLEN_T</span><br><span> AC_CHECK_SIZEOF([unsigned int])</span>=
<br><span> AC_CHECK_SIZEOF([unsigned long])</span><br><span></span><br></pr=
e><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/453?us=
p=3Demail">change 453</a>. To unsubscribe, or for help writing mail filters=
, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><di=
v itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope item=
prop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/453?usp=3Demail"/><meta=
 itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7da7c2d7d34c7e5efd52d448646=
b4398a1005e77 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 453 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--/4miw9+dozI=--

