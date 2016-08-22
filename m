Date: Mon, 22 Aug 2016 20:40:25 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160822184025.GR78279@...1296...>
References: <6c0ea9bb-351e-1c5a-eb2e-ed8a301ececf@...515...>
	<3c8fc20a-6c5a-699d-deef-a0fa1cdaaec8@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4OxkfA0LVqADv3Vx"
Content-Disposition: inline
In-Reply-To: <3c8fc20a-6c5a-699d-deef-a0fa1cdaaec8@...277...>
Subject: Re: [Openvpn-devel] Topics for today's (Monday,
 22nd Aug 2016) community meeting
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: debbie10t <debbie10t@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--4OxkfA0LVqADv3Vx
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Aug 22, 2016 at 02:01:52PM +0100, debbie10t wrote:
> I would like to get a straight answer to this problem:
> https://community.openvpn.net/openvpn/ticket/723
>=20
> --ifconfig-noexec combined with IPv6 behaviour

How much more straight than my latest reply (where I suggested to open
a trac ticket) can the answer be?

> Q:
> What is the expected behaviour ?

To do what the code does on all platforms *except* windows - neither
do IPv4 nor IPv6.

> Is this problem a bug ?

Yes.  Why open a trac ticket otherwise?

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--4OxkfA0LVqADv3Vx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQCVAwUBV7tHFakuBuNlUUl1AQLGwQQAxh17fyRqSBwSWZKyham2VjHXa74+ZzHw
LNJM+ZsnrhQQLBYC3lL0nEZMZm2Y39LK2pLeEy5FzUmsS6tVOlCPAw+/IG43Hq78
CM6lcvzROEES6j/S8m+zvigtxiroXIpkW9hb4NpQnM4BRY5QHoPD7nZOmsjp7sCo
gzm83ojK5HU=
=FlQb
-----END PGP SIGNATURE-----

--4OxkfA0LVqADv3Vx--

