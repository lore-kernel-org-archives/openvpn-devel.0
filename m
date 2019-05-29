References: <533da55c-4953-588a-4d5d-adb6955dde5a@...2510...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <59e9d2f0-9706-3810-a46f-57dd5d9c72d2@...2080...>
Date: Wed, 29 May 2019 22:51:38 +0200
MIME-Version: 1.0
In-Reply-To: <533da55c-4953-588a-4d5d-adb6955dde5a@...2510...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="kc8jnbYFcU8iyWz1hL62hzam4vPB1nofx"
Subject: Re: [Openvpn-devel] [Openvpn-users] Compiling OpenVPN 3 Linux
 Client on arm
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lorenz <lorenz@...2509...>, OpenVPN Users <Openvpn-users@lists.sourceforge.net>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kc8jnbYFcU8iyWz1hL62hzam4vPB1nofx
Content-Type: multipart/mixed; boundary="OmJ0tYcpBssg1tSD8aYiASxiZiHs3EISC";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: Lorenz <lorenz@...2509...>,
 OpenVPN Users <Openvpn-users@lists.sourceforge.net>
Cc: "openvpn-devel@lists.sourceforge.net"
 <openvpn-devel@lists.sourceforge.net>
Message-ID: <59e9d2f0-9706-3810-a46f-57dd5d9c72d2@...2080...>
Subject: Re: [Openvpn-users] Compiling OpenVPN 3 Linux Client on arm
References: <533da55c-4953-588a-4d5d-adb6955dde5a@...2510...>
In-Reply-To: <533da55c-4953-588a-4d5d-adb6955dde5a@...2510...>

--OmJ0tYcpBssg1tSD8aYiASxiZiHs3EISC
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 28/05/2019 15:30, Lorenz wrote:
> Hi,
>=20
> has anyone already succeeded to compile the OpenVPN 3 Linux Client on an =
arm
> architecture?
>=20
> I am trying to compile the project on a Raspberry Pi 3 Model B+ running
> Raspbian (basically Debian Stretch). But make always fails (see attached =
log).
> To check if there is a problem with Raspbian I also tried compiling insid=
e a
> LXC container running Ubuntu 18.04 however the same error occurred.
>=20
> GCC version:
> gcc (Raspbian 6.3.0-18+rpi1+deb9u1) 6.3.0 20170516
> gcc (Ubuntu/Linaro 7.4.0-1ubuntu1~18.04) 7.4.0
>=20
> uname:
> Linux test 4.19.42-v7+ #1219 SMP Tue May 14 21:20:58 BST 2019 armv7l GNU/=
Linux
>=20
>=20
> make finishes without problems on my amd64 machine (tested Debian Stretch=
 and
> Ubuntu 18.04).
>=20
> Do you have any ideas why the error only occurs on the Raspberry Pi?

Hi,

Thanks for testing openvpn3-linux! :)

Yes, 32 bit is a known issue.  It's related to some type deduction challenge
C++ provides which is not an issue on 64 bit platforms.  So far I've just b=
een
ignorant to 32 bit platforms (sorry!), as I didn't think it was that used t=
hat
much any more - and especially not on ARM.  But I also didn't think if
RasperryPi ... so this needs to be fixed!

If anyone is willing to dive into this issue and try to come up with a patc=
h,
I will happily review and merge it.  Otherwise I'll have a look at it once I
get a chance.  It's probably not a big challenge, just need to fully grasp =
the
C++ template complaint and find a fix which also doesn't break 64 bit.

Btw ... (and I'm NOT pointing fingers) .. but these kind of questions are
usually better suited for openvpn-devel mailing list (on Cc).


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--OmJ0tYcpBssg1tSD8aYiASxiZiHs3EISC--

--kc8jnbYFcU8iyWz1hL62hzam4vPB1nofx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJc7vDaAAoJEIbPlEyWcf3yyX8QALI6bKdxjYdpvFfP44txVy3p
eRgWKTK+y0HCa8ePJqlw7csG0WrnOj/JROBzdmsnkcGRE5XetKnC/nYasWoafCSz
M/mOhur7ZAo05Nwc1+Fir8RxZKomh+Y0Xn6Lir0vKd6lPc1HRHRFdaScofW6vHsG
atYMw9+t9KfP3LIVde4RSYgSqnbJyEdCkfH6FwCHfBLzj0YGFgLkrENFn4xlA1p8
4AUu/lqzCJtquKdQwkpntE8X6jcwG9Dmxc/tg8CcLTRgnsA6M0adC9p5fbQlBOct
PnlxDMULJewhsvQPKMYd2AqzQ3bxnMwNF2khgNnu2bOUpX1JH7MQa44HwTrWk+Q/
9B9RUyDDDtq/cKF5iYaIBrtbmwyJhQTewDDv5WaiEKtZ0yO0czc5C4gThmeIp5CE
vnW0RerK+NeDY1f83IdoIGpGrLhmavTqr9Ih3r32TFoooE5oQJHatU3rJBH9gMuL
kvhGhSVwdiGgM+3qJmCZWpvTg4CxLv57hEfmTgiSfZKmAOTrAa4QrboZbPaFkF+u
8KAM+XRfbnikNug1K9wTyF5PUZtXQX+XmCRjU0W37atysLsRFxe32gsEu6s6btga
MlAzB3BqPAmSQEwdK5+tEuPe47f4vzP3Te/k9i79jYHdTX6VFxnnxqho1DCU2qnm
ipaoun3Yz+uZC9LD7J/z
=KSER
-----END PGP SIGNATURE-----

--kc8jnbYFcU8iyWz1hL62hzam4vPB1nofx--

