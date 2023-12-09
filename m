From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 9 Dec 2023 10:05:27 +0000
In-Reply-To: <gerrit.1701876289000.I5e394bb73702d87562ed354100eaff9b41f5389e@...2715...>
References: <gerrit.1701876289000.I5e394bb73702d87562ed354100eaff9b41f5389e@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <c947b0e4aa9229b9df6c39eeaea6a9688f86edd2-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="k5c2e11DzQM="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: unit_tests: remove
 includes for mock_msg.h
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

--k5c2e11DzQM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/467?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by plaisthos


Change subject: unit_tests: remove includes for mock_msg.h
......................................................................

unit_tests: remove includes for mock_msg.h

Not actually used.

Change-Id: I5e394bb73702d87562ed354100eaff9b41f5389e
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Message-Id: <20231208173529.95023-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27=
727.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M tests/unit_tests/openvpn/test_auth_token.c
M tests/unit_tests/openvpn/test_crypto.c
M tests/unit_tests/openvpn/test_packet_id.c
M tests/unit_tests/openvpn/test_pkt.c
M tests/unit_tests/openvpn/test_tls_crypt.c
5 files changed, 0 insertions(+), 8 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/67/467/2

diff --git a/tests/unit_tests/openvpn/test_auth_token.c b/tests/unit_tests/=
openvpn/test_auth_token.c
index d96984f..a027330 100644
--- a/tests/unit_tests/openvpn/test_auth_token.c
+++ b/tests/unit_tests/openvpn/test_auth_token.c
@@ -36,8 +36,6 @@

 #include "auth_token.c"

-#include "mock_msg.h"
-
 struct test_context {
     struct tls_multi multi;
     struct key_type kt;
diff --git a/tests/unit_tests/openvpn/test_crypto.c b/tests/unit_tests/open=
vpn/test_crypto.c
index 5564524..9e5469a 100644
--- a/tests/unit_tests/openvpn/test_crypto.c
+++ b/tests/unit_tests/openvpn/test_crypto.c
@@ -38,7 +38,6 @@
 #include "options.h"
 #include "ssl_backend.h"

-#include "mock_msg.h"
 #include "mss.h"

 static const char testtext[] =3D "Dummy text to test PEM encoding";
diff --git a/tests/unit_tests/openvpn/test_packet_id.c b/tests/unit_tests/o=
penvpn/test_packet_id.c
index 90c67ac..2a2a973 100644
--- a/tests/unit_tests/openvpn/test_packet_id.c
+++ b/tests/unit_tests/openvpn/test_packet_id.c
@@ -36,8 +36,6 @@
 #include "packet_id.h"
 #include "reliable.h"

-#include "mock_msg.h"
-
 struct test_packet_id_write_data {
     struct {
         uint32_t buf_id;
diff --git a/tests/unit_tests/openvpn/test_pkt.c b/tests/unit_tests/openvpn=
/test_pkt.c
index 9f49ee7..7f05184 100644
--- a/tests/unit_tests/openvpn/test_pkt.c
+++ b/tests/unit_tests/openvpn/test_pkt.c
@@ -40,7 +40,6 @@
 #include "ssl_pkt.h"
 #include "tls_crypt.h"

-#include "mock_msg.h"
 #include "mss.h"
 #include "reliable.h"

diff --git a/tests/unit_tests/openvpn/test_tls_crypt.c b/tests/unit_tests/o=
penvpn/test_tls_crypt.c
index ed7c794..465543a 100644
--- a/tests/unit_tests/openvpn/test_tls_crypt.c
+++ b/tests/unit_tests/openvpn/test_tls_crypt.c
@@ -36,8 +36,6 @@

 #include "tls_crypt.c"

-#include "mock_msg.h"
-
 /* Define this function here as dummy since including the ssl_*.c files
  * leads to having to include even more unrelated code */
 bool

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/467?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I5e394bb73702d87562ed354100eaff9b41f5389e
Gerrit-Change-Number: 467
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--k5c2e11DzQM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/467?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by plaisthos</p><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">unit_tests: remove includes for mock_msg.h<br><b=
r>Not actually used.<br><br>Change-Id: I5e394bb73702d87562ed354100eaff9b41f=
5389e<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked=
-by: Arne Schwabe &lt;arne-openvpn@...1227...&gt;<br>Message-Id: &lt;202312=
08173529.95023-1-frank@...2641...&gt;<br>URL: https://www.mail-archive.com/=
openvpn-devel@lists.sourceforge.net/msg27727.html<br>Signed-off-by: Gert Do=
ering &lt;gert@...1296...&gt;<br>---<br>M tests/unit_tests/openvpn/test_aut=
h_token.c<br>M tests/unit_tests/openvpn/test_crypto.c<br>M tests/unit_tests=
/openvpn/test_packet_id.c<br>M tests/unit_tests/openvpn/test_pkt.c<br>M tes=
ts/unit_tests/openvpn/test_tls_crypt.c<br>5 files changed, 0 insertions(+),=
 8 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn r=
efs/changes/67/467/2</pre><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;"><span>diff --git a/tests/unit_tests/openvpn/test_aut=
h_token.c b/tests/unit_tests/openvpn/test_auth_token.c</span><br><span>inde=
x d96984f..a027330 100644</span><br><span>--- a/tests/unit_tests/openvpn/te=
st_auth_token.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_auth_to=
ken.c</span><br><span>@@ -36,8 +36,6 @@</span><br><span> </span><br><span> =
#include &quot;auth_token.c&quot;</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#include &quot;mock_msg.h&quot;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> struct test_con=
text {</span><br><span>     struct tls_multi multi;</span><br><span>     st=
ruct key_type kt;</span><br><span>diff --git a/tests/unit_tests/openvpn/tes=
t_crypto.c b/tests/unit_tests/openvpn/test_crypto.c</span><br><span>index 5=
564524..9e5469a 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_=
crypto.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_crypto.c</span=
><br><span>@@ -38,7 +38,6 @@</span><br><span> #include &quot;options.h&quot=
;</span><br><span> #include &quot;ssl_backend.h&quot;</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &quot;mock_msg.h=
&quot;</span><br><span> #include &quot;mss.h&quot;</span><br><span> </span>=
<br><span> static const char testtext[] =3D &quot;Dummy text to test PEM en=
coding&quot;;</span><br><span>diff --git a/tests/unit_tests/openvpn/test_pa=
cket_id.c b/tests/unit_tests/openvpn/test_packet_id.c</span><br><span>index=
 90c67ac..2a2a973 100644</span><br><span>--- a/tests/unit_tests/openvpn/tes=
t_packet_id.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_packet_id=
.c</span><br><span>@@ -36,8 +36,6 @@</span><br><span> #include &quot;packet=
_id.h&quot;</span><br><span> #include &quot;reliable.h&quot;</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &quot;moc=
k_msg.h&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span> struct test_packet_id_write_data {</span><br><span>     struct {<=
/span><br><span>         uint32_t buf_id;</span><br><span>diff --git a/test=
s/unit_tests/openvpn/test_pkt.c b/tests/unit_tests/openvpn/test_pkt.c</span=
><br><span>index 9f49ee7..7f05184 100644</span><br><span>--- a/tests/unit_t=
ests/openvpn/test_pkt.c</span><br><span>+++ b/tests/unit_tests/openvpn/test=
_pkt.c</span><br><span>@@ -40,7 +40,6 @@</span><br><span> #include &quot;ss=
l_pkt.h&quot;</span><br><span> #include &quot;tls_crypt.h&quot;</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &quot;=
mock_msg.h&quot;</span><br><span> #include &quot;mss.h&quot;</span><br><spa=
n> #include &quot;reliable.h&quot;</span><br><span> </span><br><span>diff -=
-git a/tests/unit_tests/openvpn/test_tls_crypt.c b/tests/unit_tests/openvpn=
/test_tls_crypt.c</span><br><span>index ed7c794..465543a 100644</span><br><=
span>--- a/tests/unit_tests/openvpn/test_tls_crypt.c</span><br><span>+++ b/=
tests/unit_tests/openvpn/test_tls_crypt.c</span><br><span>@@ -36,8 +36,6 @@=
</span><br><span> </span><br><span> #include &quot;tls_crypt.c&quot;</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &=
quot;mock_msg.h&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span> /* Define this function here as dummy since including the=
 ssl_*.c files</span><br><span>  * leads to having to include even more unr=
elated code */</span><br><span> bool</span><br><span></span><br></pre><p>To=
 view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/467?usp=3Dema=
il">change 467</a>. To unsubscribe, or for help writing mail filters, visit=
 <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div items=
cope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D=
"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/467?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I5e394bb73702d87562ed354100e=
aff9b41f5389e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 467 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--k5c2e11DzQM=--

