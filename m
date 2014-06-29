Message-ID: <53B033CC.3050107@...1227...>
Date: Sun, 29 Jun 2014 17:42:04 +0200
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <A1005665-126D-45D5-A6F2-75ED0EAE30FE@...1918...>
In-Reply-To: <A1005665-126D-45D5-A6F2-75ED0EAE30FE@...1918...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="PkNPe1F9QhJHAn87sdN9J49Jvw7AgaWfa"
Subject: Re: [Openvpn-devel] [PATCH] Fix socket-flag/TCP_NODELAY on Mac OS X
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: James Bekkema <james@...1918...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PkNPe1F9QhJHAn87sdN9J49Jvw7AgaWfa
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Am 26.06.14 13:40, schrieb James Bekkema:
> Hi All,
>
> OpenVPN 2.3.4 will currently throw a warning of "NOTE: setsockopt TCP_NOD=
ELAY=3D1 failed (No kernel support)=94 when attempting to use the TCP_NODEL=
AY socket option on Mac OS X/Darwin. Kernel support is there, however the r=
equired header file where TCP_NODELAY is defined is not being included. Thi=
s patch simply alters syshead.h to include <netinet/tcp.h> on Darwin platfo=
rms.
>
>
> --- src/openvpn/syshead.h.orig	2014-05-01 21:12:22.000000000 +1000
> +++ src/openvpn/syshead.h	2014-06-26 17:43:30.000000000 +1000
> @@ -349,6 +349,14 @@
>=20=20
>  #endif /* TARGET_DRAGONFLY */
>=20=20
> +#ifdef TARGET_DARWIN
> +
> +#ifdef HAVE_NETINET_TCP_H
> +#include <netinet/tcp.h>
> +#endif
> +
> +#endif /* TARGET_DARWIN */
> +
>  #ifdef WIN32
>  #include <iphlpapi.h>
>  #include <ntddndis.h>
>
>
> Tested under 10.7 to 10.10dp2. "Socket flags: TCP_NODELAY=3D1 succeeded=
=94 when running with debug enabled. In addition the latest beta version of=
 Viscosity is using a copy of OpenVPN with this patch applied: no issues ha=
ve been reported from testers thus far.
>
Ack.

Arne


--PkNPe1F9QhJHAn87sdN9J49Jvw7AgaWfa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlOwM9EACgkQe8+cMNS4zRewhACgwS86GkpbdGGRbmsHkjGBeGh+
ArgAn2x7hcLCdtDYLVJuRaQ/ltYKCN5E
=U///
-----END PGP SIGNATURE-----

--PkNPe1F9QhJHAn87sdN9J49Jvw7AgaWfa--

