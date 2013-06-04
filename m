Date: Tue, 4 Jun 2013 10:31:41 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20130604083141.GM20843@...1296...>
References: <alpine.LFD.2.02.1306040815590.28059@...391...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Wn92C1cCKTtqXJ4h"
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.02.1306040815590.28059@...391...>
Subject: Re: [Openvpn-devel] OpenVPN and NAT source Port change on firewall
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gerhard Wiesinger <lists@...390...>
Cc: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

--Wn92C1cCKTtqXJ4h
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jun 04, 2013 at 08:19:21AM +0200, Gerhard Wiesinger wrote:
> I've a usecase with OpenVPN and NAT with UDP where the commercial firewal=
l=20
> changes NAT binding. Keep alive is 30s, so short enough. Also float optio=
n=20
> doesn't help because it accepts packets but doesn't do the source port=20
> change. Details find below. This behaviour is reproduceable on different=
=20
> installations with this firewall.

Use a different firewall?  Use "ping 10 30" on the client to keep the
NAT state alive?

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--Wn92C1cCKTtqXJ4h
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUa2l7akuBuNlUUl1AQId0gQAtY2e2ZdvACUpPrbqbSBv7sfYu8Ge6WVB
kje6lfLPd3McBqy46ljFV0KHKDrz+Og5r6XwPgDUeK69eWxX20GJwCh3ad5HMNCQ
X68fWAkyD0slr5FSc9WNw+YJG0p4cusqzk0VIwK6gQzsjKExf8KAxeH8zq2udajO
3TsjwY9XC0c=
=pKOT
-----END PGP SIGNATURE-----

--Wn92C1cCKTtqXJ4h--

