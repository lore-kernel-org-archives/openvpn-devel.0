Date: Mon, 29 May 2017 19:32:28 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20170529173228.GY97029@...1296...>
References: <b40a8930-a6aa-cd9d-8cfb-0ed57d1cdc93@...277...>
	<bfb1203d-06e7-8242-c4bd-091e7d50801f@...2080...>
	<1a69f080-a1bc-f646-ffdc-5c5ca27ac1f4@...277...>
	<6ec92ca3-7050-6e6e-533e-4771e4970816@...515...>
	<ec48fefc-8b36-d34c-9ddb-18f196eabd8e@...2080...>
	<36e89683-6f8f-7595-d140-64d64f71b0f0@...277...>
	<2720741f-5df5-96ba-b253-5b84a9c5ad00@...2080...>
	<ebd2f501-ff03-ee3c-7aeb-a10b6e1489ab@...277...>
	<20170529145009.GX97029@...1296...>
	<dc53b349-cdd1-c26c-a105-18a8f294844a@...2080...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fc3RSXbRKaEj1MFC"
Content-Disposition: inline
In-Reply-To: <dc53b349-cdd1-c26c-a105-18a8f294844a@...2080...>
Subject: Re: [Openvpn-devel] Ubuntu 16.04.2 LTS --enable-systemd ./configure
 error
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--fc3RSXbRKaEj1MFC
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, May 29, 2017 at 05:43:52PM +0200, David Sommerseth wrote:
> > Maybe our configure should point this out more clearly, that is, if
> > "--enable-systemd" is given and pkg-config cannot be found, complain
> > about lack of *pkg-config*...
>=20
> Actually, pkcs11-helper and p11-kit checks also depends on pkg-config
> ... the systemd pkg-config calls just happens to be run first to bail
> out if it can't figure out the systemd details.  It seems pkg-config
> first called on pkcs11-helper, then openssl - both which considers
> "failure" as non-critical.
>=20
> If it is only the openssl.pc missing on some *BSD distros, then I think
> we can have pkg-config being a requirement which is checked for as early
> as possible.  Otherwise, we'll need to check for pkg-config if
> pkcs11-helper, p11-kit or systemd is enabled.  And for each new
> dependency with pkg-config support.

On the BSDs (and Solaris) we can't assume pkg-config support.  So everything
that is not linux specific has to fall back to "just try and see if linking
works".

> Btw ... I also see we could utilize pkg-config for lz4 too (at least
> with lz4-1.7.3)

This happens to have a pkg-config entry on FreeBSD, but it's called
"liblz4.pc"... go figure :-)

(And I did not check the other ones)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--fc3RSXbRKaEj1MFC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJZLFsrAAoJEB2Cnv7KVigSTWkL/A/a0iddU3yxhn8GR+79oYwP
iYln8FbQyKWLXEIPYBSAyLtEYvlvlRQn57p3apJKTDGdX0W/ZUUqQgNR6mbXKxfW
TSfn79N+xh7ioPtaTCUEDRpr+MVxs2BkNtMDQIA9lFNs2K/pGRkf6hRxcaQH53SB
YjiAzZNUrUB6O3iaLdP0Kp6w6i8wNX3wM/aUxYfKDspAkPN2HDnotGFawBSnZCZa
1B3UrXaTmcqtEBR0bYEnsiYk6yAuiqnlMdCrQxI+LIjEfapJe/AZD9fxxfSG1MiJ
5P28/RRI2mMP7Ef4nY557G6Im1n9nx5N/tO+hGHjnxoWGKRsif8q5D0cJ6YRdk0K
mGSZRr31th8Qsf9afGS++gC127gO6FdF8U3hMJIcOZRf2n8+sLEuJh8SYH7tsh3b
vy2SilpO2s++3AoJwNxi/A1bXD1UMY6wiyHl21H2Y0LCyDVqTfFk72viFQUYNPei
/JKp60Xjf513wQgR8GNmv2p8Ey+dqxLJuiXFhW5LGA==
=38Ua
-----END PGP SIGNATURE-----

--fc3RSXbRKaEj1MFC--

