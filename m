Date: Thu, 24 Mar 2011 23:57:19 +0100
From: JuanJo Ciarlante <jjo+ml@...410...>
Message-ID: <20110324225717.GA26539@...1453...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline
Subject: [Openvpn-devel] [PATCH 1/3] fix --multihome for ipv6:
	IPV6_RECVPKTINFO
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

NOTE: this is patch 1/3 over feat_ipv6_transport branch,
      commit 1b96baa8fc964bfba8bfba87f1e0e1fbabf0b47b

   - setsockopt IPV6_RECVPKTINFO (not IPV6_PKTINFO!)
   - do check for setsockopt() failures
   - append %<iface> in INFO msg

Signed-off-by: JuanJo Ciarlante <jjo@...410...>
---
 socket.c |   27 +++++++++++++++++----------
 1 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/socket.c b/socket.c
index 810bb23..08cab0e 100644
--- a/socket.c
+++ b/socket.c
@@ -813,7 +813,9 @@ create_socket_udp (const unsigned int flags)
   else if (flags & SF_USE_IP_PKTINFO)
     {
       int pad =3D 1;
-      setsockopt (sd, SOL_IP, IP_PKTINFO, (void*)&pad, sizeof(pad));
+      if (setsockopt (sd, SOL_IP, IP_PKTINFO,
+		      (void*)&pad, sizeof(pad)) < 0)
+        msg(M_SOCKERR, "UDP: failed setsockopt for IP_PKTINFO");
     }
 #endif
   return sd;
@@ -831,7 +833,9 @@ create_socket_udp6 (const unsigned int flags)
   else if (flags & SF_USE_IP_PKTINFO)
     {
       int pad =3D 1;
-      setsockopt (sd, IPPROTO_IPV6, IPV6_PKTINFO, (void*)&pad, sizeof(pad)=
);
+      if (setsockopt (sd, IPPROTO_IPV6, IPV6_RECVPKTINFO,
+		      (void*)&pad, sizeof(pad)) < 0)
+	msg(M_SOCKERR, "UDP: failed setsockopt for IPV6_RECVPKTINFO");
     }
 #endif
   return sd;
@@ -2423,6 +2427,7 @@ print_link_socket_actual_ex (const struct link_socket=
_actual *act,
 {
   if (act)
     {
+      char ifname[IF_NAMESIZE] =3D "[undef]";
       struct buffer out =3D alloc_buf_gc (128, gc);
       buf_printf (&out, "%s", print_sockaddr_ex (&act->dest, separator, fl=
ags, gc));
 #if ENABLE_IP_PKTINFO
@@ -2438,7 +2443,10 @@ print_link_socket_actual_ex (const struct link_socke=
t_actual *act,
 		  CLEAR (sa);
 		  sa.addr.in4.sin_family =3D AF_INET;
 		  sa.addr.in4.sin_addr =3D act->pi.in4.ipi_spec_dst;
-		  buf_printf (&out, " (via %s)", print_sockaddr_ex (&sa, separator, 0, g=
c));
+		  if_indextoname(act->pi.in4.ipi_ifindex, ifname);
+		  buf_printf (&out, " (via %s%%%s)",
+			      print_sockaddr_ex (&sa, separator, 0, gc),
+			      ifname);
 		}
 #ifdef USE_PF_INET6
 	      break;
@@ -2449,13 +2457,12 @@ print_link_socket_actual_ex (const struct link_sock=
et_actual *act,
 		  CLEAR(sin6);
 		  sin6.sin6_family =3D AF_INET6;
 		  sin6.sin6_addr =3D act->pi.in6.ipi6_addr;
-		    {
-		      if (getnameinfo((struct sockaddr *)&sin6, sizeof (struct sockaddr_=
in6),
-				      buf, sizeof (buf), NULL, 0, NI_NUMERICHOST) =3D=3D 0)
-			buf_printf (&out, " (via %s)", buf);
-		      else
-			buf_printf (&out, " (via [getnameinfo() err])");
-		    }
+		  if_indextoname(act->pi.in6.ipi6_ifindex, ifname);
+		  if (getnameinfo((struct sockaddr *)&sin6, sizeof (struct sockaddr_in6),
+				  buf, sizeof (buf), NULL, 0, NI_NUMERICHOST) =3D=3D 0)
+		    buf_printf (&out, " (via %s%%%s)", buf, ifname);
+		  else
+		    buf_printf (&out, " (via [getnameinfo() err]%%%s)", ifname);
 		}
 	      break;
 	    }
--=20
1.7.1

oO Juan Jose Ciarlante - juanjosec Ogmail.com - jjo O{um.edu.ar,google.com}
Oo gpg --keyserver wwwkeys.eu.pgp.net --recv-key 81276430

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk2LzE0ACgkQo/fiSWZycXcgGACdECK+wd/Xi/JBCgfoDUK373bG
nrIAoJxZLJxP9aUp8JMh4WwhB9UR9kiO
=SJY6
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--

