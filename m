Date: Thu, 24 Mar 2011 23:59:00 +0100
From: JuanJo Ciarlante <jjo+ml@...410...>
Message-ID: <20110324225858.GC26539@...1453...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f+W+jCU1fRNres8c"
Content-Disposition: inline
Subject: [Openvpn-devel] [PATCH 3/3] ipv6-0.4.15: add --multihome support to
	xBSD
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--f+W+jCU1fRNres8c
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

NOTE: this is patch 3/3 over feat_ipv6_transport branch,
      commit 1b96baa8fc964bfba8bfba87f1e0e1fbabf0b47b

   - _both_ for IPv4 (which was missing) and for IPv6
   - tested on OpenBSD 4.7, FreeBSD 8.1

Signed-off-by: JuanJo Ciarlante <jjo@...410...>
---
 socket.c  |   45 ++++++++++++++++++++++++++++++++++++++++++++-
 socket.h  |   10 ++++++++++
 syshead.h |    5 +++--
 3 files changed, 57 insertions(+), 3 deletions(-)

diff --git a/socket.c b/socket.c
index d9e6bc9..a6f41b5 100644
--- a/socket.c
+++ b/socket.c
@@ -813,9 +813,17 @@ create_socket_udp (const unsigned int flags)
   else if (flags & SF_USE_IP_PKTINFO)
     {
       int pad =3D 1;
+#ifdef IP_PKTINFO
       if (setsockopt (sd, SOL_IP, IP_PKTINFO,
 		      (void*)&pad, sizeof(pad)) < 0)
         msg(M_SOCKERR, "UDP: failed setsockopt for IP_PKTINFO");
+#elif defined(IP_RECVDSTADDR)
+      if (setsockopt (sd, IPPROTO_IP, IP_RECVDSTADDR,
+		      (void*)&pad, sizeof(pad)) < 0)
+        msg(M_SOCKERR, "UDP: failed setsockopt for IP_RECVDSTADDR");
+#else
+#error ENABLE_IP_PKTINFO is set without IP_PKTINFO xor IP_RECVDSTADDR (fix=
 syshead.h)
+#endif
     }
 #endif
   return sd;
@@ -2474,8 +2482,15 @@ print_link_socket_actual_ex (const struct link_socke=
t_actual *act,
 		  struct openvpn_sockaddr sa;
 		  CLEAR (sa);
 		  sa.addr.in4.sin_family =3D AF_INET;
+#ifdef IP_PKTINFO
 		  sa.addr.in4.sin_addr =3D act->pi.in4.ipi_spec_dst;
 		  if_indextoname(act->pi.in4.ipi_ifindex, ifname);
+#elif defined(IP_RECVDSTADDR)
+		  sa.addr.in4.sin_addr =3D act->pi.in4;
+		  ifname[0]=3D0;
+#else
+#error ENABLE_IP_PKTINFO is set without IP_PKTINFO xor IP_RECVDSTADDR (fix=
 syshead.h)
+#endif
 		  buf_printf (&out, " (via %s%%%s)",
 			      print_sockaddr_ex (&sa, separator, 0, gc),
 			      ifname);
@@ -2819,7 +2834,12 @@ link_socket_read_tcp (struct link_socket *sock,
 struct openvpn_in4_pktinfo
 {
   struct cmsghdr cmsghdr;
+#ifdef HAVE_IN_PKTINFO
   struct in_pktinfo pi4;
+#endif
+#ifdef IP_RECVDSTADDR
+  struct in_addr pi4;
+#endif
 };
 #ifdef USE_PF_INET6
 struct openvpn_in6_pktinfo
@@ -2864,13 +2884,26 @@ link_socket_read_udp_posix_recvmsg (struct link_soc=
ket *sock,
       cmsg =3D CMSG_FIRSTHDR (&mesg);
       if (cmsg !=3D NULL
 	  && CMSG_NXTHDR (&mesg, cmsg) =3D=3D NULL
+#ifdef IP_PKTINFO
 	  && cmsg->cmsg_level =3D=3D SOL_IP=20
 	  && cmsg->cmsg_type =3D=3D IP_PKTINFO
+#elif defined(IP_RECVDSTADDR)
+	  && cmsg->cmsg_level =3D=3D IPPROTO_IP
+	  && cmsg->cmsg_type =3D=3D IP_RECVDSTADDR
+#else
+#error ENABLE_IP_PKTINFO is set without IP_PKTINFO xor IP_RECVDSTADDR (fix=
 syshead.h)
+#endif
 	  && cmsg->cmsg_len >=3D sizeof (struct openvpn_in4_pktinfo))
 	{
+#ifdef IP_PKTINFO
 	  struct in_pktinfo *pkti =3D (struct in_pktinfo *) CMSG_DATA (cmsg);
 	  from->pi.in4.ipi_ifindex =3D pkti->ipi_ifindex;
 	  from->pi.in4.ipi_spec_dst =3D pkti->ipi_spec_dst;
+#elif defined(IP_RECVDSTADDR)
+	  from->pi.in4 =3D *(struct in_addr*) CMSG_DATA (cmsg);
+#else
+#error ENABLE_IP_PKTINFO is set without IP_PKTINFO xor IP_RECVDSTADDR (fix=
 syshead.h)
+#endif
 	}
 #ifdef USE_PF_INET6
       else if (cmsg !=3D NULL
@@ -2955,7 +2988,6 @@ link_socket_write_udp_posix_sendmsg (struct link_sock=
et *sock,
     case AF_INET:
       {
         struct openvpn_in4_pktinfo msgpi4;
-        struct in_pktinfo *pkti;
         mesg.msg_name =3D &to->dest.addr.sa;
         mesg.msg_namelen =3D sizeof (struct sockaddr_in);
         mesg.msg_control =3D &msgpi4;
@@ -2963,12 +2995,23 @@ link_socket_write_udp_posix_sendmsg (struct link_so=
cket *sock,
         mesg.msg_flags =3D 0;
         cmsg =3D CMSG_FIRSTHDR (&mesg);
         cmsg->cmsg_len =3D sizeof (struct openvpn_in4_pktinfo);
+#ifdef HAVE_IN_PKTINFO
         cmsg->cmsg_level =3D SOL_IP;
         cmsg->cmsg_type =3D IP_PKTINFO;
+	{
+        struct in_pktinfo *pkti;
         pkti =3D (struct in_pktinfo *) CMSG_DATA (cmsg);
         pkti->ipi_ifindex =3D to->pi.in4.ipi_ifindex;
         pkti->ipi_spec_dst =3D to->pi.in4.ipi_spec_dst;
         pkti->ipi_addr.s_addr =3D 0;
+	}
+#elif defined(IP_RECVDSTADDR)
+        cmsg->cmsg_level =3D IPPROTO_IP;
+        cmsg->cmsg_type =3D IP_RECVDSTADDR;
+        *(struct in_addr *) CMSG_DATA (cmsg) =3D to->pi.in4;
+#else
+#error ENABLE_IP_PKTINFO is set without IP_PKTINFO xor IP_RECVDSTADDR (fix=
 syshead.h)
+#endif
         break;
       }
 #ifdef USE_PF_INET6
diff --git a/socket.h b/socket.h
index 757c1f8..de6d525 100644
--- a/socket.h
+++ b/socket.h
@@ -86,7 +86,12 @@ struct link_socket_actual
   struct openvpn_sockaddr dest;
 #if ENABLE_IP_PKTINFO
   union {
+#ifdef HAVE_IN_PKTINFO
     struct in_pktinfo in4;
+#endif
+#ifdef IP_RECVDSTADDR
+    struct in_addr in4;
+#endif
 #ifdef USE_PF_INET6
     struct in6_pktinfo in6;
 #endif
@@ -576,7 +581,12 @@ addr_defined_ipi (const struct link_socket_actual *lsa)
 #if ENABLE_IP_PKTINFO
   if (!lsa) return 0;
   switch (lsa->dest.addr.sa.sa_family) {
+#ifdef HAVE_IN_PKTINFO
     case AF_INET: return lsa->pi.in4.ipi_spec_dst.s_addr !=3D 0;
+#endif
+#ifdef IP_RECVDSTADDR
+    case AF_INET: return lsa->pi.in4.s_addr !=3D 0;
+#endif
 #ifdef USE_PF_INET6
     case AF_INET6: return !IN6_IS_ADDR_UNSPECIFIED(&lsa->pi.in6.ipi6_addr);
 #endif
diff --git a/syshead.h b/syshead.h
index 7577cd5..ca3358a 100644
--- a/syshead.h
+++ b/syshead.h
@@ -393,9 +393,10 @@
 #endif
=20
 /*
- * Does this platform support linux-style IP_PKTINFO?
+ * Does this platform support linux-style IP_PKTINFO
+ * or bsd-style IP_RECVDSTADDR ?
  */
-#if defined(ENABLE_MULTIHOME) && defined(HAVE_IN_PKTINFO) && defined(IP_PK=
TINFO) && defined(HAVE_MSGHDR) && defined(HAVE_CMSGHDR) && defined(HAVE_IOV=
EC) && defined(CMSG_FIRSTHDR) && defined(CMSG_NXTHDR) && defined(HAVE_RECVM=
SG) && defined(HAVE_SENDMSG)
+#if defined(ENABLE_MULTIHOME) && ((defined(HAVE_IN_PKTINFO)&&defined(IP_PK=
TINFO)) || defined(IP_RECVDSTADDR)) && defined(HAVE_MSGHDR) && defined(HAVE=
_CMSGHDR) && defined(HAVE_IOVEC) && defined(CMSG_FIRSTHDR) && defined(CMSG_=
NXTHDR) && defined(HAVE_RECVMSG) && defined(HAVE_SENDMSG)
 #define ENABLE_IP_PKTINFO 1
 #else
 #define ENABLE_IP_PKTINFO 0
--=20
1.7.1




--=20
--JuanJo
oO Juan Jose Ciarlante - juanjosec Ogmail.com - jjo O{um.edu.ar,google.com}
Oo gpg --keyserver wwwkeys.eu.pgp.net --recv-key 81276430

--f+W+jCU1fRNres8c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk2LzLIACgkQo/fiSWZycXdz7wCggTBK1abwa3rtmmME5Cq+08Jh
EWoAoJkn8WFM9j+ykfG/Sf4o4qSUYBk1
=yib7
-----END PGP SIGNATURE-----

--f+W+jCU1fRNres8c--

