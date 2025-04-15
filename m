From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 15 Apr 2025 18:11:50 +0000
In-Reply-To: <gerrit.1744716809000.I37482a8c322680add00bab52272f9945fbb3bd09@...2715...>
References: <gerrit.1744716809000.I37482a8c322680add00bab52272f9945fbb3bd09@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <46820b9a38350e0cb134e174d12265985a142cec-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="gw/Dz9hgVms="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Remove UINT8_MAX
 definition
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: stipa <lstipakov@...277...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--gw/Dz9hgVms=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 stipa. ( http://gerrit.openvpn.net/c/openvpn/+/940?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: Remove UINT8_MAX definition
......................................................................

Remove UINT8_MAX definition

Because this is a part of C99 if uint8_t is available.

Change-Id: I37482a8c322680add00bab52272f9945fbb3bd09
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250415155259.12601-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31=
440.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/socket.c
1 file changed, 0 insertions(+), 4 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/40/940/2

diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index bd7a449..a0c22b1 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -3036,10 +3036,6 @@
     return BSTR(&buffer);
 }

-#ifndef UINT8_MAX
-#define UINT8_MAX 0xff
-#endif
-
 /* add some offset to an ipv6 address
  * (add in steps of 8 bits, taking overflow into next round)
  */

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/940?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I37482a8c322680add00bab52272f9945fbb3bd09
Gerrit-Change-Number: 940
Gerrit-PatchSet: 2
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--gw/Dz9hgVms=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by stipa.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/940?=
usp=3Demail">View Change</a></p><p>The following approvals got outdated and=
 were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">Remove UINT8_MAX definition<br><br>Because this is a=
 part of C99 if uint8_t is available.<br><br>Change-Id: I37482a8c322680add0=
0bab52272f9945fbb3bd09<br>Signed-off-by: Lev Stipakov &lt;lev@...515...&gt;=
<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Message-Id: &lt;20250=
415155259.12601-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/=
openvpn-devel@lists.sourceforge.net/msg31440.html<br>Signed-off-by: Gert Do=
ering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/socket.c<br>1 file ch=
anged, 0 insertions(+), 4 deletions(-)<br><br></pre><pre style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.open=
vpn.net:29418/openvpn refs/changes/40/940/2</pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvp=
n/socket.c b/src/openvpn/socket.c</span><br><span>index bd7a449..a0c22b1 10=
0644</span><br><span>--- a/src/openvpn/socket.c</span><br><span>+++ b/src/o=
penvpn/socket.c</span><br><span>@@ -3036,10 +3036,6 @@</span><br><span>    =
 return BSTR(&amp;buffer);</span><br><span> }</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#ifndef UINT8_MAX</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#define UINT8_MAX 0xff</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span> /* add some offset to an ipv6 add=
ress</span><br><span>  * (add in steps of 8 bits, taking overflow into next=
 round)</span><br><span>  */</span><br><span></span><br></pre><p>To view, v=
isit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/940?usp=3Demail">chan=
ge 940</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope ite=
mtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/940?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I37482a8c322680add00bab52272=
f9945fbb3bd09 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 940 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--gw/Dz9hgVms=--

