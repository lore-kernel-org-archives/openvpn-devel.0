Date: Sat, 20 Feb 2016 09:17:21 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20160220081721.GD24952@...1296...>
References: <CAP=zTkOduThZFBXdewpYv1RQyi9z0Hzaz6MPuRXSt5HkbMTewQ@...278...>
	<20160219173709.GB24952@...1296...>
	<CAP=zTkPPiPO6EPDM1bjM-cBOZ40ikC5GvbcijkXBcb=GepMZ9w@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lLO6hXgLj1bF9ti9"
Content-Disposition: inline
In-Reply-To: <CAP=zTkPPiPO6EPDM1bjM-cBOZ40ikC5GvbcijkXBcb=GepMZ9w@...278...>
Subject: Re: [Openvpn-devel] Enabling TLS Session Resumption in OpenVPN
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Shubham Chauhan <shubham13099@...2124...>
Cc: openvpn-devel@lists.sourceforge.net

--lLO6hXgLj1bF9ti9
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Feb 20, 2016 at 11:40:28AM +0530, Shubham Chauhan wrote:
> the --float option seems to be interesting!
>=20
> Help me understand one scenario.
> If I want to transfer a VPN session from one VPN server to another, keepi=
ng
> the same openvpn process running at the client side, then will the
> "--float" option help? If not float, then is there any other method?

Floating in TLS client/server mode will only cover clients that move
to a new IP address (NAT timeout, wifi/3G roaming, ...)

Roaming to a new server needs a full TLS handshake.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--lLO6hXgLj1bF9ti9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVsghEKkuBuNlUUl1AQK0IgQAlY+8yfMCBYXdCvMPzPdc89BEuXZTl6JN
tdQR7Agu7mj00hHNFXyTyKXM5Px9yBWvldDWjL/y2PAtCv9y238A0CSbt3dT1RBd
Y4hz9Q8dTrSOBC+1x7bbGfbbymC5V+5FoEtKCcngFwc+X7+GoNnxmAw6oqL8Nwmv
vIq6TrWwqh4=
=hJIc
-----END PGP SIGNATURE-----

--lLO6hXgLj1bF9ti9--

