From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Thu, 6 Jun 2024 11:33:32 +0000
In-Reply-To: <gerrit.1717505869000.Ic33c210f06e173a450534aa0969c57f140086655@...2715...>
References: <gerrit.1717505869000.Ic33c210f06e173a450534aa0969c57f140086655@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296...
Message-ID: <ee50bb52ce21422f2c9ada4eb91ccb4243c7dfbf-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="XOfDmrzpWDs="; charset=UTF-8
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
To: cron2 <gert@...1296...>, flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--XOfDmrzpWDs=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, its_Giaan, plaisthos.

its_Giaan has uploaded a new patch set (#2) to the change originally create=
d by flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/641?usp=3Demail )


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
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: its_Giaan <gianmarco@...2726...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-MessageType: newpatchset

--XOfDmrzpWDs=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, its_Giaan, plaisthos. </p>
<p>its_Giaan <strong>uploaded patch set #2</strong> to the change originall=
y created by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/641?usp=3Demail">View Change</a></p><pre style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">test_user_pass: Fix building with -=
-enable-systemd<br><br>Need to make sure that ENABLE_SYSTEMD is really disa=
bled.<br><br>Change-Id: Ic33c210f06e173a450534aa0969c57f140086655<br>Signed=
-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doeri=
ng &lt;gert@...1296...&gt;<br>Message-Id: &lt;20240605111012.3023-1-gert@...1186...=
.1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1011...=
eforge.net/msg28708.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...=
&gt;<br>---<br>M tests/unit_tests/openvpn/test_user_pass.c<br>1 file change=
d, 2 insertions(+), 0 deletions(-)<br><br></pre><pre style=3D"font-family: =
monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.=
net:29418/openvpn refs/changes/41/641/2</pre><pre style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;"><span>diff --git a/tests/unit_tes=
ts/openvpn/test_user_pass.c b/tests/unit_tests/openvpn/test_user_pass.c</sp=
an><br><span>index ac84654..b43e655 100644</span><br><span>--- a/tests/unit=
_tests/openvpn/test_user_pass.c</span><br><span>+++ b/tests/unit_tests/open=
vpn/test_user_pass.c</span><br><span>@@ -27,6 +27,8 @@</span><br><span> #en=
dif</span><br><span> </span><br><span> #undef ENABLE_SYSTEMD</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+/* avoid redefining ENABLE_SYSTEMD=
 in misc.c */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#undef=
 HAVE_CONFIG_H</span><br><span> </span><br><span> #include &quot;syshead.h&=
quot;</span><br><span> #include &quot;manage.h&quot;</span><br><span></span=
><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/641?usp=3Demail">change 641</a>. To unsubscribe, or for help writing mai=
l filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a=
>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div items=
cope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link it=
emprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/641?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: its_Giaan &lt;gianmarco@...1665...=
726...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--XOfDmrzpWDs=--

