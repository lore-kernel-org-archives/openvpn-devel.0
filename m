From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 13 Sep 2025 17:13:52 +0000
In-Reply-To: <gerrit.1757677796000.I815e68dd5d365743faff2b80783b776d9e8a645c@...2715...>
References: <gerrit.1757677796000.I815e68dd5d365743faff2b80783b776d9e8a645c@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <3fb0cfb782eca0c7d2a77fece494f9d00357c957-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="LebASciJ7zQ="; charset=UTF-8
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
To: stipa <lstipakov@...277...>
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--LebASciJ7zQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/11=
81?usp=3Demail )

Change subject: Preserve --dhcp-option values from local config
......................................................................

Preserve --dhcp-option values from local config

Commit

  2dfc4f8 ("dns: deal with --dhcp-options when --dns is active")

has changed the way how --dhcp-option values are stored. Instead of
storing them directly in tuntap_options, they are now stored in
dns_options->from_dhcp.

Before connect, we save options before --pull is applied, and for that
we call clone_dns_options(). However, this was missing to clone the
"from_dhcp" struct, and as a result, the values of --dhcp-option from
the local config have been lost.

Fix by adding shallow-copying of dhcp_options to clone_dns_options(). It
is safe to do because it only contains fixed-size arrays, scalar types
and pointers to the strings which this struct doesn't own.

Github: closes OpenVPN/openvpn#839
Github: closes OpenVPN/openvpn#840

Change-Id: I815e68dd5d365743faff2b80783b776d9e8a645c
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20250912132235.44304-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32=
879.html
URL: https://gerrit.openvpn.net/c/openvpn/+/1181
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/dns.c
1 file changed, 1 insertion(+), 0 deletions(-)




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
Gerrit-PatchSet: 2
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--LebASciJ7zQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1181?usp=3Demail">View Change</a></p><div styl=
e=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Preserve --dhcp-option values from local conf=
ig<br><br>Commit<br><br>  2dfc4f8 (&quot;dns: deal with --dhcp-options when=
 --dns is active&quot;)<br><br>has changed the way how --dhcp-option values=
 are stored. Instead of<br>storing them directly in tuntap_options, they ar=
e now stored in<br>dns_options-&gt;from_dhcp.<br><br>Before connect, we sav=
e options before --pull is applied, and for that<br>we call clone_dns_optio=
ns(). However, this was missing to clone the<br>&quot;from_dhcp&quot; struc=
t, and as a result, the values of --dhcp-option from<br>the local config ha=
ve been lost.<br><br>Fix by adding shallow-copying of dhcp_options to clone=
_dns_options(). It<br>is safe to do because it only contains fixed-size arr=
ays, scalar types<br>and pointers to the strings which this struct doesn&#3=
9;t own.<br><br>Github: closes OpenVPN/openvpn#839<br>Github: closes OpenVP=
N/openvpn#840<br><br>Change-Id: I815e68dd5d365743faff2b80783b776d9e8a645c<b=
r>Signed-off-by: Lev Stipakov &lt;lev@...515...&gt;<br>Acked-by: Frank Lich=
tenheld &lt;frank@...2641...&gt;<br>Message-Id: &lt;20250912132235.44304-1-=
frank@...2641...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1484...=
ts.sourceforge.net/msg32879.html<br>URL: https://gerrit.openvpn.net/c/openv=
pn/+/1181<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>=
M src/openvpn/dns.c<br>1 file changed, 1 insertion(+), 0 deletions(-)<br><b=
r></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c</span><br><span>index=
 8554089..5421004 100644</span><br><span>--- a/src/openvpn/dns.c</span><br>=
<span>+++ b/src/openvpn/dns.c</span><br><span>@@ -264,6 +264,7 @@</span><br=
><span>     clone.servers_prepull =3D clone_dns_servers(o-&gt;servers_prepu=
ll, gc);</span><br><span>     clone.updown =3D o-&gt;updown;</span><br><spa=
n>     clone.updown_flags =3D o-&gt;updown_flags;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    clone.from_dhcp =3D o-&gt;from_dhcp;</spa=
n><br><span> </span><br><span>     return clone;</span><br><span> }</span><=
br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/1181?usp=3Demail">change 1181</a>. To unsubscribe, or for=
 help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/sett=
ings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/Vie=
wAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/1181?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></di=
v></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I815e68dd5d365743faff2b80783=
b776d9e8a645c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1181 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--LebASciJ7zQ=--

