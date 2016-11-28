References: <20161128161625.11972-1-list@...1798...>
	<20161128161625.11972-2-list@...1798...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <f3062a2e-f7a1-c5b4-8c35-00b807b4a234@...2080...>
Date: Tue, 29 Nov 2016 00:47:38 +0100
MIME-Version: 1.0
In-Reply-To: <20161128161625.11972-2-list@...1798...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="XXWitWLqFjSBnk64ojt5M8UreKlhvTJdS"
Subject: Re: [Openvpn-devel] [PATCH 2/2] allow to enable plugin lookup with
 configure argument
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Christian Hesse <list@...1798...>, openvpn-devel@lists.sourceforge.net
Cc: Christian Hesse <mail@...1798...>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XXWitWLqFjSBnk64ojt5M8UreKlhvTJdS
Content-Type: multipart/mixed; boundary="kUCNKBV6OwJxJXeoh9NmgGlBPlEQJpn6L";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Christian Hesse <list@...1798...>, openvpn-devel@lists.sourceforge.net
Cc: Christian Hesse <mail@...1798...>
Message-ID: <f3062a2e-f7a1-c5b4-8c35-00b807b4a234@...2080...>
Subject: Re: [Openvpn-devel] [PATCH 2/2] allow to enable plugin lookup with
	configure argument
References: <20161128161625.11972-1-list@...1798...>
	<20161128161625.11972-2-list@...1798...>
In-Reply-To: <20161128161625.11972-2-list@...1798...>

--kUCNKBV6OwJxJXeoh9NmgGlBPlEQJpn6L
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 28/11/16 17:16, Christian Hesse wrote:
> From: Christian Hesse <mail@...1798...>
>=20
> For plugin lookup (give relative path to plugin directory in
> configuration) we had to configure with something like this:
>=20
> CFLAGS=3D"$CFLAGS -DPLUGIN_LIBDIR=3D\\\"/usr/lib/openvpn/plugins\\\"" ./c=
onfigure
>=20
> This allows to pass --enable-plugin-lookup to configure to achieve the
> same. As a bonus we can be sure that install path and lookup path in
> openvpn binary are the same.


Thank you for your patch.  Unfortunately I'm not convinced this is the
proper way to do it.

First of all, to achieve what I believe is your goal, you need to flip
things around:

  ./configure CFLAGS=3D"$CFLAGS
-DPLUGIN_LIBDIR=3D\\\"/usr/lib/openvpn/plugins\\\""

This will ensure that whenever 'make' decides to re-run ./configure
automatically it will keep all variables provided to the command line.


Secondly, I believe the proper way to configure PLUGIN_LIBDIR without
going via CFLAGS is to use a similar approach to what is used by
IFCONFIG, ROUTE, IPROUTE and NETSTAT.  They are configured via AC_ARG_VAR.

I'd recommend just adding these two lines to configure.ac instead:

AC_ARG_VAR([PLUGINDIR], [Path of default plug-in search directory])
AC_DEFINE_UNQUOTED([PLUGIN_LIBDIR], ["$PLUGINDIR"])

(these lines are not tested, but that should give some pointer towards a
better direction.

With these lines in place, it is expected that you can do:

  ./configure PLUGINDIR=3D/usr/lib/openvpn/plugins

Which should result in defining PLUGIN_LIBDIR in config.h.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



> ---
>  configure.ac            | 8 ++++++++
>  src/openvpn/Makefile.am | 4 ++++
>  2 files changed, 12 insertions(+)
>=20
> diff --git a/configure.ac b/configure.ac
> index d0fe889..193b5f0 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -308,6 +308,14 @@ AC_ARG_WITH(
>  	[with_plugindir=3D"\$(libdir)/openvpn/plugins"]
>  )
>=20=20
> +AC_ARG_ENABLE(
> +	[plugin-lookup],
> +	[AS_HELP_STRING([--enable-plugin-lookup], [enable plugin lookup in plug=
in directory @<:@default=3Dno@:>@])],
> +	[enable_plugin_lookup=3D"$enableval"],
> +	[enable_plugin_lookup=3D"no"]
> +)
> +AM_CONDITIONAL([ENABLE_PLUGIN_LOOKUP], [test x$enable_plugin_lookup =3D =
xyes])
> +
>=20=20
>  AC_DEFINE_UNQUOTED([TARGET_ALIAS], ["${host}"], [A string representing o=
ur host])
>  case "$host" in
> diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
> index 4c18449..46afc9a 100644
> --- a/src/openvpn/Makefile.am
> +++ b/src/openvpn/Makefile.am
> @@ -33,6 +33,10 @@ if WIN32
>  AM_CFLAGS +=3D -municode -UUNICODE
>  endif
>=20=20
> +if ENABLE_PLUGIN_LOOKUP
> +AM_CFLAGS +=3D -DPLUGIN_LIBDIR=3D\"$(plugindir)\"
> +endif
> +
>  sbin_PROGRAMS =3D openvpn
>=20=20
>  openvpn_SOURCES =3D \
>=20



--kUCNKBV6OwJxJXeoh9NmgGlBPlEQJpn6L--

--XXWitWLqFjSBnk64ojt5M8UreKlhvTJdS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYPMIaAAoJEIbPlEyWcf3ypjcP/iUII6UrfsTxB85r80pd5MYY
aZW3mTIlePtc41yWZtG+RBLN1Or6EImAdZf6PjZ6GCm4j+NmXSrNNJWc+iy3BvJd
DAb6zKtiDFeURE4RreHq725tmxhL6TREKTqzwni7y3bDqlDhjWDlnmBLKfRgrQkx
C7k2EfZ328uxLVugioLaKugj/SR2C+XRUacC/OFOv2udVwsRdv7zPnVn2P15ROE7
XFHVY+0s65omhs8XLOyttbT/Cm8IYNrf7kv9Tn5txrtKjUPEoDgSRnxAM0LcxyxW
8txgSsHlMtBGtr0GOtNBn6jDztQjiLEsKfPOxXLCkAHaWXIb9UL24/LN4ik2iiZV
CQIvxJzqk+EMzlDGkHg3J7XwafDXvKp+vmf0gXoOWc+q/jCshTE1HZkcBVSL4IvG
Ey9x58dy6UunkR0hctv5BavZYsie8QF5iOnBMFk5hWcmHqGW4Bfmp84LVarbnwrV
FiSz4pHimqPfD7TYda+6zT3L2+9bEvnG59J7Gtine6d41iYmFYTIrYKZDFoDD3O7
geKqB7wIrNGn22XLhJCZjDCLW9Wmv+4cfv0uRwBccs+CcMy/Wh8LonUXHxY3uQi3
Cw4UbVThmhcTe0JMx8Dmc+iWdat5gITwl1JmG/1vZYuQ5xSBba6GjIZ/AOs9rxOn
SWdrgSWlxoiaOTiATeax
=Jhtp
-----END PGP SIGNATURE-----

--XXWitWLqFjSBnk64ojt5M8UreKlhvTJdS--

