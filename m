From: "ordex (Code Review)" <gerrit@...515...>
Date: Mon, 25 Nov 2024 14:37:46 +0000
References: <gerrit.1732545464000.I6816f61b308ca9f6d1f9f687a6dc8e0aa2d044e0@...2715...>
Reply-To: a@...2181..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <0ba3c0296fe0e52ef01cd4a63d4ea8db344d59b3-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="w3Q4MMjxmKM="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: man: extend
 --persist-tun section
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

--w3Q4MMjxmKM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/819?usp=3Demail

to review the following change.


Change subject: man: extend --persist-tun section
......................................................................

man: extend --persist-tun section

The current persist-tun section has no mention of
retaining IP/routes and its potential usage in traffic
leaking protection.

Spell this out to allow the user to better understand
when this option can play an important role.

Change-Id: I6816f61b308ca9f6d1f9f687a6dc8e0aa2d044e0
Signed-off-by: Antonio Quartulli <antonio@...2726...>
---
M doc/man-sections/vpn-network-options.rst
1 file changed, 9 insertions(+), 0 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/19/819/1

diff --git a/doc/man-sections/vpn-network-options.rst b/doc/man-sections/vp=
n-network-options.rst
index fc76939..cfa6af9 100644
--- a/doc/man-sections/vpn-network-options.rst
+++ b/doc/man-sections/vpn-network-options.rst
@@ -312,6 +312,15 @@
   :code:`SIGUSR1` is a restart signal similar to :code:`SIGHUP`, but which
   offers finer-grained control over reset options.

+  On Linux, this option can be useful when OpenVPN is not executed as
+  root and the CAP_NET_ADMIN has not been granted, because the process
+  would otherwise not be allowed to bring the interface down and back up.
+
+  Alongside the above, using ``--persist-tun`` allows the tunnel interface
+  to retain all IP/route settings, thus allowing the user to implement
+  any advanced traffic leaking protection (please ntoe that for full
+  protection, extra route/firewall rules must be in place).
+
 --redirect-gateway flags
   Automatically execute routing commands to cause all outgoing IP traffic
   to be redirected over the VPN. This is a client-side option.

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/819?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6816f61b308ca9f6d1f9f687a6dc8e0aa2d044e0
Gerrit-Change-Number: 819
Gerrit-PatchSet: 1
Gerrit-Owner: ordex <a@...2181...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--w3Q4MMjxmKM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>ordex would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/819?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">man: extend --persist-tun section<br><br>The current persist-=
tun section has no mention of<br>retaining IP/routes and its potential usag=
e in traffic<br>leaking protection.<br><br>Spell this out to allow the user=
 to better understand<br>when this option can play an important role.<br><b=
r>Change-Id: I6816f61b308ca9f6d1f9f687a6dc8e0aa2d044e0<br>Signed-off-by: An=
tonio Quartulli &lt;antonio@...2726...&gt;<br>---<br>M doc/man-sections/vpn=
-network-options.rst<br>1 file changed, 9 insertions(+), 0 deletions(-)<br>=
<br></pre><pre style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/19/819/=
1</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;"><span>diff --git a/doc/man-sections/vpn-network-options.rst b/doc/man-s=
ections/vpn-network-options.rst</span><br><span>index fc76939..cfa6af9 1006=
44</span><br><span>--- a/doc/man-sections/vpn-network-options.rst</span><br=
><span>+++ b/doc/man-sections/vpn-network-options.rst</span><br><span>@@ -3=
12,6 +312,15 @@</span><br><span>   :code:`SIGUSR1` is a restart signal simi=
lar to :code:`SIGHUP`, but which</span><br><span>   offers finer-grained co=
ntrol over reset options.</span><br><span> </span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+  On Linux, this option can be useful when OpenVPN =
is not executed as</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
 root and the CAP_NET_ADMIN has not been granted, because the process</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+  would otherwise not be =
allowed to bring the interface down and back up.</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+  Alongside the above, using ``--persist-tun`` allows the tunnel =
interface</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  to retai=
n all IP/route settings, thus allowing the user to implement</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+  any advanced traffic leaking pro=
tection (please ntoe that for full</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+  protection, extra route/firewall rules must be in place).<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> --=
redirect-gateway flags</span><br><span>   Automatically execute routing com=
mands to cause all outgoing IP traffic</span><br><span>   to be redirected =
over the VPN. This is a client-side option.</span><br><span></span><br></pr=
e><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/819?us=
p=3Demail">change 819</a>. To unsubscribe, or for help writing mail filters=
, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><di=
v itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope item=
prop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/819?usp=3Demail"/><meta=
 itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6816f61b308ca9f6d1f9f687a6d=
c8e0aa2d044e0 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 819 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;a@...2181...&gt; </div>
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


--w3Q4MMjxmKM=--

