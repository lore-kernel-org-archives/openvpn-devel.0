From: "stipa (Code Review)" <gerrit@...515...>
Date: Wed, 25 Sep 2024 07:23:33 +0000
In-Reply-To: <gerrit.1727248983000.I101bbc9f682375ec733bca10b52da82f0abfec27@...2715...>
References: <gerrit.1727248983000.I101bbc9f682375ec733bca10b52da82f0abfec27@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <c0162c60adec98ea1bfd8fb0452f46a68fdcdf4c-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ZvjgJEyijkQ="; charset=UTF-8
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

--ZvjgJEyijkQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/769?usp=3Demail

to look at the new patch set (#2).


Change subject: dco: better naming for function parameters
......................................................................

dco: better naming for function parameters

Current naming (remote_in4/6) is confusing, since
those are in fact VPN IPv4/v4 addresses and not
related to remote at all.

Change-Id: I101bbc9f682375ec733bca10b52da82f0abfec27
Signed-off-by: Lev Stipakov <lev@...515...>
---
M src/openvpn/dco_freebsd.c
M src/openvpn/dco_internal.h
M src/openvpn/dco_linux.c
M src/openvpn/dco_win.c
4 files changed, 13 insertions(+), 13 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/69/769/2

diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index 9a90f5c..2f565a0 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -75,7 +75,7 @@
 int
 dco_new_peer(dco_context_t *dco, unsigned int peerid, int sd,
              struct sockaddr *localaddr, struct sockaddr *remoteaddr,
-             struct in_addr *remote_in4, struct in6_addr *remote_in6)
+             struct in_addr *vpn_in4, struct in6_addr *vpn_in6)
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
+        nvlist_add_binary(nvl, "vpn_ipv4", &vpn_in4->s_addr,
+                          sizeof(vpn_in4->s_addr));
     }

-    if (remote_in6)
+    if (vpn_in6)
     {
-        nvlist_add_binary(nvl, "vpn_ipv6", remote_in6, sizeof(*remote_in6)=
);
+        nvlist_add_binary(nvl, "vpn_ipv6", vpn_in6, sizeof(*vpn_in6));
     }

     nvlist_add_number(nvl, "fd", sd);
diff --git a/src/openvpn/dco_internal.h b/src/openvpn/dco_internal.h
index 624c110..240a6a4 100644
--- a/src/openvpn/dco_internal.h
+++ b/src/openvpn/dco_internal.h
@@ -62,7 +62,7 @@

 int dco_new_peer(dco_context_t *dco, unsigned int peerid, int sd,
                  struct sockaddr *localaddr, struct sockaddr *remoteaddr,
-                 struct in_addr *remote_in4, struct in6_addr *remote_in6);
+                 struct in_addr *vpn_in4, struct in6_addr *vpn_in6);

 int dco_del_peer(dco_context_t *dco, unsigned int peerid);

diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index 277cd64..b110896 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -220,7 +220,7 @@
 int
 dco_new_peer(dco_context_t *dco, unsigned int peerid, int sd,
              struct sockaddr *localaddr, struct sockaddr *remoteaddr,
-             struct in_addr *remote_in4, struct in6_addr *remote_in6)
+             struct in_addr *vpn_in4, struct in6_addr *vpn_in6)
 {
     struct gc_arena gc =3D gc_new();
     const char *remotestr =3D "[undefined]";
@@ -263,14 +263,14 @@
     }

     /* Set the primary VPN IP addresses of the peer */
-    if (remote_in4)
+    if (vpn_in4)
     {
-        NLA_PUT_U32(nl_msg, OVPN_NEW_PEER_ATTR_IPV4, remote_in4->s_addr);
+        NLA_PUT_U32(nl_msg, OVPN_NEW_PEER_ATTR_IPV4, vpn_in4->s_addr);
     }
-    if (remote_in6)
+    if (vpn_in6)
     {
         NLA_PUT(nl_msg, OVPN_NEW_PEER_ATTR_IPV6, sizeof(struct in6_addr),
-                remote_in6);
+                vpn_in6);
     }
     nla_nest_end(nl_msg, attr);

diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index 892c616..6a3476b 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -247,7 +247,7 @@
 int
 dco_new_peer(dco_context_t *dco, unsigned int peerid, int sd,
              struct sockaddr *localaddr, struct sockaddr *remoteaddr,
-             struct in_addr *remote_in4, struct in6_addr *remote_in6)
+             struct in_addr *vpn_in4, struct in6_addr *vpn_in6)
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
Gerrit-PatchSet: 2
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--ZvjgJEyijkQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>stipa <strong>uploaded patch set #2</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/769?usp=3Demail">View Change</a=
></p><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
">dco: better naming for function parameters<br><br>Current naming (remote_=
in4/6) is confusing, since<br>those are in fact VPN IPv4/v4 addresses and n=
ot<br>related to remote at all.<br><br>Change-Id: I101bbc9f682375ec733bca10=
b52da82f0abfec27<br>Signed-off-by: Lev Stipakov &lt;lev@...515...&gt;<br>--=
-<br>M src/openvpn/dco_freebsd.c<br>M src/openvpn/dco_internal.h<br>M src/o=
penvpn/dco_linux.c<br>M src/openvpn/dco_win.c<br>4 files changed, 13 insert=
ions(+), 13 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,=
monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/=
openvpn refs/changes/69/769/2</pre><pre style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/dco_freebsd.=
c b/src/openvpn/dco_freebsd.c</span><br><span>index 9a90f5c..2f565a0 100644=
</span><br><span>--- a/src/openvpn/dco_freebsd.c</span><br><span>+++ b/src/=
openvpn/dco_freebsd.c</span><br><span>@@ -75,7 +75,7 @@</span><br><span> in=
t</span><br><span> dco_new_peer(dco_context_t *dco, unsigned int peerid, in=
t sd,</span><br><span>              struct sockaddr *localaddr, struct sock=
addr *remoteaddr,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
         struct in_addr *remote_in4, struct in6_addr *remote_in6)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+             struct in_addr *=
vpn_in4, struct in6_addr *vpn_in6)</span><br><span> {</span><br><span>     =
struct ifdrv drv;</span><br><span>     nvlist_t *nvl;</span><br><span>@@ -9=
5,15 +95,15 @@</span><br><span>         nvlist_add_nvlist(nvl, &quot;remote=
&quot;, sockaddr_to_nvlist(remoteaddr));</span><br><span>     }</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (remote_=
in4)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (vpn_in4=
)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        nvlist_add_binary(nvl, &quot;vpn_ipv4&quot;, &amp;remote_in4-&gt=
;s_addr,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
             sizeof(remote_in4-&gt;s_addr));</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        nvlist_add_binary(nvl, &quot;vpn_ipv4&quot=
;, &amp;vpn_in4-&gt;s_addr,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                          sizeof(vpn_in4-&gt;s_addr));</span><br><s=
pan>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    if (remote_in6)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if (vpn_in6)</span><br><span>     {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        nvlist_add_binary(nvl, &quot;vpn_ipv6&quot=
;, remote_in6, sizeof(*remote_in6));</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        nvlist_add_binary(nvl, &quot;vpn_ipv6&quot;, vpn_i=
n6, sizeof(*vpn_in6));</span><br><span>     }</span><br><span> </span><br><=
span>     nvlist_add_number(nvl, &quot;fd&quot;, sd);</span><br><span>diff =
--git a/src/openvpn/dco_internal.h b/src/openvpn/dco_internal.h</span><br><=
span>index 624c110..240a6a4 100644</span><br><span>--- a/src/openvpn/dco_in=
ternal.h</span><br><span>+++ b/src/openvpn/dco_internal.h</span><br><span>@=
@ -62,7 +62,7 @@</span><br><span> </span><br><span> int dco_new_peer(dco_co=
ntext_t *dco, unsigned int peerid, int sd,</span><br><span>                =
  struct sockaddr *localaddr, struct sockaddr *remoteaddr,</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                 struct in_addr *remot=
e_in4, struct in6_addr *remote_in6);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                 struct in_addr *vpn_in4, struct in6_addr =
*vpn_in6);</span><br><span> </span><br><span> int dco_del_peer(dco_context_=
t *dco, unsigned int peerid);</span><br><span> </span><br><span>diff --git =
a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c</span><br><span>index 2=
77cd64..b110896 100644</span><br><span>--- a/src/openvpn/dco_linux.c</span>=
<br><span>+++ b/src/openvpn/dco_linux.c</span><br><span>@@ -220,7 +220,7 @@=
</span><br><span> int</span><br><span> dco_new_peer(dco_context_t *dco, uns=
igned int peerid, int sd,</span><br><span>              struct sockaddr *lo=
caladdr, struct sockaddr *remoteaddr,</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-             struct in_addr *remote_in4, struct in6_addr *r=
emote_in6)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
    struct in_addr *vpn_in4, struct in6_addr *vpn_in6)</span><br><span> {</=
span><br><span>     struct gc_arena gc =3D gc_new();</span><br><span>     c=
onst char *remotestr =3D &quot;[undefined]&quot;;</span><br><span>@@ -263,1=
4 +263,14 @@</span><br><span>     }</span><br><span> </span><br><span>     =
/* Set the primary VPN IP addresses of the peer */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    if (remote_in4)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if (vpn_in4)</span><br><span>     {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        NLA_PUT_U32(nl_msg, =
OVPN_NEW_PEER_ATTR_IPV4, remote_in4-&gt;s_addr);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        NLA_PUT_U32(nl_msg, OVPN_NEW_PEER_ATTR=
_IPV4, vpn_in4-&gt;s_addr);</span><br><span>     }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    if (remote_in6)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if (vpn_in6)</span><br><span>     {</span>=
<br><span>         NLA_PUT(nl_msg, OVPN_NEW_PEER_ATTR_IPV6, sizeof(struct i=
n6_addr),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
    remote_in6);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
             vpn_in6);</span><br><span>     }</span><br><span>     nla_nest=
_end(nl_msg, attr);</span><br><span> </span><br><span>diff --git a/src/open=
vpn/dco_win.c b/src/openvpn/dco_win.c</span><br><span>index 892c616..6a3476=
b 100644</span><br><span>--- a/src/openvpn/dco_win.c</span><br><span>+++ b/=
src/openvpn/dco_win.c</span><br><span>@@ -247,7 +247,7 @@</span><br><span> =
int</span><br><span> dco_new_peer(dco_context_t *dco, unsigned int peerid, =
int sd,</span><br><span>              struct sockaddr *localaddr, struct so=
ckaddr *remoteaddr,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
           struct in_addr *remote_in4, struct in6_addr *remote_in6)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+             struct in_addr=
 *vpn_in4, struct in6_addr *vpn_in6)</span><br><span> {</span><br><span>   =
  msg(D_DCO_DEBUG, &quot;%s: peer-id %d, fd %d&quot;, __func__, peerid, sd)=
;</span><br><span>     return 0;</span><br><span></span><br></pre><p>To vie=
w, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/769?usp=3Demail">=
change 769</a>. To unsubscribe, or for help writing mail filters, visit <a =
href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope=
 itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"act=
ion" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/769?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I101bbc9f682375ec733bca10b52=
da82f0abfec27 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 769 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
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
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--ZvjgJEyijkQ=--

