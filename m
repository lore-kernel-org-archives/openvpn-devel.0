Date: Thu, 22 Jun 2017 21:31:02 +0800
From: Antonio Quartulli <a@...2181...>
Message-ID: <20170622133102.GC31123@...2287...>
References: <62da7142-d087-7d89-5974-7533b1be0713@...1856...>
	<20170621211043.6490-1-steffan@...1856...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/Uq4LBwYP4y1W6pO"
Content-Disposition: inline
In-Reply-To: <20170621211043.6490-1-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH v2] Move adjust_power_of_2() to integer.h
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

--/Uq4LBwYP4y1W6pO
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Thanks for sending v2 Steffan,

On Wed, Jun 21, 2017 at 11:10:43PM +0200, Steffan Karger wrote:
> From: Steffan Karger <steffan.karger@...1435...>
>=20
> misc.c is a mess of incoherent functions, and is therefore included by
> virtually all our source files.  That makes testing harder than it should
> be.  As a first step of cleaning up misc.c, move adjust_power_of_2() to
> integer.h, which is a more suitable place for a function like this.
>=20
> This allows us to remove the duplicate implementation from test_argv.c.
>=20
> Signed-off-by: Steffan Karger <steffan.karger@...1435...>


This change is quite simple and passes basic tests.
Thanks also for adding explicit #include statements.

Acked-by: Antonio Quartulli <antonio@...515...>

Cheers,

--=20
Antonio Quartulli

--/Uq4LBwYP4y1W6pO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEbd2mMhAXbmSCipS40+HICM1soFAFAllLxpQACgkQ0+HICM1s
oFBqjhAAkhePI3f+2GnGJtsSI5R1IBNDRwxVazr30l9ovlMLQ2izyxljO8N8+JFm
vSmAjVdTA7bAKbKkEXYP8DZkhc2Bp0fc9FTyENJTr79oSw3q2NcveHuTLrawKM/k
CFsO+GdS9tN73F5oNDCFJpNsEo8RJFlLpiic1uJVoTsWgTIz0zycwXg2KeC8UNX3
ylJf6cPZSaZF7N6G1g2I04SZFw0lvcIe6VXewto3Nw6FEsT458WgxkuBnphjbUky
zKGG1bvsPKfnIWJyR1zrHFhCyty9oTfjYvn9vPaEHKKVcUgGZSZD4IShY5j2p/oe
sZdxFlSf54ED4/URYSvJHvwf2Y9P02Q5/YCxBdK4QCqo0fWiGmUMvPC1BgXaDWYu
w6QnlKAexy1xFKIt4ODvdHmhusWZgOh/9tJ3zMBet5R5KAw7VA6riSmLSz4xmyIw
XSCPHCbOgPTKthnAJs1kZYIVFyEcl9P9b2gq4+Q2ELerQHGb5M07Tp1itxNXCKWD
inmzC26oa8v99NVEKTHS7+uLB+XyPJS8E2cp1WzRZ1xMpmVTIw86H0mmPobnHK0z
NmV87AmBTfFDtCnGXgqChzTuJHDi1O3KPg87pNrx3dhmXuevO62xK8x/TFU0qk0d
ag/rMAHFVR7uQuv27mIC5GD6cPdyOfdZSBQLQ0x9eYfhZ+rFWzg=
=e/oK
-----END PGP SIGNATURE-----

--/Uq4LBwYP4y1W6pO--

