Date: Mon, 21 Apr 2014 13:49:46 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140421114946.GV16637@...1296...>
References: <1398064204-26476-1-git-send-email-james@...515...>
	<1398064204-26476-4-git-send-email-james@...515...>
	<5354F1DE.8050604@...1856...>
	<20140421104211.GT16637@...1296...>
	<5354FCC9.4030106@...1227...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pdUiLM4f4Q2vjojx"
Content-Disposition: inline
In-Reply-To: <5354FCC9.4030106@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 4/4] When tls-version-min is unspecified,
	revert to original versioning approach.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--pdUiLM4f4Q2vjojx
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Apr 21, 2014 at 01:11:05PM +0200, Arne Schwabe wrote:
> Yes. But with this patch it is always turned off, keeping OpenVPN in 99%=
=20
> of installations in TLS 1.0. Is there any other known case where it=20
> breaks aside from the Tomato OpenVPN client?

http://community.openvpn.net/openvpn/ticket/385

this is the only case I know - and I blaim the openssl library on the
server side (ARM).  So for me, "default-on with a way to turn it off" would
be sufficient.  But I assume James has much more visibility...

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--pdUiLM4f4Q2vjojx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBU1UF2qkuBuNlUUl1AQLnFgQAog0wH3hKDvU/VccsM3xTqgeoBB0DwQvx
SpXrmncmVll0+ZqBN4wy6G4CzKAoRpWrTtpcGz83LX8EzVTGNz8ZjYRfoZYrueQ7
ZVvzaEld6R76uXN77iYzWdSxW1O4dSXZCUxBI79qYj3AMqr2zPoCOKtP7cLvFc7u
ZcBRXAQS7d4=
=nvPw
-----END PGP SIGNATURE-----

--pdUiLM4f4Q2vjojx--

