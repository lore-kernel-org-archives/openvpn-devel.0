Date: Fri, 24 Feb 2017 15:34:16 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20170224143416.GW93896@...1296...>
References: <20170224135222.44640-1-gert@...1296...>
	<caa34845-d758-4c93-4974-40728ff7f2ae@...515...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AQfDLMJ/cCCv3UHO"
Content-Disposition: inline
In-Reply-To: <caa34845-d758-4c93-4974-40728ff7f2ae@...515...>
Subject: Re: [Openvpn-devel] [PATCH] Fix "--dev null"
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Samuli =?iso-8859-1?Q?Sepp=E4nen?= <samuli@...515...>
Cc: openvpn-devel@lists.sourceforge.net

--AQfDLMJ/cCCv3UHO
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Feb 24, 2017 at 04:32:14PM +0200, Samuli Sepp=E4nen wrote:
> On 24/02/2017 15:52, Gert Doering wrote:
> > To test whether a server is reachable and all the key handling is
> > right, openvpn can connect with "--dev null --ifconfig-noexec" to
> > avoid needing to the client with elevated privileges.
>=20
> There seems to be a typo here. Did you mean "to avoid needing to
> _connect to_ the client with elevated privileges"?

Actually "to _run_ the client" - indeed.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--AQfDLMJ/cCCv3UHO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYsERoAAoJEB2Cnv7KVigS42sL/2qPAyHKrdNdINzzHFoqCS8/
c7MwZ7GaE64wDBFwhDGPN2prcSjc1DL8/D+8UBEFylbU3QcwzvNnr32Yf1RHQotA
3tk0rcHY7LvFGddLgqIu4OPIM6ZBIFKTjAcQ6PlXZHwD1vysC9T2faYaN/lo+aZE
uiWQtK8fTceHAKXn901aOPj3D62GB6RuAuX/XmxXEktAfxZ4LYAAYA7o2l0jBokn
9vhUKO5jnwDI0nWlZCACz2YolJlMAX6MlBHUNZSvR/zC2FORC8bC9JuwDkhlSTQ+
cmfnqyjZ7KLJH7ZzJmysnvgbqoXNG663szcdoIlRPllnlO8FBlZlajkAf5QKdmr6
9LNT29gBKJUK3yGvdeqcVVyCmbM/js5/hHjGqpM2yNW8woBCYHAthdrvqGTSYTGc
K98X/3iIY2EBYvAc8xliCFdk9fdEJQOYUJ4qOn6jQWhrb1WINr3qb+M4UWLV4Y7I
KrCGxmJbLvAGrM7ZaVKeemTUHjk/+chamSHJlsPyCA==
=68+Y
-----END PGP SIGNATURE-----

--AQfDLMJ/cCCv3UHO--

