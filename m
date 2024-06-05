From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 5 Jun 2024 11:16:56 +0000
In-Reply-To: <gerrit.1717505869000.Ic33c210f06e173a450534aa0969c57f140086655@...2715...>
References: <gerrit.1717505869000.Ic33c210f06e173a450534aa0969c57f140086655@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <b7fac06ce46ebc5d4180faf2ca5b7d384a44507b-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="CPGoVoEclmo="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--CPGoVoEclmo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/641?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: test_user_pass: Fix building with --enable-systemd
......................................................................

test_user_pass: Fix building with --enable-systemd

Need to make sure that ENABLE_SYSTEMD is really disabled.

Change-Id: Ic33c210f06e173a450534aa0969c57f140086655
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20240605111012.3023-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28=
708.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M tests/unit_tests/openvpn/test_user_pass.c
1 file changed, 2 insertions(+), 0 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/41/641/2

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
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--CPGoVoEclmo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/641?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">test_user_pass: Fix building with --enable-systemd<b=
r><br>Need to make sure that ENABLE_SYSTEMD is really disabled.<br><br>Chan=
ge-Id: Ic33c210f06e173a450534aa0969c57f140086655<br>Signed-off-by: Frank Li=
chtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doering &lt;gert@...1711...=
96...&gt;<br>Message-Id: &lt;20240605111012.3023-1-gert@...1296...&gt;<br>U=
RL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg287=
08.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M =
tests/unit_tests/openvpn/test_user_pass.c<br>1 file changed, 2 insertions(+=
), 0 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn=
 refs/changes/41/641/2</pre><pre style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;"><span>diff --git a/tests/unit_tests/openvpn/test_u=
ser_pass.c b/tests/unit_tests/openvpn/test_user_pass.c</span><br><span>inde=
x ac84654..b43e655 100644</span><br><span>--- a/tests/unit_tests/openvpn/te=
st_user_pass.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_user_pas=
s.c</span><br><span>@@ -27,6 +27,8 @@</span><br><span> #endif</span><br><sp=
an> </span><br><span> #undef ENABLE_SYSTEMD</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+/* avoid redefining ENABLE_SYSTEMD in misc.c */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#undef HAVE_CONFIG_H</s=
pan><br><span> </span><br><span> #include &quot;syshead.h&quot;</span><br><=
span> #include &quot;manage.h&quot;</span><br><span></span><br></pre><p>To =
view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/641?usp=3Demai=
l">change 641</a>. To unsubscribe, or for help writing mail filters, visit =
<a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemsc=
ope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"=
action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/641?usp=3Demail"/><meta itempro=
p=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic33c210f06e173a450534aa0969=
c57f140086655 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 641 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--CPGoVoEclmo=--

