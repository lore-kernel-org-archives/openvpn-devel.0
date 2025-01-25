From: "ordex (Code Review)" <gerrit@...515...>
Date: Sat, 25 Jan 2025 23:46:54 +0000
In-Reply-To: <gerrit.1732545464000.I6816f61b308ca9f6d1f9f687a6dc8e0aa2d044e0@...2715...>
References: <gerrit.1732545464000.I6816f61b308ca9f6d1f9f687a6dc8e0aa2d044e0@...2715...>
Reply-To: a@...2181..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <8e3e05618e145deac5a0f93ad9b2a0487425803e-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="b8yIgRDjhGs="; charset=UTF-8
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

--b8yIgRDjhGs=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, ordex, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/819?usp=3Demail

to look at the new patch set (#2).

The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/19/819/2

diff --git a/doc/man-sections/vpn-network-options.rst b/doc/man-sections/vp=
n-network-options.rst
index fc76939..67f7e1f 100644
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
+  any advanced traffic leaking protection (please note that for full
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
Gerrit-PatchSet: 2
Gerrit-Owner: ordex <a@...2181...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: ordex <a@...2181...>
Gerrit-MessageType: newpatchset

--b8yIgRDjhGs=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, ordex, plaisthos. <=
/p>
<p>ordex <strong>uploaded patch set #2</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/819?usp=3Demail">View Change</a=
></p><p>The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">man: extend --persist-tun section<br><br>The =
current persist-tun section has no mention of<br>retaining IP/routes and it=
s potential usage in traffic<br>leaking protection.<br><br>Spell this out t=
o allow the user to better understand<br>when this option can play an impor=
tant role.<br><br>Change-Id: I6816f61b308ca9f6d1f9f687a6dc8e0aa2d044e0<br>S=
igned-off-by: Antonio Quartulli &lt;antonio@...2726...&gt;<br>---<br>M doc/=
man-sections/vpn-network-options.rst<br>1 file changed, 9 insertions(+), 0 =
deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs=
/changes/19/819/2</pre><pre style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;"><span>diff --git a/doc/man-sections/vpn-network-options=
.rst b/doc/man-sections/vpn-network-options.rst</span><br><span>index fc769=
39..67f7e1f 100644</span><br><span>--- a/doc/man-sections/vpn-network-optio=
ns.rst</span><br><span>+++ b/doc/man-sections/vpn-network-options.rst</span=
><br><span>@@ -312,6 +312,15 @@</span><br><span>   :code:`SIGUSR1` is a res=
tart signal similar to :code:`SIGHUP`, but which</span><br><span>   offers =
finer-grained control over reset options.</span><br><span> </span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+  On Linux, this option can be usef=
ul when OpenVPN is not executed as</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+  root and the CAP_NET_ADMIN has not been granted, because t=
he process</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  would o=
therwise not be allowed to bring the interface down and back up.</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+  Alongside the above, using ``--persist-tun`` al=
lows the tunnel interface</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+  to retain all IP/route settings, thus allowing the user to implemen=
t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  any advanced tra=
ffic leaking protection (please note that for full</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+  protection, extra route/firewall rules mus=
t be in place).</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span> --redirect-gateway flags</span><br><span>   Automatically exe=
cute routing commands to cause all outgoing IP traffic</span><br><span>   t=
o be redirected over the VPN. This is a client-side option.</span><br><span=
></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/819?usp=3Demail">change 819</a>. To unsubscribe, or for help writ=
ing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">sett=
ings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><di=
v itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><=
link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/819?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6816f61b308ca9f6d1f9f687a6d=
c8e0aa2d044e0 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 819 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
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
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;a@...2181...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--b8yIgRDjhGs=--

