From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Thu, 31 Jul 2025 11:17:33 +0000
References: <gerrit.1753960651000.I41c5dfc7489352a9534ff6b1585a5a81e0623ab1@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <78179ad118e0a33fd5dd46e1293c076aad5a65b6-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="LRPjGAzCLSg="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[release/2.6]: dco linux:
 avoid redefining ovpn enums (2.6)
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

--LRPjGAzCLSg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1122?usp=3Demail

to review the following change.


Change subject: dco linux: avoid redefining ovpn enums (2.6)
......................................................................

dco linux: avoid redefining ovpn enums (2.6)

Starting with Linux kernel version 6.16, a couple of ovpn-related enum
definitions were introduced in the `include/uapi/linux/if_link.h`
header. Redefining them in openvpn when they are already present in the
system headers can lead to conflicts or build issues.

This commit ensures that enum redefinitions are avoided by conditionally
using the existing definitions from the system header when available.

This is the port to release/2.6 based on commit
1d3c2b67a73a0aa011c13e62f876d24e49d41df0.

Change-Id: I41c5dfc7489352a9534ff6b1585a5a81e0623ab1
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/dco_linux.h
M src/openvpn/ovpn_dco_linux.h
2 files changed, 9 insertions(+), 4 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/22/1122/1

diff --git a/src/openvpn/dco_linux.h b/src/openvpn/dco_linux.h
index 511519a..62435d1 100644
--- a/src/openvpn/dco_linux.h
+++ b/src/openvpn/dco_linux.h
@@ -26,11 +26,11 @@

 #include "event.h"
=20
-#include "ovpn_dco_linux.h"
-
 #include <netlink/socket.h>
 #include <netlink/netlink.h>

+#include "ovpn_dco_linux.h"
+
 typedef enum ovpn_key_slot dco_key_slot_t;
 typedef enum ovpn_cipher_alg dco_cipher_t;

diff --git a/src/openvpn/ovpn_dco_linux.h b/src/openvpn/ovpn_dco_linux.h
index 73e19b5..34abc6a 100644
--- a/src/openvpn/ovpn_dco_linux.h
+++ b/src/openvpn/ovpn_dco_linux.h
@@ -237,14 +237,17 @@
 	OVPN_PACKET_ATTR_MAX =3D __OVPN_PACKET_ATTR_AFTER_LAST - 1,
 };

+#ifndef IFLA_OVPN_MAX
+
 enum ovpn_ifla_attrs {
 	IFLA_OVPN_UNSPEC =3D 0,
 	IFLA_OVPN_MODE,

-	__IFLA_OVPN_AFTER_LAST,
-	IFLA_OVPN_MAX =3D __IFLA_OVPN_AFTER_LAST - 1,
+	__IFLA_OVPN_MAX,
 };

+#define IFLA_OVPN_MAX (__IFLA_OVPN_MAX - 1)
+
 enum ovpn_mode {
 	__OVPN_MODE_FIRST =3D 0,
 	OVPN_MODE_P2P =3D __OVPN_MODE_FIRST,
@@ -253,4 +256,6 @@
 	__OVPN_MODE_AFTER_LAST,
 };

+#endif /* ifndef IFLA_OVPN_MAX */
+
 #endif /* _UAPI_LINUX_OVPN_DCO_H_ */

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1122?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: I41c5dfc7489352a9534ff6b1585a5a81e0623ab1
Gerrit-Change-Number: 1122
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--LRPjGAzCLSg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1122?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">dco linux: avoid redefining ovpn enums (2.6)<br><br>Starting=
 with Linux kernel version 6.16, a couple of ovpn-related enum<br>definitio=
ns were introduced in the `include/uapi/linux/if_link.h`<br>header. Redefin=
ing them in openvpn when they are already present in the<br>system headers =
can lead to conflicts or build issues.<br><br>This commit ensures that enum=
 redefinitions are avoided by conditionally<br>using the existing definitio=
ns from the system header when available.<br><br>This is the port to releas=
e/2.6 based on commit<br>1d3c2b67a73a0aa011c13e62f876d24e49d41df0.<br><br>C=
hange-Id: I41c5dfc7489352a9534ff6b1585a5a81e0623ab1<br>Signed-off-by: Frank=
 Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M src/openvpn/dco_linux.h<b=
r>M src/openvpn/ovpn_dco_linux.h<br>2 files changed, 9 insertions(+), 4 del=
etions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/ch=
anges/22/1122/1</pre><pre style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;"><span>diff --git a/src/openvpn/dco_linux.h b/src/openvpn/=
dco_linux.h</span><br><span>index 511519a..62435d1 100644</span><br><span>-=
-- a/src/openvpn/dco_linux.h</span><br><span>+++ b/src/openvpn/dco_linux.h<=
/span><br><span>@@ -26,11 +26,11 @@</span><br><span> </span><br><span> #inc=
lude &quot;event.h&quot;</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#include &quot;ovpn_dco_linux.h&quot;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #include &lt;netlink=
/socket.h&gt;</span><br><span> #include &lt;netlink/netlink.h&gt;</span><br=
><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &q=
uot;ovpn_dco_linux.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span> typedef enum ovpn_key_slot dco_key_slot_t;</span><=
br><span> typedef enum ovpn_cipher_alg dco_cipher_t;</span><br><span> </spa=
n><br><span>diff --git a/src/openvpn/ovpn_dco_linux.h b/src/openvpn/ovpn_dc=
o_linux.h</span><br><span>index 73e19b5..34abc6a 100644</span><br><span>---=
 a/src/openvpn/ovpn_dco_linux.h</span><br><span>+++ b/src/openvpn/ovpn_dco_=
linux.h</span><br><span>@@ -237,14 +237,17 @@</span><br><span> 	OVPN_PACKET=
_ATTR_MAX =3D __OVPN_PACKET_ATTR_AFTER_LAST - 1,</span><br><span> };</span>=
<br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef =
IFLA_OVPN_MAX</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span> enum ovpn_ifla_attrs {</span><br><span> 	IFLA_OVPN_UNSPEC =3D 0=
,</span><br><span> 	IFLA_OVPN_MODE,</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	__IFLA_OVPN_AFTER_LAST,</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-	IFLA_OVPN_MAX =3D __IFLA_OVPN_AFTER_LAS=
T - 1,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	__IFLA_OVPN_=
MAX,</span><br><span> };</span><br><span> </span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#define IFLA_OVPN_MAX (__IFLA_OVPN_MAX - 1)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> enum ovpn_=
mode {</span><br><span> 	__OVPN_MODE_FIRST =3D 0,</span><br><span> 	OVPN_MO=
DE_P2P =3D __OVPN_MODE_FIRST,</span><br><span>@@ -253,4 +256,6 @@</span><br=
><span> 	__OVPN_MODE_AFTER_LAST,</span><br><span> };</span><br><span> </spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* ifndef IFLA_OV=
PN_MAX */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span> #endif /* _UAPI_LINUX_OVPN_DCO_H_ */</span><br><span></span><br></p=
re><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1122?=
usp=3Demail">change 1122</a>. To unsubscribe, or for help writing mail filt=
ers, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p>=
<div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1122?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I41c5dfc7489352a9534ff6b1585=
a5a81e0623ab1 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1122 </div>
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


--LRPjGAzCLSg=--

