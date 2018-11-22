Date: Thu, 22 Nov 2018 10:20:47 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20181122092047.GS962@...1296...>
References: <11098166-9909-4011-83F9-C5BC3FEA769D@...260...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="OZbKyx2RhHTu2Jdh"
Content-Disposition: inline
In-Reply-To: <11098166-9909-4011-83F9-C5BC3FEA769D@...260...>
Subject: Re: [Openvpn-devel] foreign_option_2 not set in 2.4
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Cyril Scetbon <cyril.scetbon@...260...>
Cc: openvpn-devel@lists.sourceforge.net

--OZbKyx2RhHTu2Jdh
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Nov 21, 2018 at 10:41:45PM -0500, Cyril Scetbon wrote:
> I???ve discovered that foreign_option_2 is not set using 2.4.4 but is set=
 using 2.3.10.
>=20
> foreign_option_1=3Ddhcp-option DNS 10.201.50.150
> foreign_option_2=3Ddhcp-option DOMAIN cyril.net
>=20
> I had to downgrade to 2.3 because of it.

Which platform?  What's shown in the (--verb 4) log file?

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--OZbKyx2RhHTu2Jdh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJb9nTuAAoJEB2Cnv7KVigSilIMAKBLD4T+tv9fA28RQOwlfQAq
g/XTktm9dwxNVhyWJovmwYRYBtToI2Yf6xXYGkd0Y+QyO4eml8gGmt9WQLndbgyz
RnCSGOMkSebF1Iewr5nYJeh6EAH1skQ8EsoUWiIZkOQx+BTRMDtLUMNLI8F5nvZc
WM00aiPNTrxKQT8G1bNkczZKLvRQ2SCslO3zdSdBBYEpJW1Yfcer/bU8oYQ8PWvV
rLce/gUMX7LXhZF3LNM55+w0+AyXNTm5lWsUed8XXX9qMWVorR1k/B8RmbIo5Wdt
k9Ap7jEtibNezySAaso2zFvUN7JGRYsXAGNGul2aGA6Bg7/7HxqxYz7P1WEjtq4p
UyTdUPlD0dBT7W7AC9N9aTWP7LNrDaQ8VSBN02ZAcV5AqbkiuOXZXn/o0eQ4jCfh
mva44omUcP095s5iVcHzfpVOptXWTprGvX4KIE/OxQOE9oDI2CBUxfhE8TRitkoO
qoa1SN8u6h27/R6RbyHQrcPonVasFhU6OZpXV7vC5Q==
=nm2L
-----END PGP SIGNATURE-----

--OZbKyx2RhHTu2Jdh--

