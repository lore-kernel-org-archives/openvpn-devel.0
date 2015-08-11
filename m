Date: Tue, 11 Aug 2015 21:19:49 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20150811191949.GJ382@...1296...>
References: <55CA09E0.3020503@...2052...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iTDIPUn3GSM9i7eX"
Content-Disposition: inline
In-Reply-To: <55CA09E0.3020503@...2052...>
Subject: Re: [Openvpn-devel] SRV record support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gergely Czuczy <gergely.czuczy@...2052...>
Cc: openvpn-devel@lists.sourceforge.net

--iTDIPUn3GSM9i7eX
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Aug 11, 2015 at 04:42:40PM +0200, Gergely Czuczy wrote:
> I would like to ask some help, I'm looking at the OpenVPN source tree
> from GitHub as I would like to see how much effort would it be me to add
> SRV record support, as it has increasing demand these days (and really
> makes sense, especially for enterprises).

Can you elaborate a bit more on why SRV makes sense?  To my naive thinking,
the amount of stuff you have to put into the client profile anyway is
so large (like CA cert etc) that the remaining gain is fairly small...

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--iTDIPUn3GSM9i7eX
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVcpK1KkuBuNlUUl1AQJybQP/b2uvP+Cd7NTJ0EzOTE4fyl/vcp+VvnDY
7Q23Uj6YxJTX+dmS4uLoM3mYy4e6U9lJnZBSn+U5P6OKiPq66hMr3V90UCQftJrG
2NYRizOuw8xH5gG1Cy1cJ/PSurbxJZumLAGB+cPoca03eKCaOPJGs5VFFtCBLTOJ
tqTLtErzNHI=
=9WTd
-----END PGP SIGNATURE-----

--iTDIPUn3GSM9i7eX--

