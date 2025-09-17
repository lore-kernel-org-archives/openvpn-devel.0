From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 17 Sep 2025 11:58:48 +0000
In-Reply-To: <gerrit.1758038466000.I28f856c1c156b54089d95b2e2539ecdb374cdd37@...2715...>
References: <gerrit.1758038466000.I28f856c1c156b54089d95b2e2539ecdb374cdd37@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, antonio@...2726...
Message-ID: <f5e0ffb6cdc98fc412847366d738bd78c8d03331-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="5JiNNqyjwLo="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dco: Change sd
 argument to dco_new_peer from int to socket_descriptor_t
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--5JiNNqyjwLo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello ordex, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1195?usp=3Demail

to look at the new patch set (#2).

The change is no longer submittable: checks~ChecksSubmitRule is unsatisfied=
 now.


Change subject: dco: Change sd argument to dco_new_peer from int to socket_=
descriptor_t
......................................................................

dco: Change sd argument to dco_new_peer from int to socket_descriptor_t

Doesn't change anything for non-Win32 platforms.

Change-Id: I28f856c1c156b54089d95b2e2539ecdb374cdd37
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/dco.c
M src/openvpn/dco_internal.h
M src/openvpn/dco_win.c
3 files changed, 4 insertions(+), 13 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/95/1195/2

diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index 50c72c3..3429ab6 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -496,11 +496,6 @@
     return true;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 int
 dco_p2p_add_new_peer(struct context *c)
 {
@@ -609,7 +604,7 @@
     int peer_id =3D c->c2.tls_multi->peer_id;
     struct sockaddr *remoteaddr, *localaddr =3D NULL;
     struct sockaddr_storage local =3D { 0 };
-    int sd =3D c->c2.link_sockets[0]->sd;
+    const socket_descriptor_t sd =3D c->c2.link_sockets[0]->sd;


     if (c->mode =3D=3D CM_CHILD_TCP)
@@ -655,10 +650,6 @@
     return 0;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 void
 dco_install_iroute(struct multi_context *m, struct multi_instance *mi, str=
uct mroute_addr *addr)
 {
diff --git a/src/openvpn/dco_internal.h b/src/openvpn/dco_internal.h
index 83013ef..86af003 100644
--- a/src/openvpn/dco_internal.h
+++ b/src/openvpn/dco_internal.h
@@ -59,7 +59,7 @@
  * They are implemented by dco_linux.c
  */

-int dco_new_peer(dco_context_t *dco, unsigned int peerid, int sd, struct s=
ockaddr *localaddr,
+int dco_new_peer(dco_context_t *dco, unsigned int peerid, socket_descripto=
r_t sd, struct sockaddr *localaddr,
                  struct sockaddr *remoteaddr, struct in_addr *vpn_ipv4, st=
ruct in6_addr *vpn_ipv6);

 int dco_del_peer(dco_context_t *dco, unsigned int peerid);
diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index b7908a9..a86804b 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -420,10 +420,10 @@
 }

 int
-dco_new_peer(dco_context_t *dco, unsigned int peerid, int sd, struct socka=
ddr *localaddr,
+dco_new_peer(dco_context_t *dco, unsigned int peerid, socket_descriptor_t =
sd, struct sockaddr *localaddr,
              struct sockaddr *remoteaddr, struct in_addr *vpn_ipv4, struct=
 in6_addr *vpn_ipv6)
 {
-    msg(D_DCO_DEBUG, "%s: peer-id %d, fd %d", __func__, peerid, sd);
+    msg(D_DCO_DEBUG, "%s: peer-id %d, fd " SOCKET_PRINTF, __func__, peerid=
, sd);

     if (dco->ifmode =3D=3D DCO_MODE_P2P)
     {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1195?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I28f856c1c156b54089d95b2e2539ecdb374cdd37
Gerrit-Change-Number: 1195
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: ordex <antonio@...2726...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--5JiNNqyjwLo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #2</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1195?usp=3Demail">View C=
hange</a></p><p>The change is no longer submittable: checks~ChecksSubmitRul=
e is unsatisfied now.</p><pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;">dco: Change sd argument to dco_new_peer from int to s=
ocket_descriptor_t<br><br>Doesn&#39;t change anything for non-Win32 platfor=
ms.<br><br>Change-Id: I28f856c1c156b54089d95b2e2539ecdb374cdd37<br>Signed-o=
ff-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M src/openvpn/d=
co.c<br>M src/openvpn/dco_internal.h<br>M src/openvpn/dco_win.c<br>3 files =
changed, 4 insertions(+), 13 deletions(-)<br><br></pre><pre style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.o=
penvpn.net:29418/openvpn refs/changes/95/1195/2</pre><pre style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/op=
envpn/dco.c b/src/openvpn/dco.c</span><br><span>index 50c72c3..3429ab6 1006=
44</span><br><span>--- a/src/openvpn/dco.c</span><br><span>+++ b/src/openvp=
n/dco.c</span><br><span>@@ -496,11 +496,6 @@</span><br><span>     return tr=
ue;</span><br><span> }</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignor=
ed &quot;-Wconversion&quot;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span> int</span><br><span> dco_p2p_add_new_peer(struct context *c)</span=
><br><span> {</span><br><span>@@ -609,7 +604,7 @@</span><br><span>     int =
peer_id =3D c-&gt;c2.tls_multi-&gt;peer_id;</span><br><span>     struct soc=
kaddr *remoteaddr, *localaddr =3D NULL;</span><br><span>     struct sockadd=
r_storage local =3D { 0 };</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    int sd =3D c-&gt;c2.link_sockets[0]-&gt;sd;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const socket_descriptor_t sd =3D c-&g=
t;c2.link_sockets[0]-&gt;sd;</span><br><span> </span><br><span> </span><br>=
<span>     if (c-&gt;mode =3D=3D CM_CHILD_TCP)</span><br><span>@@ -655,10 +=
650,6 @@</span><br><span>     return 0;</span><br><span> }</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__=
) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span> void</span><br><span> dco_install_iroute(struct multi_context *m,=
 struct multi_instance *mi, struct mroute_addr *addr)</span><br><span> {</s=
pan><br><span>diff --git a/src/openvpn/dco_internal.h b/src/openvpn/dco_int=
ernal.h</span><br><span>index 83013ef..86af003 100644</span><br><span>--- a=
/src/openvpn/dco_internal.h</span><br><span>+++ b/src/openvpn/dco_internal.=
h</span><br><span>@@ -59,7 +59,7 @@</span><br><span>  * They are implemente=
d by dco_linux.c</span><br><span>  */</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-int dco_new_peer(dco_context_t *dco, unsi=
gned int peerid, int sd, struct sockaddr *localaddr,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+int dco_new_peer(dco_context_t *dco, unsi=
gned int peerid, socket_descriptor_t sd, struct sockaddr *localaddr,</span>=
<br><span>                  struct sockaddr *remoteaddr, struct in_addr *vp=
n_ipv4, struct in6_addr *vpn_ipv6);</span><br><span> </span><br><span> int =
dco_del_peer(dco_context_t *dco, unsigned int peerid);</span><br><span>diff=
 --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c</span><br><span>inde=
x b7908a9..a86804b 100644</span><br><span>--- a/src/openvpn/dco_win.c</span=
><br><span>+++ b/src/openvpn/dco_win.c</span><br><span>@@ -420,10 +420,10 @=
@</span><br><span> }</span><br><span> </span><br><span> int</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-dco_new_peer(dco_context_t *dco, unsi=
gned int peerid, int sd, struct sockaddr *localaddr,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+dco_new_peer(dco_context_t *dco, unsigned=
 int peerid, socket_descriptor_t sd, struct sockaddr *localaddr,</span><br>=
<span>              struct sockaddr *remoteaddr, struct in_addr *vpn_ipv4, =
struct in6_addr *vpn_ipv6)</span><br><span> {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    msg(D_DCO_DEBUG, &quot;%s: peer-id %d, fd %d&qu=
ot;, __func__, peerid, sd);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    msg(D_DCO_DEBUG, &quot;%s: peer-id %d, fd &quot; SOCKET_PRINTF,=
 __func__, peerid, sd);</span><br><span> </span><br><span>     if (dco-&gt;=
ifmode =3D=3D DCO_MODE_P2P)</span><br><span>     {</span><br><span></span><=
br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/1195?usp=3Demail">change 1195</a>. To unsubscribe, or for help writing mai=
l filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a=
>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div items=
cope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link it=
emprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1195?usp=3Dema=
il"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I28f856c1c156b54089d95b2e253=
9ecdb374cdd37 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1195 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;antonio@...2726...&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--5JiNNqyjwLo=--

