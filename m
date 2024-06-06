From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 6 Jun 2024 11:33:46 +0000
In-Reply-To: <gerrit.1717505869000.Ic33c210f06e173a450534aa0969c57f140086655@...2715...>
References: <gerrit.1717505869000.Ic33c210f06e173a450534aa0969c57f140086655@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 gianmarco@...2726..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <7f51b314389928632705220fe6debbea955a3902-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="OYironQVT5s="; charset=UTF-8
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
To: its_Giaan <gianmarco@...2726...>, flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--OYironQVT5s=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/64=
1?usp=3Demail )

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
Gerrit-MessageType: merged

--OYironQVT5s=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/641?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">test_user_pass: Fix building with --enable-sys=
temd<br><br>Need to make sure that ENABLE_SYSTEMD is really disabled.<br><b=
r>Change-Id: Ic33c210f06e173a450534aa0969c57f140086655<br>Signed-off-by: Fr=
ank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doering &lt;gert=
@...1296...&gt;<br>Message-Id: &lt;20240605111012.3023-1-gert@...1296...&gt=
;<br>URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/=
msg28708.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---=
<br>M tests/unit_tests/openvpn/test_user_pass.c<br>1 file changed, 2 insert=
ions(+), 0 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/tests/unit_tests/openvpn/test_user_pass.c b/tests/unit_test=
s/openvpn/test_user_pass.c</span><br><span>index ac84654..b43e655 100644</s=
pan><br><span>--- a/tests/unit_tests/openvpn/test_user_pass.c</span><br><sp=
an>+++ b/tests/unit_tests/openvpn/test_user_pass.c</span><br><span>@@ -27,6=
 +27,8 @@</span><br><span> #endif</span><br><span> </span><br><span> #undef=
 ENABLE_SYSTEMD</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* a=
void redefining ENABLE_SYSTEMD in misc.c */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#undef HAVE_CONFIG_H</span><br><span> </span><br><s=
pan> #include &quot;syshead.h&quot;</span><br><span> #include &quot;manage.=
h&quot;</span><br><span></span><br></pre><p>To view, visit <a href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/641?usp=3Demail">change 641</a>. To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit.ope=
nvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schem=
a.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://s=
chema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/641?usp=3Demail"/><meta itemprop=3D"name" content=3D"View C=
hange"/></div></div>

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
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--OYironQVT5s=--

