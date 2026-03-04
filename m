From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 4 Mar 2026 13:20:38 +0000
In-Reply-To: <gerrit.1772554170000.Iabe1992b2608661b862a81363574e957d18395f0@...2715...>
References: <gerrit.1772554170000.Iabe1992b2608661b862a81363574e957d18395f0@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <356ea19e342fbd121365c12f8ea706f22098d925-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="jMUfHgMu/4o="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: socket: Never use
 negative buf->len in link_socket_read*
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

--jMUfHgMu/4o=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1554?usp=3Demail

to look at the new patch set (#3).


Change subject: socket: Never use negative buf->len in link_socket_read*
......................................................................

socket: Never use negative buf->len in link_socket_read*

We really don't want to use negative buf lengths in
our code. So remove some places where we did so before.

Change-Id: Iabe1992b2608661b862a81363574e957d18395f0
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/forward.c
M src/openvpn/socket.c
M src/openvpn/socket.h
M src/openvpn/tun.h
4 files changed, 84 insertions(+), 69 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/54/1554/3

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 27cfd36..20b46d3 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -929,14 +929,12 @@
      * Set up for recvfrom call to read datagram
      * sent to our TCP/UDP port.
      */
-    int status;
-
     /*ASSERT (!c->c2.to_tun.len);*/

     c->c2.buf =3D c->c2.buffers->read_link_buf;
     ASSERT(buf_init(&c->c2.buf, c->c2.frame.buf.headroom));

-    status =3D link_socket_read(sock, &c->c2.buf, &c->c2.from);
+    ssize_t status =3D link_socket_read(sock, &c->c2.buf, &c->c2.from);

     if (socket_connection_reset(sock, status))
     {
@@ -955,14 +953,14 @@
             if (event_timeout_defined(&c->c2.explicit_exit_notification_in=
terval))
             {
                 msg(D_STREAM_ERRORS,
-                    "Connection reset during exit notification period, ign=
oring [%d]", status);
+                    "Connection reset during exit notification period, ign=
oring [%zd]", status);
                 management_sleep(1);
             }
             else
             {
                 register_signal(c->sig, SIGUSR1,
                                 "connection-reset"); /* SOFT-SIGUSR1 -- TC=
P connection reset */
-                msg(D_STREAM_ERRORS, "Connection reset, restarting [%d]", =
status);
+                msg(D_STREAM_ERRORS, "Connection reset, restarting [%zd]",=
 status);
             }
         }
         return;
@@ -1026,7 +1024,7 @@
      * Good, non-zero length packet received.
      * Commence multi-stage processing of packet,
      * such as authenticate, decrypt, decompress.
-     * If any stage fails, it sets buf.len to 0 or -1,
+     * If any stage fails, it sets buf.len to 0,
      * telling downstream stages to ignore the packet.
      */
     if (c->c2.buf.len > 0)
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 2d5fc50..d2170a4 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -1130,7 +1130,7 @@

 static void stream_buf_close(struct stream_buf *sb);

-static bool stream_buf_added(struct stream_buf *sb, int length_added);
+static bool stream_buf_added(struct stream_buf *sb, ssize_t length_added);

 /* For stream protocols, allocate a buffer to build up packet.
  * Called after frame has been finalized. */
@@ -1792,6 +1792,10 @@
     }
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 void
 link_socket_close(struct link_socket *sock)
 {
@@ -2159,12 +2163,13 @@
  * @return true if \c sb->buf contains fully reassembled packet
  */
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
@@ -2266,10 +2271,10 @@
  * Socket Read Routines
  */

-int
+ssize_t
 link_socket_read_tcp(struct link_socket *sock, struct buffer *buf)
 {
-    int len =3D 0;
+    ssize_t len =3D 0;

     if (!sock->stream_buf.residual_fully_formed)
     {
@@ -2299,7 +2304,8 @@
         }
         if (len <=3D 0)
         {
-            return buf->len =3D len;
+            buf->len =3D 0;
+            return len;
         }
     }

@@ -2331,14 +2337,14 @@
     max_int(CMSG_SPACE(sizeof(struct in6_pktinfo)), CMSG_SPACE(sizeof(stru=
ct in_addr)))
 #endif

-static socklen_t
+static ssize_t
 link_socket_read_udp_posix_recvmsg(struct link_socket *sock, struct buffer=
 *buf,
-                                   struct link_socket_actual *from)
+                                   struct link_socket_actual *from, sockle=
n_t *fromlen)
 {
     struct iovec iov;
     uint8_t pktinfo_buf[PKTINFO_BUF_SIZE];
     struct msghdr mesg =3D { 0 };
-    socklen_t fromlen =3D sizeof(from->dest.addr);
+    *fromlen =3D sizeof(from->dest.addr);

     ASSERT(sock->sd >=3D 0); /* can't happen */

@@ -2347,62 +2353,67 @@
     mesg.msg_iov =3D &iov;
     mesg.msg_iovlen =3D 1;
     mesg.msg_name =3D &from->dest.addr;
-    mesg.msg_namelen =3D fromlen;
+    mesg.msg_namelen =3D *fromlen;
     mesg.msg_control =3D pktinfo_buf;
-    mesg.msg_controllen =3D sizeof pktinfo_buf;
-    buf->len =3D recvmsg(sock->sd, &mesg, 0);
-    if (buf->len >=3D 0)
+    mesg.msg_controllen =3D (socklen_t)sizeof(pktinfo_buf);
+    ssize_t len =3D recvmsg(sock->sd, &mesg, 0);
+    if (len < 0)
     {
-        struct cmsghdr *cmsg;
-        fromlen =3D mesg.msg_namelen;
-        cmsg =3D CMSG_FIRSTHDR(&mesg);
-        if (cmsg !=3D NULL && CMSG_NXTHDR(&mesg, cmsg) =3D=3D NULL
+        buf->len =3D 0;
+        return len;
+    }
+    ASSERT(len <=3D INT_MAX);
+    buf->len =3D (int)len;
+    struct cmsghdr *cmsg;
+    *fromlen =3D mesg.msg_namelen;
+    cmsg =3D CMSG_FIRSTHDR(&mesg);
+    if (cmsg !=3D NULL && CMSG_NXTHDR(&mesg, cmsg) =3D=3D NULL
 #if defined(HAVE_IN_PKTINFO) && defined(HAVE_IPI_SPEC_DST)
-            && cmsg->cmsg_level =3D=3D SOL_IP && cmsg->cmsg_type =3D=3D IP=
_PKTINFO
-            && cmsg->cmsg_len >=3D CMSG_LEN(sizeof(struct in_pktinfo)))
+        && cmsg->cmsg_level =3D=3D SOL_IP && cmsg->cmsg_type =3D=3D IP_PKT=
INFO
+        && cmsg->cmsg_len >=3D CMSG_LEN(sizeof(struct in_pktinfo)))
 #elif defined(IP_RECVDSTADDR)
-            && cmsg->cmsg_level =3D=3D IPPROTO_IP && cmsg->cmsg_type =3D=
=3D IP_RECVDSTADDR
-            && cmsg->cmsg_len >=3D CMSG_LEN(sizeof(struct in_addr)))
+        && cmsg->cmsg_level =3D=3D IPPROTO_IP && cmsg->cmsg_type =3D=3D IP=
_RECVDSTADDR
+        && cmsg->cmsg_len >=3D CMSG_LEN(sizeof(struct in_addr)))
 #else /* if defined(HAVE_IN_PKTINFO) && defined(HAVE_IPI_SPEC_DST) */
 #error ENABLE_IP_PKTINFO is set without IP_PKTINFO xor IP_RECVDSTADDR (fix=
 syshead.h)
 #endif
-        {
+    {
 #if defined(HAVE_IN_PKTINFO) && defined(HAVE_IPI_SPEC_DST)
-            struct in_pktinfo *pkti =3D (struct in_pktinfo *)CMSG_DATA(cms=
g);
-            from->pi.in4.ipi_ifindex =3D
-                (sock->sockflags & SF_PKTINFO_COPY_IIF) ? pkti->ipi_ifinde=
x : 0;
-            from->pi.in4.ipi_spec_dst =3D pkti->ipi_spec_dst;
+        struct in_pktinfo *pkti =3D (struct in_pktinfo *)CMSG_DATA(cmsg);
+        from->pi.in4.ipi_ifindex =3D
+            (sock->sockflags & SF_PKTINFO_COPY_IIF) ? pkti->ipi_ifindex : =
0;
+        from->pi.in4.ipi_spec_dst =3D pkti->ipi_spec_dst;
 #elif defined(IP_RECVDSTADDR)
-            from->pi.in4 =3D *(struct in_addr *)CMSG_DATA(cmsg);
+        from->pi.in4 =3D *(struct in_addr *)CMSG_DATA(cmsg);
 #else /* if defined(HAVE_IN_PKTINFO) && defined(HAVE_IPI_SPEC_DST) */
 #error ENABLE_IP_PKTINFO is set without IP_PKTINFO xor IP_RECVDSTADDR (fix=
 syshead.h)
 #endif
-        }
-        else if (cmsg !=3D NULL && CMSG_NXTHDR(&mesg, cmsg) =3D=3D NULL
-                 && cmsg->cmsg_level =3D=3D IPPROTO_IPV6 && cmsg->cmsg_typ=
e =3D=3D IPV6_PKTINFO
-                 && cmsg->cmsg_len >=3D CMSG_LEN(sizeof(struct in6_pktinfo=
)))
-        {
-            struct in6_pktinfo *pkti6 =3D (struct in6_pktinfo *)CMSG_DATA(=
cmsg);
-            from->pi.in6.ipi6_ifindex =3D
-                (sock->sockflags & SF_PKTINFO_COPY_IIF) ? pkti6->ipi6_ifin=
dex : 0;
-            from->pi.in6.ipi6_addr =3D pkti6->ipi6_addr;
-        }
-        else if (cmsg !=3D NULL)
-        {
-            msg(M_WARN,
-                "CMSG received that cannot be parsed (cmsg_level=3D%d, cms=
g_type=3D%d, cmsg=3Dlen=3D%d)",
-                (int)cmsg->cmsg_level, (int)cmsg->cmsg_type, (int)cmsg->cm=
sg_len);
-        }
+    }
+    else if (cmsg !=3D NULL && CMSG_NXTHDR(&mesg, cmsg) =3D=3D NULL
+             && cmsg->cmsg_level =3D=3D IPPROTO_IPV6 && cmsg->cmsg_type =
=3D=3D IPV6_PKTINFO
+             && cmsg->cmsg_len >=3D CMSG_LEN(sizeof(struct in6_pktinfo)))
+    {
+        struct in6_pktinfo *pkti6 =3D (struct in6_pktinfo *)CMSG_DATA(cmsg=
);
+        from->pi.in6.ipi6_ifindex =3D
+            (sock->sockflags & SF_PKTINFO_COPY_IIF) ? pkti6->ipi6_ifindex =
: 0;
+        from->pi.in6.ipi6_addr =3D pkti6->ipi6_addr;
+    }
+    else if (cmsg !=3D NULL)
+    {
+        msg(M_WARN,
+            "CMSG received that cannot be parsed (cmsg_level=3D%d, cmsg_ty=
pe=3D%d, cmsg=3Dlen=3D%d)",
+            (int)cmsg->cmsg_level, (int)cmsg->cmsg_type, (int)cmsg->cmsg_l=
en);
     }

-    return fromlen;
+    return buf->len;
 }
 #endif /* if ENABLE_IP_PKTINFO */

-int
+ssize_t
 link_socket_read_udp_posix(struct link_socket *sock, struct buffer *buf,
                            struct link_socket_actual *from)
 {
+    ssize_t recvlen;
     socklen_t fromlen =3D sizeof(from->dest.addr);
     socklen_t expectedlen =3D af_addr_size(sock->info.af);
     addr_zero_host(&from->dest);
@@ -2413,16 +2424,23 @@
     /* Both PROTO_UDPv4 and PROTO_UDPv6 */
     if (sock->info.proto =3D=3D PROTO_UDP && sock->sockflags & SF_USE_IP_P=
KTINFO)
     {
-        fromlen =3D link_socket_read_udp_posix_recvmsg(sock, buf, from);
+        recvlen =3D link_socket_read_udp_posix_recvmsg(sock, buf, from, &f=
romlen);
     }
     else
 #endif
     {
-        buf->len =3D recvfrom(sock->sd, BPTR(buf), buf_forward_capacity(bu=
f), 0, &from->dest.addr.sa,
-                            &fromlen);
+        recvlen =3D recvfrom(sock->sd, BPTR(buf), buf_forward_capacity(buf=
), 0,
+                           &from->dest.addr.sa, &fromlen);
     }
+    if (recvlen < 0)
+    {
+        buf->len =3D 0;
+        return recvlen;
+    }
+    ASSERT(recvlen <=3D INT_MAX);
+    buf->len =3D (int)recvlen;
     /* FIXME: won't do anything when sock->info.af =3D=3D AF_UNSPEC */
-    if (buf->len >=3D 0 && expectedlen && fromlen !=3D expectedlen)
+    if (expectedlen && fromlen !=3D expectedlen)
     {
         bad_address_length(fromlen, expectedlen);
     }
@@ -2438,7 +2456,9 @@
 ssize_t
 link_socket_write_tcp(struct link_socket *sock, struct buffer *buf, struct=
 link_socket_actual *to)
 {
-    packet_size_type len =3D (packet_size_type)BLENZ(buf);
+    const int blen =3D BLEN(buf);
+    ASSERT(blen >=3D 0 && blen <=3D PACKET_SIZE_MAX);
+    packet_size_type len =3D (packet_size_type)blen;
     dmsg(D_STREAM_DEBUG, "STREAM: WRITE %u offset=3D%d", len, buf->offset);
     ASSERT(len <=3D sock->stream_buf.maxlen);
     len =3D htonps(len);
@@ -2450,10 +2470,6 @@
 #endif
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 #if ENABLE_IP_PKTINFO

 ssize_t
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index cd4e8ed..8b49f75 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -54,6 +54,7 @@
  */

 typedef uint16_t packet_size_type;
+#define PACKET_SIZE_MAX UINT16_MAX

 /* convert a packet_size_type from host to network order */
 #define htonps(x) htons(x)
@@ -459,7 +460,7 @@
 #endif /* if PORT_SHARE */

 static inline bool
-socket_connection_reset(const struct link_socket *sock, int status)
+socket_connection_reset(const struct link_socket *sock, ssize_t status)
 {
     if (link_socket_connection_oriented(sock))
     {
@@ -586,7 +587,7 @@
  * Socket Read Routines
  */

-int link_socket_read_tcp(struct link_socket *sock, struct buffer *buf);
+ssize_t link_socket_read_tcp(struct link_socket *sock, struct buffer *buf);

 #ifdef _WIN32

@@ -606,20 +607,20 @@

 #else  /* ifdef _WIN32 */

-int link_socket_read_udp_posix(struct link_socket *sock, struct buffer *bu=
f,
-                               struct link_socket_actual *from);
+ssize_t link_socket_read_udp_posix(struct link_socket *sock, struct buffer=
 *buf,
+                                   struct link_socket_actual *from);

 #endif /* ifdef _WIN32 */

 /* read a TCP or UDP packet from link */
-static inline int
+static inline ssize_t
 link_socket_read(struct link_socket *sock, struct buffer *buf, struct link=
_socket_actual *from)
 {
     if (proto_is_udp(sock->info.proto) || socket_is_dco_win(sock))
     /* unified UDPv4 and UDPv6, for DCO-WIN the kernel
      * will strip the length header */
     {
-        int res;
+        ssize_t res;

 #ifdef _WIN32
         res =3D link_socket_read_udp_win32(sock, buf, from);
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index 4d6dfbb..f0c5c25 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -537,7 +537,7 @@
 }

 static inline bool
-tuntap_is_dco_win_timeout(struct tuntap *tt, int status)
+tuntap_is_dco_win_timeout(struct tuntap *tt, ssize_t status)
 {
     return tuntap_is_dco_win(tt) && (status < 0) && (openvpn_errno() =3D=
=3D ERROR_NETNAME_DELETED);
 }
@@ -575,7 +575,7 @@
 }

 static inline bool
-tuntap_is_dco_win_timeout(struct tuntap *tt, int status)
+tuntap_is_dco_win_timeout(struct tuntap *tt, ssize_t status)
 {
     return false;
 }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1554?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iabe1992b2608661b862a81363574e957d18395f0
Gerrit-Change-Number: 1554
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--jMUfHgMu/4o=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #3</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1554?usp=3Demail">View C=
hange</a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">socket: Never use negative buf-&gt;len in link_s=
ocket_read*<br><br>We really don&#39;t want to use negative buf lengths in<=
br>our code. So remove some places where we did so before.<br><br>Change-Id=
: Iabe1992b2608661b862a81363574e957d18395f0<br>Signed-off-by: Frank Lichten=
held &lt;frank@...2641...&gt;<br>---<br>M src/openvpn/forward.c<br>M src/op=
envpn/socket.c<br>M src/openvpn/socket.h<br>M src/openvpn/tun.h<br>4 files =
changed, 84 insertions(+), 69 deletions(-)<br><br></pre><pre class=3D"block=
s" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git p=
ull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/54/1554/3</pre><pre=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>d=
iff --git a/src/openvpn/forward.c b/src/openvpn/forward.c</span><br><span>i=
ndex 27cfd36..20b46d3 100644</span><br><span>--- a/src/openvpn/forward.c</s=
pan><br><span>+++ b/src/openvpn/forward.c</span><br><span>@@ -929,14 +929,1=
2 @@</span><br><span>      * Set up for recvfrom call to read datagram</spa=
n><br><span>      * sent to our TCP/UDP port.</span><br><span>      */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    int status;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     /*ASSERT (=
!c-&gt;c2.to_tun.len);*/</span><br><span> </span><br><span>     c-&gt;c2.bu=
f =3D c-&gt;c2.buffers-&gt;read_link_buf;</span><br><span>     ASSERT(buf_i=
nit(&amp;c-&gt;c2.buf, c-&gt;c2.frame.buf.headroom));</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    status =3D link_socke=
t_read(sock, &amp;c-&gt;c2.buf, &amp;c-&gt;c2.from);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    ssize_t status =3D link_socket_read(s=
ock, &amp;c-&gt;c2.buf, &amp;c-&gt;c2.from);</span><br><span> </span><br><s=
pan>     if (socket_connection_reset(sock, status))</span><br><span>     {<=
/span><br><span>@@ -955,14 +953,14 @@</span><br><span>             if (even=
t_timeout_defined(&amp;c-&gt;c2.explicit_exit_notification_interval))</span=
><br><span>             {</span><br><span>                 msg(D_STREAM_ERR=
ORS,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
   &quot;Connection reset during exit notification period, ignoring [%d]&qu=
ot;, status);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
              &quot;Connection reset during exit notification period, ignor=
ing [%zd]&quot;, status);</span><br><span>                 management_sleep=
(1);</span><br><span>             }</span><br><span>             else</span=
><br><span>             {</span><br><span>                 register_signal(=
c-&gt;sig, SIGUSR1,</span><br><span>                                 &quot;=
connection-reset&quot;); /* SOFT-SIGUSR1 -- TCP connection reset */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                msg(D_STREAM_=
ERRORS, &quot;Connection reset, restarting [%d]&quot;, status);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                msg(D_STREAM_ER=
RORS, &quot;Connection reset, restarting [%zd]&quot;, status);</span><br><s=
pan>             }</span><br><span>         }</span><br><span>         retu=
rn;</span><br><span>@@ -1026,7 +1024,7 @@</span><br><span>      * Good, non=
-zero length packet received.</span><br><span>      * Commence multi-stage =
processing of packet,</span><br><span>      * such as authenticate, decrypt=
, decompress.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * I=
f any stage fails, it sets buf.len to 0 or -1,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+     * If any stage fails, it sets buf.len to 0,=
</span><br><span>      * telling downstream stages to ignore the packet.</s=
pan><br><span>      */</span><br><span>     if (c-&gt;c2.buf.len &gt; 0)</s=
pan><br><span>diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c</spa=
n><br><span>index 2d5fc50..d2170a4 100644</span><br><span>--- a/src/openvpn=
/socket.c</span><br><span>+++ b/src/openvpn/socket.c</span><br><span>@@ -11=
30,7 +1130,7 @@</span><br><span> </span><br><span> static void stream_buf_c=
lose(struct stream_buf *sb);</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-static bool stream_buf_added(struct stream_buf *sb=
, int length_added);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+static bool stream_buf_added(struct stream_buf *sb, ssize_t length_added);=
</span><br><span> </span><br><span> /* For stream protocols, allocate a buf=
fer to build up packet.</span><br><span>  * Called after frame has been fin=
alized. */</span><br><span>@@ -1792,6 +1792,10 @@</span><br><span>     }</s=
pan><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> void</span><br><span> l=
ink_socket_close(struct link_socket *sock)</span><br><span> {</span><br><sp=
an>@@ -2159,12 +2163,13 @@</span><br><span>  * @return true if \c sb-&gt;bu=
f contains fully reassembled packet</span><br><span>  */</span><br><span> s=
tatic bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-stream_buf_=
added(struct stream_buf *sb, int length_added)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+stream_buf_added(struct stream_buf *sb, ssize_t =
length_added)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    dmsg(D_STREAM_DEBUG, &quot;STREAM: ADD length_added=3D%d&quo=
t;, length_added);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   dmsg(D_STREAM_DEBUG, &quot;STREAM: ADD length_added=3D%zd&quot;, length_=
added);</span><br><span>     if (length_added &gt; 0)</span><br><span>     =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        sb-&gt;buf.l=
en +=3D length_added;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        ASSERT(sb-&gt;buf.len + length_added &lt;=3D INT_MAX);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        sb-&gt;buf.len +=3D (i=
nt)length_added;</span><br><span>     }</span><br><span> </span><br><span> =
    /* if length unknown, see if we can get the length prefix from</span><b=
r><span>@@ -2266,10 +2271,10 @@</span><br><span>  * Socket Read Routines</s=
pan><br><span>  */</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+s=
size_t</span><br><span> link_socket_read_tcp(struct link_socket *sock, stru=
ct buffer *buf)</span><br><span> {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    int len =3D 0;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    ssize_t len =3D 0;</span><br><span> </span><br><span>     i=
f (!sock-&gt;stream_buf.residual_fully_formed)</span><br><span>     {</span=
><br><span>@@ -2299,7 +2304,8 @@</span><br><span>         }</span><br><span=
>         if (len &lt;=3D 0)</span><br><span>         {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            return buf-&gt;len =3D len;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            buf-&gt;l=
en =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  return len;</span><br><span>         }</span><br><span>     }</span><br><=
span> </span><br><span>@@ -2331,14 +2337,14 @@</span><br><span>     max_int=
(CMSG_SPACE(sizeof(struct in6_pktinfo)), CMSG_SPACE(sizeof(struct in_addr))=
)</span><br><span> #endif</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-static socklen_t</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+static ssize_t</span><br><span> link_socket_read_udp_pos=
ix_recvmsg(struct link_socket *sock, struct buffer *buf,</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                                   struc=
t link_socket_actual *from)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                                   struct link_socket_actual *from,=
 socklen_t *fromlen)</span><br><span> {</span><br><span>     struct iovec i=
ov;</span><br><span>     uint8_t pktinfo_buf[PKTINFO_BUF_SIZE];</span><br><=
span>     struct msghdr mesg =3D { 0 };</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    socklen_t fromlen =3D sizeof(from-&gt;dest.addr);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    *fromlen =3D sizeof=
(from-&gt;dest.addr);</span><br><span> </span><br><span>     ASSERT(sock-&g=
t;sd &gt;=3D 0); /* can&#39;t happen */</span><br><span> </span><br><span>@=
@ -2347,62 +2353,67 @@</span><br><span>     mesg.msg_iov =3D &amp;iov;</spa=
n><br><span>     mesg.msg_iovlen =3D 1;</span><br><span>     mesg.msg_name =
=3D &amp;from-&gt;dest.addr;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    mesg.msg_namelen =3D fromlen;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    mesg.msg_namelen =3D *fromlen;</span><br><span>   =
  mesg.msg_control =3D pktinfo_buf;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    mesg.msg_controllen =3D sizeof pktinfo_buf;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    buf-&gt;len =3D recvmsg(sock-&g=
t;sd, &amp;mesg, 0);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   if (buf-&gt;len &gt;=3D 0)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    mesg.msg_controllen =3D (socklen_t)sizeof(pktinfo_buf);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    ssize_t len =3D recvm=
sg(sock-&gt;sd, &amp;mesg, 0);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if (len &lt; 0)</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        struct cmsghdr *cmsg;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        fromlen =3D mesg.msg_namele=
n;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        cmsg =3D CM=
SG_FIRSTHDR(&amp;mesg);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        if (cmsg !=3D NULL &amp;&amp; CMSG_NXTHDR(&amp;mesg, cmsg) =3D=3D=
 NULL</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        buf-&g=
t;len =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 return len;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(len &lt;=
=3D INT_MAX);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bu=
f-&gt;len =3D (int)len;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    struct cmsghdr *cmsg;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    *fromlen =3D mesg.msg_namelen;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    cmsg =3D CMSG_FIRSTHDR(&amp;mesg);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    if (cmsg !=3D NULL &amp;&am=
p; CMSG_NXTHDR(&amp;mesg, cmsg) =3D=3D NULL</span><br><span> #if defined(HA=
VE_IN_PKTINFO) &amp;&amp; defined(HAVE_IPI_SPEC_DST)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            &amp;&amp; cmsg-&gt;cmsg_level =
=3D=3D SOL_IP &amp;&amp; cmsg-&gt;cmsg_type =3D=3D IP_PKTINFO</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            &amp;&amp; cmsg-&gt;cms=
g_len &gt;=3D CMSG_LEN(sizeof(struct in_pktinfo)))</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        &amp;&amp; cmsg-&gt;cmsg_level =3D=
=3D SOL_IP &amp;&amp; cmsg-&gt;cmsg_type =3D=3D IP_PKTINFO</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        &amp;&amp; cmsg-&gt;cmsg_len=
 &gt;=3D CMSG_LEN(sizeof(struct in_pktinfo)))</span><br><span> #elif define=
d(IP_RECVDSTADDR)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        &amp;&amp; cmsg-&gt;cmsg_level =3D=3D IPPROTO_IP &amp;&amp; cmsg-&g=
t;cmsg_type =3D=3D IP_RECVDSTADDR</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            &amp;&amp; cmsg-&gt;cmsg_len &gt;=3D CMSG_LEN(sizeo=
f(struct in_addr)))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        &amp;&amp; cmsg-&gt;cmsg_level =3D=3D IPPROTO_IP &amp;&amp; cmsg-&g=
t;cmsg_type =3D=3D IP_RECVDSTADDR</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        &amp;&amp; cmsg-&gt;cmsg_len &gt;=3D CMSG_LEN(sizeof(=
struct in_addr)))</span><br><span> #else /* if defined(HAVE_IN_PKTINFO) &am=
p;&amp; defined(HAVE_IPI_SPEC_DST) */</span><br><span> #error ENABLE_IP_PKT=
INFO is set without IP_PKTINFO xor IP_RECVDSTADDR (fix syshead.h)</span><br=
><span> #endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span> #if defined(HAVE_IN_PKTINFO) &amp;&amp; defined(HAVE_IPI_SPEC_DST)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            struct in_pk=
tinfo *pkti =3D (struct in_pktinfo *)CMSG_DATA(cmsg);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            from-&gt;pi.in4.ipi_ifindex =3D=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                (sock=
-&gt;sockflags &amp; SF_PKTINFO_COPY_IIF) ? pkti-&gt;ipi_ifindex : 0;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            from-&gt;pi.in4=
.ipi_spec_dst =3D pkti-&gt;ipi_spec_dst;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        struct in_pktinfo *pkti =3D (struct in_pktinfo=
 *)CMSG_DATA(cmsg);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        from-&gt;pi.in4.ipi_ifindex =3D</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            (sock-&gt;sockflags &amp; SF_PKTINFO_COPY_I=
IF) ? pkti-&gt;ipi_ifindex : 0;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        from-&gt;pi.in4.ipi_spec_dst =3D pkti-&gt;ipi_spec_dst;=
</span><br><span> #elif defined(IP_RECVDSTADDR)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            from-&gt;pi.in4 =3D *(struct in_addr =
*)CMSG_DATA(cmsg);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       from-&gt;pi.in4 =3D *(struct in_addr *)CMSG_DATA(cmsg);</span><br><s=
pan> #else /* if defined(HAVE_IN_PKTINFO) &amp;&amp; defined(HAVE_IPI_SPEC_=
DST) */</span><br><span> #error ENABLE_IP_PKTINFO is set without IP_PKTINFO=
 xor IP_RECVDSTADDR (fix syshead.h)</span><br><span> #endif</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        else if (cmsg !=3D NULL &amp;&amp; CMSG_N=
XTHDR(&amp;mesg, cmsg) =3D=3D NULL</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                 &amp;&amp; cmsg-&gt;cmsg_level =3D=3D IPPROTO=
_IPV6 &amp;&amp; cmsg-&gt;cmsg_type =3D=3D IPV6_PKTINFO</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                 &amp;&amp; cmsg-&gt;cmsg=
_len &gt;=3D CMSG_LEN(sizeof(struct in6_pktinfo)))</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            struct in6_pktinfo *pkti6 =3D (struct in6_pkti=
nfo *)CMSG_DATA(cmsg);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            from-&gt;pi.in6.ipi6_ifindex =3D</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                (sock-&gt;sockflags &amp; SF_PKTINF=
O_COPY_IIF) ? pkti6-&gt;ipi6_ifindex : 0;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            from-&gt;pi.in6.ipi6_addr =3D pkti6-&gt;ipi=
6_addr;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        else if (cmsg !=3D=
 NULL)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_WARN,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                &quot;CMS=
G received that cannot be parsed (cmsg_level=3D%d, cmsg_type=3D%d, cmsg=3Dl=
en=3D%d)&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
          (int)cmsg-&gt;cmsg_level, (int)cmsg-&gt;cmsg_type, (int)cmsg-&gt;=
cmsg_len);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    else if (cmsg !=3D NULL &amp;&a=
mp; CMSG_NXTHDR(&amp;mesg, cmsg) =3D=3D NULL</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+             &amp;&amp; cmsg-&gt;cmsg_level =3D=3D=
 IPPROTO_IPV6 &amp;&amp; cmsg-&gt;cmsg_type =3D=3D IPV6_PKTINFO</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+             &amp;&amp; cmsg-&g=
t;cmsg_len &gt;=3D CMSG_LEN(sizeof(struct in6_pktinfo)))</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        struct in6_pktinfo *pkti6 =3D (struct in6_pk=
tinfo *)CMSG_DATA(cmsg);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        from-&gt;pi.in6.ipi6_ifindex =3D</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            (sock-&gt;sockflags &amp; SF_PKTINFO_=
COPY_IIF) ? pkti6-&gt;ipi6_ifindex : 0;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        from-&gt;pi.in6.ipi6_addr =3D pkti6-&gt;ipi6_ad=
dr;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    else if (cmsg !=3D NULL)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            &quot;CMSG received tha=
t cannot be parsed (cmsg_level=3D%d, cmsg_type=3D%d, cmsg=3Dlen=3D%d)&quot;=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            (int)c=
msg-&gt;cmsg_level, (int)cmsg-&gt;cmsg_type, (int)cmsg-&gt;cmsg_len);</span=
><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    return fromlen;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    return buf-&gt;len;</span><br><span> }</span><br><span> #=
endif /* if ENABLE_IP_PKTINFO */</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-int</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ssize_t</span><br><span> link_socket_read_udp_posix(struct lin=
k_socket *sock, struct buffer *buf,</span><br><span>                       =
     struct link_socket_actual *from)</span><br><span> {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    ssize_t recvlen;</span><br><span> =
    socklen_t fromlen =3D sizeof(from-&gt;dest.addr);</span><br><span>     =
socklen_t expectedlen =3D af_addr_size(sock-&gt;info.af);</span><br><span> =
    addr_zero_host(&amp;from-&gt;dest);</span><br><span>@@ -2413,16 +2424,2=
3 @@</span><br><span>     /* Both PROTO_UDPv4 and PROTO_UDPv6 */</span><br>=
<span>     if (sock-&gt;info.proto =3D=3D PROTO_UDP &amp;&amp; sock-&gt;soc=
kflags &amp; SF_USE_IP_PKTINFO)</span><br><span>     {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        fromlen =3D link_socket_read_udp_p=
osix_recvmsg(sock, buf, from);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        recvlen =3D link_socket_read_udp_posix_recvmsg(sock, buf=
, from, &amp;fromlen);</span><br><span>     }</span><br><span>     else</sp=
an><br><span> #endif</span><br><span>     {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        buf-&gt;len =3D recvfrom(sock-&gt;sd, BPTR(bu=
f), buf_forward_capacity(buf), 0, &amp;from-&gt;dest.addr.sa,</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                            &amp;fr=
omlen);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        recv=
len =3D recvfrom(sock-&gt;sd, BPTR(buf), buf_forward_capacity(buf), 0,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                        =
   &amp;from-&gt;dest.addr.sa, &amp;fromlen);</span><br><span>     }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    if (recvlen &lt; 0)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        buf-&gt;len =3D 0;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        return recvlen;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    ASSERT(recvlen &lt;=3D INT_MAX);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf-&gt;len =3D (i=
nt)recvlen;</span><br><span>     /* FIXME: won&#39;t do anything when sock-=
&gt;info.af =3D=3D AF_UNSPEC */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    if (buf-&gt;len &gt;=3D 0 &amp;&amp; expectedlen &amp;&amp; f=
romlen !=3D expectedlen)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if (expectedlen &amp;&amp; fromlen !=3D expectedlen)</span><br><sp=
an>     {</span><br><span>         bad_address_length(fromlen, expectedlen)=
;</span><br><span>     }</span><br><span>@@ -2438,7 +2456,9 @@</span><br><s=
pan> ssize_t</span><br><span> link_socket_write_tcp(struct link_socket *soc=
k, struct buffer *buf, struct link_socket_actual *to)</span><br><span> {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    packet_size_type len=
 =3D (packet_size_type)BLENZ(buf);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    const int blen =3D BLEN(buf);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    ASSERT(blen &gt;=3D 0 &amp;&amp; blen &lt;=
=3D PACKET_SIZE_MAX);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    packet_size_type len =3D (packet_size_type)blen;</span><br><span>    =
 dmsg(D_STREAM_DEBUG, &quot;STREAM: WRITE %u offset=3D%d&quot;, len, buf-&g=
t;offset);</span><br><span>     ASSERT(len &lt;=3D sock-&gt;stream_buf.maxl=
en);</span><br><span>     len =3D htonps(len);</span><br><span>@@ -2450,10 =
+2470,6 @@</span><br><span> #endif</span><br><span> }</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || =
defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pr=
agma GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan> #if ENABLE_IP_PKTINFO</span><br><span> </span><br><span> ssize_t</span=
><br><span>diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h</span><=
br><span>index cd4e8ed..8b49f75 100644</span><br><span>--- a/src/openvpn/so=
cket.h</span><br><span>+++ b/src/openvpn/socket.h</span><br><span>@@ -54,6 =
+54,7 @@</span><br><span>  */</span><br><span> </span><br><span> typedef ui=
nt16_t packet_size_type;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#define PACKET_SIZE_MAX UINT16_MAX</span><br><span> </span><br><span> =
/* convert a packet_size_type from host to network order */</span><br><span=
> #define htonps(x) htons(x)</span><br><span>@@ -459,7 +460,7 @@</span><br>=
<span> #endif /* if PORT_SHARE */</span><br><span> </span><br><span> static=
 inline bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-socket_co=
nnection_reset(const struct link_socket *sock, int status)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+socket_connection_reset(const struct=
 link_socket *sock, ssize_t status)</span><br><span> {</span><br><span>    =
 if (link_socket_connection_oriented(sock))</span><br><span>     {</span><b=
r><span>@@ -586,7 +587,7 @@</span><br><span>  * Socket Read Routines</span>=
<br><span>  */</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-int link_socket_read_tcp(struct link_socket *sock, struct buffer=
 *buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ssize_t link=
_socket_read_tcp(struct link_socket *sock, struct buffer *buf);</span><br><=
span> </span><br><span> #ifdef _WIN32</span><br><span> </span><br><span>@@ =
-606,20 +607,20 @@</span><br><span> </span><br><span> #else  /* ifdef _WIN3=
2 */</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-int link_socket_read_udp_posix(struct link_socket *sock, struct buffer *bu=
f,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
            struct link_socket_actual *from);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ssize_t link_socket_read_udp_posix(struct link_so=
cket *sock, struct buffer *buf,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                                   struct link_socket_actual *f=
rom);</span><br><span> </span><br><span> #endif /* ifdef _WIN32 */</span><b=
r><span> </span><br><span> /* read a TCP or UDP packet from link */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-static inline int</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+static inline ssize_t</span><br=
><span> link_socket_read(struct link_socket *sock, struct buffer *buf, stru=
ct link_socket_actual *from)</span><br><span> {</span><br><span>     if (pr=
oto_is_udp(sock-&gt;info.proto) || socket_is_dco_win(sock))</span><br><span=
>     /* unified UDPv4 and UDPv6, for DCO-WIN the kernel</span><br><span>  =
    * will strip the length header */</span><br><span>     {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        int res;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        ssize_t res;</span><br><span> <=
/span><br><span> #ifdef _WIN32</span><br><span>         res =3D link_socket=
_read_udp_win32(sock, buf, from);</span><br><span>diff --git a/src/openvpn/=
tun.h b/src/openvpn/tun.h</span><br><span>index 4d6dfbb..f0c5c25 100644</sp=
an><br><span>--- a/src/openvpn/tun.h</span><br><span>+++ b/src/openvpn/tun.=
h</span><br><span>@@ -537,7 +537,7 @@</span><br><span> }</span><br><span> <=
/span><br><span> static inline bool</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-tuntap_is_dco_win_timeout(struct tuntap *tt, int status)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+tuntap_is_dco_win_timeou=
t(struct tuntap *tt, ssize_t status)</span><br><span> {</span><br><span>   =
  return tuntap_is_dco_win(tt) &amp;&amp; (status &lt; 0) &amp;&amp; (openv=
pn_errno() =3D=3D ERROR_NETNAME_DELETED);</span><br><span> }</span><br><spa=
n>@@ -575,7 +575,7 @@</span><br><span> }</span><br><span> </span><br><span>=
 static inline bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tu=
ntap_is_dco_win_timeout(struct tuntap *tt, int status)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+tuntap_is_dco_win_timeout(struct tuntap =
*tt, ssize_t status)</span><br><span> {</span><br><span>     return false;<=
/span><br><span> }</span><br><span></span><br></pre><p>To view, visit <a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1554?usp=3Demail">change 1554</=
a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope=
 itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"act=
ion" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1554?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iabe1992b2608661b862a8136357=
4e957d18395f0 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1554 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--jMUfHgMu/4o=--

