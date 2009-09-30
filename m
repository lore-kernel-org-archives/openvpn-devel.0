Sender: JuanJo Ciarlante <juanjosec@...277...>
Date: Thu, 1 Oct 2009 00:19:42 +0200
From: JuanJo Ciarlante <jjo+ml@...410...>
Message-ID: <20090930221942.GA28717@...1266...>
References: <7bb795fd0909251436v2369d6d5q674e63e0621fcd56@...278...>
	<200909301941.01923.mailinglists@...1145...>
	<7bb795fd0909301120veaf5f48gb65b081cd2cb09a3@...278...>
	<200909302047.07444.mailinglists@...1145...>
	<7bb795fd0909301421i5fd974b5xbe8d352b7b7f3c9a@...278...>
MIME-Version: 1.0
In-Reply-To: <7bb795fd0909301421i5fd974b5xbe8d352b7b7f3c9a@...278...>
Subject: Re: [Openvpn-devel] [PATCH] openvpn over ipv6 support -v0.4.6
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Marcel =?iso-8859-1?Q?Pennewi=DF?= <mailinglists@...1145...>
Cc: openvpn-devel@lists.sourceforge.net

On Wed, Sep 30, 2009 at 11:21:41PM +0200, JuanJo Ciarlante wrote:
> On Wed, Sep 30, 2009 at 8:47 PM, Marcel Pennewi=DF
> <mailinglists@...1145...>wrote:
>=20
> > On Wednesday 30 September 2009 20:20:40 JuanJo Ciarlante wrote:
> > > Could you please copy me the the exact cmdline and context (inetd?)
> > > you are using in both cases?, also if there's any extra patch applied,
> > etc.
> >
> > /usr/sbin/openvpn --config /etc/openvpn/tcp.conf --writepid
> > /var/run/openvpn.tcp.pid --daemon --setenv
> > SVCNAME openvpn.tcp --cd /etc/openvpn
> >
> > /etc/openvpn/tcp.conf:
> > port 897
> > proto tcp6-server
> > dev tap1
> > server-bridge 192.168.42.253 255.255.255.0 192.168.42.1 192.168.42.200
> >
> > tls-server
> > dh /etc/openvpn/files/dh2048.pem
> > ca /etc/openvpn/files/ca.pem
> > cert /etc/openvpn/files/cert.pem
> > key /etc/openvpn/files/key.pem
> > comp-lzo
> > client-to-client
> > client-config-dir /etc/openvpn/clients
> > persist-tun
> > persist-key
> > keepalive 10 120
> > script-security 2
> > user nobody
> > group nogroup
> > verb 3
> >
> > patch applied from gentoo ebuild:
> > --- socket.c~   2008-11-02 01:39:00.406009999 +0100
> > +++ socket.c    2008-11-02 01:39:00.406009999 +0100
> > @@ -22,6 +22,7 @@
> >  *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> >  */
> >
> > +#define _GNU_SOURCE
> >  #include "syshead.h"
> >
> >  #include "socket.h"
> >
> > thx,
> >
>=20
> Cool ... it's crashing for me also (yaY!) , it's something in the
> multi-client path
> that I hadn't handled, will work on it tomorrow.

Please apply this patch:
From 3afb64b8255fa28e488e793259b2f3de94840b01 Mon Sep 17 00:00:00 2001
From: JuanJo Ciarlante <jjo@...410...>
Date: Thu, 1 Oct 2009 00:15:12 +0200
Subject: [PATCH] * fix multi-tcp crash (corrected assertion)

---
 mtcp.c   |    6 +++++-
 socket.c |    6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/mtcp.c b/mtcp.c
index f578429..7e2b07d 100644
--- a/mtcp.c
+++ b/mtcp.c
@@ -153,7 +153,11 @@ multi_tcp_instance_specific_init (struct multi_context=
 *m, struct multi_instance
   ASSERT (mi->context.c2.link_socket);
   ASSERT (mi->context.c2.link_socket->info.lsa);
   ASSERT (mi->context.c2.link_socket->mode =3D=3D LS_MODE_TCP_ACCEPT_FROM);
-  ASSERT (mi->context.c2.link_socket->info.lsa->actual.dest.addr.sa.sa_fam=
ily =3D=3D AF_INET);
+  ASSERT (mi->context.c2.link_socket->info.lsa->actual.dest.addr.sa.sa_fam=
ily =3D=3D AF_INET
+#ifdef USE_PF_INET6
+	  || mi->context.c2.link_socket->info.lsa->actual.dest.addr.sa.sa_family =
=3D=3D AF_INET6
+#endif
+	  );
   if (!mroute_extract_openvpn_sockaddr (&mi->real, &mi->context.c2.link_so=
cket->info.lsa->actual.dest, true))
     {
       msg (D_MULTI_ERRORS, "MULTI TCP: TCP client address is undefined");
diff --git a/socket.c b/socket.c
index 00d841e..97e6234 100644
--- a/socket.c
+++ b/socket.c
@@ -1616,7 +1616,11 @@ link_socket_init_phase1 (struct link_socket *sock,
   if (mode =3D=3D LS_MODE_TCP_ACCEPT_FROM)
     {
       ASSERT (accept_from);
-      ASSERT (sock->info.proto =3D=3D PROTO_TCPv4_SERVER);
+      ASSERT (sock->info.proto =3D=3D PROTO_TCPv4_SERVER
+#ifdef USE_PF_INET6
+	      || sock->info.proto =3D=3D PROTO_TCPv6_SERVER
+#endif
+	     );
       ASSERT (!sock->inetd);
       sock->sd =3D accept_from->sd;
     }
--=20
1.5.4.3

I tested your config upto full connection, and seems to work.

Cheers,
--=20
--JuanJo ; echo jAjo@...1263... | sed 's/[SPAM]//g'

