References: <20200717150510.124442-1-matthias.andree@...68...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <6d775ce5-fff2-3d1b-20d3-3159f5b59efd@...2080...>
Date: Fri, 17 Jul 2020 17:51:58 +0200
MIME-Version: 1.0
In-Reply-To: <20200717150510.124442-1-matthias.andree@...68...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="2zSqklh4vXMAa6nk1HEu0Bmlh7OLbXcQu"
Subject: Re: [Openvpn-devel] [PATCH 1/2] Automake options: add
 subdir-objects, and clean up
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Matthias Andree <matthias.andree@...68...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2zSqklh4vXMAa6nk1HEu0Bmlh7OLbXcQu
Content-Type: multipart/mixed; boundary="RMQYsjAqtH7xqArTN1ZTpXRh1Ek5SIThv";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: Matthias Andree <matthias.andree@...68...>,
 openvpn-devel@lists.sourceforge.net
Message-ID: <6d775ce5-fff2-3d1b-20d3-3159f5b59efd@...2080...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] Automake options: add subdir-objects,
 and clean up
References: <20200717150510.124442-1-matthias.andree@...68...>
In-Reply-To: <20200717150510.124442-1-matthias.andree@...68...>

--RMQYsjAqtH7xqArTN1ZTpXRh1Ek5SIThv
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 17/07/2020 17:05, Matthias Andree wrote:
> diff --git a/Makefile.am b/Makefile.am
> index 439120e4..e4125447 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -25,7 +25,6 @@
>=20
>  # This option prevents autoreconf from overriding our COPYING and
>  # INSTALL targets:
> -AUTOMAKE_OPTIONS =3D foreign 1.9
>  ACLOCAL_AMFLAGS =3D -I m4
>=20
>  MAINTAINERCLEANFILES =3D \
> diff --git a/configure.ac b/configure.ac
> index 45148892..9d6510ca 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -54,7 +54,7 @@ m4_define([serial_tests], [
>                  awk '{split ($NF,a,"."); if (a[1] =3D=3D 1 && a[2] >=3D =
12) { print "serial-tests" }}'
>      ])
>  ])
> -AM_INIT_AUTOMAKE(foreign serial_tests) dnl NB: Do not [quote] this param=
eter.
> +AM_INIT_AUTOMAKE(foreign serial_tests subdir-objects 1.9) dnl NB: Do not=
 [quote] this parameter.
>  AC_CANONICAL_HOST
>  AC_USE_SYSTEM_EXTENSIONS

This looks trivial, but I'll have to NAK it in the current shape.  It break=
s=20
building on at least RHEL-7.

When applying this patch, this happens:

Making all in openvpnmsica
make[3]: Entering directory `/home/davids/devel/OpenVPN/openvpn/src/openvpn=
msica'
Makefile:548: ../../src/tapctl/.deps/libopenvpnmsica_la-error.Plo: No such =
file or directory
Makefile:549: ../../src/tapctl/.deps/libopenvpnmsica_la-tap.Plo: No such fi=
le or directory
make[3]: *** No rule to make target `../../src/tapctl/.deps/libopenvpnmsica=
_la-tap.Plo'.  Stop.
make[3]: Leaving directory `/home/davids/devel/OpenVPN/openvpn/src/openvpnm=
sica'

This needs more work to avoid this issue.  It's also interesting that Windo=
ws
code is suddenly being pulled into the dependency tracking on a plain Linux
box.


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--RMQYsjAqtH7xqArTN1ZTpXRh1Ek5SIThv--

--2zSqklh4vXMAa6nk1HEu0Bmlh7OLbXcQu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJfEckeAAoJEIbPlEyWcf3yPkkP/Rha4NCOJlu2/JilKfW4o30g
v//qTHu6OzvvXvyWtRKcO1E9s/8d5pBctSEPPR1m1d5Xd1LFVdYo7k0Xri34rNBf
t1YReS4GUEFkcqp4jW8/iJ1Aej/MEleg2pYAyY1ddO8CNu/ZB5mTwIYySL4VHofE
zfsxS5pcRCulVHFmdGce3cMBcsdm3ppGSZ/QGEiUUZPnt2WjLYKZ02c1tJ8Imikw
tuYa8jvb9QlGwO6/7Xt5oTd8/u3ZfeNShbWd+Ua/ahODfRxBtWmku8Z3m6krj/rU
m6ukBhjAcUVyGuAu68+63YG30rAL09GQap8+HIupajW+7bI5u9ZO1mlLdSxYfjE2
p6ttL1mXLLL8me1JD74+WHEPnmUCyloNNY9HEumvvFKcSBMO+u2HgWcJ4PeNgqh8
BY6iuMQm30zwElSibqfwrTlIeqxWsWN9SGWFAnHkAUlkoQm0VUH4LrEyUHSLsixV
sS2TA85bF/rNOWCs8Hyno32BdED+tuPtHBaoLFx4iOvUouKOY0sdahKRa25OxdMO
46CWHb/8YWZyOtBR+Q6ZeIhOby4VTJl5FpG9Or4y5G5fGpm53tR2T41BhCOGZFBc
lXmvRCE7CMYU4/bvusPlJw/4hnbnk2GPjuexVSPCYo56f1XV+BPlZiYcR8mFNAqS
y+5UgrWvKGevpDhqd0td
=AbAM
-----END PGP SIGNATURE-----

--2zSqklh4vXMAa6nk1HEu0Bmlh7OLbXcQu--

