References: <20170115061718.3218-1-praiskup@...1347...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <8e0e7b9b-3f54-88c4-6880-a3736a3a87ea@...2080...>
Date: Sun, 15 Jan 2017 11:08:38 +0100
MIME-Version: 1.0
In-Reply-To: <20170115061718.3218-1-praiskup@...1347...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="ogVL9LGHm3jk9vB9UoQuh6oVuUuC4bExc"
Subject: Re: [Openvpn-devel] [PATCH] options: allow setting default --ca
 argument value
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Pavel Raiskup <praiskup@...1347...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ogVL9LGHm3jk9vB9UoQuh6oVuUuC4bExc
Content-Type: multipart/mixed; boundary="ip9NpkUlxV2xDnTQB13vBOULEtkSmnWuh";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Pavel Raiskup <praiskup@...1347...>, openvpn-devel@lists.sourceforge.net
Message-ID: <8e0e7b9b-3f54-88c4-6880-a3736a3a87ea@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] options: allow setting default --ca
	argument value
References: <20170115061718.3218-1-praiskup@...1347...>
In-Reply-To: <20170115061718.3218-1-praiskup@...1347...>

--ip9NpkUlxV2xDnTQB13vBOULEtkSmnWuh
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 15/01/17 07:17, Pavel Raiskup wrote:
> Adding a new --with-ca-bundle configure option.  It's argument is
> used as default CA file when no --ca option is specified at
> runtime.
>=20
> This option is primarily designed for systems where users are
> allowed to manage trusted authorities for whole system (in one
> consolidated file; usually implemented in 'ca-certificates'
> package).
>=20
> Signed-off-by: Pavel Raiskup <praiskup@...1347...>
> ---
>  configure.ac          | 5 +++++
>  src/openvpn/options.c | 9 +++++++++
>  2 files changed, 14 insertions(+)

As this was mentioned on a Red Hat Bugzilla (bz #1413343 [1]) as well,
I'm reiterating my argument here for closing that bugzilla as notabug.

I completely agree with Steffan, this is a NAK.  Such a feature would be
a dreamscenario for The Great Firewall of China and similar national
routing instances which implements complete network surveillance.  It
would make it extremely trivial for them to implement a MITM OpenVPN
server which would affect users not being aware of this issue.

This feature would elude users configuring OpenVPN it is no problem
using certificates from public CA issuers.  This is a VERY BAD idea!  We
should help users configure OpenVPN in a secure way by default.  Not the
opposite.


[1] <https://bugzilla.redhat.com/show_bug.cgi?id=3D1413343>

--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--ip9NpkUlxV2xDnTQB13vBOULEtkSmnWuh--

--ogVL9LGHm3jk9vB9UoQuh6oVuUuC4bExc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYe0oqAAoJEIbPlEyWcf3yTooP/Rvq5J7WXYxmYaYCiBYFkLWl
X9UJ9VB8s6vGi2NDVcYwhg8USWgNpeWTF/wFacNHO9Zv0I1gK+V/liBRpENJJbGr
Bbbpk2PfVQIGqFuQo5878CkWB5B6tmGtGP1qhebhZ8UuFXn2/IZVi4hLbFVpQ2DX
chePkazy4unxwwBQnkppeYGFEdmHBvDZ8MpnH7d+1fJBi/6nh1xOY3Zk8485DrGJ
O1ffbXAFXnKJjujjdtsHxEVofKcjYFAQvM56K7IrWap3hulRgXDFXi5aIcsXO4W1
/2+hKEC00PfOIuVAsCkDC9xlVmAbvhGnm9JKG6YTX0RocqhSy1dlDnL+xJsHMTfC
TwW2nrVWUgPzslrpASDJ7qM9aYBWfwfFMYo+L9sOPWXEAXXM3EJMfZ5+9uJ8X0bv
AyasPZMJT4lD6o9r2wb++0s2hCDsjR2xOwVn2K8z1NFDK7ahABNdw4swNQlgTVY9
qqdtNwaoNjocuORWN490Gri3/Sk4bf0k2xqA/QtbFVxZcKdnXPGEwHaOqM75DPOO
yKuSHh8V4eoNoL13aGnsFoIMKqaKnhiXBSnXAzMiQDE1K1lt7EvKEgZC5VM3uI+T
9nIDuAHx+Gp2QP7F+pKKncQtZZ3JqmlwrN+jdPqabWhyxaEDdLSemf1UDrFgb3U4
8f5HC/VqQ1YsQ5H4HRO3
=L+BG
-----END PGP SIGNATURE-----

--ogVL9LGHm3jk9vB9UoQuh6oVuUuC4bExc--

