From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 4 Jun 2024 12:57:51 +0000
References: <gerrit.1717505869000.Ic33c210f06e173a450534aa0969c57f140086655@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <50abac374d6c37804cff35e0161a37bb5e31ddac-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="folQhVmYOUo="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: test_user_pass: Fix
 building with --enable-systemd
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

--folQhVmYOUo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/641?usp=3Demail

to review the following change.


Change subject: test_user_pass: Fix building with --enable-systemd
......................................................................

test_user_pass: Fix building with --enable-systemd

Need to make sure that ENABLE_SYSTEMD is really disabled.

Change-Id: Ic33c210f06e173a450534aa0969c57f140086655
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M tests/unit_tests/openvpn/test_user_pass.c
1 file changed, 2 insertions(+), 0 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/41/641/1

diff --git a/tests/unit_tests/openvpn/test_user_pass.c b/tests/unit_tests/o=
penvpn/test_user_pass.c
index ac84654..b43e655 100644
--- a/tests/unit_tests/openvpn/test_user_pass.c
+++ b/tests/unit_tests/openvpn/test_user_pass.c
@@ -27,6 +27,8 @@
 #endif

 #undef ENABLE_SYSTEMD
+/* avoid redefining ENABLE_SYSTEMD in misc.c */
+#undef HAVE_CONFIG_H

 #include "syshead.h"
 #include "manage.h"

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/641?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic33c210f06e173a450534aa0969c57f140086655
Gerrit-Change-Number: 641
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--folQhVmYOUo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/641?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">test_user_pass: Fix building with --enable-systemd<br><br>Nee=
d to make sure that ENABLE_SYSTEMD is really disabled.<br><br>Change-Id: Ic=
33c210f06e173a450534aa0969c57f140086655<br>Signed-off-by: Frank Lichtenheld=
 &lt;frank@...2641...&gt;<br>---<br>M tests/unit_tests/openvpn/test_user_pa=
ss.c<br>1 file changed, 2 insertions(+), 0 deletions(-)<br><br></pre><pre s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull =
ssh://gerrit.openvpn.net:29418/openvpn refs/changes/41/641/1</pre><pre styl=
e=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff -=
-git a/tests/unit_tests/openvpn/test_user_pass.c b/tests/unit_tests/openvpn=
/test_user_pass.c</span><br><span>index ac84654..b43e655 100644</span><br><=
span>--- a/tests/unit_tests/openvpn/test_user_pass.c</span><br><span>+++ b/=
tests/unit_tests/openvpn/test_user_pass.c</span><br><span>@@ -27,6 +27,8 @@=
</span><br><span> #endif</span><br><span> </span><br><span> #undef ENABLE_S=
YSTEMD</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* avoid rede=
fining ENABLE_SYSTEMD in misc.c */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#undef HAVE_CONFIG_H</span><br><span> </span><br><span> #inc=
lude &quot;syshead.h&quot;</span><br><span> #include &quot;manage.h&quot;</=
span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/641?usp=3Demail">change 641</a>. To unsubscribe, or=
 for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/=
settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org=
/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/641?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/><=
/div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic33c210f06e173a450534aa0969=
c57f140086655 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 641 </div>
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


--folQhVmYOUo=--

