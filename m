Date: Sun, 9 Feb 2014 12:50:57 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20140209115057.GT16637@...1296...>
References: <52F6E3AF.1080400@...1030...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2FWNEMwxOgX6dEWt"
Content-Disposition: inline
In-Reply-To: <52F6E3AF.1080400@...1030...>
Subject: Re: [Openvpn-devel] --local, --lport and --bind
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Dash Four <mr.dash.four@...1030...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--2FWNEMwxOgX6dEWt
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Feb 09, 2014 at 02:10:56AM +0000, Dash Four wrote:
> Currently, openvpn only accepts "bind" if both "lport" and "local"=20
> options are specified. Why?
>=20
> Why can't I specify "local" to instruct openvpn to bind to a specific IP=
=20
> address or interface and leave it to decide a (random) port it binds to=20
> in the same way in which the "nobind" option currently functions? What=20
> is the reason for this unnecessary restriction?

If I'm not mistaken, "the C API" - bind() always takes an address *and*
a port number, so you can't just bind to an address alone.  (You can bind
to a port alone because there's INADDR_ANY for "take any address on the
system", but there's no specific "ANY_PORT").  Arne, correct me if I'm wron=
g.

I think OpenVPN *could* make use of the --multihome mechanism to specify
a source address (--local) without binding - but the multitude of open
issues in trac regarding --multihome suggests there's good reasons why
this is not done today.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--2FWNEMwxOgX6dEWt
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUvdroKkuBuNlUUl1AQIvoAP7Bp9pMzsnidDEiDogLEdLzJ5l+ezd7qca
k01uoLZ5zewlfyf5osPehQKlWxiAqkHKA+RhC++7ZMSC/s0ih0DFMSPawxJcldFU
LMzSq/Urua4TQT4nY9TuHiG1vggeLohhiITAyYLGyZNcRuQJViAH7B45WuyUzLOe
UbdTDoA5XlE=
=aUNg
-----END PGP SIGNATURE-----

--2FWNEMwxOgX6dEWt--

