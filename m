Date: Sun, 30 Aug 2015 16:25:34 +0200
From: "Lukasz K." <movrax-dev@...2061...>
Message-ID: <20150830162534.4ee0c9f2.movrax-dev@...2061...>
In-Reply-To: <20150830115444.GU34798@...1296...>
References: <20150830002336.32791c7b.movrax-dev@...2061...>
	<20150830115444.GU34798@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	boundary="Sig_/sl6aertIQ2iuGK/Kuq=NAwa";
	protocol="application/pgp-signature"
Subject: Re: [Openvpn-devel] [PATCH] Privileges not being dropped if the
 first connection is not successful
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

--Sig_/sl6aertIQ2iuGK/Kuq=NAwa
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Hello,

On Sun, 30 Aug 2015 13:54:44 +0200
Gert Doering <gert@...1296...> wrote:

> Hi,
>=20
> On Sun, Aug 30, 2015 at 12:23:36AM +0200, Lukasz K. wrote:
> > Author: Lukasz Kutyla <movrax-dev@...2061...>
> >=20
> > Interruption in first connection will prevent further privilege
> > dropping
>=20
> Which OpenVPN version is this about?  2.3.x up to 2.3.5, or
> 2.3.6/.7/.8, or git master?
>=20
> (Init sequence and connection attempts have changed quite a bit, and
> this might be yet another daemon() fallout)
>=20
> gert

Affected versions that I've checked so far:
2.1.3, 2.2.1, 2.3.4, 2.3.6, 2.3.7, 2.3.8, git (OpenVPN 2.3_git
[git:master/291c227d2ccecaa9+])

I guess it's safe to assume at this point that other releases with
similar code present are going to have the same issue.

I forgot to mention previously that suggested patch is NOT going to get
rid off "NOTE:" messages for each reconnect (for the sake of being
explicit, so this is intentional).

Improved patch below which introduces additional checks using
"c->first_time" for notice messages will make sure that the user is
only presented with "NOTE:" once, if this is the correct course of
action.

Signed-off-by: Lukasz Kutyla <movrax-dev@...2061...>
---
 src/openvpn/init.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index fe00918..403d2d9 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -948,14 +948,14 @@ do_uid_gid_chroot (struct context *c, bool
no_delay) static const char why_not[] =3D "will be delayed because of
--client, --pull, or --up-delay"; struct context_0 *c0 =3D c->c0;
=20
-  if (c->first_time && c0 && !c0->uid_gid_set)
+  if (c0 && !c0->uid_gid_set)
     {
       /* chroot if requested */
       if (c->options.chroot_dir)
 	{
 	  if (no_delay)
 	    platform_chroot (c->options.chroot_dir);
-	  else
+	  else if (c->first_time)
 	    msg (M_INFO, "NOTE: chroot %s", why_not);
 	}
=20
@@ -966,13 +966,13 @@ do_uid_gid_chroot (struct context *c, bool
no_delay) platform_user_set (&c0->platform_state_user);
 	  c0->uid_gid_set =3D true;
 	}
-      else if (c0->uid_gid_specified)
+      else if (c->first_time && c0->uid_gid_specified)
 	{
 	  msg (M_INFO, "NOTE: UID/GID downgrade %s", why_not);
 	}
=20
 #ifdef ENABLE_MEMSTATS
-      if (c->options.memstats_fn)
+      if (c->first_time && c->options.memstats_fn)
 	mstats_open(c->options.memstats_fn);
 #endif
=20
@@ -991,7 +991,7 @@ do_uid_gid_chroot (struct context *c, bool no_delay)
 	    else
 	      msg (M_INFO, "setcon to '%s' succeeded",
c->options.selinux_context); }
-	  else
+	  else if (c->first_time)
 	    msg (M_INFO, "NOTE: setcon %s", why_not);
 	}
 #endif

--

Lukasz K.

--Sig_/sl6aertIQ2iuGK/Kuq=NAwa
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJV4xJsAAoJENIr6TaVB1CURQ0P/0qcnwsETvMOE+7JbgPTM1k8
HmYTp2Twt9rzdqAH0dcQNzTz/APZ/OMh0T7YDJUI+18NNNKC1zQyUQ5QJ+qyfb2l
lfC0h36j0FckVuGzmIRLptdjQuKHiG6dIUJl9KZHl08zIdmbd6BYTi86X5GYaDWF
7vILsHm0INp35nvsq8QI2T2hFvDHo11MNJzlNTCy8t715xBTX+Ge+Msw6xwhC0hi
zuhMdDvUuy57KIAeaNjH883wfaXsZfKdM+vFUqfXL1SMgxHYKTKviAkOfzpxF8Hu
LQjRiB0dNFCBZExXL55h7+t26RTWOHLJA3sX0LqqRg9spVSz1KzqPGRZNVnx+Iie
jo+dVyo1oNpmTMLZnIWyWBpXB+Ni+Bwm6Mal9Ka3A8T6/iIf+rtCVB2mIp+jx0mt
nxPFpTblnYKURa5rEW9VmtCd1ICSgDuT7ZHrIaBhA8nBXFt2JSo+tBvKcIwbEBct
3lUYYDpXQTrVuqDl9oYwYkmrkQN1ntQoB6TGDfOz98O9UjAp4ftZrgFrJi4nW1DF
cyQNk4OXs1uSBBk04xEmuUf4HH7rzfeB8RKFr4jss/JaZtVr30rbkixTV7qvAOLx
4vKrNBVryXY13/Vq4ywflqIHTVlR5gK3JHOJeFEEEFzxZuUxKIZB3p2DQEulN6q0
mogK/EG6tkOYEuWS02fV
=DniI
-----END PGP SIGNATURE-----

--Sig_/sl6aertIQ2iuGK/Kuq=NAwa--

