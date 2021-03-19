Date: Fri, 19 Mar 2021 07:55:20 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20210319065520.GJ976@...1296...>
References: <20210318181258.89704-1-juliusz@...2525...>
 <206262d3-1ced-99f7-b28d-fce0b7982e65@...2080...>
 <1a7e4f9f-6164-7acf-2b9f-7e1da5f65894@...2525...>
 <80ebff83-8b76-7cf9-f354-85c96d1feb20@...2080...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="iImK9uaII5iQeEUX"
Content-Disposition: inline
In-Reply-To: <80ebff83-8b76-7cf9-f354-85c96d1feb20@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Add PKG_CHECK_VAR compatibility
 definition for old autoconf versions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn@...2080...>
Cc: Juliusz Sosinowicz <juliusz@...2525...>, openvpn-devel@lists.sourceforge.net

--iImK9uaII5iQeEUX
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Mar 19, 2021 at 12:16:28AM +0100, David Sommerseth wrote:
> On 19/03/2021 00:00, Juliusz Sosinowicz wrote:
> > For reference, the version of pkg-config shipped on my Ubuntu 14 vm is=
=20
> > 0.26-1ubuntu4. It looks like the default packages are very outdated.
>=20
> Thanks for checking.  You might want to reconsider if you want to=20
> support Ubuntu 14 these days; Ubuntu 16.04 LTS is the oldest one=20
> supported by Canonical, and after end of April this year only 16.04.4 is=
=20
> supported.
>=20
> <https://endoflife.software/operating-systems/linux/ubuntu>

Ubuntu 16 and Ubuntu 18 (!) also have this old stuff and fail building,
so it seems "updating pkgconfig" is really not their prime priority.

I'll merge with the new commit message.

Thanks for the review.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--iImK9uaII5iQeEUX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgVErRAAoJEB2Cnv7KVigSZ24L/1KeGpwIcjCnsqjSUFn4Pciv
eGI6262MIUUieh9f/izBSdu9AW+i+PCrDz3Ud7pNhtc36qPYnde2vCQ0p5BVshVa
K4sdZjmcuZV1/QILIYgxKxJ9U3QPsBfIphpskN0EIx/vTz8f+QgJ1HVtYYXDpANR
Db1k8KTSNgt3uzLNSaTRNUDmjuUogNSH71pFiMPeziWo1YbX9RkKYDIHUOkrKh2y
DFcA0rZV5u5CwxOLRzHyJblL6X0CrrNiYrG8cmb2q1yH1AUTztG3PQdikUpZLhy2
nfeWYUC5cE/gavrsaFLitkFROTDk2EBurhegk7lIY6IO4oPvLCjEvPKDPLKXLbsc
Di47vTk7wq8RxUkbIgYh1MBDDDfaRjzInC4+KCneUShxyq1h0R2Kfy3Jkwq3NoIB
/qqM+et5sr/lNk6nSjbFa42U3FPRHnC1QDoIoSFHFzlLJtVI5Dr/21HgYyDSNkMT
ME+MXYqJD9G9Fg9dr8CWE/HI/BLeHLMM+Ts4b94gFA==
=JUHD
-----END PGP SIGNATURE-----

--iImK9uaII5iQeEUX--

