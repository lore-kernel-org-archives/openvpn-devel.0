Date: Wed, 1 Jul 2015 16:41:58 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20150701144158.GD382@...1296...>
References: <99A30EB899EB448B846248EC2E9A353A@...1853...>
	<5593EBF6.4060203@...1114...>
	<1896EA4F53C84141B287C36403D7DE21@...1853...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uZ5dETJmNdvv1FsL"
Content-Disposition: inline
In-Reply-To: <1896EA4F53C84141B287C36403D7DE21@...1853...>
Subject: Re: [Openvpn-devel] OpenVPN 2.3.7-I602-x86_64.exe download 404 Error
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: debbie10t@...277...
Cc: openvpn-devel@lists.sourceforge.net

--uZ5dETJmNdvv1FsL
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Jul 01, 2015 at 03:05:44PM +0100, debbie10t@...277... wrote:
> Resolving swupdate.openvpn.org (swupdate.openvpn.org)... 104.28.1.12,=20
> 104.28.0.12
> Connecting to swupdate.openvpn.org=20
> (swupdate.openvpn.org)|104.28.1.12|:443... connected.


Something interesting is going on.  I thought it might be related to
the two different IP addresses, and maybe one has the file and one
does not - but it works for both from here...

Connecting to swupdate.openvpn.org (swupdate.openvpn.org)|104.28.0.12|:443.=
.. connected.
openvpn-install-2.3 100%[=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D>]   1.72M  1.06MB/s   in 1.6s=20=20=20

Connecting to swupdate.openvpn.org (swupdate.openvpn.org)|104.28.1.12|:443.=
.. connected.
openvpn-install-2.3 100%[=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D>]   1.72M  1.04MB/s   in 1.6s=20=20=20

funny.

Samuli, can you investigate?

gert


--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--uZ5dETJmNdvv1FsL
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVZP8NqkuBuNlUUl1AQLwCwQAkejRm8uyJaOOpZW4KYTbKK2Wp9EuAStf
48o8OMyoBWD8u8kNJegsmDFqdSaPNq1eIee41raLn4R2NnMwhGcpbpg26YudYJCe
BrwTjeL2jXaGk62mOAS5mSGQJr0e5PhUQ4oSPzhSRsN3GVw/gOZqTmY5NgzBRlEt
yF9z6yPdQfI=
=uacY
-----END PGP SIGNATURE-----

--uZ5dETJmNdvv1FsL--

