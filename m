From: "ralf_lici (Code Review)" <gerrit@...515...>
Date: Mon, 9 Sep 2024 13:54:50 +0000
References: <gerrit.1725890088000.I5adbe0a79f078221c4bb5f3d39391a81b4d8adce@...2715...>
Reply-To: ralf@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <e644c50fcd50e137d1f35ca7cf3ab9f2b1444f19-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="5tA5bABuMU0="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Fix
 check_addr_clash argument order
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

--5tA5bABuMU0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/737?usp=3Demail

to review the following change.


Change subject: Fix check_addr_clash argument order
......................................................................

Fix check_addr_clash argument order

In init_tun() make sure to pass the --local and --remote addresses in
the host order so that they can be compared to the --ifconfig addresses.

Change-Id: I5adbe0a79f078221c4bb5f3d39391a81b4d8adce
Signed-off-by: Ralf Lici <ralf@...2726...>
---
M src/openvpn/tun.c
1 file changed, 4 insertions(+), 2 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/37/737/1

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 739e008..1cd6ad2 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -877,9 +877,10 @@
             {
                 if (curele->ai_family =3D=3D AF_INET)
                 {
+                    const in_addr_t local =3D ntohl(((struct sockaddr_in *=
)curele->ai_addr)->sin_addr.s_addr);
                     check_addr_clash("local",
                                      tt->type,
-                                     ((struct sockaddr_in *)curele->ai_add=
r)->sin_addr.s_addr,
+                                     local,
                                      tt->local,
                                      tt->remote_netmask);
                 }
@@ -889,9 +890,10 @@
             {
                 if (curele->ai_family =3D=3D AF_INET)
                 {
+                    const in_addr_t remote =3D ntohl(((struct sockaddr_in =
*)curele->ai_addr)->sin_addr.s_addr);
                     check_addr_clash("remote",
                                      tt->type,
-                                     ((struct sockaddr_in *)curele->ai_add=
r)->sin_addr.s_addr,
+                                     remote,
                                      tt->local,
                                      tt->remote_netmask);
                 }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/737?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I5adbe0a79f078221c4bb5f3d39391a81b4d8adce
Gerrit-Change-Number: 737
Gerrit-PatchSet: 1
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--5tA5bABuMU0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>ralf_lici would like plaisthos and flichtenheld to <strong>review</stron=
g> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/737?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Fix check_addr_clash argument order<br><br>In init_tun() make=
 sure to pass the --local and --remote addresses in<br>the host order so th=
at they can be compared to the --ifconfig addresses.<br><br>Change-Id: I5ad=
be0a79f078221c4bb5f3d39391a81b4d8adce<br>Signed-off-by: Ralf Lici &lt;ralf@=
...2726...&gt;<br>---<br>M src/openvpn/tun.c<br>1 file changed, 4 insertion=
s(+), 2 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/open=
vpn refs/changes/37/737/1</pre><pre style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;"><span>diff --git a/src/openvpn/tun.c b/src/open=
vpn/tun.c</span><br><span>index 739e008..1cd6ad2 100644</span><br><span>---=
 a/src/openvpn/tun.c</span><br><span>+++ b/src/openvpn/tun.c</span><br><spa=
n>@@ -877,9 +877,10 @@</span><br><span>             {</span><br><span>     =
            if (curele-&gt;ai_family =3D=3D AF_INET)</span><br><span>      =
           {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
             const in_addr_t local =3D ntohl(((struct sockaddr_in *)curele-=
&gt;ai_addr)-&gt;sin_addr.s_addr);</span><br><span>                     che=
ck_addr_clash(&quot;local&quot;,</span><br><span>                          =
            tt-&gt;type,</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                                     ((struct sockaddr_in *)curele-&gt;a=
i_addr)-&gt;sin_addr.s_addr,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                                     local,</span><br><span>      =
                                tt-&gt;local,</span><br><span>             =
                         tt-&gt;remote_netmask);</span><br><span>          =
       }</span><br><span>@@ -889,9 +890,10 @@</span><br><span>             =
{</span><br><span>                 if (curele-&gt;ai_family =3D=3D AF_INET)=
</span><br><span>                 {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                    const in_addr_t remote =3D ntohl(((stru=
ct sockaddr_in *)curele-&gt;ai_addr)-&gt;sin_addr.s_addr);</span><br><span>=
                     check_addr_clash(&quot;remote&quot;,</span><br><span> =
                                     tt-&gt;type,</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                                     ((struct s=
ockaddr_in *)curele-&gt;ai_addr)-&gt;sin_addr.s_addr,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                     remo=
te,</span><br><span>                                      tt-&gt;local,</sp=
an><br><span>                                      tt-&gt;remote_netmask);<=
/span><br><span>                 }</span><br><span></span><br></pre><p>To v=
iew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/737?usp=3Demail=
">change 737</a>. To unsubscribe, or for help writing mail filters, visit <=
a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemsco=
pe itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"a=
ction" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" hre=
f=3D"http://gerrit.openvpn.net/c/openvpn/+/737?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I5adbe0a79f078221c4bb5f3d393=
91a81b4d8adce </div>
<div style=3D"display:none"> Gerrit-Change-Number: 737 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ralf@...2726...&gt=
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


--5tA5bABuMU0=--

