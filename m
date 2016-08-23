Date: Tue, 23 Aug 2016 22:46:53 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160823204653.GI78279@...1296...>
References: <CAKuzo_jO0FLo=xMakh1yB6_h=huE4Pqp6Xtk2QEgXikeui-F6w@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MhDS85o8hQkNlKhq"
Content-Disposition: inline
In-Reply-To: <CAKuzo_jO0FLo=xMakh1yB6_h=huE4Pqp6Xtk2QEgXikeui-F6w@...278...>
Subject: Re: [Openvpn-devel] block-outside-dns and multiple tunnels
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--MhDS85o8hQkNlKhq
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

specifically...

On Sat, Aug 06, 2016 at 12:04:39AM -0400, Selva Nair wrote:
[..]
> 2. Add all filters to a common custom sublayer. This requires a pre-defin=
ed
> UUID that could be used to define the sublayer and shared between all
> instances of openvpn.
>=20
> For UUID,
[..]
> (b) hard code a UUID in the executable and use it as the sublayer key
>=20
> I prefer (b) as its simpler.

2b sounds like the way to get there with the least amount of work, and
without interfering with other folks...

Are there some sort of guidelines how "hard coded UUIDs" are to be used?  Or
do you just randomly pick a large number out of your hat?

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--MhDS85o8hQkNlKhq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQCVAwUBV7y2PKkuBuNlUUl1AQIvTgP/dtZwonUerdCqEXbZJlOQ5VdcrsVXGU9k
taCzR2BxbNyhP7rNlsHZUXAgidCvdK1HlD/7aYaqfvNE35aIaclFgKHHEYDxk0eP
SJplpawJZZ4SIozPTwArTdTFzamQO2dP6dl4WpjUAj9f9UC0+mDlwrVRaALJ2Pgq
O6cxpJEgnDk=
=8ywE
-----END PGP SIGNATURE-----

--MhDS85o8hQkNlKhq--

