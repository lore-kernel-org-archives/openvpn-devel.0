From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 14 Feb 2025 16:03:55 +0000
In-Reply-To: <gerrit.1739527719000.I02afe6817433ca21aae76671c35151ec6a066933@...2715...>
References: <gerrit.1739527719000.I02afe6817433ca21aae76671c35151ec6a066933@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., marco@...2726...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <c2b8d21c7052caabd1c723c3c528fbe34a0b3728-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="TVf+xDMHRxw="; charset=UTF-8
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
To: mrbff <marco@...2726...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--TVf+xDMHRxw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/89=
8?usp=3Demail )

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
Gerrit-MessageType: merged

--TVf+xDMHRxw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/898?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">get_default_gateway(): Prevent passing IPV4_IN=
VALID_ADDR as a destination<br><br>When using --redirect-gateway (IPv4) whi=
le connected to an IPv6 remote,<br>OpenVPN still attempts to determine the =
IPv4 default gateway,<br>so link_socket_current_remote() returns IPV4_INVAL=
ID_ADDR (0xffffffff)<br>as the destination, leading to unintended behavior:=
<br><br>- the IPv4 default gateway (rl-&gt;rgi.gateway.addr) gets wiped.<br=
>- this prevents proper restoration of the original route when needed.<br><=
br>To fix this, if link_socket_current_remote() returns IPV4_INVALID_ADDR,<=
br>we now pass INADDR_ANY (0x00000000) to get_default_gateway(),<br>ensurin=
g the function behaves correctly.<br><br>Change-Id: I02afe6817433ca21aae766=
71c35151ec6a066933<br>Signed-off-by: Marco Baffo &lt;marco@...2726...&gt;<b=
r>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Message-Id: &lt;2025021=
4153434.18539-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/op=
envpn-devel@lists.sourceforge.net/msg30895.html<br>Signed-off-by: Gert Doer=
ing &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/route.c<br>1 file chang=
ed, 1 insertion(+), 1 deletion(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/route.c b/src/openvpn/route.c</span><br><span>i=
ndex d895e1c..bc41492 100644</span><br><span>--- a/src/openvpn/route.c</spa=
n><br><span>+++ b/src/openvpn/route.c</span><br><span>@@ -655,7 +655,7 @@</=
span><br><span>         rl-&gt;spec.flags |=3D RTSA_DEFAULT_METRIC;</span><=
br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    get_default_gateway(&amp;rl-&gt;rgi, remote_host, ctx);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    get_default_gateway=
(&amp;rl-&gt;rgi, remote_host !=3D IPV4_INVALID_ADDR ? remote_host : INADDR=
_ANY, ctx);</span><br><span>     if (rl-&gt;rgi.flags &amp; RGI_ADDR_DEFINE=
D)</span><br><span>     {</span><br><span>         setenv_route_addr(es, &q=
uot;net_gateway&quot;, rl-&gt;rgi.gateway.addr, -1);</span><br><span></span=
><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/898?usp=3Demail">change 898</a>. To unsubscribe, or for help writing mai=
l filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a=
>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div items=
cope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link it=
emprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/898?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--TVf+xDMHRxw=--

