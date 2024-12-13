From: "ordex (Code Review)" <gerrit@...515...>
Date: Fri, 13 Dec 2024 17:09:31 +0000
References: <gerrit.1734109769000.I76e2e616c6ffe436a9627fa71aaace74030b2f4a@...2715...>
Reply-To: a@...2181..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <ef088f4d459f0badb62893055dacc51d12013a28-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="GD1FJMW3gyA="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: dco: pass
 remoteaddr only for UDP peers
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

--GD1FJMW3gyA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/842?usp=3Demail

to review the following change.


Change subject: dco: pass remoteaddr only for UDP peers
......................................................................

dco: pass remoteaddr only for UDP peers

TCP connected sockets do not need any remote addr
because the destination is fixed.
For this reason we can avoid sending the remote addr
along the peer-new dco call.

This change is important on Linux because the new 'ovpn'
kernel module is stricter when it comes to accepting
netlink messages and will reject calls with TCP sockets
if a remote address is specified.

Change-Id: I76e2e616c6ffe436a9627fa71aaace74030b2f4a
Signed-off-by: Antonio Quartulli <antonio@...2726...>
---
M src/openvpn/dco.c
1 file changed, 3 insertions(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/42/842/1

diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index dcc80d3..b1a3715 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -494,7 +494,9 @@
     }
 #endif
     int ret =3D dco_new_peer(&c->c1.tuntap->dco, multi->peer_id,
-                           c->c2.link_socket->sd, NULL, remoteaddr, NULL, =
NULL);
+                           c->c2.link_socket->sd, NULL,
+                           proto_is_dgram(ls->info.proto) ? remoteaddr : N=
ULL,
+                           NULL, NULL);
     if (ret < 0)
     {
         return ret;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/842?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I76e2e616c6ffe436a9627fa71aaace74030b2f4a
Gerrit-Change-Number: 842
Gerrit-PatchSet: 1
Gerrit-Owner: ordex <a@...2181...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--GD1FJMW3gyA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>ordex would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/842?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">dco: pass remoteaddr only for UDP peers<br><br>TCP connected =
sockets do not need any remote addr<br>because the destination is fixed.<br=
>For this reason we can avoid sending the remote addr<br>along the peer-new=
 dco call.<br><br>This change is important on Linux because the new &#39;ov=
pn&#39;<br>kernel module is stricter when it comes to accepting<br>netlink =
messages and will reject calls with TCP sockets<br>if a remote address is s=
pecified.<br><br>Change-Id: I76e2e616c6ffe436a9627fa71aaace74030b2f4a<br>Si=
gned-off-by: Antonio Quartulli &lt;antonio@...2726...&gt;<br>---<br>M src/o=
penvpn/dco.c<br>1 file changed, 3 insertions(+), 1 deletion(-)<br><br></pre=
><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">gi=
t pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/42/842/1</pre><p=
re style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span=
>diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c</span><br><span>index d=
cc80d3..b1a3715 100644</span><br><span>--- a/src/openvpn/dco.c</span><br><s=
pan>+++ b/src/openvpn/dco.c</span><br><span>@@ -494,7 +494,9 @@</span><br><=
span>     }</span><br><span> #endif</span><br><span>     int ret =3D dco_ne=
w_peer(&amp;c-&gt;c1.tuntap-&gt;dco, multi-&gt;peer_id,</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                           c-&gt;c2.link_=
socket-&gt;sd, NULL, remoteaddr, NULL, NULL);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                           c-&gt;c2.link_socket-&=
gt;sd, NULL,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
                    proto_is_dgram(ls-&gt;info.proto) ? remoteaddr : NULL,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
       NULL, NULL);</span><br><span>     if (ret &lt; 0)</span><br><span>  =
   {</span><br><span>         return ret;</span><br><span></span><br></pre>=
<p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/842?usp=
=3Demail">change 842</a>. To unsubscribe, or for help writing mail filters,=
 visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div=
 itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/842?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I76e2e616c6ffe436a9627fa71aa=
ace74030b2f4a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 842 </div>
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


--GD1FJMW3gyA=--

