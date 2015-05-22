Date: Fri, 22 May 2015 16:43:58 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20150522144358.GB382@...1296...>
References: <555BF270.3090706@...1147...> <20150521181409.GY382@...1296...>
	<555E21F7.4030002@...1147...> <20150521183108.GZ382@...1296...>
	<555E55B4.5080804@...1147...> <20150522074348.GA382@...1296...>
	<555F1566.6030303@...1147...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kPepdeVVZyud5ZkI"
Content-Disposition: inline
In-Reply-To: <555F1566.6030303@...1147...>
Subject: Re: [Openvpn-devel] patch for bug #93: up-restart env vars
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Just Keijser <janjust@...1147...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--kPepdeVVZyud5ZkI
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, May 22, 2015 at 01:39:18PM +0200, Jan Just Keijser wrote:
> > - add a patch to openvpn.8 that explains the differences in --up-restart
> >   (so people will know that the lack of route env vars is not a bug)
>=20
> agreed, but do we patch openvpn.8 before or after the documentation=20
> split ;) ?

Before, so we can close #93 and ship the change in 2.3.7 :-)

I'll send a doc patch tonight.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--kPepdeVVZyud5ZkI
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVV9ArqkuBuNlUUl1AQISPgP8DrDNkDYuUjSovYukccRx/TZ+1xJdM6+R
wAVhNp6ufShCaO83zA7RtoaKyTE2qetoEl2WUF/HQEg8daW+UGapQNODvrKl6jR1
GgtDazbXn2/BL/5B+PZprmC4IntPAYVkEGWAMJ4Fq9n8dE53FOXIgAm3NaGA55HL
sGQwW6y7z94=
=sthQ
-----END PGP SIGNATURE-----

--kPepdeVVZyud5ZkI--

