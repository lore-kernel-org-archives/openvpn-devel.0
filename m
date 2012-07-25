Date: Wed, 25 Jul 2012 14:29:40 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120725122940.GF2535@...1296...>
References: <CAO5YuCUbSojNT5m78QChRjTr=f4JHkiAA-P7+sa62RA5KVyHog@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8GpibOaaTibBMecb"
Content-Disposition: inline
In-Reply-To: <CAO5YuCUbSojNT5m78QChRjTr=f4JHkiAA-P7+sa62RA5KVyHog@...278...>
Subject: Re: [Openvpn-devel] enable P2MP opentions?
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: jay alco <jproxy22@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--8GpibOaaTibBMecb
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Jul 25, 2012 at 01:57:20PM +0800, jay alco wrote:
> Hi, i build openvpn from source with the following featured disabled SSL,
> CRYPTO. I have successfully build openpn without this option but during t=
he
> test running the server configuration it gives me error
>=20
> Options error: Unrecognized option or missing parameter(s) in
> config.ovpn:6: client-cert-not-required (2.2.2)

If you build without SSL, none of the SSL-related options are compiled in
(surprise!).

[..]
> It looks like all options under P2MP and P2MP_SERVER are disable when i
> disable SSL, CRYPTO. and for that i can not use client-cert-not-required,
> username-as-common-name, server X X, etc.. and cannot run the server. How
> do i eneable P2MP and P2MP_SERVER during build?

P2MP_SERVER requires SSL to operate - if you disable SSL, there is no
way you can use the OpenVPN server functionality.  All you can do is
use OpenVPN in point-to-point mode.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--8GpibOaaTibBMecb
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBUA/mtKkuBuNlUUl1AQIp7QP+JTXVhHz2CQt2DSU/qZh446bOlAeokh/k
r2f0E4fRXDmDbEd7eaLOK5F+/3P5fEeHwfrjnpcgz8cKTooriT5MTZB6v7/Om+N/
xSy3SEsuCvyxaxN9Ok6KMYbMpRXUyXUG36l49W26Uw5WvnXH9kj0yXI03aigzAu7
uC+88ctSdP8=
=+fOB
-----END PGP SIGNATURE-----

--8GpibOaaTibBMecb--

