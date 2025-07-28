From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 28 Jul 2025 11:00:29 +0000
In-Reply-To: <gerrit.1753697277000.I2ab13767b5aa858e024b45be3d161bf6090de763@...2715...>
References: <gerrit.1753697277000.I2ab13767b5aa858e024b45be3d161bf6090de763@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <70fe840d9592316fe2b0b30fc958fbf74b51eee8-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="TU411XurdDE="; charset=UTF-8
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

--TU411XurdDE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1118?usp=3Demail

to look at the new patch set (#2).

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld


Change subject: unit_tests/plugins/auth-pam: fix stdint.h related build err=
or on fedora 42
......................................................................

unit_tests/plugins/auth-pam: fix stdint.h related build error on fedora 42

add <stdint.h> to test_search_and_replace.c to fix build error on
fedora 42 / arm64 ("error: uintptr_t undeclared")

Change-Id: I2ab13767b5aa858e024b45be3d161bf6090de763
Signed-off-by: Gert Doering <gert@...1296...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20250728104234.29797-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32=
384.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M tests/unit_tests/plugins/auth-pam/test_search_and_replace.c
1 file changed, 1 insertion(+), 0 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/18/1118/2

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
Gerrit-PatchSet: 2
Gerrit-Owner: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--TU411XurdDE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1118?usp=3Demail">View Change</=
a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">unit_tests/plugins/auth-pam: fix stdint.h rel=
ated build error on fedora 42<br><br>add &lt;stdint.h&gt; to test_search_an=
d_replace.c to fix build error on<br>fedora 42 / arm64 (&quot;error: uintpt=
r_t undeclared&quot;)<br><br>Change-Id: I2ab13767b5aa858e024b45be3d161bf609=
0de763<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>Acked-by: =
Frank Lichtenheld &lt;frank@...2641...&gt;<br>Message-Id: &lt;2025072810423=
4.29797-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-=
devel@lists.sourceforge.net/msg32384.html<br>Signed-off-by: Gert Doering &l=
t;gert@...1296...&gt;<br>---<br>M tests/unit_tests/plugins/auth-pam/test_se=
arch_and_replace.c<br>1 file changed, 1 insertion(+), 0 deletions(-)<br><br=
></pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/18/1118/2<=
/pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
"><span>diff --git a/tests/unit_tests/plugins/auth-pam/test_search_and_repl=
ace.c b/tests/unit_tests/plugins/auth-pam/test_search_and_replace.c</span><=
br><span>index d40467f..50b241d 100644</span><br><span>--- a/tests/unit_tes=
ts/plugins/auth-pam/test_search_and_replace.c</span><br><span>+++ b/tests/u=
nit_tests/plugins/auth-pam/test_search_and_replace.c</span><br><span>@@ -2,=
6 +2,7 @@</span><br><span> #include &lt;unistd.h&gt;</span><br><span> #incl=
ude &lt;stdlib.h&gt;</span><br><span> #include &lt;stdarg.h&gt;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdint.h&gt;</span=
><br><span> #include &lt;string.h&gt;</span><br><span> #include &lt;setjmp.=
h&gt;</span><br><span> #include &lt;cmocka.h&gt;</span><br><span></span><br=
></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1=
118?usp=3Demail">change 1118</a>. To unsubscribe, or for help writing mail =
filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.=
</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemsco=
pe itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link item=
prop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1118?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2ab13767b5aa858e024b45be3d1=
61bf6090de763 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1118 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@...1296...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--TU411XurdDE=--

