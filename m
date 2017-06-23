Reply-To: openvpn-devel@lists.sourceforge.net
References: <CAFHpkQFO7thcucb_iCb2vz2ySvVbDFc0qj2BY2b5B+TG9LG_Gg@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <0c24e24a-d7b0-4f76-f501-4569f7bbcb6d@...2080...>
Date: Fri, 23 Jun 2017 22:39:08 +0200
MIME-Version: 1.0
In-Reply-To: <CAFHpkQFO7thcucb_iCb2vz2ySvVbDFc0qj2BY2b5B+TG9LG_Gg@...278...>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="wDaWBHkGl8estqdl7p7W8X70wjkvncsob"
Subject: Re: [Openvpn-devel] test usage() ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wDaWBHkGl8estqdl7p7W8X70wjkvncsob
Content-Type: multipart/mixed; boundary="HM7qpMErllqtwIL919bnKvIXAs7fHRgVA";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>,
 "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Message-ID: <0c24e24a-d7b0-4f76-f501-4569f7bbcb6d@...2080...>
Subject: Re: [Openvpn-devel] test usage() ?
References: <CAFHpkQFO7thcucb_iCb2vz2ySvVbDFc0qj2BY2b5B+TG9LG_Gg@...278...>
In-Reply-To: <CAFHpkQFO7thcucb_iCb2vz2ySvVbDFc0qj2BY2b5B+TG9LG_Gg@...278...>

--HM7qpMErllqtwIL919bnKvIXAs7fHRgVA
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 23/06/17 11:59, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=
=D0=B8=D0=BD wrote:
> Hello,
>=20
> following to
> https://github.com/OpenVPN/openvpn/commit/49629380a7bdba25c24c9d410b79946=
fe29249f0
>=20
> I spent some days on trying to get cmocka to test usage(), I gave up :-)
> now, I think, we should just add "src/openvpn/openvpn --help" to .travis.=
yml
>=20
> the question is - can we rely on exit status "1"  here ?

Yes.

> $ src/openvpn/openvpn --help >/dev/null
> $ echo $?
> 1
> $
>=20
>=20
> why does "1" mean "ok" here ?
At the end of the usage() function, it calls
openvpn_exit(OPENVPN_EXIT_STATUS_USAGE).  OPENVPN_EXIT_STATUS_USAGE is
defined to be 1 in error.h.  And the argument given to openvpn_exit() is
an integer which is used as the exit code when OpenVPN stops running.

It is not uncommon that usage() returns a non-0.  But that varies from
project to project.  In OpenVPN context 1 usually can be interpreted as
"no tunnel was started".


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--HM7qpMErllqtwIL919bnKvIXAs7fHRgVA--

--wDaWBHkGl8estqdl7p7W8X70wjkvncsob
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJZTXxsAAoJEIbPlEyWcf3yFasP/jMHPNd+FTN9PJGDOsJ4K2Is
iLiRPXjTOIza9M+xEPJGux268uyeCR1q7KjM2Y6fNWdZwfg9uokAT4MLf7SEsX3Y
9owTpZjBFV4HPzXAFSZ07DXsGp6RJwhsGBg3vpHgQdidZI1jTxWITX3WdLng8800
+gRFerMnQ0qR7iQoZW70KXp7jUej5jME4VnaP2GZUZhQUIabksys9S4Vm+73xZ/e
sxWEH7zSTfLCteUZMmdB/6+U4JCkXAxVb23xkmFUQoNZ4AlH+b2iGdGUkFz9h7Ce
PFGiYr3sZLa0V6CgBizuI6bN36A9yzjBy/21+Qy564QdBu6NhQjiwxiytaiKL+rQ
01vFStyucotuU/lKC8/yJmJ4RYLQimLklrPjmU3S55vAcJIHVEhe3L359UwKrOLn
tEuXUIXGsr9OytfNjwTMekru92wHVabyv32WN4Xz4jwqJSDFHIs4AQzhkBJLttr8
4t8nzfTt8KQGqYmFUln2hiqnIbhMx7ig9Fpl0TILLEYR5KbgzHZuaeombu1HGOeg
3vOthfcAxnDRXFfyF6Q0Bs5F6n72cwKAqmVVjQUrRmwkOyciIFU8NznMkHqvrVU4
VyfAsB8jw9MdTcJSJBeYqJkswe8xNItXBO7XS/HkIjZ+l9BAeeiDy15IgQ6jr1I1
re0Mhw3ZnwSvWoHIVEMY
=uBzu
-----END PGP SIGNATURE-----

--wDaWBHkGl8estqdl7p7W8X70wjkvncsob--

