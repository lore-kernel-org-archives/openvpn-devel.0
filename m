From: "selvanair (Code Review)" <gerrit@...515...>
Date: Thu, 30 Apr 2026 15:36:41 +0000
In-Reply-To: <gerrit.1777558352000.I53b3f4c60897a1f4dd5efeb6575d525ffb082402@...2715...>
References: <gerrit.1777558352000.I53b3f4c60897a1f4dd5efeb6575d525ffb082402@...2715...>
Reply-To: selva.nair@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <64b442850eea2f35185a1a2efed21a557ddf0277-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="cmIu/E+jQZA="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--cmIu/E+jQZA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1646?usp=3Demail

to look at the new patch set (#2).

The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld


Change subject: DNS server documentation update
......................................................................

DNS server documentation update

Change-Id: I53b3f4c60897a1f4dd5efeb6575d525ffb082402
Signed-off-by: Selva Nair <selva.nair@...277...>
---
M doc/man-sections/client-options.rst
1 file changed, 15 insertions(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/46/1646/2

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
Gerrit-PatchSet: 2
Gerrit-Owner: selvanair <selva.nair@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--cmIu/E+jQZA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>selvanair <strong>uploaded patch set #2</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1646?usp=3Demail">View Chan=
ge</a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld</p><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">DNS server documentation upd=
ate<br><br>Change-Id: I53b3f4c60897a1f4dd5efeb6575d525ffb082402<br>Signed-o=
ff-by: Selva Nair &lt;selva.nair@...277...&gt;<br>---<br>M doc/man-sections=
/client-options.rst<br>1 file changed, 15 insertions(+), 1 deletion(-)<br><=
br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs=
/changes/46/1646/2</pre><pre style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;"><span>diff --git a/doc/man-sections/client-options.rst=
 b/doc/man-sections/client-options.rst</span><br><span>index 1664eed..3ad91=
04 100644</span><br><span>--- a/doc/man-sections/client-options.rst</span><=
br><span>+++ b/doc/man-sections/client-options.rst</span><br><span>@@ -216,=
7 +216,8 @@</span><br><span>   DNS server options it must be between 0 and =
127. The server id is used</span><br><span>   to group options and also for=
 ordering the list of configured DNS servers;</span><br><span>   lower numb=
ers come first. DNS servers being pushed to a client replace</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-  already configured DNS servers wit=
h the same server id.</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+  already configured DNS servers with the same server id. Only the group =
of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  options corresp=
onding to the lowest server id is applied.</span><br><span> </span><br><spa=
n>   The ``address`` option configures the IPv4 and / or IPv6 address(es) o=
f</span><br><span>   the DNS server. Up to eight addresses can be specified=
 per DNS server.</span><br><span>@@ -249,6 +250,19 @@</span><br><span>   so=
 that ``--dns`` overrides ``--dhcp-option``. Thus, ``--dns`` can be used to=
day</span><br><span>   to migrate from ``--dhcp-option``.</span><br><span> =
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Windows only:</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  #. If tap-windows6 is in use, dns serve=
rs are set by DHCP by default.</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+     In this case only ``--dns search-domains`` and ``--dns serv=
er n address ..``</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
   with the lowest value of ``n`` are interpreted. All other ``--dns`` opti=
ons</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     are ignored=
. Use of the dco driver is the recommended way to make use of these</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+     new features.</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+  #. If ``--dns server n resolve-domains`` is i=
n use, the DNS server addresses</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+     corresponding to ``n`` are set on the interface only if ``=
search-domains`` is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
     also specified.  Otherwise these DNS addresses are used only for NRPT =
rules for</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     split=
-DNS.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an> --explicit-exit-notify n</span><br><span>   In UDP client mode or point=
-to-point mode, send server/peer an exit</span><br><span>   notification if=
 tunnel is restarted or OpenVPN process is exited. In</span><br><span></spa=
n><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/1646?usp=3Demail">change 1646</a>. To unsubscribe, or for help writing =
mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Dema=
il">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMess=
age"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/1646?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div>=
</div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I53b3f4c60897a1f4dd5efeb6575=
d525ffb082402 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1646 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: selvanair &lt;selva.nair@...1354...=
..&gt; </div>
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

</body></html>=

--cmIu/E+jQZA=--

