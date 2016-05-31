Date: Tue, 31 May 2016 15:02:34 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160531130234.GV53051@...1296...>
References: <1464694920-3624-1-git-send-email-pinkel@...277...>
	<574D81DE.1040204@...1435...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nkMSImF/AKWoFNFm"
Content-Disposition: inline
In-Reply-To: <574D81DE.1040204@...1435...>
Subject: Re: [Openvpn-devel] [PATCH master] Plug memory leak in mbedTLS
 backend
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

--nkMSImF/AKWoFNFm
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, May 31, 2016 at 02:21:50PM +0200, Steffan Karger wrote:
> > +end:
> > +  mbedtls_mpi_free(&serial_mpi);
> >    return buf;
> >  }
>=20
> ACK - *but* Ivo did this work for us (Fox-IT), so some external eyes
> before applying are welcome.

I was about to write a NAK, spent some time reading mbedtls/bignum.c,=20
and indeed this is needed (zeroize and free X->p), so another ACK here :-)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--nkMSImF/AKWoFNFm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBV02LaakuBuNlUUl1AQIWPgP/VmaoBSHUiQpNlP1SatThCBaCm0bNwpci
S3wBOUE1GhcgtDHwLRdfR6D/nZmzm+lK0OaQwmo0M9vvCGsAhl6mMZNo2GjwPdAH
d8mcFAWncZA1OrgyhWeXin7Vog2rwiPi9J8ylzmRdKME7tj+tWAUb6y1bMOCg979
COkbj5QGCwo=
=yf1O
-----END PGP SIGNATURE-----

--nkMSImF/AKWoFNFm--

