From: "ordex (Code Review)" <gerrit@...515...>
Date: Wed, 15 Nov 2023 13:45:12 +0000
References: <gerrit.1700055887000.I7a3349c7de4202b5eb2f576e3f8a82a9af6f7f31@...2715...>
Reply-To: a@...2181..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <66f4e0fa28801d0720f6992c646f3d790c2cfeb3-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="7/YDTVBIsOA="; charset=UTF-8
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

--7/YDTVBIsOA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/435?usp=3Demail

to review the following change.


Change subject: if a local IPv6 address is provided, socket must be v6-only
......................................................................

if a local IPv6 address is provided, socket must be v6-only

Change-Id: I7a3349c7de4202b5eb2f576e3f8a82a9af6f7f31
Signed-off-by: Antonio Quartulli <a@...2181...>
---
M src/openvpn/socket.c
1 file changed, 8 insertions(+), 2 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/35/435/1

diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index f2bd624..17bd263 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -1108,9 +1108,15 @@
         }
         else
         {
+            bool v6only =3D sock->info.bind_ipv6_only;
+
+            /* force binding IPv6-only if an address was specified
+             * an it is a IPv6 */
+            if (sock->local_host && ai_family =3D=3D AF_INET6)
+                v6only =3D true;
+
             socket_bind(sock->sd, sock->info.lsa->bind_local,
-                        ai_family,
-                        "TCP/UDP", sock->info.bind_ipv6_only);
+                        ai_family, "TCP/UDP", v6only);
         }
     }
 }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/435?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7a3349c7de4202b5eb2f576e3f8a82a9af6f7f31
Gerrit-Change-Number: 435
Gerrit-PatchSet: 1
Gerrit-Owner: ordex <a@...2181...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--7/YDTVBIsOA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>ordex would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/435?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">if a local IPv6 address is provided, socket must be v6-only<b=
r><br>Change-Id: I7a3349c7de4202b5eb2f576e3f8a82a9af6f7f31<br>Signed-off-by=
: Antonio Quartulli &lt;a@...2181...&gt;<br>---<br>M src/openvpn/socket.c<b=
r>1 file changed, 8 insertions(+), 2 deletions(-)<br><br></pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit.openvpn.net:29418/openvpn refs/changes/35/435/1</pre><pre style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git=
 a/src/openvpn/socket.c b/src/openvpn/socket.c</span><br><span>index f2bd62=
4..17bd263 100644</span><br><span>--- a/src/openvpn/socket.c</span><br><spa=
n>+++ b/src/openvpn/socket.c</span><br><span>@@ -1108,9 +1108,15 @@</span><=
br><span>         }</span><br><span>         else</span><br><span>         =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            bool v=
6only =3D sock-&gt;info.bind_ipv6_only;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            /* force binding IPv6-only if an address was specified</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+             * an it is a I=
Pv6 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            i=
f (sock-&gt;local_host &amp;&amp; ai_family =3D=3D AF_INET6)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                v6only =3D true;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>    =
         socket_bind(sock-&gt;sd, sock-&gt;info.lsa-&gt;bind_local,</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                        ai_fa=
mily,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
        &quot;TCP/UDP&quot;, sock-&gt;info.bind_ipv6_only);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                        ai_family, =
&quot;TCP/UDP&quot;, v6only);</span><br><span>         }</span><br><span>  =
   }</span><br><span> }</span><br><span></span><br></pre><p>To view, visit =
<a href=3D"http://gerrit.openvpn.net/c/openvpn/+/435?usp=3Demail">change 43=
5</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"h=
ttp://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/435?usp=3Demail"/><meta itemprop=3D"name" c=
ontent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7a3349c7de4202b5eb2f576e3f8=
a82a9af6f7f31 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 435 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;a@...2181...&gt; </div>
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


--7/YDTVBIsOA=--

