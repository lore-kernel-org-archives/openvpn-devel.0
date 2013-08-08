MIME-Version: 1.0
Date: Thu, 8 Aug 2013 13:59:13 -0400
Message-ID: <CANfRfr0zuKi5mf0vAFXPvnRtrsyyFx3EtpGpbzNJsCLBnqZxLA@...278...>
From: Jesse Glick <jglick@...1836...>
Subject: [Openvpn-devel] [PATCH 2/2] When using UDP over SOCKS5,
 send the actual remote hostname (FQDN) to the proxy server in the
 first packet.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Also as: https://github.com/OpenVPN/openvpn/pull/6

I was exploring the possibility of using a SOCKS5 server to multiplex
OpenVPN connections based on hostname (in the remote option), akin to
how HTTP reverse proxies commonly delegate to a physical server
according to the HTTP 1.1 Host header=E2=80=94so that many hostnames can map
to the same IP of the reverse proxy.

I found that the SOCKS5 protocol does support DOMAINNAME rather than
IP V4 when using the UDP relay server. However, OpenVPN was never
using this option; it always sent a preresolved IP (v4) address,
giving the proxy server no way of inferring what hostname was
originally requested.

This patch amends the socks_process_outgoing_udp method to send
DOMAINNAME for the first datagram of the connection, when an FQDN was
specified. Thereafter it sends IP V4since this is more compact=E2=80=94and
experimentation with the Dante server revealed that it
calledcgethostbyname on many, if not all, such datagrams it received,
which could be quite expensive. Since in the case of OpenVPN the
=E2=80=9Cdesired destination address=E2=80=9D is constant for the life of t=
he tunnel,
it should suffice to send the hostname just once.

socks_adjust_frame_parameters also needed to be changed to allow for
the worst-case buffer size, a 255-character hostname (Linux generally
only allows 64) plus fixed-length fields (7 bytes). It would be nicer
to set this according to the actual hostname length, but I could not
see how to obtain that hostname during this early stage of
initialization.

Filing this for the purpose of getting feedback. Probably there needs
to be a user option to configure this behavior:

=C2=B7 disable (restoring original behavior; perhaps the default)
=C2=B7 enable for first packet only (as in the current patch)
=C2=B7 enable for all packets, which could be useful in case the reverse
proxy is using a single UDP relay server for many clients (since
SOCKS5 offers no apparent connection identifier other than the
BND.PORT)

Note that the original code probably does not work with IPv6, but I
did not attempt to address that in this patch.

 src/openvpn/forward.c |  2 +-
 src/openvpn/openvpn.h |  5 +++++
 src/openvpn/socks.c   | 38 +++++++++++++++++++++++++++-----------
 src/openvpn/socks.h   |  3 +--
 4 files changed, 34 insertions(+), 14 deletions(-)

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 447b86d..ba084aa 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -631,7 +631,7 @@ socks_preprocess_outgoing_link (struct context *c,
 {
   if (c->c2.link_socket->socks_proxy && c->c2.link_socket->info.proto
=3D=3D PROTO_UDPv4)
     {
-      *size_delta +=3D socks_process_outgoing_udp (&c->c2.to_link,
c->c2.to_link_addr);
+      *size_delta +=3D socks_process_outgoing_udp (c);
       *to_addr =3D &c->c2.link_socket->socks_relay;
     }
 }
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index 606a4f5..e040fe7 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -291,6 +291,11 @@ struct context_2
   counter_type n_trunc_post_decrypt;
 #endif

+#ifdef ENABLE_SOCKS
+  /* Set to true after first UDP packet sent over SOCKS, so we only
send ATYP=3DDOMAINNAME once */
+  bool socks_sent_hostname;
+#endif
+
   /*
    * Timer objects for ping and inactivity
    * timeout features.
diff --git a/src/openvpn/socks.c b/src/openvpn/socks.c
index 235982e..d98887f 100644
--- a/src/openvpn/socks.c
+++ b/src/openvpn/socks.c
@@ -49,14 +49,17 @@
 #include "proxy.h"

 #include "memdbg.h"
+#include "openvpn.h"

 #define UP_TYPE_SOCKS "SOCKS Proxy"

+/* See \c socks_process_outgoing_udp for motivation. */
 void
 socks_adjust_frame_parameters (struct frame *frame, int proto)
 {
   if (proto =3D=3D PROTO_UDPv4)
-    frame_add_to_extra_link (frame, 10);
+    // TODO no access to remote_host at this time, so have to assume the w=
orst
+    frame_add_to_extra_link (frame, 255 + 7);
 }

 struct socks_proxy_info *
@@ -510,33 +513,46 @@ socks_process_incoming_udp (struct buffer *buf,
 }

 /*
- * Add a 10 byte socks header prior to UDP write.
- * *to is the destination address.
+ * Add a socks header prior to UDP write.
  *
  * Run before UDP write.
  * Returns the size of the header.
  */
 int
-socks_process_outgoing_udp (struct buffer *buf,
-    const struct link_socket_actual *to)
+socks_process_outgoing_udp (struct context *c)
 {
+  struct link_socket_actual *to =3D c->c2.to_link_addr;
+  const char *host =3D c->c2.link_socket->remote_host;
   /*
-   * Get a 10 byte subset buffer prepended to buf --
+   * Get a subset buffer prepended to buf --
    * we expect these bytes will be here because
    * we allocated frame space in socks_adjust_frame_parameters.
    */
-  struct buffer head =3D buf_sub (buf, 10, true);
+  int len =3D c->c2.socks_sent_hostname ||
ip_addr_dotted_quad_safe(host) ? /* use ATYP =3D IP V4 */ 0 :
strlen(host);
+  c->c2.socks_sent_hostname =3D true; // only ever use ATYP =3D
DOMAINNAME once per connection
+  int size =3D len ? len + 7 : 10;
+  struct buffer head =3D buf_sub (&c->c2.to_link, size, true);

   /* crash if not enough headroom in buf */
   ASSERT (buf_defined (&head));

   buf_write_u16 (&head, 0); /* RSV =3D 0 */
   buf_write_u8 (&head, 0); /* FRAG =3D 0 */
-  buf_write_u8 (&head, '\x01'); /* ATYP =3D 1 (IP V4) */
-  buf_write (&head, &to->dest.addr.in4.sin_addr, sizeof
(to->dest.addr.in4.sin_addr));
-  buf_write (&head, &to->dest.addr.in4.sin_port, sizeof
(to->dest.addr.in4.sin_port));
+  if (len)
+    {
+      msg(M_INFO, "Sending hostname %s to SOCKS5 proxy", host);
+      buf_write_u8(&head, '\x03'); /* ATYP =3D 3 (DOMAINNAME) */
+      buf_write_u8(&head, len);
+      buf_write(&head, host, len);
+    }
+  else
+    {
+      buf_write_u8(&head, '\x01'); /* ATYP =3D 1 (IP V4) */
+      buf_write(&head, &to->dest.addr.in4.sin_addr, /* 4 */sizeof
(to->dest.addr.in4.sin_addr));
+    }
+  buf_write (&head, &to->dest.addr.in4.sin_port, /* 2 */sizeof
(to->dest.addr.in4.sin_port));

-  return 10;
+  return size;
 }

 #else
diff --git a/src/openvpn/socks.h b/src/openvpn/socks.h
index b55ff6f..a6160d2 100644
--- a/src/openvpn/socks.h
+++ b/src/openvpn/socks.h
@@ -70,8 +70,7 @@ void establish_socks_proxy_udpassoc (struct
socks_proxy_info *p,
 void socks_process_incoming_udp (struct buffer *buf,
  struct link_socket_actual *from);

-int socks_process_outgoing_udp (struct buffer *buf,
- const struct link_socket_actual *to);
+int socks_process_outgoing_udp (struct context *c);

 #endif
 #endif
--=20
1.8.1.2

