Reply-To: openvpn-devel@lists.sourceforge.net
References: <20170807132301.22759-1-chipitsine@...277...>
 <20170807132301.22759-3-chipitsine@...277...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <a2e7511e-2416-cfbc-4b0f-5ffcf8f15e17@...2080...>
Date: Mon, 7 Aug 2017 17:34:46 +0200
MIME-Version: 1.0
In-Reply-To: <20170807132301.22759-3-chipitsine@...277...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="h2xr94rKSWgRSTFaV0VhfaKB6GWIG27W6"
Subject: Re: [Openvpn-devel] [PATCH 3/3] add a test to "openvpn --help"
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Ilya Shipitsin <chipitsine@...277...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--h2xr94rKSWgRSTFaV0VhfaKB6GWIG27W6
Content-Type: multipart/mixed; boundary="tAJfSf8IMv3Gnc3LD0TmEAhhL5ln5jC3V";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Ilya Shipitsin <chipitsine@...277...>, openvpn-devel@lists.sourceforge.net
Message-ID: <a2e7511e-2416-cfbc-4b0f-5ffcf8f15e17@...2080...>
Subject: Re: [Openvpn-devel] [PATCH 3/3] add a test to "openvpn --help"
References: <20170807132301.22759-1-chipitsine@...277...>
 <20170807132301.22759-3-chipitsine@...277...>
In-Reply-To: <20170807132301.22759-3-chipitsine@...277...>

--tAJfSf8IMv3Gnc3LD0TmEAhhL5ln5jC3V
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 07/08/17 15:23, Ilya Shipitsin wrote:
> inspired by https://www.mail-archive.com/openvpn-devel@...290...=
net/msg13808.html
> ---
>  tests/Makefile.am |  2 +-
>  tests/t_usage.sh  | 29 +++++++++++++++++++++++++++++
>  2 files changed, 30 insertions(+), 1 deletion(-)
>  create mode 100755 tests/t_usage.sh
>=20
> diff --git a/tests/Makefile.am b/tests/Makefile.am
> index 0795680c..7306d1d1 100644
> --- a/tests/Makefile.am
> +++ b/tests/Makefile.am
> @@ -14,7 +14,7 @@ MAINTAINERCLEANFILES =3D \
>=20=20
>  SUBDIRS =3D unit_tests
>=20=20
> -test_scripts =3D t_client.sh
> +test_scripts =3D t_client.sh t_usage.sh
>  if ENABLE_CRYPTO
>  test_scripts +=3D t_lpback.sh t_cltsrv.sh
>  endif
> diff --git a/tests/t_usage.sh b/tests/t_usage.sh
> new file mode 100755
> index 00000000..f4845468
> --- /dev/null
> +++ b/tests/t_usage.sh
> @@ -0,0 +1,29 @@
> +#!/bin/sh
> +#
> +# run "openvpn --help"
> +# - check that openvpn did not crash
> +#
> +# prerequisites:
> +# - openvpn binary in current directory
> +#
> +# inspired by https://www.mail-archive.com/openvpn-devel@...1768...=
ge.net/msg13808.html
> +#
> +
> +top_builddir=3D"${top_builddir:-..}"
> +
> +if [ ! -x "${top_builddir}/src/openvpn/openvpn" ]
> +then
> +    echo "no (executable) openvpn binary in current build tree. FAIL." >=
&2
> +    exit 1
> +fi
> +
> +exit_code=3D0
> +
> +"${top_builddir}/src/openvpn/openvpn" --help >/dev/null
> +
> +if [ $? -ne 1 ]
> +then
> +   exit_code=3D1
> +fi

This check is odd.  Where the --help option is parsed, it calls usage(),
usage_small().  And those functions will always call:

   openvpn_exit(OPENVPN_EXIT_STATUS_USAGE);

And OPENVPN_EXIT_STATUS_USAGE is defined as:

error.h:#define OPENVPN_EXIT_STATUS_USAGE                   1

I would rather recommend you to grep for some information you expect to
be listed in --help and check if that was found instead.

For example:

$ ./openvpn --help | grep -- ^-- | wc -l
238

As we might vary number of options from time to time, I wouldn't check
against 238.  But that it should be above 220 in the foreseeable future
would not be an unreasonable assumption.  *BUT* the number of options
might differ more in some other builds (depending on
--enable-*/--disable-* arguments given to ./configure).


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--tAJfSf8IMv3Gnc3LD0TmEAhhL5ln5jC3V--

--h2xr94rKSWgRSTFaV0VhfaKB6GWIG27W6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJZiIicAAoJEIbPlEyWcf3yi10P/1a5MZ3ErdHKYo4DKxYudYnE
y3iRKrmhPItMZ1ocdvlj+k9QqNn+zfcoA28fQ9A95ehuBIEoNgMiL6Qe/mQ2t+FL
zl/kVtuwO1K2BvANG7qt1UdY5yjAkq1guid1Gm2XmamuOf6MBOi7iEc417rCOokA
c1Y0bG0ySZoZSMMrKnueoMufhCGphCy3acQ5QQ1u6JZKBQluAvxUjjR8P633ZFas
f3N/FjOSYT93rPTK4+WGtGmGOX96RpqY/i2EMxCC4TLbiCqZmS3WGhQcNzlrANKX
Y+vcX3neRtFUGeSuhb8qsTgSqiw/znXN8ktvYpX1utww1iNECE2PZE6i3ITDrn9H
wzT+icPkf0HQcztNfIs6f15wNra7MAOSvVNXhjiRzFypI3seUun1nf2HWz0ZlDKT
YJGN4hD7Tdo7H/Y0vBG54NGFCbKQM55aiU01e+rdLyPlZaF48NQSmVncpSCEOL0s
fIL4QgPeimJ3AJnnvB0hba4SSxewKXd74X8ytg3kFu3ZzwLp66z89jWhii4TSkDC
6qOvA30vGVfTFrW6UEivs8cUFoEqWX8lHG9rc8fwSMxYRFu4JcXk3VXUMbpLwCYv
3hGprAeBeMZJy8yaU34cmvuar/Z9wMv3dFyqO4ckxiIQCavuKLVdv2lsdHS6MrV5
QdIcXOvyIQckQulstkx4
=tHe6
-----END PGP SIGNATURE-----

--h2xr94rKSWgRSTFaV0VhfaKB6GWIG27W6--

