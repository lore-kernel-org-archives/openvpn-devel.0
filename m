References: <1477672963-5724-1-git-send-email-heiko.hund@...1489...>
	<1477672963-5724-2-git-send-email-heiko.hund@...1489...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <da3ee3dd-9aef-1554-53ca-8760d87fa08b@...2080...>
Date: Tue, 8 Nov 2016 00:28:03 +0100
MIME-Version: 1.0
In-Reply-To: <1477672963-5724-2-git-send-email-heiko.hund@...1489...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="9DmjlcxCf9MRb1e8gbiU2cromedWLnhkq"
Subject: Re: [Openvpn-devel] [PATCH 1/7] put argv_* functions into own file,
 add unit tests
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Heiko Hund <heiko.hund@...1489...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9DmjlcxCf9MRb1e8gbiU2cromedWLnhkq
Content-Type: multipart/mixed; boundary="X8uhcSRtqcJIrGssS3un08BmTBsPGWKe7";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Heiko Hund <heiko.hund@...1489...>, openvpn-devel@lists.sourceforge.net
Message-ID: <da3ee3dd-9aef-1554-53ca-8760d87fa08b@...2080...>
Subject: Re: [Openvpn-devel] [PATCH 1/7] put argv_* functions into own file,
	add unit tests
References: <1477672963-5724-1-git-send-email-heiko.hund@...1489...>
	<1477672963-5724-2-git-send-email-heiko.hund@...1489...>
In-Reply-To: <1477672963-5724-2-git-send-email-heiko.hund@...1489...>

--X8uhcSRtqcJIrGssS3un08BmTBsPGWKe7
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 28/10/16 18:42, Heiko Hund wrote:
> misc.c is too crowded with different things to perform any
> sane unit testing due to its dependencies. So, in order to re-write
> the #ifdef'ed tests for the argv_* family of functions into unit
> tests I moved them into a dedicated file.
>=20
> Signed-off-by: Heiko Hund <heiko.hund@...1489...>
> ---
>  configure.ac                         |   1 +
>  src/openvpn/Makefile.am              |   1 +
>  src/openvpn/argv.c                   | 412 +++++++++++++++++++++++++++++=
++
>  src/openvpn/argv.h                   |  76 ++++++
>  src/openvpn/misc.c                   | 459 -----------------------------=
------
>  src/openvpn/misc.h                   |  48 +---
>  tests/unit_tests/Makefile.am         |   2 +-
>  tests/unit_tests/openvpn/Makefile.am |  15 ++
>  tests/unit_tests/openvpn/test_argv.c | 194 +++++++++++++++
>  9 files changed, 701 insertions(+), 507 deletions(-)
>  create mode 100644 src/openvpn/argv.c
>  create mode 100644 src/openvpn/argv.h
>  create mode 100644 tests/unit_tests/openvpn/Makefile.am
>  create mode 100644 tests/unit_tests/openvpn/test_argv.c
>=20

ACK.  Reviewed that all argv_* functions and the related code is just
moved from misc.[ch] to argv.[ch].  One minor change was detected, but
it makes sense: The argv_clone() function is not declared static in
argv.c.  This makes sense as it is only used in this scope.

Good to see that we have proper unit testing on argv.c too!  These tests
doesn't test all functions explicitly, but the majority of them will be
tested indirectly through the other calls.  The exception is
argv_reset(), which I've understood will be changed further later on in
this process.

I will wait with applying this patch to the git tree until all the other
patches in this series have been reviewed and ACKed.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--X8uhcSRtqcJIrGssS3un08BmTBsPGWKe7--

--9DmjlcxCf9MRb1e8gbiU2cromedWLnhkq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYIQ4DAAoJEIbPlEyWcf3ywwAQAJloJHHQPUSN9xztzX8bclqA
HTo3Vqik5+XD/M4/kMuCDDOfzdIp1woqe5IuGytr2lykE2g7AvvqfTmAjicrsuaQ
q/4GVD/Ni4OQOt21vyi44EnQfzBdUBIU4EbFGIvcLT9X2X7nr3G6rSfIDUAUdJmh
kT46P0iXv6bOPzmiO+7skqTDz2ndeK+9xGixrvqHrlTGkJPrYulRtUIRTHJoT/Q8
xdzOudaJe4Yk+pW5QdqkgpXOTwF0aty/TnsFM9/oRUrFOMvbY9jDA2/drc0DMLfU
dOBcvobwQLr/h2/WQIDq5+2EDvvbkuL+qiEcDna2QdiauEoSj/3mb6WnlfewObs8
7CG3ulTfW8pqJy4aXLfKxYeD1zh5YoO5qctbyZQ9hyH4pd8yof2MJQM8p7vdIvPP
s9ry/sK9heDo8yyz/ihFTxzMAmiheReLoiXpxqxoliXlNMLIN01uQcFqqg7XFGZo
MW5oExlBvNt4A1UPG43CFlzeMeCygRxN/aA7DJ22KDYjuIsWOeq+dXDEWGwimhYa
Cl0NPnww9PW3ub0NyuMQGgRGpGHRegDgBoQCcVZ3H310fvUwSugOtMu/69OM7+Fb
Evi3mgOxC76Dj4aW6wge03oibpCrYj0TS3LJTGqGFp3pv+W+/WfaUUyixEE7ufDq
6PydZFZYvpXGZQiWInNz
=jjL2
-----END PGP SIGNATURE-----

--9DmjlcxCf9MRb1e8gbiU2cromedWLnhkq--

