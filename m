From: "stipa (Code Review)" <gerrit@...515...>
Date: Tue, 15 Apr 2025 11:33:32 +0000
References: <gerrit.1744716809000.I37482a8c322680add00bab52272f9945fbb3bd09@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <9cc1439ea605cde4f66995e3f85adc416b0204c8-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="SzCsZ7w9HIM="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--SzCsZ7w9HIM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/940?usp=3Demail

to review the following change.


Change subject: Remove UINT8_MAX definition
......................................................................

Remove UINT8_MAX definition

Because this is a part of C99 if uint8_t is available.

Change-Id: I37482a8c322680add00bab52272f9945fbb3bd09
Signed-off-by: Lev Stipakov <lev@...515...>
---
M src/openvpn/socket.c
1 file changed, 0 insertions(+), 4 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/40/940/1

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
Gerrit-PatchSet: 1
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--SzCsZ7w9HIM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>stipa would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/940?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Remove UINT8_MAX definition<br><br>Because this is a part of =
C99 if uint8_t is available.<br><br>Change-Id: I37482a8c322680add00bab52272=
f9945fbb3bd09<br>Signed-off-by: Lev Stipakov &lt;lev@...515...&gt;<br>---<b=
r>M src/openvpn/socket.c<br>1 file changed, 0 insertions(+), 4 deletions(-)=
<br><br></pre><pre style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/40/=
940/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;"><span>diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c</spa=
n><br><span>index bd7a449..a0c22b1 100644</span><br><span>--- a/src/openvpn=
/socket.c</span><br><span>+++ b/src/openvpn/socket.c</span><br><span>@@ -30=
36,10 +3036,6 @@</span><br><span>     return BSTR(&amp;buffer);</span><br><=
span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#ifndef UINT8_MAX</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#define UINT8_MAX 0xff</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an> /* add some offset to an ipv6 address</span><br><span>  * (add in steps=
 of 8 bits, taking overflow into next round)</span><br><span>  */</span><br=
><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/940?usp=3Demail">change 940</a>. To unsubscribe, or for hel=
p writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings=
">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessag=
e"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAct=
ion"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/9=
40?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></d=
iv>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I37482a8c322680add00bab52272=
f9945fbb3bd09 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 940 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
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


--SzCsZ7w9HIM=--

