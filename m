From: "d12fk (Code Review)" <gerrit@...515...>
Date: Thu, 12 Dec 2024 07:47:42 +0000
References: <gerrit.1733989644000.I81d4bb0abdd421f5ba260c10c610918652334a4d@...2715...>
Reply-To: heiko@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <6389cf62a6846c2fbb37283949b0d6308d3510da-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="4IWAs9Oa2h0="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--4IWAs9Oa2h0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/834?usp=3Demail

to review the following change.


Change subject: dns: store IPv4 addresses in network byte order
......................................................................

dns: store IPv4 addresses in network byte order

This is done so that inet_ntop(3) can be used with IPv4 name server
addresses. It expects the binary address in network byte order. If they
are not that way the address octets are reversed.

Change-Id: I81d4bb0abdd421f5ba260c10c610918652334a4d
Signed-off-by: Heiko Hund <heiko@...2662...>
---
M src/openvpn/dns.c
1 file changed, 3 insertions(+), 3 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/34/834/1

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
Gerrit-PatchSet: 1
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--4IWAs9Oa2h0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>d12fk would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/834?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">dns: store IPv4 addresses in network byte order<br><br>This i=
s done so that inet_ntop(3) can be used with IPv4 name server<br>addresses.=
 It expects the binary address in network byte order. If they<br>are not th=
at way the address octets are reversed.<br><br>Change-Id: I81d4bb0abdd421f5=
ba260c10c610918652334a4d<br>Signed-off-by: Heiko Hund &lt;heiko@...2662...&=
gt;<br>---<br>M src/openvpn/dns.c<br>1 file changed, 3 insertions(+), 3 del=
etions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/ch=
anges/34/834/1</pre><pre style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;"><span>diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c</=
span><br><span>index 0539ca5..15e7322 100644</span><br><span>--- a/src/open=
vpn/dns.c</span><br><span>+++ b/src/openvpn/dns.c</span><br><span>@@ -121,7=
 +121,7 @@</span><br><span>     if (ai-&gt;ai_family =3D=3D AF_INET)</span>=
<br><span>     {</span><br><span>         struct sockaddr_in *sin =3D (stru=
ct sockaddr_in *)ai-&gt;ai_addr;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        server-&gt;addr[server-&gt;addr_count].in.a4.s_addr =3D =
ntohl(sin-&gt;sin_addr.s_addr);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        server-&gt;addr[server-&gt;addr_count].in.a4.s_addr =3D=
 sin-&gt;sin_addr.s_addr;</span><br><span>     }</span><br><span>     else<=
/span><br><span>     {</span><br><span>@@ -384,7 +384,7 @@</span><br><span>=
             if (s-&gt;addr[j].family =3D=3D AF_INET)</span><br><span>     =
        {</span><br><span>                 setenv_dns_option(es, &quot;dns_=
server_%d_address_%d&quot;, i, j + 1,</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                                  print_in_addr_t(s-&gt;add=
r[j].in.a4.s_addr, 0, &amp;gc));</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                                  print_in_addr_t(s-&gt;addr[j=
].in.a4.s_addr, IA_NET_ORDER, &amp;gc));</span><br><span>             }</sp=
an><br><span>             else</span><br><span>             {</span><br><sp=
an>@@ -443,7 +443,7 @@</span><br><span>             const char *fmt_port;</=
span><br><span>             if (server-&gt;addr[j].family =3D=3D AF_INET)</=
span><br><span>             {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                addr =3D print_in_addr_t(server-&gt;addr[j].in.a4.s=
_addr, 0, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                addr =3D print_in_addr_t(server-&gt;addr[j].in.a4.s_addr, I=
A_NET_ORDER, &amp;gc);</span><br><span>                 fmt_port =3D &quot;=
    address =3D %s:%s&quot;;</span><br><span>             }</span><br><span=
>             else</span><br><span></span><br></pre><p>To view, visit <a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/834?usp=3Demail">change 834</a>=
. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:/=
/gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"h=
ttp://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/834?usp=3Demail"/><meta itemprop=3D"name" conte=
nt=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I81d4bb0abdd421f5ba260c10c61=
0918652334a4d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 834 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
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


--4IWAs9Oa2h0=--

