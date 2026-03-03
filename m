From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 3 Mar 2026 16:47:40 +0000
In-Reply-To: <gerrit.1768578994000.I7be7427480d3540d43dd818eddb6eb5860956459@...2715...>
References: <gerrit.1768578994000.I7be7427480d3540d43dd818eddb6eb5860956459@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <bb3e52296204c21aab1b586ac2aa60015706b680-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="hWpanwhRc58="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: socket: Fix various
 conversion warnings
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

--hWpanwhRc58=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1476?usp=3Demail

to look at the new patch set (#7).


Change subject: socket: Fix various conversion warnings
......................................................................

socket: Fix various conversion warnings

- We assume that addrinfo->ai_family always fits
  into a sa_family_t, so we do not check those.
- Reduce places where we explicitly pass ai_family
  and prefer sock->info.af.
- Make sure that --bind-dev has a suitable length.
- Treat PROTO_* as uint8_t where possible (however,
  much code uses proto =3D -1 for various error handling).

Change-Id: I7be7427480d3540d43dd818eddb6eb5860956459
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/options.c
M src/openvpn/socket.c
M src/openvpn/socket_util.c
3 files changed, 30 insertions(+), 40 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/76/1476/7

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index fdbc678..e1c62bd 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -6492,7 +6492,15 @@
     else if (streq(p[0], "bind-dev") && p[1])
     {
         VERIFY_PERMISSION(OPT_P_SOCKFLAGS);
-        options->bind_dev =3D p[1];
+        if (strlen(p[1]) <=3D IFNAMSIZ)
+        {
+            options->bind_dev =3D p[1];
+        }
+        else
+        {
+            msg(msglevel, "argument to --bind-dev is longer than allowed %=
u", IFNAMSIZ);
+            goto err;
+        }
     }
 #endif
     else if (streq(p[0], "txqueuelen") && p[1] && !p[2])
@@ -6578,11 +6586,9 @@
     }
     else if (streq(p[0], "proto") && p[1] && !p[2])
     {
-        int proto;
-        sa_family_t af;
         VERIFY_PERMISSION(OPT_P_GENERAL | OPT_P_CONNECTION);
-        proto =3D ascii2proto(p[1]);
-        af =3D ascii2af(p[1]);
+        int proto =3D ascii2proto(p[1]);
+        sa_family_t af =3D ascii2af(p[1]);
         if (proto < 0)
         {
             msg(msglevel, "Bad protocol: '%s'. Allowed protocols with --pr=
oto option: %s", p[1],
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 0b72684..33c12db 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -649,28 +649,23 @@
 }

 static void
-bind_local(struct link_socket *sock, const sa_family_t ai_family)
+bind_local(struct link_socket *sock)
 {
     /* bind to local address/port */
     if (sock->bind_local)
     {
         if (sock->socks_proxy && sock->info.proto =3D=3D PROTO_UDP)
         {
-            socket_bind(sock->ctrl_sd, sock->info.lsa->bind_local, ai_fami=
ly, "SOCKS", false);
+            socket_bind(sock->ctrl_sd, sock->info.lsa->bind_local, sock->i=
nfo.af, "SOCKS", false);
         }
         else
         {
-            socket_bind(sock->sd, sock->info.lsa->bind_local, ai_family, "=
TCP/UDP",
+            socket_bind(sock->sd, sock->info.lsa->bind_local, sock->info.a=
f, "TCP/UDP",
                         sock->info.bind_ipv6_only);
         }
     }
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 static void
 create_socket(struct link_socket *sock, struct addrinfo *addr)
 {
@@ -702,7 +697,7 @@
     }
     /* Set af field of sock->info, so it always reflects the address family
      * of the created socket */
-    sock->info.af =3D addr->ai_family;
+    sock->info.af =3D (sa_family_t)addr->ai_family;

     /* set socket buffers based on --sndbuf and --rcvbuf options */
     socket_set_buffers(sock->sd, &sock->socket_buffer_sizes, true);
@@ -714,8 +709,9 @@
     if (sock->bind_dev)
     {
         msg(M_INFO, "Using bind-dev %s", sock->bind_dev);
+        /* Note: We verify strlen of bind_dev in options parsing */
         if (setsockopt(sock->sd, SOL_SOCKET, SO_BINDTODEVICE, sock->bind_d=
ev,
-                       strlen(sock->bind_dev) + 1)
+                       (socklen_t)(strlen(sock->bind_dev) + 1))
             !=3D 0)
         {
             msg(M_WARN | M_ERRNO, "WARN: setsockopt SO_BINDTODEVICE=3D%s f=
ailed", sock->bind_dev);
@@ -723,13 +719,9 @@
     }
 #endif

-    bind_local(sock, addr->ai_family);
+    bind_local(sock);
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 #ifdef TARGET_ANDROID
 static void
 protect_fd_nonlocal(int fd, const struct sockaddr *addr)
@@ -1161,13 +1153,8 @@
     }
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 static void
-resolve_bind_local(struct link_socket *sock, const sa_family_t af)
+resolve_bind_local(struct link_socket *sock)
 {
     struct gc_arena gc =3D gc_new();

@@ -1183,12 +1170,12 @@
         }

         /* will return AF_{INET|INET6}from local_host */
-        status =3D get_cached_dns_entry(sock->dns_cache, sock->local_host,=
 sock->local_port, af,
+        status =3D get_cached_dns_entry(sock->dns_cache, sock->local_host,=
 sock->local_port, sock->info.af,
                                       flags, &sock->info.lsa->bind_local);

         if (status)
         {
-            status =3D openvpn_getaddrinfo(flags, sock->local_host, sock->=
local_port, 0, NULL, af,
+            status =3D openvpn_getaddrinfo(flags, sock->local_host, sock->=
local_port, 0, NULL, sock->info.af,
                                          &sock->info.lsa->bind_local);
         }

@@ -1209,7 +1196,7 @@
             /* the resolved 'local entry' might have a different family th=
an
              * what was globally configured
              */
-            sock->info.af =3D sock->info.lsa->bind_local->ai_family;
+            sock->info.af =3D (sa_family_t)sock->info.lsa->bind_local->ai_=
family;
         }
     }

@@ -1405,7 +1392,8 @@

     sock->mark =3D o->mark;
     sock->bind_dev =3D o->bind_dev;
-    sock->info.proto =3D proto;
+    ASSERT(proto >=3D 0 && proto < PROTO_N);
+    sock->info.proto =3D (uint8_t)proto;
     sock->info.af =3D o->ce.af;
     sock->info.remote_float =3D o->ce.remote_float;
     sock->info.lsa =3D &c->c1.link_socket_addrs[sock_index];
@@ -1471,7 +1459,7 @@
     {
         if (sock->bind_local)
         {
-            resolve_bind_local(sock, sock->info.af);
+            resolve_bind_local(sock);
         }
         resolve_remote(sock, 1, NULL);
     }
@@ -1732,9 +1720,9 @@
              * and we should not connect a remote */
             if (sock->info.af =3D=3D AF_UNSPEC)
             {
+                sock->info.af =3D (sa_family_t)sock->info.lsa->bind_local-=
>ai_family;
                 msg(M_WARN, "Could not determine IPv4/IPv6 protocol. Using=
 %s",
-                    addr_family_name(sock->info.lsa->bind_local->ai_family=
));
-                sock->info.af =3D sock->info.lsa->bind_local->ai_family;
+                    addr_family_name(sock->info.af));
             }
             create_socket(sock, sock->info.lsa->bind_local);
         }
@@ -1794,10 +1782,6 @@
     }
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 void
 link_socket_close(struct link_socket *sock)
 {
@@ -2374,8 +2358,8 @@
     else if (cmsg !=3D NULL)
     {
         msg(M_WARN,
-            "CMSG received that cannot be parsed (cmsg_level=3D%d, cmsg_ty=
pe=3D%d, cmsg=3Dlen=3D%d)",
-            (int)cmsg->cmsg_level, (int)cmsg->cmsg_type, (int)cmsg->cmsg_l=
en);
+            "CMSG received that cannot be parsed (cmsg_level=3D%d, cmsg_ty=
pe=3D%d, cmsg=3Dlen=3D%zu)",
+            cmsg->cmsg_level, cmsg->cmsg_type, (size_t)cmsg->cmsg_len);
     }

     return buf->len;
diff --git a/src/openvpn/socket_util.c b/src/openvpn/socket_util.c
index 0194f38..913ac69 100644
--- a/src/openvpn/socket_util.c
+++ b/src/openvpn/socket_util.c
@@ -356,7 +356,7 @@
     const char *short_form;
     const char *display_form;
     sa_family_t proto_af;
-    int proto;
+    uint8_t proto;
 };

 /* Indexed by PROTO_x */

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1476?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7be7427480d3540d43dd818eddb6eb5860956459
Gerrit-Change-Number: 1476
Gerrit-PatchSet: 7
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--hWpanwhRc58=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #7</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1476?usp=3Demail">View C=
hange</a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">socket: Fix various conversion warnings<br><br>-=
 We assume that addrinfo-&gt;ai_family always fits<br>  into a sa_family_t,=
 so we do not check those.<br>- Reduce places where we explicitly pass ai_f=
amily<br>  and prefer sock-&gt;info.af.<br>- Make sure that --bind-dev has =
a suitable length.<br>- Treat PROTO_* as uint8_t where possible (however,<b=
r>  much code uses proto =3D -1 for various error handling).<br><br>Change-=
Id: I7be7427480d3540d43dd818eddb6eb5860956459<br>Signed-off-by: Frank Licht=
enheld &lt;frank@...2641...&gt;<br>---<br>M src/openvpn/options.c<br>M src/=
openvpn/socket.c<br>M src/openvpn/socket_util.c<br>3 files changed, 30 inse=
rtions(+), 40 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font=
-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=
.openvpn.net:29418/openvpn refs/changes/76/1476/7</pre><pre style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/=
openvpn/options.c b/src/openvpn/options.c</span><br><span>index fdbc678..e1=
c62bd 100644</span><br><span>--- a/src/openvpn/options.c</span><br><span>++=
+ b/src/openvpn/options.c</span><br><span>@@ -6492,7 +6492,15 @@</span><br>=
<span>     else if (streq(p[0], &quot;bind-dev&quot;) &amp;&amp; p[1])</spa=
n><br><span>     {</span><br><span>         VERIFY_PERMISSION(OPT_P_SOCKFLA=
GS);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        options-&=
gt;bind_dev =3D p[1];</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        if (strlen(p[1]) &lt;=3D IFNAMSIZ)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            options-&gt;bind_dev =3D p[1];</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        else</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            msg(msglevel, &quot;argument to --bind-dev is longer=
 than allowed %u&quot;, IFNAMSIZ);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            goto err;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        }</span><br><span>     }</span><br><span> #endif</=
span><br><span>     else if (streq(p[0], &quot;txqueuelen&quot;) &amp;&amp;=
 p[1] &amp;&amp; !p[2])</span><br><span>@@ -6578,11 +6586,9 @@</span><br><s=
pan>     }</span><br><span>     else if (streq(p[0], &quot;proto&quot;) &am=
p;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        int proto;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        sa_family_t af;</span><br><span>      =
   VERIFY_PERMISSION(OPT_P_GENERAL | OPT_P_CONNECTION);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        proto =3D ascii2proto(p[1]);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        af =3D ascii2af(p[=
1]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        int pro=
to =3D ascii2proto(p[1]);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        sa_family_t af =3D ascii2af(p[1]);</span><br><span>         i=
f (proto &lt; 0)</span><br><span>         {</span><br><span>             ms=
g(msglevel, &quot;Bad protocol: &#39;%s&#39;. Allowed protocols with --prot=
o option: %s&quot;, p[1],</span><br><span>diff --git a/src/openvpn/socket.c=
 b/src/openvpn/socket.c</span><br><span>index 0b72684..33c12db 100644</span=
><br><span>--- a/src/openvpn/socket.c</span><br><span>+++ b/src/openvpn/soc=
ket.c</span><br><span>@@ -649,28 +649,23 @@</span><br><span> }</span><br><s=
pan> </span><br><span> static void</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-bind_local(struct link_socket *sock, const sa_family_t ai_fami=
ly)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bind_local(struc=
t link_socket *sock)</span><br><span> {</span><br><span>     /* bind to loc=
al address/port */</span><br><span>     if (sock-&gt;bind_local)</span><br>=
<span>     {</span><br><span>         if (sock-&gt;socks_proxy &amp;&amp; s=
ock-&gt;info.proto =3D=3D PROTO_UDP)</span><br><span>         {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            socket_bind(sock-&gt;=
ctrl_sd, sock-&gt;info.lsa-&gt;bind_local, ai_family, &quot;SOCKS&quot;, fa=
lse);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            so=
cket_bind(sock-&gt;ctrl_sd, sock-&gt;info.lsa-&gt;bind_local, sock-&gt;info=
.af, &quot;SOCKS&quot;, false);</span><br><span>         }</span><br><span>=
         else</span><br><span>         {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            socket_bind(sock-&gt;sd, sock-&gt;info.lsa-&=
gt;bind_local, ai_family, &quot;TCP/UDP&quot;,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            socket_bind(sock-&gt;sd, sock-&gt;in=
fo.lsa-&gt;bind_local, sock-&gt;info.af, &quot;TCP/UDP&quot;,</span><br><sp=
an>                         sock-&gt;info.bind_ipv6_only);</span><br><span>=
         }</span><br><span>     }</span><br><span> }</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || d=
efined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pra=
gma GCC diagnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#pragma GCC diagnostic ignored &quot;-Wconversion&quot;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span> static void</span><br><span> create_=
socket(struct link_socket *sock, struct addrinfo *addr)</span><br><span> {<=
/span><br><span>@@ -702,7 +697,7 @@</span><br><span>     }</span><br><span>=
     /* Set af field of sock-&gt;info, so it always reflects the address fa=
mily</span><br><span>      * of the created socket */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    sock-&gt;info.af =3D addr-&gt;ai_family=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sock-&gt;info.=
af =3D (sa_family_t)addr-&gt;ai_family;</span><br><span> </span><br><span> =
    /* set socket buffers based on --sndbuf and --rcvbuf options */</span><=
br><span>     socket_set_buffers(sock-&gt;sd, &amp;sock-&gt;socket_buffer_s=
izes, true);</span><br><span>@@ -714,8 +709,9 @@</span><br><span>     if (s=
ock-&gt;bind_dev)</span><br><span>     {</span><br><span>         msg(M_INF=
O, &quot;Using bind-dev %s&quot;, sock-&gt;bind_dev);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        /* Note: We verify strlen of bind=
_dev in options parsing */</span><br><span>         if (setsockopt(sock-&gt=
;sd, SOL_SOCKET, SO_BINDTODEVICE, sock-&gt;bind_dev,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                       strlen(sock-&gt;bind=
_dev) + 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
              (socklen_t)(strlen(sock-&gt;bind_dev) + 1))</span><br><span> =
            !=3D 0)</span><br><span>         {</span><br><span>            =
 msg(M_WARN | M_ERRNO, &quot;WARN: setsockopt SO_BINDTODEVICE=3D%s failed&q=
uot;, sock-&gt;bind_dev);</span><br><span>@@ -723,13 +719,9 @@</span><br><s=
pan>     }</span><br><span> #endif</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    bind_local(sock, addr-&gt;ai_family);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bind_local(sock);=
</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span> #ifdef TARGET_ANDROID</span><=
br><span> static void</span><br><span> protect_fd_nonlocal(int fd, const st=
ruct sockaddr *addr)</span><br><span>@@ -1161,13 +1153,8 @@</span><br><span=
>     }</span><br><span> }</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic i=
gnored &quot;-Wconversion&quot;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-resolve_bind_local(struct link_socket *sock, const sa_family_t af)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+resolve_bind_local(struct=
 link_socket *sock)</span><br><span> {</span><br><span>     struct gc_arena=
 gc =3D gc_new();</span><br><span> </span><br><span>@@ -1183,12 +1170,12 @@=
</span><br><span>         }</span><br><span> </span><br><span>         /* w=
ill return AF_{INET|INET6}from local_host */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        status =3D get_cached_dns_entry(sock-&gt;dns=
_cache, sock-&gt;local_host, sock-&gt;local_port, af,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        status =3D get_cached_dns_entry(s=
ock-&gt;dns_cache, sock-&gt;local_host, sock-&gt;local_port, sock-&gt;info.=
af,</span><br><span>                                       flags, &amp;sock=
-&gt;info.lsa-&gt;bind_local);</span><br><span> </span><br><span>         i=
f (status)</span><br><span>         {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            status =3D openvpn_getaddrinfo(flags, sock-&gt;=
local_host, sock-&gt;local_port, 0, NULL, af,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            status =3D openvpn_getaddrinfo(flags,=
 sock-&gt;local_host, sock-&gt;local_port, 0, NULL, sock-&gt;info.af,</span=
><br><span>                                          &amp;sock-&gt;info.lsa=
-&gt;bind_local);</span><br><span>         }</span><br><span> </span><br><s=
pan>@@ -1209,7 +1196,7 @@</span><br><span>             /* the resolved &#39=
;local entry&#39; might have a different family than</span><br><span>      =
        * what was globally configured</span><br><span>              */</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            sock-&gt;info=
.af =3D sock-&gt;info.lsa-&gt;bind_local-&gt;ai_family;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            sock-&gt;info.af =3D (sa_fa=
mily_t)sock-&gt;info.lsa-&gt;bind_local-&gt;ai_family;</span><br><span>    =
     }</span><br><span>     }</span><br><span> </span><br><span>@@ -1405,7 =
+1392,8 @@</span><br><span> </span><br><span>     sock-&gt;mark =3D o-&gt;m=
ark;</span><br><span>     sock-&gt;bind_dev =3D o-&gt;bind_dev;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    sock-&gt;info.proto =3D proto=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(proto &=
gt;=3D 0 &amp;&amp; proto &lt; PROTO_N);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    sock-&gt;info.proto =3D (uint8_t)proto;</span><br>=
<span>     sock-&gt;info.af =3D o-&gt;ce.af;</span><br><span>     sock-&gt;=
info.remote_float =3D o-&gt;ce.remote_float;</span><br><span>     sock-&gt;=
info.lsa =3D &amp;c-&gt;c1.link_socket_addrs[sock_index];</span><br><span>@=
@ -1471,7 +1459,7 @@</span><br><span>     {</span><br><span>         if (so=
ck-&gt;bind_local)</span><br><span>         {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            resolve_bind_local(sock, sock-&gt;info.=
af);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            res=
olve_bind_local(sock);</span><br><span>         }</span><br><span>         =
resolve_remote(sock, 1, NULL);</span><br><span>     }</span><br><span>@@ -1=
732,9 +1720,9 @@</span><br><span>              * and we should not connect =
a remote */</span><br><span>             if (sock-&gt;info.af =3D=3D AF_UNS=
PEC)</span><br><span>             {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                sock-&gt;info.af =3D (sa_family_t)sock-&gt;=
info.lsa-&gt;bind_local-&gt;ai_family;</span><br><span>                 msg=
(M_WARN, &quot;Could not determine IPv4/IPv6 protocol. Using %s&quot;,</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                    addr_f=
amily_name(sock-&gt;info.lsa-&gt;bind_local-&gt;ai_family));</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                sock-&gt;info.af =3D=
 sock-&gt;info.lsa-&gt;bind_local-&gt;ai_family;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                    addr_family_name(sock-&gt;=
info.af));</span><br><span>             }</span><br><span>             crea=
te_socket(sock, sock-&gt;info.lsa-&gt;bind_local);</span><br><span>        =
 }</span><br><span>@@ -1794,10 +1782,6 @@</span><br><span>     }</span><br>=
<span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span> void</span><br><span> link_socket_close(=
struct link_socket *sock)</span><br><span> {</span><br><span>@@ -2374,8 +23=
58,8 @@</span><br><span>     else if (cmsg !=3D NULL)</span><br><span>     =
{</span><br><span>         msg(M_WARN,</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            &quot;CMSG received that cannot be parsed (cms=
g_level=3D%d, cmsg_type=3D%d, cmsg=3Dlen=3D%d)&quot;,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            (int)cmsg-&gt;cmsg_level, (int)=
cmsg-&gt;cmsg_type, (int)cmsg-&gt;cmsg_len);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            &quot;CMSG received that cannot be par=
sed (cmsg_level=3D%d, cmsg_type=3D%d, cmsg=3Dlen=3D%zu)&quot;,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            cmsg-&gt;cmsg_level,=
 cmsg-&gt;cmsg_type, (size_t)cmsg-&gt;cmsg_len);</span><br><span>     }</sp=
an><br><span> </span><br><span>     return buf-&gt;len;</span><br><span>dif=
f --git a/src/openvpn/socket_util.c b/src/openvpn/socket_util.c</span><br><=
span>index 0194f38..913ac69 100644</span><br><span>--- a/src/openvpn/socket=
_util.c</span><br><span>+++ b/src/openvpn/socket_util.c</span><br><span>@@ =
-356,7 +356,7 @@</span><br><span>     const char *short_form;</span><br><sp=
an>     const char *display_form;</span><br><span>     sa_family_t proto_af=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int proto;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint8_t proto;</span>=
<br><span> };</span><br><span> </span><br><span> /* Indexed by PROTO_x */</=
span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/1476?usp=3Demail">change 1476</a>. To unsubscribe, =
or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.ne=
t/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://=
schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"htt=
p://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/1476?usp=3Demail"/><meta itemprop=3D"name" content=3D"=
View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7be7427480d3540d43dd818eddb=
6eb5860956459 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1476 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--hWpanwhRc58=--

