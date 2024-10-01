From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Tue, 1 Oct 2024 15:30:04 +0000
In-Reply-To: <gerrit.1727098847000.I705fd9bf9298a54560eca12e3797351f4af321a7@...2715...>
References: <gerrit.1727098847000.I705fd9bf9298a54560eca12e3797351f4af321a7@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641..., a@...2181...
Message-ID: <44d555ce6a9a938f022c559696e8bd6afeec7073-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="2tMfbONl9D0="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: if a local IPv6
 address is provided, socket must be v6-only
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

--2tMfbONl9D0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, its_Giaan, plaisthos.

Hello flichtenheld, ordex, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/761?usp=3Demail

to look at the new patch set (#2).

The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld


Change subject: if a local IPv6 address is provided, socket must be v6-only
......................................................................

if a local IPv6 address is provided, socket must be v6-only

If we want to use a wildcard IPv6 socket (i.e ::port), it
must be separate from an IPv4 wildcard socket.
To do this, we need to set a specific flag when passing
'::' to '--local' otherwise the second socket won't be
able to bind properly.

Change-Id: I705fd9bf9298a54560eca12e3797351f4af321a7
Signed-off-by: Antonio Quartulli <a@...2181...>
---
M src/openvpn/socket.c
1 file changed, 10 insertions(+), 2 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/61/761/2

diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 1e48d9a..8677472 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -1111,9 +1111,17 @@
         }
         else
         {
+            bool v6only =3D sock->info.bind_ipv6_only;
+
+            /* force binding IPv6-only if an address was specified
+             * and it is a IPv6 */
+            if (sock->local_host && ai_family =3D=3D AF_INET6)
+            {
+                v6only =3D true;
+            }
+
             socket_bind(sock->sd, sock->info.lsa->bind_local,
-                        ai_family,
-                        "TCP/UDP", sock->info.bind_ipv6_only);
+                        ai_family, "TCP/UDP", v6only);
         }
     }
 }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/761?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I705fd9bf9298a54560eca12e3797351f4af321a7
Gerrit-Change-Number: 761
Gerrit-PatchSet: 2
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: ordex <a@...2181...>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: its_Giaan <gianmarco@...2726...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--2tMfbONl9D0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, its_Giaan, plaistho=
s. </p>
<p>its_Giaan <strong>uploaded patch set #2</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/761?usp=3Demail">View Chang=
e</a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">if a local IPv6 address is provided, socket m=
ust be v6-only<br><br>If we want to use a wildcard IPv6 socket (i.e ::port)=
, it<br>must be separate from an IPv4 wildcard socket.<br>To do this, we ne=
ed to set a specific flag when passing<br>&#39;::&#39; to &#39;--local&#39;=
 otherwise the second socket won&#39;t be<br>able to bind properly.<br><br>=
Change-Id: I705fd9bf9298a54560eca12e3797351f4af321a7<br>Signed-off-by: Anto=
nio Quartulli &lt;a@...2181...&gt;<br>---<br>M src/openvpn/socket.c<br>1 fi=
le changed, 10 insertions(+), 2 deletions(-)<br><br></pre><pre style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerri=
t.openvpn.net:29418/openvpn refs/changes/61/761/2</pre><pre style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/=
openvpn/socket.c b/src/openvpn/socket.c</span><br><span>index 1e48d9a..8677=
472 100644</span><br><span>--- a/src/openvpn/socket.c</span><br><span>+++ b=
/src/openvpn/socket.c</span><br><span>@@ -1111,9 +1111,17 @@</span><br><spa=
n>         }</span><br><span>         else</span><br><span>         {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            bool v6only =
=3D sock-&gt;info.bind_ipv6_only;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       /* force binding IPv6-only if an address was specified</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+             * and it is a IPv6 *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (so=
ck-&gt;local_host &amp;&amp; ai_family =3D=3D AF_INET6)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                v6only =3D true;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span>             socket_b=
ind(sock-&gt;sd, sock-&gt;info.lsa-&gt;bind_local,</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                        ai_family,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                        &quot;TCP=
/UDP&quot;, sock-&gt;info.bind_ipv6_only);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                        ai_family, &quot;TCP/UDP&quo=
t;, v6only);</span><br><span>         }</span><br><span>     }</span><br><s=
pan> }</span><br><span></span><br></pre><p>To view, visit <a href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/761?usp=3Demail">change 761</a>. To unsubsc=
ribe, or for help writing mail filters, visit <a href=3D"http://gerrit.open=
vpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema=
.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sc=
hema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/761?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Ch=
ange"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I705fd9bf9298a54560eca12e379=
7351f4af321a7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 761 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-CC: ordex &lt;a@...2181...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: its_Giaan &lt;gianmarco@...1665...=
726...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--2tMfbONl9D0=--

