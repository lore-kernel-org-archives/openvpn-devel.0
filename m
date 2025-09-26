From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 26 Sep 2025 20:53:15 +0000
In-Reply-To: <gerrit.1758038466000.I28f856c1c156b54089d95b2e2539ecdb374cdd37@...2715...>
References: <gerrit.1758038466000.I28f856c1c156b54089d95b2e2539ecdb374cdd37@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 antonio@...2726...
Message-ID: <0f5e245ca760c28c532edf57edf2500a53083340-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="4eDLmak1VOI="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--4eDLmak1VOI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/11=
95?usp=3Demail )

Change subject: dco: Change sd argument to dco_new_peer from int to socket_=
descriptor_t
......................................................................

dco: Change sd argument to dco_new_peer from int to socket_descriptor_t

Doesn't change anything for non-Win32 platforms.

Change-Id: I28f856c1c156b54089d95b2e2539ecdb374cdd37
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Antonio Quartulli <antonio@...2726...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1195
Message-Id: <20250924151044.50567-1-frank@...2641...>
URL: https://sourceforge.net/p/openvpn/mailman/message/59238248/
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/dco.c
M src/openvpn/dco_internal.h
M src/openvpn/dco_win.c
3 files changed, 4 insertions(+), 13 deletions(-)




diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index 2cf90af..6afc680 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -491,11 +491,6 @@
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
@@ -604,7 +599,7 @@
     int peer_id =3D c->c2.tls_multi->peer_id;
     struct sockaddr *remoteaddr, *localaddr =3D NULL;
     struct sockaddr_storage local =3D { 0 };
-    int sd =3D c->c2.link_sockets[0]->sd;
+    const socket_descriptor_t sd =3D c->c2.link_sockets[0]->sd;

=20
     if (c->mode =3D=3D CM_CHILD_TCP)
@@ -650,10 +645,6 @@
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
index 7dd43d6..4dd307f 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -415,10 +415,10 @@
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
Gerrit-PatchSet: 8
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: ordex <antonio@...2726...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--4eDLmak1VOI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1195?usp=3Demail">View Change</a></p><div styl=
e=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">dco: Change sd argument to dco_new_peer from =
int to socket_descriptor_t<br><br>Doesn&#39;t change anything for non-Win32=
 platforms.<br><br>Change-Id: I28f856c1c156b54089d95b2e2539ecdb374cdd37<br>=
Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Anto=
nio Quartulli &lt;antonio@...2726...&gt;<br>Gerrit URL: https://gerrit.open=
vpn.net/c/openvpn/+/1195<br>Message-Id: &lt;20250924151044.50567-1-frank@...1186...=
.2641...&gt;<br>URL: https://sourceforge.net/p/openvpn/mailman/message/5923=
8248/<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M sr=
c/openvpn/dco.c<br>M src/openvpn/dco_internal.h<br>M src/openvpn/dco_win.c<=
br>3 files changed, 4 insertions(+), 13 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c</span><br><span>index=
 2cf90af..6afc680 100644</span><br><span>--- a/src/openvpn/dco.c</span><br>=
<span>+++ b/src/openvpn/dco.c</span><br><span>@@ -491,11 +491,6 @@</span><b=
r><span>     return true;</span><br><span> }</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(_=
_clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC =
diagnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragm=
a GCC diagnostic ignored &quot;-Wconversion&quot;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span> int</span><br><span> dco_p2p_add_new_peer(st=
ruct context *c)</span><br><span> {</span><br><span>@@ -604,7 +599,7 @@</sp=
an><br><span>     int peer_id =3D c-&gt;c2.tls_multi-&gt;peer_id;</span><br=
><span>     struct sockaddr *remoteaddr, *localaddr =3D NULL;</span><br><sp=
an>     struct sockaddr_storage local =3D { 0 };</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    int sd =3D c-&gt;c2.link_sockets[0]-&gt;sd;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const socket_des=
criptor_t sd =3D c-&gt;c2.link_sockets[0]-&gt;sd;</span><br><span> </span><=
br><span> </span><br><span>     if (c-&gt;mode =3D=3D CM_CHILD_TCP)</span><=
br><span>@@ -650,10 +645,6 @@</span><br><span>     return 0;</span><br><spa=
n> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span> void</span><br><span> dco_install_iroute(str=
uct multi_context *m, struct multi_instance *mi, struct mroute_addr *addr)<=
/span><br><span> {</span><br><span>diff --git a/src/openvpn/dco_internal.h =
b/src/openvpn/dco_internal.h</span><br><span>index 83013ef..86af003 100644<=
/span><br><span>--- a/src/openvpn/dco_internal.h</span><br><span>+++ b/src/=
openvpn/dco_internal.h</span><br><span>@@ -59,7 +59,7 @@</span><br><span>  =
* They are implemented by dco_linux.c</span><br><span>  */</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-int dco_new_peer(dco=
_context_t *dco, unsigned int peerid, int sd, struct sockaddr *localaddr,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+int dco_new_peer(dco_=
context_t *dco, unsigned int peerid, socket_descriptor_t sd, struct sockadd=
r *localaddr,</span><br><span>                  struct sockaddr *remoteaddr=
, struct in_addr *vpn_ipv4, struct in6_addr *vpn_ipv6);</span><br><span> </=
span><br><span> int dco_del_peer(dco_context_t *dco, unsigned int peerid);<=
/span><br><span>diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c<=
/span><br><span>index 7dd43d6..4dd307f 100644</span><br><span>--- a/src/ope=
nvpn/dco_win.c</span><br><span>+++ b/src/openvpn/dco_win.c</span><br><span>=
@@ -415,10 +415,10 @@</span><br><span> }</span><br><span> </span><br><span>=
 int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_new_peer(dco_=
context_t *dco, unsigned int peerid, int sd, struct sockaddr *localaddr,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_new_peer(dco_conte=
xt_t *dco, unsigned int peerid, socket_descriptor_t sd, struct sockaddr *lo=
caladdr,</span><br><span>              struct sockaddr *remoteaddr, struct =
in_addr *vpn_ipv4, struct in6_addr *vpn_ipv6)</span><br><span> {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_DCO_DEBUG, &quot;%s: p=
eer-id %d, fd %d&quot;, __func__, peerid, sd);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    msg(D_DCO_DEBUG, &quot;%s: peer-id %d, fd &q=
uot; SOCKET_PRINTF, __func__, peerid, sd);</span><br><span> </span><br><spa=
n>     if (dco-&gt;ifmode =3D=3D DCO_MODE_P2P)</span><br><span>     {</span=
><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/1195?usp=3Demail">change 1195</a>. To unsubscribe, or f=
or help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/se=
ttings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Email=
Message"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/V=
iewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/1195?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></=
div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I28f856c1c156b54089d95b2e253=
9ecdb374cdd37 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1195 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 8 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;antonio@...2726...&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--4eDLmak1VOI=--

