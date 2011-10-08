Date: Sat, 8 Oct 2011 12:31:17 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20111008103117.GG8496@...1296...>
References: <C8EBC1CC-8304-4A97-A2C6-DE114CB05EFF@...1502...>
	<B96E3F2E-F1EF-41B4-9342-16AE68F53A8D@...1502...>
	<49806E1A-9928-4272-8EF5-55943866941D@...1502...>
	<4E8587EC.1020201@...1114...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xkNb03ROHe2/B3kn"
Content-Disposition: inline
In-Reply-To: <4E8587EC.1020201@...1114...>
Subject: Re: [Openvpn-devel] [PATCH] Client's routes ageing timer
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net

--xkNb03ROHe2/B3kn
Content-Type: multipart/mixed; boundary="oduJBtpfeiryv1QF"
Content-Disposition: inline

--oduJBtpfeiryv1QF
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Sep 30, 2011 at 11:12:12AM +0200, David Sommerseth wrote:
> On 15/09/11 23:42, Davide Guerri wrote:
> > Please find attached a patch for a new stale-routes-check (and remove)
> > option.
>=20
> Applied to the master branch in testing and stable trees.=20=20

The way this is currently implemented breaks compilation with=20
--disable-crypto --disable-ssl (glad we have buildbot to test this :) ),
because in that case, P2MP_SERVER is not enabled, and=20
options->stale_routes_ageing_time and options->stale_routes_check_interval=
=20
are not defined.

The patch below moves the block inside the #ifdef P2MP_SERVER block
inside options.c - the code is not changed, just moved elsewhere.=20=20

Smoke-tested on FreeBSD 8.2 (just compilation, not even started).

Please verify, ACK, and commit :-)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--oduJBtpfeiryv1QF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-move-block-for-stale-routes-check-config-inside-ifde.patch"
Content-Transfer-Encoding: quoted-printable

=46rom 6e7fdb22e361f6c3d0c617b2d633be4dc3e8607a Mon Sep 17 00:00:00 2001
From: Gert Doering <gert@...1296...>
Date: Sat, 8 Oct 2011 12:26:52 +0200
Subject: [PATCH] move block for "stale-routes-check" config inside #ifdef
 P2MP_SERVER block - options->stale_routes_ageing_time etc.
 are not defined otherwise, and compilation fails.

Signed-off-by: Gert Doering <gert@...1296...>
---
 options.c |   38 +++++++++++++++++++-------------------
 1 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/options.c b/options.c
index 68255a5..c1a0ba6 100644
--- a/options.c
+++ b/options.c
@@ -4950,25 +4950,6 @@ add_option (struct options *options,
 	}
       options->max_routes =3D max_routes;
     }
-  else if (streq (p[0], "stale-routes-check") && p[1])
-    {
-      int ageing_time, check_interval;
-
-      VERIFY_PERMISSION (OPT_P_GENERAL);
-      ageing_time =3D atoi (p[1]);
-      if (p[2])
-        check_interval =3D atoi (p[2]);
-      else
-        check_interval =3D ageing_time;
-
-      if (ageing_time < 1 || check_interval < 1)
-        {
-        msg (msglevel, "--stale-routes-check aging time and check interval=
 must be >=3D 1");
-        goto err;
-        }
-      options->stale_routes_ageing_time  =3D ageing_time;
-      options->stale_routes_check_interval =3D check_interval;
-    }
   else if (streq (p[0], "route-gateway") && p[1])
     {
       VERIFY_PERMISSION (OPT_P_ROUTE_EXTRAS);
@@ -5598,6 +5579,25 @@ add_option (struct options *options,
       VERIFY_PERMISSION (OPT_P_GENERAL);
       options->server_flags |=3D SF_TCP_NODELAY_HELPER;
     }
+  else if (streq (p[0], "stale-routes-check") && p[1])
+    {
+      int ageing_time, check_interval;
+
+      VERIFY_PERMISSION (OPT_P_GENERAL);
+      ageing_time =3D atoi (p[1]);
+      if (p[2])
+        check_interval =3D atoi (p[2]);
+      else
+        check_interval =3D ageing_time;
+
+      if (ageing_time < 1 || check_interval < 1)
+        {
+        msg (msglevel, "--stale-routes-check aging time and check interval=
 must be >=3D 1");
+        goto err;
+        }
+      options->stale_routes_ageing_time  =3D ageing_time;
+      options->stale_routes_check_interval =3D check_interval;
+    }
 #endif /* P2MP_SERVER */
=20
   else if (streq (p[0], "client"))
--=20
1.7.7


--oduJBtpfeiryv1QF--

--xkNb03ROHe2/B3kn
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTpAmdKkuBuNlUUl1AQJ/BgQAopiqM4PNkY9zpfkqaPtNyVAfPPvvfiEr
3+mkSZQHoJQ8nML3CASKj4YOM/DUHmltXL2VEXlt4XI9nos3WDP0dm4nji9JAPtl
jWZYVT0BvzQhMvZfQ1awhkTafpkmBPSeqHw5SPRtMJmgmD8WailBR4GCoxmTdEVE
KgSX6luZ10c=
=E4kG
-----END PGP SIGNATURE-----

--xkNb03ROHe2/B3kn--

