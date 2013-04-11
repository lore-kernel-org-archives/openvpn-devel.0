Date: Thu, 11 Apr 2013 10:30:02 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20130411083001.GI569@...1296...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rf72Gf+bfLC8kxKs"
Content-Disposition: inline
Subject: [Openvpn-devel] users of the OpenVPN management interface?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--rf72Gf+bfLC8kxKs
Content-Type: multipart/mixed; boundary="cy9Nn4fUvYST66Pl"
Content-Disposition: inline

--cy9Nn4fUvYST66Pl
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I'm currently working on ironing out some wrinkles of the management
interface regarding IPv6 addresses (like the "kill" command only taking
IPv4 addresses, which doesn't help if a client connects over IPv6...).

Now, I'm wondering who is actually *using* the management interface on
the server side (where stuff like "status 2" makes a bigger difference).

I know about the OpenVPN Access Server, but even that one is not using
all the functionality (most notably, not using "kill" but "client-kill").

Which features of the management interface are the various client=20
applications using?  Heiko?

One of the results of this work is the patch appended below - the
"status 2" and "status 3" commands currently do not show the IPv6 address
assigned to the client.  Since the table is tagged, adding an extra
column will not harm a well-behaved user (like "AS"), but might confuse
an application that only looks for "stuff in the 8th column"...

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--cy9Nn4fUvYST66Pl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-Print-Virtual-IPv6-Address-on-management-interface-q.patch"
Content-Transfer-Encoding: quoted-printable

=46rom 18d97cf42f35b2a673dd392b9fba6d2c1c141409 Mon Sep 17 00:00:00 2001
From: Gert Doering <gert@...1296...>
Date: Wed, 10 Apr 2013 20:55:37 +0200
Subject: [PATCH] Print "Virtual IPv6 Address" on management interface queri=
es
 for "status 2" or "3".

Add extra column after "Virtual Address", empty if no IPv6 address assigned
to this client (or IPv6 not active at all).

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/multi.c |    8 +++++---
 src/openvpn/multi.h |    1 +
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index ab3f10c..1076eea 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -807,8 +807,8 @@ multi_print_status (struct multi_context *m, struct sta=
tus_output *so, const int
 	   */
 	  status_printf (so, "TITLE%c%s", sep, title_string);
 	  status_printf (so, "TIME%c%s%c%u", sep, time_string (now, 0, false, &gc=
_top), sep, (unsigned int)now);
-	  status_printf (so, "HEADER%cCLIENT_LIST%cCommon Name%cReal Address%cVir=
tual Address%cBytes Received%cBytes Sent%cConnected Since%cConnected Since =
(time_t)%cUsername",
-			 sep, sep, sep, sep, sep, sep, sep, sep, sep);
+	  status_printf (so, "HEADER%cCLIENT_LIST%cCommon Name%cReal Address%cVir=
tual Address%cVirtual IPv6 Address%cBytes Received%cBytes Sent%cConnected S=
ince%cConnected Since (time_t)%cUsername",
+			 sep, sep, sep, sep, sep, sep, sep, sep, sep, sep);
 	  hash_iterator_init (m->hash, &hi);
 	  while ((he =3D hash_iterator_next (&hi)))
 	    {
@@ -817,10 +817,11 @@ multi_print_status (struct multi_context *m, struct s=
tatus_output *so, const int
=20
 	      if (!mi->halt)
 		{
-		  status_printf (so, "CLIENT_LIST%c%s%c%s%c%s%c" counter_format "%c" cou=
nter_format "%c%s%c%u%c%s",
+		  status_printf (so, "CLIENT_LIST%c%s%c%s%c%s%c%s%c" counter_format "%c"=
 counter_format "%c%s%c%u%c%s",
 				 sep, tls_common_name (mi->context.c2.tls_multi, false),
 				 sep, mroute_addr_print (&mi->real, &gc),
 				 sep, print_in_addr_t (mi->reporting_addr, IA_EMPTY_IF_UNDEF, &gc),
+				 sep, print_in6_addr (mi->reporting_addr_ipv6, IA_EMPTY_IF_UNDEF, &gc),
 				 sep, mi->context.c2.link_read_bytes,
 				 sep, mi->context.c2.link_write_bytes,
 				 sep, time_string (mi->created, 0, false, &gc),
@@ -1847,6 +1848,7 @@ multi_connection_established (struct multi_context *m=
, struct multi_instance *mi
=20
 	  /* set our client's VPN endpoint for status reporting purposes */
 	  mi->reporting_addr =3D mi->context.c2.push_ifconfig_local;
+	  mi->reporting_addr_ipv6 =3D mi->context.c2.push_ifconfig_ipv6_local;
=20
 	  /* set context-level authentication flag */
 	  mi->context.c2.context_auth =3D CAS_SUCCEEDED;
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index 2bc0c8a..fc2ffb2 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -88,6 +88,7 @@ struct multi_instance {
   bool socket_set_called;
=20
   in_addr_t reporting_addr;       /* IP address shown in status listing */
+  struct in6_addr reporting_addr_ipv6;  /* IPv6 address in status listing =
*/
=20
   bool did_open_context;
   bool did_real_hash;
--=20
1.7.8.6


--cy9Nn4fUvYST66Pl--

--rf72Gf+bfLC8kxKs
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUWZ0iKkuBuNlUUl1AQKm7QP7BYsLlORJLyuYumrRFsLX1LyAytVQBHsm
01Hkk/ydJjqxDNsVWCYMF6k9Y8uTFKPGgk7qcO3AFff1j7b7ctV0hemfp0tWIvaE
sXn4P0vkbt8Hgc5erxs5CMWkR1mEq6yhqbB7K+gFCMv+bVGued7lnyHDe0ayREVM
1w8hVe4mhSM=
=96xl
-----END PGP SIGNATURE-----

--rf72Gf+bfLC8kxKs--

