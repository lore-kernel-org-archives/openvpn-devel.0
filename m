From: "selvanair (Code Review)" <gerrit@...515...>
Date: Thu, 30 Apr 2026 14:12:34 +0000
References: <gerrit.1777558352000.I53b3f4c60897a1f4dd5efeb6575d525ffb082402@...2715...>
Reply-To: selva.nair@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <763a7dbee0ce5583f95a61a2d3721f91338be000-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="w8dDvDhf7uQ="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--w8dDvDhf7uQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1646?usp=3Demail

to review the following change.


Change subject: DNS server documentation update
......................................................................

DNS server documentation update

Change-Id: I53b3f4c60897a1f4dd5efeb6575d525ffb082402
Signed-off-by: Selva Nair <selva.nair@...277...>
---
M doc/man-sections/client-options.rst
1 file changed, 12 insertions(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/46/1646/1

diff --git a/doc/man-sections/client-options.rst b/doc/man-sections/client-=
options.rst
index 1664eed..5df881d 100644
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
@@ -249,6 +250,16 @@
   so that ``--dns`` overrides ``--dhcp-option``. Thus, ``--dns`` can be us=
ed today
   to migrate from ``--dhcp-option``.

+  Windows only: (i) If tap-windows6 is in use, dns servers are set by DHCP=
 by
+  default. In this case only ``--dns search-domains`` and ``--dns server n=
 address ..``
+  with the lowest value of ``n`` are interpreted. All other ``--dns`` opti=
ons
+  are ignored. Use of the dco driver is the recommended way to make use of=
 these
+  new features.
+  (ii) If ``--dns server n resolve-domains`` is in use, the DNS server add=
resses
+  corresponding to ``n`` are set on the interface only if ``search-domains=
`` is
+  also specified.  Otherwise these DNS addresses are used only for NRPT ru=
les for
+  split-DNS.
+
 --explicit-exit-notify n
   In UDP client mode or point-to-point mode, send server/peer an exit
   notification if tunnel is restarted or OpenVPN process is exited. In

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1646?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I53b3f4c60897a1f4dd5efeb6575d525ffb082402
Gerrit-Change-Number: 1646
Gerrit-PatchSet: 1
Gerrit-Owner: selvanair <selva.nair@...277...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--w8dDvDhf7uQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>selvanair would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1646?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">DNS server documentation update<br><br>Chan=
ge-Id: I53b3f4c60897a1f4dd5efeb6575d525ffb082402<br>Signed-off-by: Selva Na=
ir &lt;selva.nair@...277...&gt;<br>---<br>M doc/man-sections/client-options=
.rst<br>1 file changed, 12 insertions(+), 1 deletion(-)<br><br></pre><pre c=
lass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/46/164=
6/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;"><span>diff --git a/doc/man-sections/client-options.rst b/doc/man-sect=
ions/client-options.rst</span><br><span>index 1664eed..5df881d 100644</span=
><br><span>--- a/doc/man-sections/client-options.rst</span><br><span>+++ b/=
doc/man-sections/client-options.rst</span><br><span>@@ -216,7 +216,8 @@</sp=
an><br><span>   DNS server options it must be between 0 and 127. The server=
 id is used</span><br><span>   to group options and also for ordering the l=
ist of configured DNS servers;</span><br><span>   lower numbers come first.=
 DNS servers being pushed to a client replace</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-  already configured DNS servers with the same serv=
er id.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  already con=
figured DNS servers with the same server id. Only the group of</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+  options corresponding to the l=
owest server id is applied.</span><br><span> </span><br><span>   The ``addr=
ess`` option configures the IPv4 and / or IPv6 address(es) of</span><br><sp=
an>   the DNS server. Up to eight addresses can be specified per DNS server=
.</span><br><span>@@ -249,6 +250,16 @@</span><br><span>   so that ``--dns``=
 overrides ``--dhcp-option``. Thus, ``--dns`` can be used today</span><br><=
span>   to migrate from ``--dhcp-option``.</span><br><span> </span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+  Windows only: (i) If tap-windows=
6 is in use, dns servers are set by DHCP by</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+  default. In this case only ``--dns search-domains=
`` and ``--dns server n address ..``</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+  with the lowest value of ``n`` are interpreted. All othe=
r ``--dns`` options</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
  are ignored. Use of the dco driver is the recommended way to make use of =
these</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  new features=
.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  (ii) If ``--dns =
server n resolve-domains`` is in use, the DNS server addresses</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+  corresponding to ``n`` are set=
 on the interface only if ``search-domains`` is</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+  also specified.  Otherwise these DNS addresse=
s are used only for NRPT rules for</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+  split-DNS.</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span> --explicit-exit-notify n</span><br><span>   In UD=
P client mode or point-to-point mode, send server/peer an exit</span><br><s=
pan>   notification if tunnel is restarted or OpenVPN process is exited. In=
</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerri=
t.openvpn.net/c/openvpn/+/1646?usp=3Demail">change 1646</a>. To unsubscribe=
, or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.=
net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http:=
//schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"h=
ttp://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.o=
penvpn.net/c/openvpn/+/1646?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I53b3f4c60897a1f4dd5efeb6575=
d525ffb082402 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1646 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: selvanair &lt;selva.nair@...1354...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--w8dDvDhf7uQ=--

