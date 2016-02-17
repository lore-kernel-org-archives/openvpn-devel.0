Date: Wed, 17 Feb 2016 16:26:37 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20160217152637.GF24952@...1296...>
References: <56C32BCD.1050407@...515...>
	<4C31798F36DC4AEAB6F32F82028081C3@...2089...>
	<56C47948.5070804@...1227...> <56C4842D.8020605@...515...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SJSmxtiB2WItBmX7"
Content-Disposition: inline
In-Reply-To: <56C4842D.8020605@...515...>
Subject: Re: [Openvpn-devel] Handling bitness (32/64) for OpenVPN
 Windowsinstallers
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

--SJSmxtiB2WItBmX7
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Feb 17, 2016 at 04:31:09PM +0200, Samuli Sepp=E4nen wrote:
> Yes, that is big part of the appeal. Plus the results of the=20
> installations would be more consistent:
>=20
> - Registry keys would always be in the main registry
> - OpenVPN always under "C:\Program Files\OpenVPN" (unless customized)

I do like this :-)

The installer would need some way to deal with "legacy" prior setups,
namely "the new and magic 32/64 bit installer hits a 64-bit system that
has a 32-bit OpenVPN on it".  But that's not truly different than today
(64bit installer running on a system that has the 32bit version pre-
installed), so we need to fix this some way or the other anyway...

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--SJSmxtiB2WItBmX7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVsSRLKkuBuNlUUl1AQKu9QQApZx4+5Ri+bmBt0d0pUQdbJRVde/fLni8
NoOjptghksnJmQqyHTDdsx++YoFiotyJcayQxiZ8XRMXLNIpIrnrOHIkIG33JWjS
YI5uIh18EZVbUk5VoCcZEbeurgRC4J7AGrj38FBP/l/rvzDstB8XOgbnxBcWtOMi
EmC66lucfSA=
=OG3S
-----END PGP SIGNATURE-----

--SJSmxtiB2WItBmX7--

