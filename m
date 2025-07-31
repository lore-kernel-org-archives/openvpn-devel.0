From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 31 Jul 2025 15:43:43 +0000
In-Reply-To: <gerrit.1753974592000.I37ca672f05e9d77ec586fa28dadc6dc752e574fb@...2715...>
References: <gerrit.1753974592000.I37ca672f05e9d77ec586fa28dadc6dc752e574fb@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <55fdfc7564e443c5c391544b5c77fdcb8586f755-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="fCjkoCUVBTs="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Fix wrong byte
 order of --dns server
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: stipa <lstipakov@...277...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--fCjkoCUVBTs=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/11=
25?usp=3Demail )

Change subject: Fix wrong byte order of --dns server
......................................................................

Fix wrong byte order of --dns server

We already fixed it in commit 82fd89a04f, but
the fix got lost in 2dfc4f8.

tuntap_options require host byte order, and we store
dns servers in struct dns_server in network byte order,
what we got from getaddrinfo().

Fix (again) by converting to the host byte order.

Change-Id: I37ca672f05e9d77ec586fa28dadc6dc752e574fb
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250731152912.21826-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32=
460.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/options.c
1 file changed, 1 insertion(+), 1 deletion(-)




diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 3ceada0..ff9addd 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3573,7 +3573,7 @@
             {
                 if (s->addr[i].family =3D=3D AF_INET && tt->dns_len + 1 < =
N_DHCP_ADDR)
                 {
-                    tt->dns[tt->dns_len++] =3D s->addr[i].in.a4.s_addr;
+                    tt->dns[tt->dns_len++] =3D ntohl(s->addr[i].in.a4.s_ad=
dr);
                 }
                 else if (tt->dns6_len + 1 < N_DHCP_ADDR)
                 {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1125?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I37ca672f05e9d77ec586fa28dadc6dc752e574fb
Gerrit-Change-Number: 1125
Gerrit-PatchSet: 2
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--fCjkoCUVBTs=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1125?usp=3Demail">View Change</a></p><div styl=
e=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Fix wrong byte order of --dns server<br><br>W=
e already fixed it in commit 82fd89a04f, but<br>the fix got lost in 2dfc4f8=
.<br><br>tuntap_options require host byte order, and we store<br>dns server=
s in struct dns_server in network byte order,<br>what we got from getaddrin=
fo().<br><br>Fix (again) by converting to the host byte order.<br><br>Chang=
e-Id: I37ca672f05e9d77ec586fa28dadc6dc752e574fb<br>Signed-off-by: Lev Stipa=
kov &lt;lev@...515...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;=
<br>Message-Id: &lt;20250731152912.21826-1-gert@...1296...&gt;<br>URL: http=
s://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32460.html<=
br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/open=
vpn/options.c<br>1 file changed, 1 insertion(+), 1 deletion(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/options.c b/src/openvpn/options.c</span><br><sp=
an>index 3ceada0..ff9addd 100644</span><br><span>--- a/src/openvpn/options.=
c</span><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -3573,7 +3=
573,7 @@</span><br><span>             {</span><br><span>                 if=
 (s-&gt;addr[i].family =3D=3D AF_INET &amp;&amp; tt-&gt;dns_len + 1 &lt; N_=
DHCP_ADDR)</span><br><span>                 {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                    tt-&gt;dns[tt-&gt;dns_len++] =
=3D s-&gt;addr[i].in.a4.s_addr;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                    tt-&gt;dns[tt-&gt;dns_len++] =3D ntohl(s-&g=
t;addr[i].in.a4.s_addr);</span><br><span>                 }</span><br><span=
>                 else if (tt-&gt;dns6_len + 1 &lt; N_DHCP_ADDR)</span><br>=
<span>                 {</span><br><span></span><br></pre><p>To view, visit=
 <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1125?usp=3Demail">change =
1125</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope ite=
mtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/1125?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I37ca672f05e9d77ec586fa28dad=
c6dc752e574fb </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1125 </div>
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
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--fCjkoCUVBTs=--

