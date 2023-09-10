From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 10 Sep 2023 15:33:25 +0000
In-Reply-To: <gerrit.1692141606000.I61adc26ce2ff737e020c3d980902a46758cb23e5@...2715...>
References: <gerrit.1692141606000.I61adc26ce2ff737e020c3d980902a46758cb23e5@...2715...>
Reply-To: openvpn-devel@lists.sourceforge.net, frank@...2641...,
 a@...2181...
Message-ID: <63e53945cdd2f8e7ecb27c2ef4227ff04ff697c1-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Z2f9LtxREMU="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: dco: fix crash when
 --multihome is used with --proto tcp
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Z2f9LtxREMU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/32=
4?usp=3Demail )

Change subject: dco: fix crash when --multihome is used with --proto tcp
......................................................................

dco: fix crash when --multihome is used with --proto tcp

Although it's a combination of options that is not really useful,
when specifying --multihome along with --proto tcp and DCO is enabled,
OpenVPN will crash while attempting to access c2.link_socket_actual
(NULL for the TCP case) in order to retrieve the local address (in
function dco_multi_get_localaddr())

Prevent crash by running this code only if proto is UDP.
The same check is already performed in socket.c/h for the non-DCO
case.

Github: fixes OpenVPN/openvpn#390
Change-Id: I61adc26ce2ff737e020c3d980902a46758cb23e5
Signed-off-by: Antonio Quartulli <a@...2181...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20230815231555.6465-1-a@...2181...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26=
953.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/dco.c
1 file changed, 1 insertion(+), 1 deletion(-)




diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index 7c7eaac..cd3e0ad 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -509,7 +509,7 @@
 #if ENABLE_IP_PKTINFO
     struct context *c =3D &mi->context;

-    if (!(c->options.sockflags & SF_USE_IP_PKTINFO))
+    if (!proto_is_udp(c->c2.link_socket->info.proto) || !(c->options.sockf=
lags & SF_USE_IP_PKTINFO))
     {
         return false;
     }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/324?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I61adc26ce2ff737e020c3d980902a46758cb23e5
Gerrit-Change-Number: 324
Gerrit-PatchSet: 2
Gerrit-Owner: ordex <a@...2181...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--Z2f9LtxREMU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/324?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">dco: fix crash when --multihome is used with -=
-proto tcp<br><br>Although it&#39;s a combination of options that is not re=
ally useful,<br>when specifying --multihome along with --proto tcp and DCO =
is enabled,<br>OpenVPN will crash while attempting to access c2.link_socket=
_actual<br>(NULL for the TCP case) in order to retrieve the local address (=
in<br>function dco_multi_get_localaddr())<br><br>Prevent crash by running t=
his code only if proto is UDP.<br>The same check is already performed in so=
cket.c/h for the non-DCO<br>case.<br><br>Github: fixes OpenVPN/openvpn#390<=
br>Change-Id: I61adc26ce2ff737e020c3d980902a46758cb23e5<br>Signed-off-by: A=
ntonio Quartulli &lt;a@...2181...&gt;<br>Acked-by: Gert Doering &lt;gert@...1186...=
.1296...&gt;<br>Message-Id: &lt;20230815231555.6465-1-a@...2181...&gt;<br>U=
RL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg269=
53.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M =
src/openvpn/dco.c<br>1 file changed, 1 insertion(+), 1 deletion(-)<br><br><=
/pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c</span><br><span>index=
 7c7eaac..cd3e0ad 100644</span><br><span>--- a/src/openvpn/dco.c</span><br>=
<span>+++ b/src/openvpn/dco.c</span><br><span>@@ -509,7 +509,7 @@</span><br=
><span> #if ENABLE_IP_PKTINFO</span><br><span>     struct context *c =3D &a=
mp;mi-&gt;context;</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    if (!(c-&gt;options.sockflags &amp; SF_USE_IP_PKTINFO))<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!proto_is_ud=
p(c-&gt;c2.link_socket-&gt;info.proto) || !(c-&gt;options.sockflags &amp; S=
F_USE_IP_PKTINFO))</span><br><span>     {</span><br><span>         return f=
alse;</span><br><span>     }</span><br><span></span><br></pre><p>To view, v=
isit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/324?usp=3Demail">chan=
ge 324</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope ite=
mtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/324?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I61adc26ce2ff737e020c3d98090=
2a46758cb23e5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 324 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;a@...2181...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--Z2f9LtxREMU=--

