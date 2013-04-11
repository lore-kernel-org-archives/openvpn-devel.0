Date: Thu, 11 Apr 2013 17:09:18 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20130411150918.GW569@...1296...>
References: <20130411083001.GI569@...1296...>
	<20130411102046.GM569@...1296...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TVVcQco/7vcH19KK"
Content-Disposition: inline
In-Reply-To: <20130411102046.GM569@...1296...>
Subject: Re: [Openvpn-devel] users of the OpenVPN management interface?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--TVVcQco/7vcH19KK
Content-Type: multipart/mixed; boundary="EmW68jKGQIhj8inv"
Content-Disposition: inline

--EmW68jKGQIhj8inv
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Apr 11, 2013 at 12:20:46PM +0200, Gert Doering wrote:
> Arne pointed me to an older patch from him that also adds columns, and
> when applying that one, it (of course) caused conflicts.  So here's a
> new version of the "virtual IPv6 address" patch rebased on current master.

And after Arne's #ifdef frenzy, my patch of course doesn't apply anymore...

v4 below :-)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--EmW68jKGQIhj8inv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-Print-Virtual-IPv6-Address-on-management-interface-q.patch"
Content-Transfer-Encoding: quoted-printable

=46rom f7002b23551b2d21e74b35388248b5a0807c0e4b Mon Sep 17 00:00:00 2001
From: Gert Doering <gert@...1296...>
Date: Wed, 10 Apr 2013 20:55:37 +0200
Subject: [PATCH] Print "Virtual IPv6 Address" on management interface queri=
es
 [v4]

Add extra column to management queries for "status 2" or "status 3"
after "Virtual Address", empty if no IPv6 address assigned to this
client (or IPv6 not active at all).

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/multi.c |    8 +++++---
 src/openvpn/multi.h |    1 +
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 5900523..f016b14 100644
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
(time_t)%cUsername%cClient ID",
-			 sep, sep, sep, sep, sep, sep, sep, sep, sep, sep);
+	  status_printf (so, "HEADER%cCLIENT_LIST%cCommon Name%cReal Address%cVir=
tual Address%cVirtual IPv6 Address%cBytes Received%cBytes Sent%cConnected S=
ince%cConnected Since (time_t)%cUsername%cClient ID",
+			 sep, sep, sep, sep, sep, sep, sep, sep, sep, sep, sep);
 	  hash_iterator_init (m->hash, &hi);
 	  while ((he =3D hash_iterator_next (&hi)))
 	    {
@@ -817,7 +817,7 @@ multi_print_status (struct multi_context *m, struct sta=
tus_output *so, const int
=20
 	      if (!mi->halt)
 		{
-		  status_printf (so, "CLIENT_LIST%c%s%c%s%c%s%c" counter_format "%c" cou=
nter_format "%c%s%c%u%c%s%c"
+		  status_printf (so, "CLIENT_LIST%c%s%c%s%c%s%c%s%c" counter_format "%c"=
 counter_format "%c%s%c%u%c%s%c"
 #ifdef MANAGEMENT_DEF_AUTH
 				 "%lu",
 #else
@@ -826,6 +826,7 @@ multi_print_status (struct multi_context *m, struct sta=
tus_output *so, const int
 				 sep, tls_common_name (mi->context.c2.tls_multi, false),
 				 sep, mroute_addr_print (&mi->real, &gc),
 				 sep, print_in_addr_t (mi->reporting_addr, IA_EMPTY_IF_UNDEF, &gc),
+				 sep, print_in6_addr (mi->reporting_addr_ipv6, IA_EMPTY_IF_UNDEF, &gc),
 				 sep, mi->context.c2.link_read_bytes,
 				 sep, mi->context.c2.link_write_bytes,
 				 sep, time_string (mi->created, 0, false, &gc),
@@ -1857,6 +1858,7 @@ multi_connection_established (struct multi_context *m=
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


--EmW68jKGQIhj8inv--

--TVVcQco/7vcH19KK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUWbSHqkuBuNlUUl1AQL6pAP7Bg71L76wNkkjRIfUoDY29Vxox0x2w6tp
fH0xrlsmFh8MsBoUYSaERch2CXy94TiR+1FcDUS9W4cjID043JgljIqu4kfT6psW
5qTPWwv8QmJl5PWIr8MPb3tfWLZAJ2tyANz2QZ1axl/huah0MfC5s9oDAaeikUnA
v1FzNdP4Ly8=
=fzcs
-----END PGP SIGNATURE-----

--TVVcQco/7vcH19KK--

