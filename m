Date: Thu, 9 Jul 2015 09:37:56 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20150709073756.GX382@...1296...>
References: <99A30EB899EB448B846248EC2E9A353A@...1853...>
	<5593EBF6.4060203@...1114...>
	<1896EA4F53C84141B287C36403D7DE21@...1853...>
	<20150701144158.GD382@...1296...>
	<55963DC2.7060104@...515...> <559E2283.2030609@...515...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LitXjSG+kozIp4+C"
Content-Disposition: inline
In-Reply-To: <559E2283.2030609@...515...>
Subject: Re: [Openvpn-devel] OpenVPN 2.3.7-I602-x86_64.exe download 404 Error
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Samuli =?iso-8859-1?Q?Sepp=E4nen?= <samuli@...515...>
Cc: openvpn-devel@lists.sourceforge.net

--LitXjSG+kozIp4+C
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Jul 09, 2015 at 10:28:03AM +0300, Samuli Sepp=E4nen wrote:
> <https://community.centminmod.com/threads/cloudflare-universal-ssl-incomp=
atible-with-winxp-internet-explorer-8-browsers.1577/>
>=20
> We have received reports that downloads from Windows XP don't work,=20
> either. We will probably have to move the downloads to a domain which=20
> does not use ECC.

"ECC" might not be the issue here, but "the funny set of ciphers that
cloudflare uses" seems to be - incompatible with older clients, but at
the same time, very bad marks at ssllabs.com (usually, "leaving out older
clients" is done to *improve* security)... funny this.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--LitXjSG+kozIp4+C
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVZ4k1KkuBuNlUUl1AQLWJwQAlozf9BKZzS7DB5wimULDdrSou+0KJwCI
V+vcDMOJ9sYMxfSLbT/HtlDmNqN2MyLGBDZUQ6GrGqeSPqnNSOnrCYkjfHGC2PWZ
ZGonGDQrxxHKwkm+FmpFQNBDwxzn51SpumfLm9qU9BoI8I0pVAMbw90knsvmIvNr
pE/ko9fNMu0=
=zvfR
-----END PGP SIGNATURE-----

--LitXjSG+kozIp4+C--

