From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 7 May 2026 07:44:53 +0000
In-Reply-To: <gerrit.1777558352000.I53b3f4c60897a1f4dd5efeb6575d525ffb082402@...2715...>
References: <gerrit.1777558352000.I53b3f4c60897a1f4dd5efeb6575d525ffb082402@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., selva.nair@...277...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <a4b3c3446e6026a0f08c365f359541802bc590d9-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="sN4CgPS989o="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: DNS server
 documentation update
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: selvanair <selva.nair@...277...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--sN4CgPS989o=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#3) to the change originally created by=
 selvanair. ( http://gerrit.openvpn.net/c/openvpn/+/1646?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld


Change subject: DNS server documentation update
......................................................................

DNS server documentation update

Github: OpenVPN/openvpn#937

Change-Id: I53b3f4c60897a1f4dd5efeb6575d525ffb082402
Signed-off-by: Selva Nair <selva.nair@...277...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1646
Message-Id: <20260430163249.13638-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36=
816.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M doc/man-sections/client-options.rst
1 file changed, 15 insertions(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/46/1646/3

diff --git a/doc/man-sections/client-options.rst b/doc/man-sections/client-=
options.rst
index 1664eed..3ad9104 100644
--- a/doc/man-sections/client-options.rst
+++ b/doc/man-sections/client-options.rst
@@ -216,7 +216,8 @@
   DNS server options it must be between 0 and 127. The server id is used
   to group options and also for ordering the list of configured DNS server=
s;
   lower numbers come first. DNS servers being pushed to a client replace
-  already configured DNS servers with the same server id.
+  already configured DNS servers with the same server id. Only the group of
+  options corresponding to the lowest server id is applied.

   The ``address`` option configures the IPv4 and / or IPv6 address(es) of
   the DNS server. Up to eight addresses can be specified per DNS server.
@@ -249,6 +250,19 @@
   so that ``--dns`` overrides ``--dhcp-option``. Thus, ``--dns`` can be us=
ed today
   to migrate from ``--dhcp-option``.

+  Windows only:
+
+  #. If tap-windows6 is in use, dns servers are set by DHCP by default.
+     In this case only ``--dns search-domains`` and ``--dns server n addre=
ss ..``
+     with the lowest value of ``n`` are interpreted. All other ``--dns`` o=
ptions
+     are ignored. Use of the dco driver is the recommended way to make use=
 of these
+     new features.
+
+  #. If ``--dns server n resolve-domains`` is in use, the DNS server addre=
sses
+     corresponding to ``n`` are set on the interface only if ``search-doma=
ins`` is
+     also specified.  Otherwise these DNS addresses are used only for NRPT=
 rules for
+     split-DNS.
+
 --explicit-exit-notify n
   In UDP client mode or point-to-point mode, send server/peer an exit
   notification if tunnel is restarted or OpenVPN process is exited. In

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1646?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I53b3f4c60897a1f4dd5efeb6575d525ffb082402
Gerrit-Change-Number: 1646
Gerrit-PatchSet: 3
Gerrit-Owner: selvanair <selva.nair@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--sN4CgPS989o=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #3</strong> to the change originally created by selvanair.<=
/p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1646?usp=3Demail">Vi=
ew Change</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld</p><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">DNS server documentation upd=
ate<br><br>Github: OpenVPN/openvpn#937<br><br>Change-Id: I53b3f4c60897a1f4d=
d5efeb6575d525ffb082402<br>Signed-off-by: Selva Nair &lt;selva.nair@...1354...=
..&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Gerrit UR=
L: https://gerrit.openvpn.net/c/openvpn/+/1646<br>Message-Id: &lt;202604301=
63249.13638-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/open=
vpn-devel@lists.sourceforge.net/msg36816.html<br>Signed-off-by: Gert Doerin=
g &lt;gert@...1296...&gt;<br>---<br>M doc/man-sections/client-options.rst<b=
r>1 file changed, 15 insertions(+), 1 deletion(-)<br><br></pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/46/1646/3<=
/pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
"><span>diff --git a/doc/man-sections/client-options.rst b/doc/man-sections=
/client-options.rst</span><br><span>index 1664eed..3ad9104 100644</span><br=
><span>--- a/doc/man-sections/client-options.rst</span><br><span>+++ b/doc/=
man-sections/client-options.rst</span><br><span>@@ -216,7 +216,8 @@</span><=
br><span>   DNS server options it must be between 0 and 127. The server id =
is used</span><br><span>   to group options and also for ordering the list =
of configured DNS servers;</span><br><span>   lower numbers come first. DNS=
 servers being pushed to a client replace</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-  already configured DNS servers with the same server i=
d.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  already configu=
red DNS servers with the same server id. Only the group of</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+  options corresponding to the lowes=
t server id is applied.</span><br><span> </span><br><span>   The ``address`=
` option configures the IPv4 and / or IPv6 address(es) of</span><br><span> =
  the DNS server. Up to eight addresses can be specified per DNS server.</s=
pan><br><span>@@ -249,6 +250,19 @@</span><br><span>   so that ``--dns`` ove=
rrides ``--dhcp-option``. Thus, ``--dns`` can be used today</span><br><span=
>   to migrate from ``--dhcp-option``.</span><br><span> </span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+  Windows only:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+  #. If tap-windows6 is in use, dns servers are set by DHCP =
by default.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     In =
this case only ``--dns search-domains`` and ``--dns server n address ..``</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+     with the lowest =
value of ``n`` are interpreted. All other ``--dns`` options</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+     are ignored. Use of the dco dr=
iver is the recommended way to make use of these</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+     new features.</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  #. If ``--dns server n resolve-domains`` is in use, the DNS serv=
er addresses</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     co=
rresponding to ``n`` are set on the interface only if ``search-domains`` is=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     also specified=
.  Otherwise these DNS addresses are used only for NRPT rules for</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+     split-DNS.</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> --explicit-exit=
-notify n</span><br><span>   In UDP client mode or point-to-point mode, sen=
d server/peer an exit</span><br><span>   notification if tunnel is restarte=
d or OpenVPN process is exited. In</span><br><span></span><br></pre><p>To v=
iew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1646?usp=3Demai=
l">change 1646</a>. To unsubscribe, or for help writing mail filters, visit=
 <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</=
p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itempr=
op=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1646?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I53b3f4c60897a1f4dd5efeb6575=
d525ffb082402 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1646 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: selvanair &lt;selva.nair@...1354...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--sN4CgPS989o=--

