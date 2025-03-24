From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 24 Mar 2025 13:54:00 +0000
In-Reply-To: <gerrit.1742822307000.Ib579c1538eb5440bb7008bc866a5cb7d74844374@...2715...>
References: <gerrit.1742822307000.Ib579c1538eb5440bb7008bc866a5cb7d74844374@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <5f5258e8299bea649821ef416f173d2e7d46a6d7-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="AGgpSYN1TJk="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--AGgpSYN1TJk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#3) to the change originally created by=
 plaisthos. ( http://gerrit.openvpn.net/c/openvpn/+/915?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld


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
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20250324133759.13155-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31=
205.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpnserv/interactive.c
1 file changed, 3 insertions(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/15/915/3

diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index e64ac30..c6963b3 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -1901,7 +1901,9 @@
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
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--AGgpSYN1TJk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #3</strong> to the change originally cr=
eated by plaisthos.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
915?usp=3Demail">View Change</a></p><p>The following approvals got outdated=
 and were removed:
Code-Review+2 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Directly use _countof in array initialisation=
<br><br>This fixes the build failures on MSVC cl compiler.<br><br>MSVC cl d=
oes not thinks of the expression of a const variable times<br>an integer to=
 be compile time static. C23 introduce the constexpr<br>(like in C++) state=
ment for that but we are only on C11 for now.<br><br>So directly use the _c=
ountof(msg-&gt;addr) expression in the array<br>initialisation.<br><br>Chan=
ge-Id: Ib579c1538eb5440bb7008bc866a5cb7d74844374<br>Signed-off-by: Arne Sch=
wabe &lt;arne@...1227...&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@...2375...=
41...&gt;<br>Message-Id: &lt;20250324133759.13155-1-gert@...1296...&gt;<br>=
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31=
205.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M=
 src/openvpnserv/interactive.c<br>1 file changed, 3 insertions(+), 1 deleti=
on(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/change=
s/15/915/3</pre><pre style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;"><span>diff --git a/src/openvpnserv/interactive.c b/src/openvpn=
serv/interactive.c</span><br><span>index e64ac30..c6963b3 100644</span><br>=
<span>--- a/src/openvpnserv/interactive.c</span><br><span>+++ b/src/openvpn=
serv/interactive.c</span><br><span>@@ -1901,7 +1901,9 @@</span><br><span>  =
   if (msg-&gt;addr_len &gt; 0)</span><br><span>     {</span><br><span>    =
     /* prepare the comma separated address list */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        CHAR addrs[max_addrs * 64]; /* 64 i=
s enough for one IPv4/6 address */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        /* cannot use max_addrs here as that is not consider=
ed compile</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
* time constant by all compilers and constexpr is C23 */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        CHAR addrs[_countof(msg-&gt;ad=
dr) * 64]; /* 64 is enough for one IPv4/6 address */</span><br><span>      =
   size_t offset =3D 0;</span><br><span>         for (int i =3D 0; i &lt; a=
ddr_len; ++i)</span><br><span>         {</span><br><span></span><br></pre><=
p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/915?usp=
=3Demail">change 915</a>. To unsubscribe, or for help writing mail filters,=
 visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div=
 itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/915?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib579c1538eb5440bb7008bc866a=
5cb7d74844374 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 915 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--AGgpSYN1TJk=--

