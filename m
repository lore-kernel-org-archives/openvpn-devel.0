Date: Tue, 29 Nov 2016 14:47:58 +0100
From: Christian Hesse <list@...1798...>
Message-ID: <20161129144758.20f53682@...1799...>
In-Reply-To: <20161129110716.3946-1-list@...1798...>
References: <20161129120559.5be3e4ad@...1799...>
	<20161129110716.3946-1-list@...1798...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/RoUO3m59POSmXex3InB9U3W";
	protocol="application/pgp-signature"
Subject: Re: [Openvpn-devel] [PATCH 1/1] Clean up plugin path handling
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net
Cc: Christian Hesse <mail@...1798...>

--Sig_/RoUO3m59POSmXex3InB9U3W
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Christian Hesse <list@...1798...> on Tue, 2016/11/29 12:07:
> From: Christian Hesse <mail@...1798...>
>=20
> Drop --with-plugindir, instead use an environment variable PLUGINDIR
> to specify the plugin directory.
>=20
> This always defines PLUGIN_LIBDIR and enables plugin search path.
>=20
> Signed-off-by: Christian Hesse <mail@...1798...>
> ---
>  configure.ac            | 14 ++++++--------
>  src/openvpn/Makefile.am |  3 ++-
>  2 files changed, 8 insertions(+), 9 deletions(-)
>=20
> diff --git a/configure.ac b/configure.ac
> index f4073d0..5fe652e 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -301,13 +301,12 @@ AC_ARG_WITH(
>  	[with_crypto_library=3D"openssl"]
>  )
>=20=20
> -AC_ARG_WITH(
> -	[plugindir],
> -	[AS_HELP_STRING([--with-plugindir], [plugin directory
> @<:@default=3DLIBDIR/openvpn@:>@])],
> -	,
> -	[with_plugindir=3D"\$(libdir)/openvpn/plugins"]
> -)
> -
> +AC_ARG_VAR([PLUGINDIR], [Path of plug-in directory
> @<:@default=3DLIBDIR/openvpn/plugins@:>@]) +if test -n "${PLUGINDIR}"; th=
en
> +	plugindir=3D"${PLUGINDIR}"
> +else
> +	plugindir=3D"\${libdir}/openvpn/plugins"
> +fi
>=20=20
>  AC_DEFINE_UNQUOTED([TARGET_ALIAS], ["${host}"], [A string representing o=
ur
> host]) case "$host" in
> @@ -1245,7 +1244,6 @@ AM_CONDITIONAL([ENABLE_PLUGIN_AUTH_PAM], [test
> "${enable_plugin_auth_pam}" =3D "ye AM_CONDITIONAL([ENABLE_PLUGIN_DOWN_RO=
OT],
> [test "${enable_plugin_down_root}" =3D "yes"])
> AM_CONDITIONAL([ENABLE_CRYPTO], [test "${enable_crypto}" =3D "yes"])=20
> -plugindir=3D"${with_plugindir}"
>  sampledir=3D"\$(docdir)/sample"
>  AC_SUBST([plugindir])
>  AC_SUBST([sampledir])
> diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
> index 4c18449..188834a 100644
> --- a/src/openvpn/Makefile.am
> +++ b/src/openvpn/Makefile.am
> @@ -27,7 +27,8 @@ AM_CFLAGS =3D \
>  	$(OPTIONAL_CRYPTO_CFLAGS) \
>  	$(OPTIONAL_LZO_CFLAGS) \
>  	$(OPTIONAL_LZ4_CFLAGS) \
> -	$(OPTIONAL_PKCS11_HELPER_CFLAGS)
> +	$(OPTIONAL_PKCS11_HELPER_CFLAGS) \
> +	-DPLUGIN_LIBDIR=3D\"${plugindir}\"
>  if WIN32
>  # we want unicode entry point but not the macro
>  AM_CFLAGS +=3D -municode -UUNICODE

The alternative would look something like this:

--- a/configure.ac
+++ b/configure.ac
@@ -301,13 +301,13 @@ AC_ARG_WITH(
 	[with_crypto_library=3D"openssl"]
 )
=20
-AC_ARG_WITH(
-	[plugindir],
-	[AS_HELP_STRING([--with-plugindir], [plugin directory @<:@default=3DLIBDI=
R/openvpn@:>@])],
-	,
-	[with_plugindir=3D"\$(libdir)/openvpn/plugins"]
-)
-
+AC_ARG_VAR([PLUGINDIR], [Path of plug-in directory @<:@default=3DLIBDIR/op=
envpn/plugins@:>@])
+if test -n "${PLUGINDIR}"; then
+	plugindir=3D"${PLUGINDIR}"
+	AC_DEFINE_UNQUOTED([PLUGIN_LIBDIR], ["${PLUGINDIR}"], [Path of plug-in se=
arch directory])
+else
+	plugindir=3D"\${libdir}/openvpn/plugins"
+fi
=20
 AC_DEFINE_UNQUOTED([TARGET_ALIAS], ["${host}"], [A string representing our=
 host])
 case "$host" in
@@ -1245,7 +1245,6 @@ AM_CONDITIONAL([ENABLE_PLUGIN_AUTH_PAM], [test "${ena=
ble_plugin_auth_pam}" =3D "ye
 AM_CONDITIONAL([ENABLE_PLUGIN_DOWN_ROOT], [test "${enable_plugin_down_root=
}" =3D "yes"])
 AM_CONDITIONAL([ENABLE_CRYPTO], [test "${enable_crypto}" =3D "yes"])
=20
-plugindir=3D"${with_plugindir}"
 sampledir=3D"\$(docdir)/sample"
 AC_SUBST([plugindir])
 AC_SUBST([sampledir])

However you *have* to give PLUGINDIR this way to enable the search path. I
would like to avoid that. And I did not find a way to move
AC_DEFINE_UNQUOTED() below the condition due to the nested variables in
$libdir.
--=20
main(a){char*c=3D/*    Schoene Gruesse                         */"B?IJj;MEH"
"CX:;",b;for(a/*    Best regards             my address:    */=3D0;b=3Dc[a+=
+];)
putchar(b-1/(/*    Chris            cc -ox -xc - && ./x    */b/42*2-3)*42);}

--Sig_/RoUO3m59POSmXex3InB9U3W
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXHmveYAHrRp+prOviUUh18yA9HYFAlg9hw4ACgkQiUUh18yA
9HYCEQgAs7FrAA9W06PzjD5pgq0OD71tS+PdkemJh2TL53b7T326QhnYb0wZjz3l
0MGKVJc3SBYzqiAeW0WTTFNXQTcZmJ4xWjiN69Ht5x8MnfR3SXpK4QbhSJm/ZdlJ
tC3JzSMiKZtSbWKFNVLdzSDEmGFLb+Te9fapMQZzpIIrfdVy2timBCvhHuN5qCOP
8bSsFKO3PLUXkELYZ1A0LiJWX8inMlwrGwx5iGmc79jdtCGr7tLPga4UJBugOP4V
sJcIgXMLd+6A39+IkMMAX9ipcPeRHnwYvonZXqcUu5T9ivdpbCJfVKABpYNHNeLa
pgwx1+4tDwctD3eCF7qyllJHYPcqqQ==
=s4JM
-----END PGP SIGNATURE-----

--Sig_/RoUO3m59POSmXex3InB9U3W--

