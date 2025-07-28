From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 28 Jul 2025 10:07:59 +0000
References: <gerrit.1753697277000.I2ab13767b5aa858e024b45be3d161bf6090de763@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <03e1861be3be01fbf35d7513e8226fc8a13b7566-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="BQAR7gIenyc="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]:
 unit_tests/plugins/auth-pam: fix stdint.h related build error on fedo...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--BQAR7gIenyc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1118?usp=3Demail

to review the following change.


Change subject: unit_tests/plugins/auth-pam: fix stdint.h related build err=
or on fedora 42
......................................................................

unit_tests/plugins/auth-pam: fix stdint.h related build error on fedora 42

add <stdint.h> to test_search_and_replace.c to fix build error on
fedora 42 / arm64 ("error: uintptr_t undeclared")

Change-Id: I2ab13767b5aa858e024b45be3d161bf6090de763
Signed-off-by: Gert Doering <gert@...1296...>
---
M tests/unit_tests/plugins/auth-pam/test_search_and_replace.c
1 file changed, 1 insertion(+), 0 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/18/1118/1

diff --git a/tests/unit_tests/plugins/auth-pam/test_search_and_replace.c b/=
tests/unit_tests/plugins/auth-pam/test_search_and_replace.c
index d40467f..50b241d 100644
--- a/tests/unit_tests/plugins/auth-pam/test_search_and_replace.c
+++ b/tests/unit_tests/plugins/auth-pam/test_search_and_replace.c
@@ -2,6 +2,7 @@
 #include <unistd.h>
 #include <stdlib.h>
 #include <stdarg.h>
+#include <stdint.h>
 #include <string.h>
 #include <setjmp.h>
 #include <cmocka.h>

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1118?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I2ab13767b5aa858e024b45be3d161bf6090de763
Gerrit-Change-Number: 1118
Gerrit-PatchSet: 1
Gerrit-Owner: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--BQAR7gIenyc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>cron2 would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1118?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">unit_tests/plugins/auth-pam: fix stdint.h related build erro=
r on fedora 42<br><br>add &lt;stdint.h&gt; to test_search_and_replace.c to =
fix build error on<br>fedora 42 / arm64 (&quot;error: uintptr_t undeclared&=
quot;)<br><br>Change-Id: I2ab13767b5aa858e024b45be3d161bf6090de763<br>Signe=
d-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M tests/unit_tests=
/plugins/auth-pam/test_search_and_replace.c<br>1 file changed, 1 insertion(=
+), 0 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvp=
n refs/changes/18/1118/1</pre><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;"><span>diff --git a/tests/unit_tests/plugins/auth=
-pam/test_search_and_replace.c b/tests/unit_tests/plugins/auth-pam/test_sea=
rch_and_replace.c</span><br><span>index d40467f..50b241d 100644</span><br><=
span>--- a/tests/unit_tests/plugins/auth-pam/test_search_and_replace.c</spa=
n><br><span>+++ b/tests/unit_tests/plugins/auth-pam/test_search_and_replace=
.c</span><br><span>@@ -2,6 +2,7 @@</span><br><span> #include &lt;unistd.h&g=
t;</span><br><span> #include &lt;stdlib.h&gt;</span><br><span> #include &lt=
;stdarg.h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inclu=
de &lt;stdint.h&gt;</span><br><span> #include &lt;string.h&gt;</span><br><s=
pan> #include &lt;setjmp.h&gt;</span><br><span> #include &lt;cmocka.h&gt;</=
span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/1118?usp=3Demail">change 1118</a>. To unsubscribe, =
or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.ne=
t/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/E=
mailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.o=
rg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1118?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"=
/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2ab13767b5aa858e024b45be3d1=
61bf6090de763 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1118 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@...1296...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--BQAR7gIenyc=--

