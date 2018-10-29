Date: Mon, 29 Oct 2018 23:09:04 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20181029220904.GR962@...1296...>
References: <1d93843c-6fe8-1a60-28fc-c013a57877da@...2181...>
 <20181029172040.17034-1-arne@...1227...>
 <BN6PR04MB0932760BE8E092FA236F57C0DDF30@...2439...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="uqjP27OxY1Nu6GVP"
Content-Disposition: inline
In-Reply-To: <BN6PR04MB0932760BE8E092FA236F57C0DDF30@...2439...>
Subject: Re: [Openvpn-devel] [PATCH v5] Implement block-ipv6
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Kristian McColm <kristianmccolm@...160...>
Cc: Arne Schwabe <arne@...1227...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--uqjP27OxY1Nu6GVP
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Oct 29, 2018 at 09:06:13PM +0000, Kristian McColm wrote:
> Will this feature break VPNs that use NAT64 to connect to IPv4-only OpenV=
PN servers?

No.

This is an opt-in feature which you can enable by pushing "block-ipv6"
from the server to the client, to avoid IPv6 traffic (to, say, youtube)
bypassing your IPv4-only VPN.

If your VPN is dual-stacked *inside* the tunnel, you wouldn't enable
this.  If your VPN is IPv4-only, but the client has external IPv6
connectivity, you might consider enabling this.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--uqjP27OxY1Nu6GVP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJb14T/AAoJEB2Cnv7KVigSuxwMAJbxTMiOKLijZFmcEIaNEuI9
EUDj9261szt16lbRaG4BhTrOh6pQiupG7swrLSNLnaNfXA2BqVpBkfFPto4t/fc+
LO0e3x5zCFWgYH8IBjW866jTt1778y98tSQXCT8fUPF/XJdnyMr0eNxcklV7BcAR
QT7e6lIe4Nliut0zwFQg4Y459OwG7ZZQIDRplTluNMcQD/E7JKfXSXQQWZt75b5b
EVBPqhyZwbGc29pnI4oPD/+4hlqYQlAe9L/QakHsMdvPqAybWcy9cCVt9qfAONrE
LOnmS2okWOO5kTwn4QVzi8aFwP3s6Kd6Jukpg1Bu5iF8QSrfuhmfLUes7F2uLLsD
tni9UIMdeMCW/FK8eVvCffQt/uXWFjm0bLf2ifPV5nn9YM8w+vsgZUslO3wXGjET
oGNoDjAiSkH4VmxHeras9MUAmpJ/nsIaqUZ/1AAE3NDh0HyWeTNMVqRZnlCn8JKO
Kc2/PuwVkql2tuuGkG4puL0B5xXp1jYCcC2SVuUiAg==
=8NBM
-----END PGP SIGNATURE-----

--uqjP27OxY1Nu6GVP--

