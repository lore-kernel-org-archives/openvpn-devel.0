From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 27 Sep 2024 16:49:59 +0000
In-Reply-To: <gerrit.1727248983000.I101bbc9f682375ec733bca10b52da82f0abfec27@...2715...>
References: <gerrit.1727248983000.I101bbc9f682375ec733bca10b52da82f0abfec27@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277..., a@...2181...
Message-ID: <560aba46e23399b31ca47d5cd8764383469bafa0-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="seLwgF7xauI="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dco: better naming
 for function parameters
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: stipa <lstipakov@...277...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--seLwgF7xauI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/76=
9?usp=3Demail )

Change subject: dco: better naming for function parameters
......................................................................

dco: better naming for function parameters

Current naming (remote_in4/6) is confusing, since
those are in fact VPN IPv4/v6 addresses and not
related to remote at all.

Change-Id: I101bbc9f682375ec733bca10b52da82f0abfec27
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Antonio Quartulli <a@...2181...>
Message-Id: <20240927093045.22753-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29=
460.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/dco_freebsd.c
M src/openvpn/dco_internal.h
M src/openvpn/dco_linux.c
M src/openvpn/dco_win.c
4 files changed, 13 insertions(+), 13 deletions(-)




diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index 9a90f5c..c92e42a 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -75,7 +75,7 @@
 int
 dco_new_peer(dco_context_t *dco, unsigned int peerid, int sd,
              struct sockaddr *localaddr, struct sockaddr *remoteaddr,
-             struct in_addr *remote_in4, struct in6_addr *remote_in6)
+             struct in_addr *vpn_ipv4, struct in6_addr *vpn_ipv6)
 {
     struct ifdrv drv;
     nvlist_t *nvl;
@@ -95,15 +95,15 @@
         nvlist_add_nvlist(nvl, "remote", sockaddr_to_nvlist(remoteaddr));
     }

-    if (remote_in4)
+    if (vpn_ipv4)
     {
-        nvlist_add_binary(nvl, "vpn_ipv4", &remote_in4->s_addr,
-                          sizeof(remote_in4->s_addr));
+        nvlist_add_binary(nvl, "vpn_ipv4", &vpn_ipv4->s_addr,
+                          sizeof(vpn_ipv4->s_addr));
     }

-    if (remote_in6)
+    if (vpn_ipv6)
     {
-        nvlist_add_binary(nvl, "vpn_ipv6", remote_in6, sizeof(*remote_in6)=
);
+        nvlist_add_binary(nvl, "vpn_ipv6", vpn_ipv6, sizeof(*vpn_ipv6));
     }

     nvlist_add_number(nvl, "fd", sd);
diff --git a/src/openvpn/dco_internal.h b/src/openvpn/dco_internal.h
index 624c110..4bbcc82 100644
--- a/src/openvpn/dco_internal.h
+++ b/src/openvpn/dco_internal.h
@@ -62,7 +62,7 @@

 int dco_new_peer(dco_context_t *dco, unsigned int peerid, int sd,
                  struct sockaddr *localaddr, struct sockaddr *remoteaddr,
-                 struct in_addr *remote_in4, struct in6_addr *remote_in6);
+                 struct in_addr *vpn_ipv4, struct in6_addr *vpn_ipv6);

 int dco_del_peer(dco_context_t *dco, unsigned int peerid);

diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index 277cd64..b038382 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -220,7 +220,7 @@
 int
 dco_new_peer(dco_context_t *dco, unsigned int peerid, int sd,
              struct sockaddr *localaddr, struct sockaddr *remoteaddr,
-             struct in_addr *remote_in4, struct in6_addr *remote_in6)
+             struct in_addr *vpn_ipv4, struct in6_addr *vpn_ipv6)
 {
     struct gc_arena gc =3D gc_new();
     const char *remotestr =3D "[undefined]";
@@ -263,14 +263,14 @@
     }

     /* Set the primary VPN IP addresses of the peer */
-    if (remote_in4)
+    if (vpn_ipv4)
     {
-        NLA_PUT_U32(nl_msg, OVPN_NEW_PEER_ATTR_IPV4, remote_in4->s_addr);
+        NLA_PUT_U32(nl_msg, OVPN_NEW_PEER_ATTR_IPV4, vpn_ipv4->s_addr);
     }
-    if (remote_in6)
+    if (vpn_ipv6)
     {
         NLA_PUT(nl_msg, OVPN_NEW_PEER_ATTR_IPV6, sizeof(struct in6_addr),
-                remote_in6);
+                vpn_ipv6);
     }
     nla_nest_end(nl_msg, attr);

diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index 892c616..9224bca 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -247,7 +247,7 @@
 int
 dco_new_peer(dco_context_t *dco, unsigned int peerid, int sd,
              struct sockaddr *localaddr, struct sockaddr *remoteaddr,
-             struct in_addr *remote_in4, struct in6_addr *remote_in6)
+             struct in_addr *vpn_ipv4, struct in6_addr *vpn_ipv6)
 {
     msg(D_DCO_DEBUG, "%s: peer-id %d, fd %d", __func__, peerid, sd);
     return 0;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/769?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I101bbc9f682375ec733bca10b52da82f0abfec27
Gerrit-Change-Number: 769
Gerrit-PatchSet: 5
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: ordex <a@...2181...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--seLwgF7xauI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/769?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">dco: better naming for function parameters<br>=
<br>Current naming (remote_in4/6) is confusing, since<br>those are in fact =
VPN IPv4/v6 addresses and not<br>related to remote at all.<br><br>Change-Id=
: I101bbc9f682375ec733bca10b52da82f0abfec27<br>Signed-off-by: Lev Stipakov =
&lt;lev@...515...&gt;<br>Acked-by: Antonio Quartulli &lt;a@...2181...&gt;<b=
r>Message-Id: &lt;20240927093045.22753-1-frank@...2641...&gt;<br>URL: https=
://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29460.html<b=
r>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openv=
pn/dco_freebsd.c<br>M src/openvpn/dco_internal.h<br>M src/openvpn/dco_linux=
.c<br>M src/openvpn/dco_win.c<br>4 files changed, 13 insertions(+), 13 dele=
tions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c</span=
><br><span>index 9a90f5c..c92e42a 100644</span><br><span>--- a/src/openvpn/=
dco_freebsd.c</span><br><span>+++ b/src/openvpn/dco_freebsd.c</span><br><sp=
an>@@ -75,7 +75,7 @@</span><br><span> int</span><br><span> dco_new_peer(dco=
_context_t *dco, unsigned int peerid, int sd,</span><br><span>             =
 struct sockaddr *localaddr, struct sockaddr *remoteaddr,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-             struct in_addr *remote_in4=
, struct in6_addr *remote_in6)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+             struct in_addr *vpn_ipv4, struct in6_addr *vpn_ipv6=
)</span><br><span> {</span><br><span>     struct ifdrv drv;</span><br><span=
>     nvlist_t *nvl;</span><br><span>@@ -95,15 +95,15 @@</span><br><span>  =
       nvlist_add_nvlist(nvl, &quot;remote&quot;, sockaddr_to_nvlist(remote=
addr));</span><br><span>     }</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    if (remote_in4)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (vpn_ipv4)</span><br><span>     {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        nvlist_add_binary(nvl=
, &quot;vpn_ipv4&quot;, &amp;remote_in4-&gt;s_addr,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                          sizeof(remote_in4=
-&gt;s_addr));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   nvlist_add_binary(nvl, &quot;vpn_ipv4&quot;, &amp;vpn_ipv4-&gt;s_addr,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
     sizeof(vpn_ipv4-&gt;s_addr));</span><br><span>     }</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (remote_in6)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (vpn_ipv6)</sp=
an><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      nvlist_add_binary(nvl, &quot;vpn_ipv6&quot;, remote_in6, sizeof(*remo=
te_in6));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        nv=
list_add_binary(nvl, &quot;vpn_ipv6&quot;, vpn_ipv6, sizeof(*vpn_ipv6));</s=
pan><br><span>     }</span><br><span> </span><br><span>     nvlist_add_numb=
er(nvl, &quot;fd&quot;, sd);</span><br><span>diff --git a/src/openvpn/dco_i=
nternal.h b/src/openvpn/dco_internal.h</span><br><span>index 624c110..4bbcc=
82 100644</span><br><span>--- a/src/openvpn/dco_internal.h</span><br><span>=
+++ b/src/openvpn/dco_internal.h</span><br><span>@@ -62,7 +62,7 @@</span><b=
r><span> </span><br><span> int dco_new_peer(dco_context_t *dco, unsigned in=
t peerid, int sd,</span><br><span>                  struct sockaddr *locala=
ddr, struct sockaddr *remoteaddr,</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                 struct in_addr *remote_in4, struct in6_addr *r=
emote_in6);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
         struct in_addr *vpn_ipv4, struct in6_addr *vpn_ipv6);</span><br><s=
pan> </span><br><span> int dco_del_peer(dco_context_t *dco, unsigned int pe=
erid);</span><br><span> </span><br><span>diff --git a/src/openvpn/dco_linux=
.c b/src/openvpn/dco_linux.c</span><br><span>index 277cd64..b038382 100644<=
/span><br><span>--- a/src/openvpn/dco_linux.c</span><br><span>+++ b/src/ope=
nvpn/dco_linux.c</span><br><span>@@ -220,7 +220,7 @@</span><br><span> int</=
span><br><span> dco_new_peer(dco_context_t *dco, unsigned int peerid, int s=
d,</span><br><span>              struct sockaddr *localaddr, struct sockadd=
r *remoteaddr,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
      struct in_addr *remote_in4, struct in6_addr *remote_in6)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+             struct in_addr *vpn=
_ipv4, struct in6_addr *vpn_ipv6)</span><br><span> {</span><br><span>     s=
truct gc_arena gc =3D gc_new();</span><br><span>     const char *remotestr =
=3D &quot;[undefined]&quot;;</span><br><span>@@ -263,14 +263,14 @@</span><b=
r><span>     }</span><br><span> </span><br><span>     /* Set the primary VP=
N IP addresses of the peer */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    if (remote_in4)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    if (vpn_ipv4)</span><br><span>     {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        NLA_PUT_U32(nl_msg, OVPN_NEW_PEER_ATTR_I=
PV4, remote_in4-&gt;s_addr);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        NLA_PUT_U32(nl_msg, OVPN_NEW_PEER_ATTR_IPV4, vpn_ipv4-&gt;=
s_addr);</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    if (remote_in6)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if (vpn_ipv6)</span><br><span>     {</span><br><span>        =
 NLA_PUT(nl_msg, OVPN_NEW_PEER_ATTR_IPV6, sizeof(struct in6_addr),</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                remote_in6);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                vpn_i=
pv6);</span><br><span>     }</span><br><span>     nla_nest_end(nl_msg, attr=
);</span><br><span> </span><br><span>diff --git a/src/openvpn/dco_win.c b/s=
rc/openvpn/dco_win.c</span><br><span>index 892c616..9224bca 100644</span><b=
r><span>--- a/src/openvpn/dco_win.c</span><br><span>+++ b/src/openvpn/dco_w=
in.c</span><br><span>@@ -247,7 +247,7 @@</span><br><span> int</span><br><sp=
an> dco_new_peer(dco_context_t *dco, unsigned int peerid, int sd,</span><br=
><span>              struct sockaddr *localaddr, struct sockaddr *remoteadd=
r,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             struct=
 in_addr *remote_in4, struct in6_addr *remote_in6)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+             struct in_addr *vpn_ipv4, struc=
t in6_addr *vpn_ipv6)</span><br><span> {</span><br><span>     msg(D_DCO_DEB=
UG, &quot;%s: peer-id %d, fd %d&quot;, __func__, peerid, sd);</span><br><sp=
an>     return 0;</span><br><span></span><br></pre><p>To view, visit <a hre=
f=3D"http://gerrit.openvpn.net/c/openvpn/+/769?usp=3Demail">change 769</a>.=
 To unsubscribe, or for help writing mail filters, visit <a href=3D"http://=
gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"ht=
tp://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/769?usp=3Demail"/><meta itemprop=3D"name" conte=
nt=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I101bbc9f682375ec733bca10b52=
da82f0abfec27 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 769 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;a@...2181...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--seLwgF7xauI=--

