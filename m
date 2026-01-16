From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 16 Jan 2026 15:56:39 +0000
References: <gerrit.1768578994000.I7be7427480d3540d43dd818eddb6eb5860956459@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <4367295783f5004eacc5d9f66224de7d6331e2cd-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="wUc1yEq8dFs="; charset=UTF-8
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

--wUc1yEq8dFs=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1476?usp=3Demail

to review the following change.


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
- Some of the usual "recv* returns ssize_t not int"
  adaptions.

Change-Id: I7be7427480d3540d43dd818eddb6eb5860956459
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/options.c
M src/openvpn/socket.c
M src/openvpn/socket.h
M src/openvpn/socket_util.c
4 files changed, 49 insertions(+), 55 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/76/1476/1

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 85669e0..0f2bd03 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -6515,7 +6515,15 @@
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
@@ -6601,11 +6609,9 @@
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
index 331249d..eea94d0 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -661,28 +661,23 @@
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
@@ -714,7 +709,7 @@
     }
     /* Set af field of sock->info, so it always reflects the address family
      * of the created socket */
-    sock->info.af =3D addr->ai_family;
+    sock->info.af =3D (sa_family_t)addr->ai_family;

     /* set socket buffers based on --sndbuf and --rcvbuf options */
     socket_set_buffers(sock->sd, &sock->socket_buffer_sizes, true);
@@ -726,8 +721,9 @@
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
@@ -735,13 +731,9 @@
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
@@ -1144,7 +1136,7 @@

 static void stream_buf_close(struct stream_buf *sb);

-static bool stream_buf_added(struct stream_buf *sb, int length_added);
+static bool stream_buf_added(struct stream_buf *sb, ssize_t length_added);

 /* For stream protocols, allocate a buffer to build up packet.
  * Called after frame has been finalized. */
@@ -1173,13 +1165,8 @@
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

@@ -1195,12 +1182,12 @@
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

@@ -1221,7 +1208,7 @@
             /* the resolved 'local entry' might have a different family th=
an
              * what was globally configured
              */
-            sock->info.af =3D sock->info.lsa->bind_local->ai_family;
+            sock->info.af =3D (sa_family_t)sock->info.lsa->bind_local->ai_=
family;
         }
     }

@@ -1417,7 +1404,8 @@

     sock->mark =3D o->mark;
     sock->bind_dev =3D o->bind_dev;
-    sock->info.proto =3D proto;
+    ASSERT(proto >=3D 0 && proto < PROTO_N);
+    sock->info.proto =3D (uint8_t)proto;
     sock->info.af =3D o->ce.af;
     sock->info.remote_float =3D o->ce.remote_float;
     sock->info.lsa =3D &c->c1.link_socket_addrs[sock_index];
@@ -1483,7 +1471,7 @@
     {
         if (sock->bind_local)
         {
-            resolve_bind_local(sock, sock->info.af);
+            resolve_bind_local(sock);
         }
         resolve_remote(sock, 1, NULL);
     }
@@ -1744,9 +1732,9 @@
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
@@ -2142,12 +2130,13 @@
 }

 static bool
-stream_buf_added(struct stream_buf *sb, int length_added)
+stream_buf_added(struct stream_buf *sb, ssize_t length_added)
 {
-    dmsg(D_STREAM_DEBUG, "STREAM: ADD length_added=3D%d", length_added);
+    dmsg(D_STREAM_DEBUG, "STREAM: ADD length_added=3D%zd", length_added);
     if (length_added > 0)
     {
-        sb->buf.len +=3D length_added;
+        ASSERT(sb->buf.len + length_added <=3D INT_MAX);
+        sb->buf.len +=3D (int)length_added;
     }

     /* if length unknown, see if we can get the length prefix from
@@ -2253,7 +2242,7 @@
 int
 link_socket_read_tcp(struct link_socket *sock, struct buffer *buf)
 {
-    int len =3D 0;
+    ssize_t len =3D 0;

     if (!sock->stream_buf.residual_fully_formed)
     {
@@ -2284,7 +2273,7 @@
         }
         if (len <=3D 0)
         {
-            return buf->len =3D len;
+            return buf->len =3D (int)len;
         }
     }

@@ -2334,13 +2323,14 @@
     mesg.msg_name =3D &from->dest.addr;
     mesg.msg_namelen =3D fromlen;
     mesg.msg_control =3D pktinfo_buf;
-    mesg.msg_controllen =3D sizeof pktinfo_buf;
-    buf->len =3D recvmsg(sock->sd, &mesg, 0);
-    if (buf->len >=3D 0)
+    mesg.msg_controllen =3D sizeof(pktinfo_buf);
+    ssize_t len =3D recvmsg(sock->sd, &mesg, 0);
+    if (len >=3D 0)
     {
-        struct cmsghdr *cmsg;
+        ASSERT(len <=3D INT_MAX);
+        buf->len =3D (int)len;
         fromlen =3D mesg.msg_namelen;
-        cmsg =3D CMSG_FIRSTHDR(&mesg);
+        struct cmsghdr *cmsg =3D CMSG_FIRSTHDR(&mesg);
         if (cmsg !=3D NULL && CMSG_NXTHDR(&mesg, cmsg) =3D=3D NULL
 #if defined(HAVE_IN_PKTINFO) && defined(HAVE_IPI_SPEC_DST)
             && cmsg->cmsg_level =3D=3D SOL_IP && cmsg->cmsg_type =3D=3D IP=
_PKTINFO
@@ -2375,8 +2365,8 @@
         else if (cmsg !=3D NULL)
         {
             msg(M_WARN,
-                "CMSG received that cannot be parsed (cmsg_level=3D%d, cms=
g_type=3D%d, cmsg=3Dlen=3D%d)",
-                (int)cmsg->cmsg_level, (int)cmsg->cmsg_type, (int)cmsg->cm=
sg_len);
+                "CMSG received that cannot be parsed (cmsg_level=3D%d, cms=
g_type=3D%d, cmsg=3Dlen=3D%zu)",
+                cmsg->cmsg_level, cmsg->cmsg_type, cmsg->cmsg_len);
         }
     }

@@ -2403,8 +2393,8 @@
     else
 #endif
     {
-        buf->len =3D recvfrom(sock->sd, BPTR(buf), buf_forward_capacity(bu=
f), 0, &from->dest.addr.sa,
-                            &fromlen);
+        buf->len =3D (int)recvfrom(sock->sd, BPTR(buf), buf_forward_capaci=
ty(buf),
+                                 0, &from->dest.addr.sa, &fromlen);
     }
     /* FIXME: won't do anything when sock->info.af =3D=3D AF_UNSPEC */
     if (buf->len >=3D 0 && expectedlen && fromlen !=3D expectedlen)
@@ -2423,8 +2413,9 @@
 ssize_t
 link_socket_write_tcp(struct link_socket *sock, struct buffer *buf, struct=
 link_socket_actual *to)
 {
-    packet_size_type len =3D BLEN(buf);
-    dmsg(D_STREAM_DEBUG, "STREAM: WRITE %d offset=3D%d", (int)len, buf->of=
fset);
+    ASSERT(BLEN(buf) >=3D 0 && BLEN(buf) <=3D PACKET_SIZE_MAX);
+    packet_size_type len =3D (packet_size_type)BLEN(buf);
+    dmsg(D_STREAM_DEBUG, "STREAM: WRITE %u offset=3D%d", len, buf->offset);
     ASSERT(len <=3D sock->stream_buf.maxlen);
     len =3D htonps(len);
     ASSERT(buf_write_prepend(buf, &len, sizeof(len)));
@@ -2435,10 +2426,6 @@
 #endif
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 #if ENABLE_IP_PKTINFO

 ssize_t
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 850064d..192a03c 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -54,6 +54,7 @@
  */

 typedef uint16_t packet_size_type;
+#define PACKET_SIZE_MAX UINT16_MAX

 /* convert a packet_size_type from host to network order */
 #define htonps(x) htons(x)
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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7be7427480d3540d43dd818eddb6eb5860956459
Gerrit-Change-Number: 1476
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--wUc1yEq8dFs=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1476?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">socket: Fix various conversion warnings<br>=
<br>- We assume that addrinfo-&gt;ai_family always fits<br>  into a sa_fami=
ly_t, so we do not check those.<br>- Reduce places where we explicitly pass=
 ai_family<br>  and prefer sock-&gt;info.af.<br>- Make sure that --bind-dev=
 has a suitable length.<br>- Treat PROTO_* as uint8_t where possible (howev=
er,<br>  much code uses proto =3D -1 for various error handling).<br>- Some=
 of the usual &quot;recv* returns ssize_t not int&quot;<br>  adaptions.<br>=
<br>Change-Id: I7be7427480d3540d43dd818eddb6eb5860956459<br>Signed-off-by: =
Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M src/openvpn/options.=
c<br>M src/openvpn/socket.c<br>M src/openvpn/socket.h<br>M src/openvpn/sock=
et_util.c<br>4 files changed, 49 insertions(+), 55 deletions(-)<br><br></pr=
e><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/change=
s/76/1476/1</pre><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;"><span>diff --git a/src/openvpn/options.c b/src/openvpn/option=
s.c</span><br><span>index 85669e0..0f2bd03 100644</span><br><span>--- a/src=
/openvpn/options.c</span><br><span>+++ b/src/openvpn/options.c</span><br><s=
pan>@@ -6515,7 +6515,15 @@</span><br><span>     else if (streq(p[0], &quot;=
bind-dev&quot;) &amp;&amp; p[1])</span><br><span>     {</span><br><span>   =
      VERIFY_PERMISSION(OPT_P_SOCKFLAGS);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        options-&gt;bind_dev =3D p[1];</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        if (strlen(p[1]) &lt;=3D IFN=
AMSIZ)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            options-&gt=
;bind_dev =3D p[1];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        el=
se</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(msglevel, &=
quot;argument to --bind-dev is longer than allowed %u&quot;, IFNAMSIZ);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            goto err;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><=
span>     }</span><br><span> #endif</span><br><span>     else if (streq(p[0=
], &quot;txqueuelen&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><spa=
n>@@ -6601,11 +6609,9 @@</span><br><span>     }</span><br><span>     else i=
f (streq(p[0], &quot;proto&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><=
br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  int proto;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        s=
a_family_t af;</span><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL | O=
PT_P_CONNECTION);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    proto =3D ascii2proto(p[1]);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        af =3D ascii2af(p[1]);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        int proto =3D ascii2proto(p[1]);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        sa_family_t af =3D ascii=
2af(p[1]);</span><br><span>         if (proto &lt; 0)</span><br><span>     =
    {</span><br><span>             msg(msglevel, &quot;Bad protocol: &#39;%=
s&#39;. Allowed protocols with --proto option: %s&quot;, p[1],</span><br><s=
pan>diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c</span><br><spa=
n>index 331249d..eea94d0 100644</span><br><span>--- a/src/openvpn/socket.c<=
/span><br><span>+++ b/src/openvpn/socket.c</span><br><span>@@ -661,28 +661,=
23 @@</span><br><span> }</span><br><span> </span><br><span> static void</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-bind_local(struct link_so=
cket *sock, const sa_family_t ai_family)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+bind_local(struct link_socket *sock)</span><br><span> =
{</span><br><span>     /* bind to local address/port */</span><br><span>   =
  if (sock-&gt;bind_local)</span><br><span>     {</span><br><span>         =
if (sock-&gt;socks_proxy &amp;&amp; sock-&gt;info.proto =3D=3D PROTO_UDP)</=
span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            socket_bind(sock-&gt;ctrl_sd, sock-&gt;info.lsa-&gt;bind_lo=
cal, ai_family, &quot;SOCKS&quot;, false);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            socket_bind(sock-&gt;ctrl_sd, sock-&gt;i=
nfo.lsa-&gt;bind_local, sock-&gt;info.af, &quot;SOCKS&quot;, false);</span>=
<br><span>         }</span><br><span>         else</span><br><span>        =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            socket_=
bind(sock-&gt;sd, sock-&gt;info.lsa-&gt;bind_local, ai_family, &quot;TCP/UD=
P&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 socket_bind(sock-&gt;sd, sock-&gt;info.lsa-&gt;bind_local, sock-&gt;info.a=
f, &quot;TCP/UDP&quot;,</span><br><span>                         sock-&gt;i=
nfo.bind_ipv6_only);</span><br><span>         }</span><br><span>     }</spa=
n><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot=
;-Wconversion&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#e=
ndif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>=
 static void</span><br><span> create_socket(struct link_socket *sock, struc=
t addrinfo *addr)</span><br><span> {</span><br><span>@@ -714,7 +709,7 @@</s=
pan><br><span>     }</span><br><span>     /* Set af field of sock-&gt;info,=
 so it always reflects the address family</span><br><span>      * of the cr=
eated socket */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    so=
ck-&gt;info.af =3D addr-&gt;ai_family;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    sock-&gt;info.af =3D (sa_family_t)addr-&gt;ai_family=
;</span><br><span> </span><br><span>     /* set socket buffers based on --s=
ndbuf and --rcvbuf options */</span><br><span>     socket_set_buffers(sock-=
&gt;sd, &amp;sock-&gt;socket_buffer_sizes, true);</span><br><span>@@ -726,8=
 +721,9 @@</span><br><span>     if (sock-&gt;bind_dev)</span><br><span>    =
 {</span><br><span>         msg(M_INFO, &quot;Using bind-dev %s&quot;, sock=
-&gt;bind_dev);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    /* Note: We verify strlen of bind_dev in options parsing */</span><br><=
span>         if (setsockopt(sock-&gt;sd, SOL_SOCKET, SO_BINDTODEVICE, sock=
-&gt;bind_dev,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
                strlen(sock-&gt;bind_dev) + 1)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                       (socklen_t)(strlen(sock-&=
gt;bind_dev) + 1))</span><br><span>             !=3D 0)</span><br><span>   =
      {</span><br><span>             msg(M_WARN | M_ERRNO, &quot;WARN: sets=
ockopt SO_BINDTODEVICE=3D%s failed&quot;, sock-&gt;bind_dev);</span><br><sp=
an>@@ -735,13 +731,9 @@</span><br><span>     }</span><br><span> #endif</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bind=
_local(sock, addr-&gt;ai_family);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    bind_local(sock);</span><br><span> }</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) ||=
 defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#p=
ragma GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span> #ifdef TARGET_ANDROID</span><br><span> static void</span><br><span> p=
rotect_fd_nonlocal(int fd, const struct sockaddr *addr)</span><br><span>@@ =
-1144,7 +1136,7 @@</span><br><span> </span><br><span> static void stream_bu=
f_close(struct stream_buf *sb);</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-static bool stream_buf_added(struct stream_buf =
*sb, int length_added);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+static bool stream_buf_added(struct stream_buf *sb, ssize_t length_adde=
d);</span><br><span> </span><br><span> /* For stream protocols, allocate a =
buffer to build up packet.</span><br><span>  * Called after frame has been =
finalized. */</span><br><span>@@ -1173,13 +1165,8 @@</span><br><span>     }=
</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored =
&quot;-Wconversion&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-reso=
lve_bind_local(struct link_socket *sock, const sa_family_t af)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+resolve_bind_local(struct link_s=
ocket *sock)</span><br><span> {</span><br><span>     struct gc_arena gc =3D=
 gc_new();</span><br><span> </span><br><span>@@ -1195,12 +1182,12 @@</span>=
<br><span>         }</span><br><span> </span><br><span>         /* will ret=
urn AF_{INET|INET6}from local_host */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        status =3D get_cached_dns_entry(sock-&gt;dns_cache,=
 sock-&gt;local_host, sock-&gt;local_port, af,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        status =3D get_cached_dns_entry(sock-&gt=
;dns_cache, sock-&gt;local_host, sock-&gt;local_port, sock-&gt;info.af,</sp=
an><br><span>                                       flags, &amp;sock-&gt;in=
fo.lsa-&gt;bind_local);</span><br><span> </span><br><span>         if (stat=
us)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            status =3D openvpn_getaddrinfo(flags, sock-&gt;local_h=
ost, sock-&gt;local_port, 0, NULL, af,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            status =3D openvpn_getaddrinfo(flags, sock-&=
gt;local_host, sock-&gt;local_port, 0, NULL, sock-&gt;info.af,</span><br><s=
pan>                                          &amp;sock-&gt;info.lsa-&gt;bi=
nd_local);</span><br><span>         }</span><br><span> </span><br><span>@@ =
-1221,7 +1208,7 @@</span><br><span>             /* the resolved &#39;local =
entry&#39; might have a different family than</span><br><span>             =
 * what was globally configured</span><br><span>              */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            sock-&gt;info.af =3D=
 sock-&gt;info.lsa-&gt;bind_local-&gt;ai_family;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            sock-&gt;info.af =3D (sa_family_t)=
sock-&gt;info.lsa-&gt;bind_local-&gt;ai_family;</span><br><span>         }<=
/span><br><span>     }</span><br><span> </span><br><span>@@ -1417,7 +1404,8=
 @@</span><br><span> </span><br><span>     sock-&gt;mark =3D o-&gt;mark;</s=
pan><br><span>     sock-&gt;bind_dev =3D o-&gt;bind_dev;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    sock-&gt;info.proto =3D proto;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(proto &gt;=3D =
0 &amp;&amp; proto &lt; PROTO_N);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    sock-&gt;info.proto =3D (uint8_t)proto;</span><br><span> =
    sock-&gt;info.af =3D o-&gt;ce.af;</span><br><span>     sock-&gt;info.re=
mote_float =3D o-&gt;ce.remote_float;</span><br><span>     sock-&gt;info.ls=
a =3D &amp;c-&gt;c1.link_socket_addrs[sock_index];</span><br><span>@@ -1483=
,7 +1471,7 @@</span><br><span>     {</span><br><span>         if (sock-&gt;=
bind_local)</span><br><span>         {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            resolve_bind_local(sock, sock-&gt;info.af);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            resolve_bi=
nd_local(sock);</span><br><span>         }</span><br><span>         resolve=
_remote(sock, 1, NULL);</span><br><span>     }</span><br><span>@@ -1744,9 +=
1732,9 @@</span><br><span>              * and we should not connect a remot=
e */</span><br><span>             if (sock-&gt;info.af =3D=3D AF_UNSPEC)</s=
pan><br><span>             {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                sock-&gt;info.af =3D (sa_family_t)sock-&gt;info.ls=
a-&gt;bind_local-&gt;ai_family;</span><br><span>                 msg(M_WARN=
, &quot;Could not determine IPv4/IPv6 protocol. Using %s&quot;,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                    addr_family_n=
ame(sock-&gt;info.lsa-&gt;bind_local-&gt;ai_family));</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                sock-&gt;info.af =3D sock-&=
gt;info.lsa-&gt;bind_local-&gt;ai_family;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                    addr_family_name(sock-&gt;info.af=
));</span><br><span>             }</span><br><span>             create_sock=
et(sock, sock-&gt;info.lsa-&gt;bind_local);</span><br><span>         }</spa=
n><br><span>@@ -2142,12 +2130,13 @@</span><br><span> }</span><br><span> </s=
pan><br><span> static bool</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-stream_buf_added(struct stream_buf *sb, int length_added)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+stream_buf_added(struct stream_b=
uf *sb, ssize_t length_added)</span><br><span> {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    dmsg(D_STREAM_DEBUG, &quot;STREAM: ADD lengt=
h_added=3D%d&quot;, length_added);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    dmsg(D_STREAM_DEBUG, &quot;STREAM: ADD length_added=3D%z=
d&quot;, length_added);</span><br><span>     if (length_added &gt; 0)</span=
><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    sb-&gt;buf.len +=3D length_added;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        ASSERT(sb-&gt;buf.len + length_added &lt;=3D INT_=
MAX);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        sb-&gt=
;buf.len +=3D (int)length_added;</span><br><span>     }</span><br><span> </=
span><br><span>     /* if length unknown, see if we can get the length pref=
ix from</span><br><span>@@ -2253,7 +2242,7 @@</span><br><span> int</span><b=
r><span> link_socket_read_tcp(struct link_socket *sock, struct buffer *buf)=
</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  int len =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 ssize_t len =3D 0;</span><br><span> </span><br><span>     if (!sock-&gt;st=
ream_buf.residual_fully_formed)</span><br><span>     {</span><br><span>@@ -=
2284,7 +2273,7 @@</span><br><span>         }</span><br><span>         if (l=
en &lt;=3D 0)</span><br><span>         {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            return buf-&gt;len =3D len;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            return buf-&gt;len =3D (=
int)len;</span><br><span>         }</span><br><span>     }</span><br><span>=
 </span><br><span>@@ -2334,13 +2323,14 @@</span><br><span>     mesg.msg_nam=
e =3D &amp;from-&gt;dest.addr;</span><br><span>     mesg.msg_namelen =3D fr=
omlen;</span><br><span>     mesg.msg_control =3D pktinfo_buf;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    mesg.msg_controllen =3D sizeof =
pktinfo_buf;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    buf-&=
gt;len =3D recvmsg(sock-&gt;sd, &amp;mesg, 0);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    if (buf-&gt;len &gt;=3D 0)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    mesg.msg_controllen =3D sizeof(pkti=
nfo_buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ssize_=
t len =3D recvmsg(sock-&gt;sd, &amp;mesg, 0);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    if (len &gt;=3D 0)</span><br><span>     {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct cmsghdr *c=
msg;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ASSERT(=
len &lt;=3D INT_MAX);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        buf-&gt;len =3D (int)len;</span><br><span>         fromlen =3D me=
sg.msg_namelen;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  cmsg =3D CMSG_FIRSTHDR(&amp;mesg);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        struct cmsghdr *cmsg =3D CMSG_FIRSTHDR(&amp;mesg);=
</span><br><span>         if (cmsg !=3D NULL &amp;&amp; CMSG_NXTHDR(&amp;me=
sg, cmsg) =3D=3D NULL</span><br><span> #if defined(HAVE_IN_PKTINFO) &amp;&a=
mp; defined(HAVE_IPI_SPEC_DST)</span><br><span>             &amp;&amp; cmsg=
-&gt;cmsg_level =3D=3D SOL_IP &amp;&amp; cmsg-&gt;cmsg_type =3D=3D IP_PKTIN=
FO</span><br><span>@@ -2375,8 +2365,8 @@</span><br><span>         else if (=
cmsg !=3D NULL)</span><br><span>         {</span><br><span>             msg=
(M_WARN,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
   &quot;CMSG received that cannot be parsed (cmsg_level=3D%d, cmsg_type=3D=
%d, cmsg=3Dlen=3D%d)&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                (int)cmsg-&gt;cmsg_level, (int)cmsg-&gt;cmsg_type, (i=
nt)cmsg-&gt;cmsg_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                &quot;CMSG received that cannot be parsed (cmsg_level=3D=
%d, cmsg_type=3D%d, cmsg=3Dlen=3D%zu)&quot;,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                cmsg-&gt;cmsg_level, cmsg-&gt;cmsg=
_type, cmsg-&gt;cmsg_len);</span><br><span>         }</span><br><span>     =
}</span><br><span> </span><br><span>@@ -2403,8 +2393,8 @@</span><br><span> =
    else</span><br><span> #endif</span><br><span>     {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        buf-&gt;len =3D recvfrom(sock-&gt=
;sd, BPTR(buf), buf_forward_capacity(buf), 0, &amp;from-&gt;dest.addr.sa,</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                       =
     &amp;fromlen);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        buf-&gt;len =3D (int)recvfrom(sock-&gt;sd, BPTR(buf), buf_forward_c=
apacity(buf),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                           0, &amp;from-&gt;dest.addr.sa, &amp;fromlen);</s=
pan><br><span>     }</span><br><span>     /* FIXME: won&#39;t do anything w=
hen sock-&gt;info.af =3D=3D AF_UNSPEC */</span><br><span>     if (buf-&gt;l=
en &gt;=3D 0 &amp;&amp; expectedlen &amp;&amp; fromlen !=3D expectedlen)</s=
pan><br><span>@@ -2423,8 +2413,9 @@</span><br><span> ssize_t</span><br><spa=
n> link_socket_write_tcp(struct link_socket *sock, struct buffer *buf, stru=
ct link_socket_actual *to)</span><br><span> {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    packet_size_type len =3D BLEN(buf);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    dmsg(D_STREAM_DEBUG, &quot;ST=
REAM: WRITE %d offset=3D%d&quot;, (int)len, buf-&gt;offset);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(BLEN(buf) &gt;=3D 0 &am=
p;&amp; BLEN(buf) &lt;=3D PACKET_SIZE_MAX);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    packet_size_type len =3D (packet_size_type)BLEN=
(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    dmsg(D_ST=
REAM_DEBUG, &quot;STREAM: WRITE %u offset=3D%d&quot;, len, buf-&gt;offset);=
</span><br><span>     ASSERT(len &lt;=3D sock-&gt;stream_buf.maxlen);</span=
><br><span>     len =3D htonps(len);</span><br><span>     ASSERT(buf_write_=
prepend(buf, &amp;len, sizeof(len)));</span><br><span>@@ -2435,10 +2426,6 @=
@</span><br><span> #endif</span><br><span> }</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(_=
_clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC =
diagnostic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #if =
ENABLE_IP_PKTINFO</span><br><span> </span><br><span> ssize_t</span><br><spa=
n>diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h</span><br><span>=
index 850064d..192a03c 100644</span><br><span>--- a/src/openvpn/socket.h</s=
pan><br><span>+++ b/src/openvpn/socket.h</span><br><span>@@ -54,6 +54,7 @@<=
/span><br><span>  */</span><br><span> </span><br><span> typedef uint16_t pa=
cket_size_type;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#def=
ine PACKET_SIZE_MAX UINT16_MAX</span><br><span> </span><br><span> /* conver=
t a packet_size_type from host to network order */</span><br><span> #define=
 htonps(x) htons(x)</span><br><span>diff --git a/src/openvpn/socket_util.c =
b/src/openvpn/socket_util.c</span><br><span>index 0194f38..913ac69 100644</=
span><br><span>--- a/src/openvpn/socket_util.c</span><br><span>+++ b/src/op=
envpn/socket_util.c</span><br><span>@@ -356,7 +356,7 @@</span><br><span>   =
  const char *short_form;</span><br><span>     const char *display_form;</s=
pan><br><span>     sa_family_t proto_af;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    int proto;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    uint8_t proto;</span><br><span> };</span><br><span> </spa=
n><br><span> /* Indexed by PROTO_x */</span><br><span></span><br></pre><p>T=
o view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1476?usp=3De=
mail">change 1476</a>. To unsubscribe, or for help writing mail filters, vi=
sit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>=
.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemsc=
ope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link ite=
mprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1476?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7be7427480d3540d43dd818eddb=
6eb5860956459 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1476 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--wUc1yEq8dFs=--

