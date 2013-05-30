Date: Thu, 30 May 2013 20:44:28 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20130530184427.GP20843@...1296...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZP5/UaesXwhUwRsu"
Content-Disposition: inline
Subject: [Openvpn-devel] Bugfix for #297
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--ZP5/UaesXwhUwRsu
Content-Type: multipart/mixed; boundary="jAJnlX6Iz2QeVWJH"
Content-Disposition: inline

--jAJnlX6Iz2QeVWJH
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

just so it's in the list archives - the reporter for trac#297 attached
a bugfix, which I'm going to commit to master and release/2.3 - that
is "acked-by: gert@...1296...".

Arne has also acked the patch on #openvpn-devel.

Since the reporter has not come forward with a real name and e-mail
address, I'll commit this as "myself", but will make it clear in the
comment that I didn't actually fix it...

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--jAJnlX6Iz2QeVWJH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-Fix-problem-with-UDP-tunneling-due-to-mishandled-pkt.patch"
Content-Transfer-Encoding: quoted-printable

=46rom 9bd19f10d52cd10f2317757a2144fc0663ca7c62 Mon Sep 17 00:00:00 2001
From: Gert Doering <gert@...1296...>
Date: Thu, 30 May 2013 13:31:24 +0200
Subject: [PATCH] Fix problem with UDP tunneling due to mishandled pktinfo
 structures.

In link_socket_write_udp_posix_sendmsg(), pktinfo structures for ipv4 and
ipv6 are going out of scope before actually calling sendmsg(), so depending
on compiler optimization, garbage is passed to sendmsg() - fix by using
"union openvpn_pktinfo" and having that in scope all the time.

Problem reported and patch provided by "danta" in trac#297

Signed-off-by: Gert Doering <gert@...1296...>
Acked-by: Gert Doering <gert@...1296...>
Acked-by: Arne Schwabe <arne@...1227...>
URL: https://community.openvpn.net/openvpn/ticket/297
Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/socket.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 94d2b10..40356a0 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -2796,6 +2796,7 @@ link_socket_write_udp_posix_sendmsg (struct link_sock=
et *sock,
   struct iovec iov;
   struct msghdr mesg;
   struct cmsghdr *cmsg;
+  union openvpn_pktinfo opi;
=20
   iov.iov_base =3D BPTR (buf);
   iov.iov_len =3D BLEN (buf);
@@ -2805,11 +2806,10 @@ link_socket_write_udp_posix_sendmsg (struct link_so=
cket *sock,
     {
     case AF_INET:
       {
-        struct openvpn_in4_pktinfo msgpi4;
         mesg.msg_name =3D &to->dest.addr.sa;
         mesg.msg_namelen =3D sizeof (struct sockaddr_in);
-        mesg.msg_control =3D &msgpi4;
-        mesg.msg_controllen =3D sizeof msgpi4;
+        mesg.msg_control =3D &opi;
+        mesg.msg_controllen =3D sizeof (struct openvpn_in4_pktinfo);
         mesg.msg_flags =3D 0;
         cmsg =3D CMSG_FIRSTHDR (&mesg);
         cmsg->cmsg_len =3D sizeof (struct openvpn_in4_pktinfo);
@@ -2834,12 +2834,11 @@ link_socket_write_udp_posix_sendmsg (struct link_so=
cket *sock,
       }
     case AF_INET6:
       {
-        struct openvpn_in6_pktinfo msgpi6;
         struct in6_pktinfo *pkti6;
         mesg.msg_name =3D &to->dest.addr.sa;
         mesg.msg_namelen =3D sizeof (struct sockaddr_in6);
-        mesg.msg_control =3D &msgpi6;
-        mesg.msg_controllen =3D sizeof msgpi6;
+        mesg.msg_control =3D &opi;
+        mesg.msg_controllen =3D sizeof (struct openvpn_in6_pktinfo);
         mesg.msg_flags =3D 0;
         cmsg =3D CMSG_FIRSTHDR (&mesg);
         cmsg->cmsg_len =3D sizeof (struct openvpn_in6_pktinfo);
--=20
1.8.1.5


--jAJnlX6Iz2QeVWJH--

--ZP5/UaesXwhUwRsu
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUaeeC6kuBuNlUUl1AQL8aQP9GyDiJUQ/yldugg4uX6d0PiZvKeEa9Uaf
vdjwfpW7SZcCOYO+9RkKsaT5FYtT+qwFTfwVyUv3RIdpdnNz6IXPBL6Fy+gOGoem
Uwrl5qfPZ4tcCp3iMimANqAwPuIQd4iSoF+7EtO5mNxEz6mwBgOSLFjdeb7blxiQ
6fjDu/QEFe4=
=pktp
-----END PGP SIGNATURE-----

--ZP5/UaesXwhUwRsu--

