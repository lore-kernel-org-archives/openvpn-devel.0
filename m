From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 24 Mar 2025 13:18:29 +0000
References: <gerrit.1742822307000.Ib579c1538eb5440bb7008bc866a5cb7d74844374@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <2f05c6780e43d1255945871f43ecea6ef299351f-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="D4jOVxh14bc="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Directly use
 _countof in array initialisation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--D4jOVxh14bc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/915?usp=3Demail

to review the following change.


Change subject: Directly use _countof in array initialisation
......................................................................

Directly use _countof in array initialisation

This fixes the build failures on MSVC cl compiler.

MSVC cl does not thinks of the expression of a const variable times
an integer to be compile time static. C23 introduce the constexpr
(like in C++) statement for that but we are only on C11 for now.

So directly use the _countof(msg->addr) expression in the array
initialisation.

Change-Id: Ib579c1538eb5440bb7008bc866a5cb7d74844374
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpnserv/interactive.c
1 file changed, 4 insertions(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/15/915/1

diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index e64ac30..abc2cda 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -34,6 +34,7 @@
 #include <shellapi.h>
 #include <mstcpip.h>
 #include <inttypes.h>
+#include <assert.h>

 #include <versionhelpers.h>

@@ -1901,7 +1902,9 @@
     if (msg->addr_len > 0)
     {
         /* prepare the comma separated address list */
-        CHAR addrs[max_addrs * 64]; /* 64 is enough for one IPv4/6 address=
 */
+        /* cannot use max_addrs here as that is not considered compile
+         * time constant by all compilers and constexpr is C23 */
+        CHAR addrs[_countof(msg->addr) * 64]; /* 64 is enough for one IPv4=
/6 address */
         size_t offset =3D 0;
         for (int i =3D 0; i < addr_len; ++i)
         {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/915?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib579c1538eb5440bb7008bc866a5cb7d74844374
Gerrit-Change-Number: 915
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--D4jOVxh14bc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/915?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Directly use _countof in array initialisation<br><br>This fix=
es the build failures on MSVC cl compiler.<br><br>MSVC cl does not thinks o=
f the expression of a const variable times<br>an integer to be compile time=
 static. C23 introduce the constexpr<br>(like in C++) statement for that bu=
t we are only on C11 for now.<br><br>So directly use the _countof(msg-&gt;a=
ddr) expression in the array<br>initialisation.<br><br>Change-Id: Ib579c153=
8eb5440bb7008bc866a5cb7d74844374<br>Signed-off-by: Arne Schwabe &lt;arne@...1186...=
.1227...&gt;<br>---<br>M src/openvpnserv/interactive.c<br>1 file changed, 4=
 insertions(+), 1 deletion(-)<br><br></pre><pre style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:2=
9418/openvpn refs/changes/15/915/1</pre><pre style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpnserv/int=
eractive.c b/src/openvpnserv/interactive.c</span><br><span>index e64ac30..a=
bc2cda 100644</span><br><span>--- a/src/openvpnserv/interactive.c</span><br=
><span>+++ b/src/openvpnserv/interactive.c</span><br><span>@@ -34,6 +34,7 @=
@</span><br><span> #include &lt;shellapi.h&gt;</span><br><span> #include &l=
t;mstcpip.h&gt;</span><br><span> #include &lt;inttypes.h&gt;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#include &lt;assert.h&gt;</span><b=
r><span> </span><br><span> #include &lt;versionhelpers.h&gt;</span><br><spa=
n> </span><br><span>@@ -1901,7 +1902,9 @@</span><br><span>     if (msg-&gt;=
addr_len &gt; 0)</span><br><span>     {</span><br><span>         /* prepare=
 the comma separated address list */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        CHAR addrs[max_addrs * 64]; /* 64 is enough for one =
IPv4/6 address */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      /* cannot use max_addrs here as that is not considered compile</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+         * time constant b=
y all compilers and constexpr is C23 */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        CHAR addrs[_countof(msg-&gt;addr) * 64]; /* 64 =
is enough for one IPv4/6 address */</span><br><span>         size_t offset =
=3D 0;</span><br><span>         for (int i =3D 0; i &lt; addr_len; ++i)</sp=
an><br><span>         {</span><br><span></span><br></pre><p>To view, visit =
<a href=3D"http://gerrit.openvpn.net/c/openvpn/+/915?usp=3Demail">change 91=
5</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"h=
ttp://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/915?usp=3Demail"/><meta itemprop=3D"name" c=
ontent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib579c1538eb5440bb7008bc866a=
5cb7d74844374 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 915 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--D4jOVxh14bc=--

