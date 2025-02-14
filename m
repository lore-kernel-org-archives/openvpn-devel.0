From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 14 Feb 2025 16:03:51 +0000
In-Reply-To: <gerrit.1739527719000.I02afe6817433ca21aae76671c35151ec6a066933@...2715...>
References: <gerrit.1739527719000.I02afe6817433ca21aae76671c35151ec6a066933@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., marco@...2726...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <c2b8d21c7052caabd1c723c3c528fbe34a0b3728-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="oGNpTLRX7Sk="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]:
 get_default_gateway(): Prevent passing IPV4_INVALID_ADDR as a destina...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: mrbff <marco@...2726...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--oGNpTLRX7Sk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#4) to the change originally created by=
 mrbff. ( http://gerrit.openvpn.net/c/openvpn/+/898?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: get_default_gateway(): Prevent passing IPV4_INVALID_ADDR as=
 a destination
......................................................................

get_default_gateway(): Prevent passing IPV4_INVALID_ADDR as a destination

When using --redirect-gateway (IPv4) while connected to an IPv6 remote,
OpenVPN still attempts to determine the IPv4 default gateway,
so link_socket_current_remote() returns IPV4_INVALID_ADDR (0xffffffff)
as the destination, leading to unintended behavior:

- the IPv4 default gateway (rl->rgi.gateway.addr) gets wiped.
- this prevents proper restoration of the original route when needed.

To fix this, if link_socket_current_remote() returns IPV4_INVALID_ADDR,
we now pass INADDR_ANY (0x00000000) to get_default_gateway(),
ensuring the function behaves correctly.

Change-Id: I02afe6817433ca21aae76671c35151ec6a066933
Signed-off-by: Marco Baffo <marco@...2726...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250214153434.18539-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30=
895.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/route.c
1 file changed, 1 insertion(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/98/898/4

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index d895e1c..bc41492 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -655,7 +655,7 @@
         rl->spec.flags |=3D RTSA_DEFAULT_METRIC;
     }

-    get_default_gateway(&rl->rgi, remote_host, ctx);
+    get_default_gateway(&rl->rgi, remote_host !=3D IPV4_INVALID_ADDR ? rem=
ote_host : INADDR_ANY, ctx);
     if (rl->rgi.flags & RGI_ADDR_DEFINED)
     {
         setenv_route_addr(es, "net_gateway", rl->rgi.gateway.addr, -1);

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/898?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I02afe6817433ca21aae76671c35151ec6a066933
Gerrit-Change-Number: 898
Gerrit-PatchSet: 4
Gerrit-Owner: mrbff <marco@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--oGNpTLRX7Sk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #4</strong> to the change originally cr=
eated by mrbff.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/898?=
usp=3Demail">View Change</a></p><p>The following approvals got outdated and=
 were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">get_default_gateway(): Prevent passing IPV4_INVALID_=
ADDR as a destination<br><br>When using --redirect-gateway (IPv4) while con=
nected to an IPv6 remote,<br>OpenVPN still attempts to determine the IPv4 d=
efault gateway,<br>so link_socket_current_remote() returns IPV4_INVALID_ADD=
R (0xffffffff)<br>as the destination, leading to unintended behavior:<br><b=
r>- the IPv4 default gateway (rl-&gt;rgi.gateway.addr) gets wiped.<br>- thi=
s prevents proper restoration of the original route when needed.<br><br>To =
fix this, if link_socket_current_remote() returns IPV4_INVALID_ADDR,<br>we =
now pass INADDR_ANY (0x00000000) to get_default_gateway(),<br>ensuring the =
function behaves correctly.<br><br>Change-Id: I02afe6817433ca21aae76671c351=
51ec6a066933<br>Signed-off-by: Marco Baffo &lt;marco@...2726...&gt;<br>Acke=
d-by: Gert Doering &lt;gert@...1296...&gt;<br>Message-Id: &lt;2025021415343=
4.18539-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-=
devel@lists.sourceforge.net/msg30895.html<br>Signed-off-by: Gert Doering &l=
t;gert@...1296...&gt;<br>---<br>M src/openvpn/route.c<br>1 file changed, 1 =
insertion(+), 1 deletion(-)<br><br></pre><pre style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:294=
18/openvpn refs/changes/98/898/4</pre><pre style=3D"font-family: monospace,=
monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/route.c b=
/src/openvpn/route.c</span><br><span>index d895e1c..bc41492 100644</span><b=
r><span>--- a/src/openvpn/route.c</span><br><span>+++ b/src/openvpn/route.c=
</span><br><span>@@ -655,7 +655,7 @@</span><br><span>         rl-&gt;spec.f=
lags |=3D RTSA_DEFAULT_METRIC;</span><br><span>     }</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    get_default_gateway(&=
amp;rl-&gt;rgi, remote_host, ctx);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    get_default_gateway(&amp;rl-&gt;rgi, remote_host !=3D IP=
V4_INVALID_ADDR ? remote_host : INADDR_ANY, ctx);</span><br><span>     if (=
rl-&gt;rgi.flags &amp; RGI_ADDR_DEFINED)</span><br><span>     {</span><br><=
span>         setenv_route_addr(es, &quot;net_gateway&quot;, rl-&gt;rgi.gat=
eway.addr, -1);</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/898?usp=3Demail">change 898</a>. =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"htt=
p://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D=
"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/898?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I02afe6817433ca21aae76671c35=
151ec6a066933 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 898 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: mrbff &lt;marco@...2726...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--oGNpTLRX7Sk=--

