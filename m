Message-ID: <4F392718.1040603@...1114...>
Date: Mon, 13 Feb 2012 16:07:04 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <7c22eb11c37c167998cc7975576fe585@...1550...>
	<4F3902E7.3050901@...384...>
	<4F390984.9080503@...1550...>
In-Reply-To: <4F390984.9080503@...1550...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigDAD91AB16E6EFBF7CA9494F9"
Subject: Re: [Openvpn-devel] [PATCH] Check for ENABLE_MANAGEMENT for
	ENABLE_CLIENT_CR
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Igor Novgorodov <igor@...1550...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDAD91AB16E6EFBF7CA9494F9
Content-Type: multipart/mixed; boundary="------------080607080701060608090903"

This is a multi-part message in MIME format.
--------------080607080701060608090903
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 13/02/12 14:00, Igor Novgorodov wrote:
> I'm building latest GIT with:
>=20
> ./configure \
> --disable-debug \
> --disable-plugins \
> --disable-management \
> --disable-socks \
> --disable-password-save \
> --disable-multi \
> --disable-server \
> --disable-pkcs11 \
> --disable-http \
> --disable-port-share \
> --disable-def-auth \
> --disable-pf \
> --disable-lzo \
> --disable-selinux \
> --disable-iproute2 \
> --enable-small
>=20
> (effectively, the version that supports only static keys and no fancy stu=
ff)
>=20
> Build fails with:
> ...
> gcc -DHAVE_CONFIG_H -I. -I. -g -O2 -MT init.o -MD -MP -MF .deps/init.Tpo=
=20
> -c -o init.o init.c
> init.c: In function =91do_route=92:
> init.c:1364:7: error: too few arguments to function =91plugin_call=92
> plugin.h:196:1: note: declared here
> init.c: In function =91do_init_crypto_tls=92:
> init.c:2286:20: error: =91const struct options=92 has no member named =91=
sc_info=92
> make[2]: *** [init.o] Error 1
> ...
>=20
> Here are even two errors, one of which (plugin_call) function is=20
> addressed in OpenWRT patchset:
> https://dev.openwrt.org/browser/packages/net/openvpn-polarssl/patches/300=
-fix-plugin_call-with-ssl.patch

I would love the OpenWRT guys o give us a heads up directly when something
like this is noticed.  Such things we really want to fix ASAP.

However, I didn't particular like the approach in that patch, so I've
attached another patch for review.  If this is acked, please consider using
this one instead (patch 0001).

> And another is that i'm talking about.

I'm giving your patch an ACK, so that will go into the tree.  But even one
more fix is needed, which is in the second patch I attached.


kind regards,

David Sommerseth


> On 13.02.2012 16:32, David Sommerseth wrote:
> On 12/02/12 19:40, igor@...1550... wrote:
>>>> When building a very minimal OpenVPN for OpenWRT with
>>>> --disable-management among others, the compilaton fails due to
>>>> ENABLE_CLIENT_CR being defined, although the management interface,
>>>> which makes use of it, has been disabled.
>>>>
>>>> The attached simple patch checks for ENABLE_MANAGEMENT before defining
>>>> ENABLE_CLIENT_CR.
> Which version are you compiling?  I tried a couple of compile with the
> latest version in git (master branch) in combination with
> --disable-management and --enable-small ... And I could not manage to
> trigger this one.  Our buildbot (even though, not testing all
> combinations) have also not triggered this one.
>=20
> Could you provide more version information and the configure arguments
> you use?
>=20
>=20
> kind regards,
>=20
> David Sommerseth
>=20
>=20
>=20
> -------------------------------------------------------------------------=
-----
> Try before you buy =3D See our experts in action!
> The most comprehensive online learning library for Microsoft developers
> is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
> Metro Style Apps, more. Free future releases when you subscribe now!
> http://p.sf.net/sfu/learndevnow-dev2
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20


--------------080607080701060608090903
Content-Type: text/x-patch;
	name="0001-Fix-compile-issues-when-plug-ins-are-disabled.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename*0="0001-Fix-compile-issues-when-plug-ins-are-disabled.patch"

=46rom a0cc57dc54aefd0507a83174fb6c0e7a2b47b90f Mon Sep 17 00:00:00 2001
From: David Sommerseth <davids@...1347...>
Date: Mon, 13 Feb 2012 15:52:00 +0100
Subject: [PATCH 1/2] Fix compile issues when plug-ins are disabled.

Commit 1876ccd012e9e2ca6f8e1cd9e7e9bb4bf24ccecb modified
plugin_call() and introduced plugin_call_ssl().  But the similar
approach was missing for situations without plug-ins.

Solution: Rename plugin_call() in the #else !ENABLE_PLUGIN
section to plugin_call_ssl().  Then move the plugin_ssl() function
inside the #ifdef ENABLE_PLUGIN section outside the #ifdef, making
it available for builds with and without plug-ins enabled.

Signed-off-by: David Sommerseth <davids@...1347...>
---
 plugin.h |   31 +++++++++++++++----------------
 1 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/plugin.h b/plugin.h
index 948ab88..6f75e27 100644
--- a/plugin.h
+++ b/plugin.h
@@ -133,20 +133,6 @@ int plugin_call_ssl (const struct plugin_list *pl,
 #endif
 		);
=20
-static inline int
-plugin_call(const struct plugin_list *pl,
-	const int type,
-	const struct argv *av,
-	struct plugin_return *pr,
-	struct env_set *es)
-{
-  return plugin_call_ssl(pl, type, av, pr, es
-#ifdef USE_SSL
-      , -1, NULL
-#endif
-      );
-}
-
 void plugin_list_close (struct plugin_list *pl);
 bool plugin_defined (const struct plugin_list *pl, const int type);
=20
@@ -182,7 +168,6 @@ plugin_return_init (struct plugin_return *pr)
 }
=20
 #else
-
 struct plugin_list { int dummy; };
 struct plugin_return { int dummy; };
=20
@@ -193,7 +178,7 @@ plugin_defined (const struct plugin_list *pl, const i=
nt type)
 }
=20
 static inline int
-plugin_call (const struct plugin_list *pl,
+plugin_call_ssl (const struct plugin_list *pl,
 	     const int type,
 	     const struct argv *av,
 	     struct plugin_return *pr,
@@ -209,4 +194,18 @@ plugin_call (const struct plugin_list *pl,
=20
 #endif /* ENABLE_PLUGIN */
=20
+static inline int
+plugin_call(const struct plugin_list *pl,
+	const int type,
+	const struct argv *av,
+	struct plugin_return *pr,
+	struct env_set *es)
+{
+  return plugin_call_ssl(pl, type, av, pr, es
+#ifdef USE_SSL
+      , -1, NULL
+#endif
+      );
+}
+
 #endif /* OPENVPN_PLUGIN_H */
--=20
1.7.4.4


--------------080607080701060608090903
Content-Type: text/x-patch;
	name="0002-Remove-show-gateway-if-debug-info-is-not-enabled-dis.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename*0="0002-Remove-show-gateway-if-debug-info-is-not-enabled-dis.pa";
	filename*1="tch"

=46rom e3ed7ec5c5a61141807d7028b6a88b24c2798d17 Mon Sep 17 00:00:00 2001
From: David Sommerseth <davids@...1347...>
Date: Mon, 13 Feb 2012 16:03:46 +0100
Subject: [PATCH 2/2] Remove --show-gateway if debug info is not enabled
 (--disable-debug)

The --show-gateway feature depends on functions only being enabled when
--disable-debug is _not_ used.  As this I consider --show-gateway more
a handy function for debugging, removing this feature when --disable-debu=
g
is used seems like the proper approach.

Signed-off-by: David Sommerseth <davids@...1347...>
---
 options.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/options.c b/options.c
index a0b3431..2edec4e 100644
--- a/options.c
+++ b/options.c
@@ -735,7 +735,9 @@ static const char usage_message[] =3D
 #endif				/* ENABLE_PKCS11 */
   "\n"
   "General Standalone Options:\n"
+#ifdef ENABLE_DEBUG
   "--show-gateway : Show info about default gateway.\n"
+#endif
  ;
=20
 #endif /* !ENABLE_SMALL */
@@ -4031,6 +4033,7 @@ add_option (struct options *options,
=20
       read_config_file (options, p[1], level, file, line, msglevel, perm=
ission_mask, option_types_found, es);
     }
+#ifdef ENABLE_DEBUG
   else if (streq (p[0], "show-gateway"))
     {
       struct route_gateway_info rgi;
@@ -4039,6 +4042,7 @@ add_option (struct options *options,
       print_default_gateway(M_INFO, &rgi);
       openvpn_exit (OPENVPN_EXIT_STATUS_GOOD); /* exit point */
     }
+#endif
 #if 0
   else if (streq (p[0], "foreign-option") && p[1])
     {
--=20
1.7.4.4


--------------080607080701060608090903--

--------------enigDAD91AB16E6EFBF7CA9494F9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk85JxoACgkQDC186MBRfrp6XQCePuthmtP4FqgEsbBIDt+Ojlyc
XqkAnjs+I4KkYUAD1C0tkq5Nk9/Zfx39
=ASg4
-----END PGP SIGNATURE-----

--------------enigDAD91AB16E6EFBF7CA9494F9--

