From: "stipa (Code Review)" <gerrit@...515...>
Date: Fri, 12 Sep 2025 11:49:59 +0000
References: <gerrit.1757677796000.I815e68dd5d365743faff2b80783b776d9e8a645c@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <f7e996320688902d3b853929ec7fd56d28c9e8fd-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="kCZhpzupTRw="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Preserve
 --dhcp-option values from local config
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

--kCZhpzupTRw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1181?usp=3Demail

to review the following change.


Change subject: Preserve --dhcp-option values from local config
......................................................................

Preserve --dhcp-option values from local config

Commit

  2dfc4f8 ("dns: deal with --dhcp-options when --dns is active")

has changed the way how --dhcp-option values are stored. Instead of
storing them directly in tuntap_options, they are now stored in
dns_options->from_dhcp.

Before connect, we save options before --pull is applied, for that
we call clone_dns_options(). However, this routing was missing cloning
of from_dhcp struct, and as a result, the values of --dhcp-option from'
the local config have been lost.

Fix by adding shallow-copying of dhcp_options to clone_dns_options(). It
is safe to do because it only contains fixed-size arrays, scalar types
and pointers to the strings which this struct doesn't own.

GitHub: https://github.com/OpenVPN/openvpn/issues/839

Change-Id: I815e68dd5d365743faff2b80783b776d9e8a645c
Signed-off-by: Lev Stipakov <lev@...515...>
---
M src/openvpn/dns.c
1 file changed, 1 insertion(+), 0 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/81/1181/1

diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c
index 8554089..5421004 100644
--- a/src/openvpn/dns.c
+++ b/src/openvpn/dns.c
@@ -264,6 +264,7 @@
     clone.servers_prepull =3D clone_dns_servers(o->servers_prepull, gc);
     clone.updown =3D o->updown;
     clone.updown_flags =3D o->updown_flags;
+    clone.from_dhcp =3D o->from_dhcp;

     return clone;
 }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1181?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I815e68dd5d365743faff2b80783b776d9e8a645c
Gerrit-Change-Number: 1181
Gerrit-PatchSet: 1
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--kCZhpzupTRw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>stipa would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1181?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">Preserve --dhcp-option values from local config<br><br>Commi=
t<br><br>  2dfc4f8 (&quot;dns: deal with --dhcp-options when --dns is activ=
e&quot;)<br><br>has changed the way how --dhcp-option values are stored. In=
stead of<br>storing them directly in tuntap_options, they are now stored in=
<br>dns_options-&gt;from_dhcp.<br><br>Before connect, we save options befor=
e --pull is applied, for that<br>we call clone_dns_options(). However, this=
 routing was missing cloning<br>of from_dhcp struct, and as a result, the v=
alues of --dhcp-option from&#39;<br>the local config have been lost.<br><br=
>Fix by adding shallow-copying of dhcp_options to clone_dns_options(). It<b=
r>is safe to do because it only contains fixed-size arrays, scalar types<br=
>and pointers to the strings which this struct doesn&#39;t own.<br><br>GitH=
ub: https://github.com/OpenVPN/openvpn/issues/839<br><br>Change-Id: I815e68=
dd5d365743faff2b80783b776d9e8a645c<br>Signed-off-by: Lev Stipakov &lt;lev@...220...=
..515...&gt;<br>---<br>M src/openvpn/dns.c<br>1 file changed, 1 insertion(+=
), 0 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn=
 refs/changes/81/1181/1</pre><pre style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;"><span>diff --git a/src/openvpn/dns.c b/src/openvp=
n/dns.c</span><br><span>index 8554089..5421004 100644</span><br><span>--- a=
/src/openvpn/dns.c</span><br><span>+++ b/src/openvpn/dns.c</span><br><span>=
@@ -264,6 +264,7 @@</span><br><span>     clone.servers_prepull =3D clone_dn=
s_servers(o-&gt;servers_prepull, gc);</span><br><span>     clone.updown =3D=
 o-&gt;updown;</span><br><span>     clone.updown_flags =3D o-&gt;updown_fla=
gs;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    clone.from_d=
hcp =3D o-&gt;from_dhcp;</span><br><span> </span><br><span>     return clon=
e;</span><br><span> }</span><br><span></span><br></pre><p>To view, visit <a=
 href=3D"http://gerrit.openvpn.net/c/openvpn/+/1181?usp=3Demail">change 118=
1</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"h=
ttp://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1181?usp=3Demail"/><meta itemprop=3D"name" =
content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I815e68dd5d365743faff2b80783=
b776d9e8a645c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1181 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
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


--kCZhpzupTRw=--

