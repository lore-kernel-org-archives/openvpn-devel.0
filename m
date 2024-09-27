From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 27 Sep 2024 16:49:56 +0000
In-Reply-To: <gerrit.1727248983000.I101bbc9f682375ec733bca10b52da82f0abfec27@...2715...>
References: <gerrit.1727248983000.I101bbc9f682375ec733bca10b52da82f0abfec27@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277..., a@...2181...
Message-ID: <560aba46e23399b31ca47d5cd8764383469bafa0-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="6+1XIcoy7o4="; charset=UTF-8
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
To: stipa <lstipakov@...277...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--6+1XIcoy7o4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#5) to the change originally created by=
 stipa. ( http://gerrit.openvpn.net/c/openvpn/+/769?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by ordex


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/69/769/5

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
Gerrit-MessageType: newpatchset

--6+1XIcoy7o4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #5</strong> to the change originally cr=
eated by stipa.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/769?=
usp=3Demail">View Change</a></p><p>The following approvals got outdated and=
 were removed:
Code-Review+2 by ordex</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">dco: better naming for function parameters<br><br>Cu=
rrent naming (remote_in4/6) is confusing, since<br>those are in fact VPN IP=
v4/v6 addresses and not<br>related to remote at all.<br><br>Change-Id: I101=
bbc9f682375ec733bca10b52da82f0abfec27<br>Signed-off-by: Lev Stipakov &lt;le=
v@...515...&gt;<br>Acked-by: Antonio Quartulli &lt;a@...2181...&gt;<br>Mess=
age-Id: &lt;20240927093045.22753-1-frank@...2641...&gt;<br>URL: https://www=
.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29460.html<br>Sign=
ed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/dco=
_freebsd.c<br>M src/openvpn/dco_internal.h<br>M src/openvpn/dco_linux.c<br>=
M src/openvpn/dco_win.c<br>4 files changed, 13 insertions(+), 13 deletions(=
-)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/6=
9/769/5</pre><pre style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;"><span>diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_fr=
eebsd.c</span><br><span>index 9a90f5c..c92e42a 100644</span><br><span>--- a=
/src/openvpn/dco_freebsd.c</span><br><span>+++ b/src/openvpn/dco_freebsd.c<=
/span><br><span>@@ -75,7 +75,7 @@</span><br><span> int</span><br><span> dco=
_new_peer(dco_context_t *dco, unsigned int peerid, int sd,</span><br><span>=
              struct sockaddr *localaddr, struct sockaddr *remoteaddr,</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-             struct in_add=
r *remote_in4, struct in6_addr *remote_in6)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+             struct in_addr *vpn_ipv4, struct in6_a=
ddr *vpn_ipv6)</span><br><span> {</span><br><span>     struct ifdrv drv;</s=
pan><br><span>     nvlist_t *nvl;</span><br><span>@@ -95,15 +95,15 @@</span=
><br><span>         nvlist_add_nvlist(nvl, &quot;remote&quot;, sockaddr_to_=
nvlist(remoteaddr));</span><br><span>     }</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    if (remote_in4)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if (vpn_ipv4)</span><br><span> =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        nvlist_a=
dd_binary(nvl, &quot;vpn_ipv4&quot;, &amp;remote_in4-&gt;s_addr,</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                          sizeof=
(remote_in4-&gt;s_addr));</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        nvlist_add_binary(nvl, &quot;vpn_ipv4&quot;, &amp;vpn_ipv4-&g=
t;s_addr,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
                sizeof(vpn_ipv4-&gt;s_addr));</span><br><span>     }</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (re=
mote_in6)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (vp=
n_ipv6)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        nvlist_add_binary(nvl, &quot;vpn_ipv6&quot;, remote_in6, s=
izeof(*remote_in6));</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        nvlist_add_binary(nvl, &quot;vpn_ipv6&quot;, vpn_ipv6, sizeof(*vpn=
_ipv6));</span><br><span>     }</span><br><span> </span><br><span>     nvli=
st_add_number(nvl, &quot;fd&quot;, sd);</span><br><span>diff --git a/src/op=
envpn/dco_internal.h b/src/openvpn/dco_internal.h</span><br><span>index 624=
c110..4bbcc82 100644</span><br><span>--- a/src/openvpn/dco_internal.h</span=
><br><span>+++ b/src/openvpn/dco_internal.h</span><br><span>@@ -62,7 +62,7 =
@@</span><br><span> </span><br><span> int dco_new_peer(dco_context_t *dco, =
unsigned int peerid, int sd,</span><br><span>                  struct socka=
ddr *localaddr, struct sockaddr *remoteaddr,</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                 struct in_addr *remote_in4, struct =
in6_addr *remote_in6);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                 struct in_addr *vpn_ipv4, struct in6_addr *vpn_ipv6);</=
span><br><span> </span><br><span> int dco_del_peer(dco_context_t *dco, unsi=
gned int peerid);</span><br><span> </span><br><span>diff --git a/src/openvp=
n/dco_linux.c b/src/openvpn/dco_linux.c</span><br><span>index 277cd64..b038=
382 100644</span><br><span>--- a/src/openvpn/dco_linux.c</span><br><span>++=
+ b/src/openvpn/dco_linux.c</span><br><span>@@ -220,7 +220,7 @@</span><br><=
span> int</span><br><span> dco_new_peer(dco_context_t *dco, unsigned int pe=
erid, int sd,</span><br><span>              struct sockaddr *localaddr, str=
uct sockaddr *remoteaddr,</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-             struct in_addr *remote_in4, struct in6_addr *remote_in6)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+             struct i=
n_addr *vpn_ipv4, struct in6_addr *vpn_ipv6)</span><br><span> {</span><br><=
span>     struct gc_arena gc =3D gc_new();</span><br><span>     const char =
*remotestr =3D &quot;[undefined]&quot;;</span><br><span>@@ -263,14 +263,14 =
@@</span><br><span>     }</span><br><span> </span><br><span>     /* Set the=
 primary VPN IP addresses of the peer */</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    if (remote_in4)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    if (vpn_ipv4)</span><br><span>     {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        NLA_PUT_U32(nl_msg, OVPN_NEW_=
PEER_ATTR_IPV4, remote_in4-&gt;s_addr);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        NLA_PUT_U32(nl_msg, OVPN_NEW_PEER_ATTR_IPV4, vp=
n_ipv4-&gt;s_addr);</span><br><span>     }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    if (remote_in6)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    if (vpn_ipv6)</span><br><span>     {</span><br><sp=
an>         NLA_PUT(nl_msg, OVPN_NEW_PEER_ATTR_IPV6, sizeof(struct in6_addr=
),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                rem=
ote_in6);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      vpn_ipv6);</span><br><span>     }</span><br><span>     nla_nest_end(n=
l_msg, attr);</span><br><span> </span><br><span>diff --git a/src/openvpn/dc=
o_win.c b/src/openvpn/dco_win.c</span><br><span>index 892c616..9224bca 1006=
44</span><br><span>--- a/src/openvpn/dco_win.c</span><br><span>+++ b/src/op=
envpn/dco_win.c</span><br><span>@@ -247,7 +247,7 @@</span><br><span> int</s=
pan><br><span> dco_new_peer(dco_context_t *dco, unsigned int peerid, int sd=
,</span><br><span>              struct sockaddr *localaddr, struct sockaddr=
 *remoteaddr,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
     struct in_addr *remote_in4, struct in6_addr *remote_in6)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+             struct in_addr *vpn_=
ipv4, struct in6_addr *vpn_ipv6)</span><br><span> {</span><br><span>     ms=
g(D_DCO_DEBUG, &quot;%s: peer-id %d, fd %d&quot;, __func__, peerid, sd);</s=
pan><br><span>     return 0;</span><br><span></span><br></pre><p>To view, v=
isit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/769?usp=3Demail">chan=
ge 769</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope ite=
mtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/769?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--6+1XIcoy7o4=--

