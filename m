Date: Tue, 30 Aug 2016 14:33:18 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160830123318.GT78279@...1296...>
References: <1472413323-21723-1-git-send-email-steffan@...1856...>
	<5109e5e1-bdc9-4920-fe3e-72461a3ed546@...2080...>
	<22844900-214f-b69f-ef15-ace77cf56bbe@...2080...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DLaL2EIg5P33KCvN"
Content-Disposition: inline
In-Reply-To: <22844900-214f-b69f-ef15-ace77cf56bbe@...2080...>
Subject: Re: [Openvpn-devel] [PATCH (master)] Drop gnu89/c89 support,
 switch to c99
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--DLaL2EIg5P33KCvN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Aug 29, 2016 at 11:03:00PM +0200, David Sommerseth wrote:
>  -std=3Dc89
>    Makes the LZ4 library we're shipping explode.

We could fix that, but right now the LZ4 sources are "very close to
upstream" (just a few file and #include renames) so that would make
comparison "are these sane sources or have they been tampered with"
less easy.

But I think -std=3Dc89 would also break stuff that we really want, like

 for( int i=3D0; i<10; i++)
      ^^^

... which really makes "this is the loop variable and nothing else"
much easier to read than having an "int i" 50+ lines earlier in the code...

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--DLaL2EIg5P33KCvN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQCVAwUBV8V9DakuBuNlUUl1AQKv0QP+L61Q/gi8lgCl+j4GQE5gtPpxxZ8aNyHs
VnMw6hTZawzf9GpQs0dAO/6dDsonEMnPwOPdv7eJ+HoVQXKVdDVi+O1KpRjqLiDt
agzXlmzQUwmnNzSAim5Izt8zfu6hPhPcjETW/j1sVHCBRPhq3LiEfaUfQKhiyKaz
2JE+DhWZ1NY=
=jiob
-----END PGP SIGNATURE-----

--DLaL2EIg5P33KCvN--

