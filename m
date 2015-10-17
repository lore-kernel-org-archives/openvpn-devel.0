Date: Sat, 17 Oct 2015 21:50:22 +0200
From: "Lukasz K." <movrax-dev@...2061...>
Message-ID: <20151017215022.6ce3cdab.movrax-dev@...2061...>
In-Reply-To: <5612D2DB.8090007@...1856...>
References: <20150830002336.32791c7b.movrax-dev@...2061...>
	<20150830115444.GU34798@...1296...>
	<20150830162534.4ee0c9f2.movrax-dev@...2061...>
	<20150830203749.GW34798@...1296...>
	<20150903221836.04306e51.movrax-dev@...2061...>
	<5612D2DB.8090007@...1856...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	boundary="Sig_/2Ofi5lCJVcj4sat3q4UvAq0";
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
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

--Sig_/2Ofi5lCJVcj4sat3q4UvAq0
Content-Type: multipart/mixed; boundary="MP_/OFfDYwcAtoH/r3FUuOSgkf7"

--MP_/OFfDYwcAtoH/r3FUuOSgkf7
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Mon, 5 Oct 2015 21:43:23 +0200
Steffan Karger <steffan@...1856...> wrote:

> Thanks.  This version looks good to me, but the patch won't apply.
> Most likely your MUA messed up line wrapping.  Could you resend the
> patch using 'git send-email', or alternatively as an attachment?
>=20
> -Steffan

Hi,

You're right, my mail client is wrapping lines once they go past 72
characters, so it broke the patch.

I'm really surprised I haven't noticed that.

This time I've used 'git format-patch', and included resulting file as
a separate attachment (as you requested).

I'm sorry for the delay, I was unavailable lately.

Lukasz K.

--MP_/OFfDYwcAtoH/r3FUuOSgkf7
Content-Type: text/x-patch
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename=0001-Fix-privilege-drop-if-first-connection-attempt-fails.patch

=46rom 35d268234fc65b75239b2dff8f9eb15c8c4a642a Mon Sep 17 00:00:00 2001
From: Lukasz Kutyla <movrax-dev@...2061...>
Date: Sat, 17 Oct 2015 21:15:15 +0200
Subject: [PATCH] Fix privilege drop if first connection attempt fails

OpenVPN does not drop privileges (UID/GID/chroot) as requested according to=
 the configuration file and/or passed arguments if the first connection att=
empt is not established successfully, this also includes applying SELinux c=
ontext.
Signals and restarts are processed after "context.first_time" is set to "fa=
lse", which results in omitting entire privilege dropping block in "do_uid_=
gid_chroot()" when successful connection is finally made (everything is ini=
tialized correctly and said function is called), since "context.first_time"=
 is used as block entry condition.

We modify "do_uid_gid_chroot()" in such a way that allows us to drop privil=
eges even when first connection attempt was unsuccessful.

Signed-off-by: Lukasz Kutyla <movrax-dev@...2061...>
---
 src/openvpn/init.c    | 31 ++++++++++++++++++-------------
 src/openvpn/openvpn.h |  6 ++++--
 2 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 5dd8781..c5c0ab6 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -950,31 +950,30 @@ do_uid_gid_chroot (struct context *c, bool no_delay)
   static const char why_not[] =3D "will be delayed because of --client, --=
pull, or --up-delay";
   struct context_0 *c0 =3D c->c0;
=20
-  if (c->first_time && c0 && !c0->uid_gid_set)
+  if (c0 && !c0->uid_gid_chroot_set)
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
-      /* set user and/or group that we want to setuid/setgid to */
-      if (no_delay)
+      /* set user and/or group if we want to setuid/setgid */
+      if (c0->uid_gid_specified)
 	{
-	  platform_group_set (&c0->platform_state_group);
-	  platform_user_set (&c0->platform_state_user);
-	  c0->uid_gid_set =3D true;
-	}
-      else if (c0->uid_gid_specified)
-	{
-	  msg (M_INFO, "NOTE: UID/GID downgrade %s", why_not);
+	  if (no_delay) {
+	    platform_group_set (&c0->platform_state_group);
+	    platform_user_set (&c0->platform_state_user);
+	  }
+	  else if (c->first_time)
+	    msg (M_INFO, "NOTE: UID/GID downgrade %s", why_not);
 	}
=20
 #ifdef ENABLE_MEMSTATS
-      if (c->options.memstats_fn)
+      if (c->first_time && c->options.memstats_fn)
 	mstats_open(c->options.memstats_fn);
 #endif
=20
@@ -993,10 +992,16 @@ do_uid_gid_chroot (struct context *c, bool no_delay)
 	    else
 	      msg (M_INFO, "setcon to '%s' succeeded", c->options.selinux_context=
);
 	  }
-	  else
+	  else if (c->first_time)
 	    msg (M_INFO, "NOTE: setcon %s", why_not);
 	}
 #endif
+
+      /* Privileges are going to be dropped by now (if requested), be sure
+       * to prevent any future privilege dropping attempts from now on.
+       */
+      if (no_delay)
+	c0->uid_gid_chroot_set =3D true;
     }
 }
=20
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index 4fab00b..3f1df6e 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -130,13 +130,15 @@ struct context_persist
  *
  * Level 0 state is initialized once at program startup, and then remains
  * throughout the lifetime of the OpenVPN process.  This structure
- * contains information related to the process's PID, user, and group.
+ * contains information related to the process's PID, user, group, and
+ * privileges.
  */
 struct context_0
 {
   /* workspace for --user/--group */
   bool uid_gid_specified;
-  bool uid_gid_set;
+  /* helper which tells us whether we should keep trying to drop privilege=
s */
+  bool uid_gid_chroot_set;
   struct platform_state_user platform_state_user;
   struct platform_state_group platform_state_group;
 };
--=20
2.6.1


--MP_/OFfDYwcAtoH/r3FUuOSgkf7--

--Sig_/2Ofi5lCJVcj4sat3q4UvAq0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJWIqaGAAoJENIr6TaVB1CUflQP/ixqzEECKwz9lkOTiOZ6Dz9h
+byktPEcJKhNJhJ1VYmeUKXGLlge8DiRXBDnW3tGwyAYqdk4iJt5Ln8+JjbYZP+L
xc7zl32N1D5IO2jJyPyILWQp1UmY1q1aeT0qxEAqILJwcPzEfOtQvimM4VZa+lBY
4fehlOU7wPfH4qCa8eO0XWvoaui+ENa3v1HPdjyjNENiq3Gj82EoOjG73SZqWOi7
LHr0PC8wYg0XUeUy7m28xJFKUYPDC4NpYcBcw/gtgjZiHvd74N8ygYabDw8OI1cU
BcWLOmrcWsw/hJ1cYI4NKn6Q0MPQezDIPhwMzzXOhE7WSDs1eq1pJsnCr2lTNied
xGTYnuSqBkP4yypVw6Cn21BACtTGD5IseWMDe48xBl8RiuhfPbwBwWJzTT5+ADyw
+Ce4/i6IdlrSeNcTr+ba9iSBGHCwFq53Yd1ERithFxauuy1K56WY06tTI60+uj9i
mSin2qSkll97j/4yo3bRY4z24oQqNbEgt0eE/RSKePYf8ozi2JBnBxrKyHUgjp+h
Um1l7VKYCGgvvvdFkEG6NUWkjb4g9xZhMYibStHcHO2qnwKjVHKaBLX3etg3Ur0B
9vV5P3haeio03BxpigjMbrFq0k9oA7xvSAS2RxHSgbyfouJ3jch/p0QJsLxK0Xuq
ppCA175ZqOkZBWY626gn
=cte+
-----END PGP SIGNATURE-----

--Sig_/2Ofi5lCJVcj4sat3q4UvAq0--

