From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 20 Dec 2024 21:41:33 +0000
In-Reply-To: <gerrit.1733989644000.I81d4bb0abdd421f5ba260c10c610918652334a4d@...2715...>
References: <gerrit.1733989644000.I81d4bb0abdd421f5ba260c10c610918652334a4d@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <2131d8df3887d70ac7e6e84d54fc7181cb0d1869-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="DO5rHcTDBLY="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: dns: store IPv4
 addresses in network byte order
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: d12fk <heiko@...515...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--DO5rHcTDBLY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 d12fk. ( http://gerrit.openvpn.net/c/openvpn/+/834?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld


Change subject: dns: store IPv4 addresses in network byte order
......................................................................

dns: store IPv4 addresses in network byte order

This is done so that inet_ntop(3) can be used with IPv4 name server
addresses. It expects the binary address in network byte order. If they
are not that way the address octets are reversed.

Change-Id: I81d4bb0abdd421f5ba260c10c610918652334a4d
Signed-off-by: Heiko Hund <heiko@...2662...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20241213164552.265863-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30=
111.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/dns.c
1 file changed, 3 insertions(+), 3 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/34/834/2

diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c
index 0539ca5..15e7322 100644
--- a/src/openvpn/dns.c
+++ b/src/openvpn/dns.c
@@ -121,7 +121,7 @@
     if (ai->ai_family =3D=3D AF_INET)
     {
         struct sockaddr_in *sin =3D (struct sockaddr_in *)ai->ai_addr;
-        server->addr[server->addr_count].in.a4.s_addr =3D ntohl(sin->sin_a=
ddr.s_addr);
+        server->addr[server->addr_count].in.a4.s_addr =3D sin->sin_addr.s_=
addr;
     }
     else
     {
@@ -384,7 +384,7 @@
             if (s->addr[j].family =3D=3D AF_INET)
             {
                 setenv_dns_option(es, "dns_server_%d_address_%d", i, j + 1,
-                                  print_in_addr_t(s->addr[j].in.a4.s_addr,=
 0, &gc));
+                                  print_in_addr_t(s->addr[j].in.a4.s_addr,=
 IA_NET_ORDER, &gc));
             }
             else
             {
@@ -443,7 +443,7 @@
             const char *fmt_port;
             if (server->addr[j].family =3D=3D AF_INET)
             {
-                addr =3D print_in_addr_t(server->addr[j].in.a4.s_addr, 0, =
&gc);
+                addr =3D print_in_addr_t(server->addr[j].in.a4.s_addr, IA_=
NET_ORDER, &gc);
                 fmt_port =3D "    address =3D %s:%s";
             }
             else

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/834?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I81d4bb0abdd421f5ba260c10c610918652334a4d
Gerrit-Change-Number: 834
Gerrit-PatchSet: 2
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--DO5rHcTDBLY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by d12fk.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/834?=
usp=3Demail">View Change</a></p><p>The following approvals got outdated and=
 were removed:
Code-Review+2 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">dns: store IPv4 addresses in network byte ord=
er<br><br>This is done so that inet_ntop(3) can be used with IPv4 name serv=
er<br>addresses. It expects the binary address in network byte order. If th=
ey<br>are not that way the address octets are reversed.<br><br>Change-Id: I=
81d4bb0abdd421f5ba260c10c610918652334a4d<br>Signed-off-by: Heiko Hund &lt;h=
eiko@...2662...&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@...2641...&gt;=
<br>Message-Id: &lt;20241213164552.265863-1-frank@...2641...&gt;<br>URL: ht=
tps://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30111.htm=
l<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/op=
envpn/dns.c<br>1 file changed, 3 insertions(+), 3 deletions(-)<br><br></pre=
><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">gi=
t pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/34/834/2</pre><p=
re style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span=
>diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c</span><br><span>index 0=
539ca5..15e7322 100644</span><br><span>--- a/src/openvpn/dns.c</span><br><s=
pan>+++ b/src/openvpn/dns.c</span><br><span>@@ -121,7 +121,7 @@</span><br><=
span>     if (ai-&gt;ai_family =3D=3D AF_INET)</span><br><span>     {</span=
><br><span>         struct sockaddr_in *sin =3D (struct sockaddr_in *)ai-&g=
t;ai_addr;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ser=
ver-&gt;addr[server-&gt;addr_count].in.a4.s_addr =3D ntohl(sin-&gt;sin_addr=
.s_addr);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        se=
rver-&gt;addr[server-&gt;addr_count].in.a4.s_addr =3D sin-&gt;sin_addr.s_ad=
dr;</span><br><span>     }</span><br><span>     else</span><br><span>     {=
</span><br><span>@@ -384,7 +384,7 @@</span><br><span>             if (s-&gt=
;addr[j].family =3D=3D AF_INET)</span><br><span>             {</span><br><s=
pan>                 setenv_dns_option(es, &quot;dns_server_%d_address_%d&q=
uot;, i, j + 1,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
                            print_in_addr_t(s-&gt;addr[j].in.a4.s_addr, 0, =
&amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
                         print_in_addr_t(s-&gt;addr[j].in.a4.s_addr, IA_NET=
_ORDER, &amp;gc));</span><br><span>             }</span><br><span>         =
    else</span><br><span>             {</span><br><span>@@ -443,7 +443,7 @@=
</span><br><span>             const char *fmt_port;</span><br><span>       =
      if (server-&gt;addr[j].family =3D=3D AF_INET)</span><br><span>       =
      {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
  addr =3D print_in_addr_t(server-&gt;addr[j].in.a4.s_addr, 0, &amp;gc);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                addr =
=3D print_in_addr_t(server-&gt;addr[j].in.a4.s_addr, IA_NET_ORDER, &amp;gc)=
;</span><br><span>                 fmt_port =3D &quot;    address =3D %s:%s=
&quot;;</span><br><span>             }</span><br><span>             else</s=
pan><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.o=
penvpn.net/c/openvpn/+/834?usp=3Demail">change 834</a>. To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/s=
ettings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Emai=
lMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/=
ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/834?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></=
div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I81d4bb0abdd421f5ba260c10c61=
0918652334a4d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 834 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--DO5rHcTDBLY=--

