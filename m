From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Thu, 17 Oct 2024 14:47:28 +0000
In-Reply-To: <gerrit.1727098847000.I705fd9bf9298a54560eca12e3797351f4af321a7@...2715...>
References: <gerrit.1727098847000.I705fd9bf9298a54560eca12e3797351f4af321a7@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641..., a@...2181...
Message-ID: <3330175e8be7262681e2610a66b23884f6ca5f40-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="9eoHrfueocE="; charset=UTF-8
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

--9eoHrfueocE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, ordex, plaisthos.

Hello flichtenheld, ordex, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/761?usp=3Demail

to look at the new patch set (#5).


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
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
---
M src/openvpn/socket.c
1 file changed, 10 insertions(+), 2 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/61/761/5

diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index b7d80ee..2b55021 100644
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
Gerrit-PatchSet: 5
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: ordex <a@...2181...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: ordex <a@...2181...>
Gerrit-MessageType: newpatchset

--9eoHrfueocE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, ordex, plaisthos. <=
/p>
<p>its_Giaan <strong>uploaded patch set #5</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/761?usp=3Demail">View Chang=
e</a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">if a local IPv6 address is provided, socket must be v6-only<br><br>If=
 we want to use a wildcard IPv6 socket (i.e ::port), it<br>must be separate=
 from an IPv4 wildcard socket.<br>To do this, we need to set a specific fla=
g when passing<br>&#39;::&#39; to &#39;--local&#39; otherwise the second so=
cket won&#39;t be<br>able to bind properly.<br><br>Change-Id: I705fd9bf9298=
a54560eca12e3797351f4af321a7<br>Signed-off-by: Antonio Quartulli &lt;a@...1665...=
181...&gt;<br>Signed-off-by: Gianmarco De Gregori &lt;gianmarco@...2726...&=
gt;<br>---<br>M src/openvpn/socket.c<br>1 file changed, 10 insertions(+), 2=
 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn ref=
s/changes/61/761/5</pre><pre style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;"><span>diff --git a/src/openvpn/socket.c b/src/openvpn/=
socket.c</span><br><span>index b7d80ee..2b55021 100644</span><br><span>--- =
a/src/openvpn/socket.c</span><br><span>+++ b/src/openvpn/socket.c</span><br=
><span>@@ -1111,9 +1111,17 @@</span><br><span>         }</span><br><span>  =
       else</span><br><span>         {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            bool v6only =3D sock-&gt;info.bind_ipv6_only=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            /* force binding IPv6-onl=
y if an address was specified</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+             * and it is a IPv6 */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            if (sock-&gt;local_host &amp;&amp; ai_=
family =3D=3D AF_INET6)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
              v6only =3D true;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span>             socket_bind(sock-&gt;sd, sock-&gt;info.l=
sa-&gt;bind_local,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
                     ai_family,</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                        &quot;TCP/UDP&quot;, sock-&gt;info.bind_i=
pv6_only);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
               ai_family, &quot;TCP/UDP&quot;, v6only);</span><br><span>   =
      }</span><br><span>     }</span><br><span> }</span><br><span></span><b=
r></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
761?usp=3Demail">change 761</a>. To unsubscribe, or for help writing mail f=
ilters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.<=
/p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemp=
rop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/761?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I705fd9bf9298a54560eca12e379=
7351f4af321a7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 761 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;a@...2181...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;a@...2181...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--9eoHrfueocE=--

