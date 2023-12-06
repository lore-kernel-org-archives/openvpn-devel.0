From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 6 Dec 2023 15:24:53 +0000
References: <gerrit.1701876289000.I5e394bb73702d87562ed354100eaff9b41f5389e@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <b4dee14d011828b15d8b539388ce97a1a6f5f3fb-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="kbOF9OOt8QI="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--kbOF9OOt8QI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/467?usp=3Demail

to review the following change.


Change subject: unit_tests: remove includes for mock_msg.h
......................................................................

unit_tests: remove includes for mock_msg.h

Not actually used.

Change-Id: I5e394bb73702d87562ed354100eaff9b41f5389e
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M tests/unit_tests/openvpn/test_auth_token.c
M tests/unit_tests/openvpn/test_crypto.c
M tests/unit_tests/openvpn/test_packet_id.c
M tests/unit_tests/openvpn/test_pkt.c
M tests/unit_tests/openvpn/test_tls_crypt.c
5 files changed, 0 insertions(+), 8 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/67/467/1

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
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--kbOF9OOt8QI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/467?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">unit_tests: remove includes for mock_msg.h<br><br>Not actuall=
y used.<br><br>Change-Id: I5e394bb73702d87562ed354100eaff9b41f5389e<br>Sign=
ed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M tests/uni=
t_tests/openvpn/test_auth_token.c<br>M tests/unit_tests/openvpn/test_crypto=
.c<br>M tests/unit_tests/openvpn/test_packet_id.c<br>M tests/unit_tests/ope=
nvpn/test_pkt.c<br>M tests/unit_tests/openvpn/test_tls_crypt.c<br>5 files c=
hanged, 0 insertions(+), 8 deletions(-)<br><br></pre><pre style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.ope=
nvpn.net:29418/openvpn refs/changes/67/467/1</pre><pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/tests/uni=
t_tests/openvpn/test_auth_token.c b/tests/unit_tests/openvpn/test_auth_toke=
n.c</span><br><span>index d96984f..a027330 100644</span><br><span>--- a/tes=
ts/unit_tests/openvpn/test_auth_token.c</span><br><span>+++ b/tests/unit_te=
sts/openvpn/test_auth_token.c</span><br><span>@@ -36,8 +36,6 @@</span><br><=
span> </span><br><span> #include &quot;auth_token.c&quot;</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &quot;mock_m=
sg.h&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span> struct test_context {</span><br><span>     struct tls_multi multi;</=
span><br><span>     struct key_type kt;</span><br><span>diff --git a/tests/=
unit_tests/openvpn/test_crypto.c b/tests/unit_tests/openvpn/test_crypto.c</=
span><br><span>index 5564524..9e5469a 100644</span><br><span>--- a/tests/un=
it_tests/openvpn/test_crypto.c</span><br><span>+++ b/tests/unit_tests/openv=
pn/test_crypto.c</span><br><span>@@ -38,7 +38,6 @@</span><br><span> #includ=
e &quot;options.h&quot;</span><br><span> #include &quot;ssl_backend.h&quot;=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#in=
clude &quot;mock_msg.h&quot;</span><br><span> #include &quot;mss.h&quot;</s=
pan><br><span> </span><br><span> static const char testtext[] =3D &quot;Dum=
my text to test PEM encoding&quot;;</span><br><span>diff --git a/tests/unit=
_tests/openvpn/test_packet_id.c b/tests/unit_tests/openvpn/test_packet_id.c=
</span><br><span>index 90c67ac..2a2a973 100644</span><br><span>--- a/tests/=
unit_tests/openvpn/test_packet_id.c</span><br><span>+++ b/tests/unit_tests/=
openvpn/test_packet_id.c</span><br><span>@@ -36,8 +36,6 @@</span><br><span>=
 #include &quot;packet_id.h&quot;</span><br><span> #include &quot;reliable.=
h&quot;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#include &quot;mock_msg.h&quot;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span> struct test_packet_id_write_data {</span><b=
r><span>     struct {</span><br><span>         uint32_t buf_id;</span><br><=
span>diff --git a/tests/unit_tests/openvpn/test_pkt.c b/tests/unit_tests/op=
envpn/test_pkt.c</span><br><span>index 9f49ee7..7f05184 100644</span><br><s=
pan>--- a/tests/unit_tests/openvpn/test_pkt.c</span><br><span>+++ b/tests/u=
nit_tests/openvpn/test_pkt.c</span><br><span>@@ -40,7 +40,6 @@</span><br><s=
pan> #include &quot;ssl_pkt.h&quot;</span><br><span> #include &quot;tls_cry=
pt.h&quot;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#include &quot;mock_msg.h&quot;</span><br><span> #include &quot;mss.=
h&quot;</span><br><span> #include &quot;reliable.h&quot;</span><br><span> <=
/span><br><span>diff --git a/tests/unit_tests/openvpn/test_tls_crypt.c b/te=
sts/unit_tests/openvpn/test_tls_crypt.c</span><br><span>index ed7c794..4655=
43a 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_tls_crypt.c<=
/span><br><span>+++ b/tests/unit_tests/openvpn/test_tls_crypt.c</span><br><=
span>@@ -36,8 +36,6 @@</span><br><span> </span><br><span> #include &quot;tl=
s_crypt.c&quot;</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#include &quot;mock_msg.h&quot;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span> /* Define this function here as dum=
my since including the ssl_*.c files</span><br><span>  * leads to having to=
 include even more unrelated code */</span><br><span> bool</span><br><span>=
</span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/467?usp=3Demail">change 467</a>. To unsubscribe, or for help writi=
ng mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">setti=
ngs</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div=
 itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><l=
ink itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/467?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I5e394bb73702d87562ed354100e=
aff9b41f5389e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 467 </div>
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


--kbOF9OOt8QI=--

