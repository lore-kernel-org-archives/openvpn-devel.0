References: <20191009120043.22692-1-gert@...1296...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <8e319090-1c64-5625-df1f-a08382eff1ad@...2080...>
Date: Thu, 10 Oct 2019 20:21:07 +0200
MIME-Version: 1.0
In-Reply-To: <20191009120043.22692-1-gert@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="bbUY0zSgCGmhNiYAkt6UzWtLRTdgJNtLE"
Subject: Re: [Openvpn-devel] [PATCH] OpenSolaris/OpenIllumos: use /bin/bash
 if available for test scripts.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bbUY0zSgCGmhNiYAkt6UzWtLRTdgJNtLE
Content-Type: multipart/mixed; boundary="6Iti3dosOtsy6b5hhMfiPFQTtde56jtCC";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net
Message-ID: <8e319090-1c64-5625-df1f-a08382eff1ad@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] OpenSolaris/OpenIllumos: use /bin/bash if
 available for test scripts.
References: <20191009120043.22692-1-gert@...1296...>
In-Reply-To: <20191009120043.22692-1-gert@...1296...>

--6Iti3dosOtsy6b5hhMfiPFQTtde56jtCC
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 09/10/2019 14:00, Gert Doering wrote:
> t_client.sh relies on "echo -e" and "echo -n" to produce nicely
> looking output, which fails on Solaris /bin/sh - force SHELL=3D/bin/bash
> on recent-enough Solaris variants that have it.
>=20
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>  configure.ac | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/configure.ac b/configure.ac
> index c7fd7a84..4159e450 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -306,6 +306,7 @@ case "$host" in
>  		AC_DEFINE([TARGET_SOLARIS], [1], [Are we running on Solaris?])
>  		AC_DEFINE_UNQUOTED([TARGET_PREFIX], ["S"], [Target prefix])
>  		CPPFLAGS=3D"$CPPFLAGS -D_XPG4_2"
> +		test -x /bin/bash && SHELL=3D"/bin/bash"
>  		;;
>  	*-*-openbsd*)
>  		AC_DEFINE([TARGET_OPENBSD], [1], [Are we running on OpenBSD?])
>=20

I have not tested this (don't have access to Solaris environments), but loo=
ks
like a reasonable solution.

Acked-By: David Sommerseth <davids@...2529...>

--=20
kind regards,

David Sommerseth
OpenVPN Inc



--6Iti3dosOtsy6b5hhMfiPFQTtde56jtCC--

--bbUY0zSgCGmhNiYAkt6UzWtLRTdgJNtLE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJdn3aZAAoJEIbPlEyWcf3ytAMP+wcjItVjI8F7BInm6Ck8X61Y
KqHMBigfyQyEQzo8SutmUWd9GyQfUVDwAM3ELG35Txp1P5UfAeylcOzmXlLI/QGP
sRBzquhRlfBNgBIEOZ7cs2UO1LV8spH17a51dKJFzmJyxJvB1wlxDbRovOtGLRQs
BpcSr0GwoNrH7797adgPhvoKm3YQR6yykYBU6rsrXdPQPxyl2eykvhvLcaa0lDrR
HTFX6spI+XZPXXXOAvhHoTHMEQitwuZsjrp2LRNi4O0XtTbe1lN/mQRCWvntcBo+
VmrALt83vBepVJljDJT5EuWCdBNB1zZs34RlXwTxtWb4NkJ54jdOLS6AadK1fg8R
ib0ZDztPyuSuZk7yGy5SpME0F83fSktAQi3VTGjN3eFD92erC6/oAVYKRIrD9eEe
fj4S7pMwmWwNTmYaII0BS1aQq1RT2e18Uqx2ZOYw/eSiMWbSPsOJm0gI+SkVO/pt
0rnYHX4Z4e36OV/8jYTBG8C3eVWWxzxDGOpZguNyAnJH62L/BlNkltPLhPxUv/KI
I5fYNqzJqtdZ23ijS2m/mvuABWwcHBA9hmXUSfCQXBZpxE+ux3AsIVDkrWETr3ND
JuRq5O0oCpiSyyllPlv0GdZWQjkm/nEVXPDuQI/HfpSMesGWZgKJg9e4aApDpOqm
ZOp8IepO0B8qDdMtKu3b
=Gf9E
-----END PGP SIGNATURE-----

--bbUY0zSgCGmhNiYAkt6UzWtLRTdgJNtLE--

