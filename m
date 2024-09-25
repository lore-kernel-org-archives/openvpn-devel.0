From: "stipa (Code Review)" <gerrit@...515...>
Date: Wed, 25 Sep 2024 08:06:31 +0000
In-Reply-To: <gerrit.1727248983000.I101bbc9f682375ec733bca10b52da82f0abfec27@...2715...>
References: <gerrit.1727248983000.I101bbc9f682375ec733bca10b52da82f0abfec27@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641..., a@...2181...
Message-ID: <231069fab071bfe87d8bc4628ae5d779bb9e5bab-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="DehJgr4BwXA="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--DehJgr4BwXA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, ordex, plaisthos, stipa.

Hello flichtenheld, ordex, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/769?usp=3Demail

to look at the new patch set (#3).

The following approvals got outdated and were removed:
Code-Review-1 by ordex


Change subject: dco: better naming for function parameters
......................................................................

dco: better naming for function parameters

Current naming (remote_in4/6) is confusing, since
those are in fact VPN IPv4/v6 addresses and not
related to remote at all.

Change-Id: I101bbc9f682375ec733bca10b52da82f0abfec27
Signed-off-by: Lev Stipakov <lev@...515...>
---
M src/openvpn/dco_freebsd.c
M src/openvpn/dco_internal.h
M src/openvpn/dco_linux.c
M src/openvpn/dco_win.c
4 files changed, 13 insertions(+), 13 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/69/769/3

diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index 9a90f5c..d15c9ca 100644
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
+    if (vpn_in4)
     {
-        nvlist_add_binary(nvl, "vpn_ipv4", &remote_in4->s_addr,
-                          sizeof(remote_in4->s_addr));
+        nvlist_add_binary(nvl, "vpn_ipv4", &vpn_ipv4->s_addr,
+                          sizeof(vpn_ipv4->s_addr));
     }

-    if (remote_in6)
+    if (vpn_in6)
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
Gerrit-PatchSet: 3
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: ordex <a@...2181...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: ordex <a@...2181...>
Gerrit-Attention: stipa <lstipakov@...277...>
Gerrit-MessageType: newpatchset

--DehJgr4BwXA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, ordex, plaisthos, s=
tipa. </p>
<p>stipa <strong>uploaded patch set #3</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/769?usp=3Demail">View Change</a=
></p><p>The following approvals got outdated and were removed:
Code-Review-1 by ordex</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">dco: better naming for function parameters<br><br>Cu=
rrent naming (remote_in4/6) is confusing, since<br>those are in fact VPN IP=
v4/v6 addresses and not<br>related to remote at all.<br><br>Change-Id: I101=
bbc9f682375ec733bca10b52da82f0abfec27<br>Signed-off-by: Lev Stipakov &lt;le=
v@...515...&gt;<br>---<br>M src/openvpn/dco_freebsd.c<br>M src/openvpn/dco_=
internal.h<br>M src/openvpn/dco_linux.c<br>M src/openvpn/dco_win.c<br>4 fil=
es changed, 13 insertions(+), 13 deletions(-)<br><br></pre><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerr=
it.openvpn.net:29418/openvpn refs/changes/69/769/3</pre><pre style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src=
/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c</span><br><span>index 9a=
90f5c..d15c9ca 100644</span><br><span>--- a/src/openvpn/dco_freebsd.c</span=
><br><span>+++ b/src/openvpn/dco_freebsd.c</span><br><span>@@ -75,7 +75,7 @=
@</span><br><span> int</span><br><span> dco_new_peer(dco_context_t *dco, un=
signed int peerid, int sd,</span><br><span>              struct sockaddr *l=
ocaladdr, struct sockaddr *remoteaddr,</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-             struct in_addr *remote_in4, struct in6_addr *=
remote_in6)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
     struct in_addr *vpn_ipv4, struct in6_addr *vpn_ipv6)</span><br><span> =
{</span><br><span>     struct ifdrv drv;</span><br><span>     nvlist_t *nvl=
;</span><br><span>@@ -95,15 +95,15 @@</span><br><span>         nvlist_add_n=
vlist(nvl, &quot;remote&quot;, sockaddr_to_nvlist(remoteaddr));</span><br><=
span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    if (remote_in4)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    if (vpn_in4)</span><br><span>     {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        nvlist_add_binary(nvl, &quot;vpn_ipv4&quo=
t;, &amp;remote_in4-&gt;s_addr,</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                          sizeof(remote_in4-&gt;s_addr));</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        nvlist_add_binary(n=
vl, &quot;vpn_ipv4&quot;, &amp;vpn_ipv4-&gt;s_addr,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                          sizeof(vpn_ipv4=
-&gt;s_addr));</span><br><span>     }</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    if (remote_in6)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (vpn_in6)</span><br><span>     {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        nvlist_add_bina=
ry(nvl, &quot;vpn_ipv6&quot;, remote_in6, sizeof(*remote_in6));</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        nvlist_add_binary(nvl, =
&quot;vpn_ipv6&quot;, vpn_ipv6, sizeof(*vpn_ipv6));</span><br><span>     }<=
/span><br><span> </span><br><span>     nvlist_add_number(nvl, &quot;fd&quot=
;, sd);</span><br><span>diff --git a/src/openvpn/dco_internal.h b/src/openv=
pn/dco_internal.h</span><br><span>index 624c110..4bbcc82 100644</span><br><=
span>--- a/src/openvpn/dco_internal.h</span><br><span>+++ b/src/openvpn/dco=
_internal.h</span><br><span>@@ -62,7 +62,7 @@</span><br><span> </span><br><=
span> int dco_new_peer(dco_context_t *dco, unsigned int peerid, int sd,</sp=
an><br><span>                  struct sockaddr *localaddr, struct sockaddr =
*remoteaddr,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
        struct in_addr *remote_in4, struct in6_addr *remote_in6);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                 struct in_ad=
dr *vpn_ipv4, struct in6_addr *vpn_ipv6);</span><br><span> </span><br><span=
> int dco_del_peer(dco_context_t *dco, unsigned int peerid);</span><br><spa=
n> </span><br><span>diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_=
linux.c</span><br><span>index 277cd64..b038382 100644</span><br><span>--- a=
/src/openvpn/dco_linux.c</span><br><span>+++ b/src/openvpn/dco_linux.c</spa=
n><br><span>@@ -220,7 +220,7 @@</span><br><span> int</span><br><span> dco_n=
ew_peer(dco_context_t *dco, unsigned int peerid, int sd,</span><br><span>  =
            struct sockaddr *localaddr, struct sockaddr *remoteaddr,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-             struct in_addr =
*remote_in4, struct in6_addr *remote_in6)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+             struct in_addr *vpn_ipv4, struct in6_add=
r *vpn_ipv6)</span><br><span> {</span><br><span>     struct gc_arena gc =3D=
 gc_new();</span><br><span>     const char *remotestr =3D &quot;[undefined]=
&quot;;</span><br><span>@@ -263,14 +263,14 @@</span><br><span>     }</span>=
<br><span> </span><br><span>     /* Set the primary VPN IP addresses of the=
 peer */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (remot=
e_in4)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (vpn_i=
pv4)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        NLA_PUT_U32(nl_msg, OVPN_NEW_PEER_ATTR_IPV4, remote_in4-&gt;s=
_addr);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        NLA_=
PUT_U32(nl_msg, OVPN_NEW_PEER_ATTR_IPV4, vpn_ipv4-&gt;s_addr);</span><br><s=
pan>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (rem=
ote_in6)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (vpn=
_ipv6)</span><br><span>     {</span><br><span>         NLA_PUT(nl_msg, OVPN=
_NEW_PEER_ATTR_IPV6, sizeof(struct in6_addr),</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                remote_in6);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                vpn_ipv6);</span><br><spa=
n>     }</span><br><span>     nla_nest_end(nl_msg, attr);</span><br><span> =
</span><br><span>diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c=
</span><br><span>index 892c616..9224bca 100644</span><br><span>--- a/src/op=
envpn/dco_win.c</span><br><span>+++ b/src/openvpn/dco_win.c</span><br><span=
>@@ -247,7 +247,7 @@</span><br><span> int</span><br><span> dco_new_peer(dco=
_context_t *dco, unsigned int peerid, int sd,</span><br><span>             =
 struct sockaddr *localaddr, struct sockaddr *remoteaddr,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-             struct in_addr *remote_in4=
, struct in6_addr *remote_in6)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+             struct in_addr *vpn_ipv4, struct in6_addr *vpn_ipv6=
)</span><br><span> {</span><br><span>     msg(D_DCO_DEBUG, &quot;%s: peer-i=
d %d, fd %d&quot;, __func__, peerid, sd);</span><br><span>     return 0;</s=
pan><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.o=
penvpn.net/c/openvpn/+/769?usp=3Demail">change 769</a>. To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/s=
ettings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Emai=
lMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/=
ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/769?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></=
div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I101bbc9f682375ec733bca10b52=
da82f0abfec27 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 769 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
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
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;a@...2181...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--DehJgr4BwXA=--

