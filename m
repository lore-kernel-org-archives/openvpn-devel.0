Date: Sun, 7 Oct 2018 09:29:33 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20181007072933.GZ962@...1296...>
References: <20171202152144.22426-1-a@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="e59cmCxsGlzMyaN0"
Content-Disposition: inline
In-Reply-To: <20171202152144.22426-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v7] convert *_inline attributes to bool
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

--e59cmCxsGlzMyaN0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Dec 02, 2017 at 11:21:44PM +0800, Antonio Quartulli wrote:
> Carrying around the INLINE_TAG is not really efficient,
> because it requires a strcmp() to be performed every
> time we want to understand if the data is stored inline
> or not.
>=20
> Convert all the *_inline attributes to bool to make the
> logic easier and checks more efficient.
>=20
> Signed-off-by: Antonio Quartulli <a@...2181...>

As discussed with Antonio right now, this got left in the cold for too
long and much of the surrounding code got changed - so it does not apply
anymore.

(Also, it was missing an ACK...)

Can I have a rebased version & an ACK on that, please? ;-)

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--e59cmCxsGlzMyaN0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJbubXcAAoJEB2Cnv7KVigSsUkL/iLii74eX/TEw0lyk2TD13lN
ox8jFPgux1jCWR83HWFfNjX2eiN03OY7Er4NSkuTAABVa79a2g0iYp0S83L78JMx
vNcdP1kO+EMwQ0FjE9LNzqiju+qQRZTcaJuZ7IWzCNJu8gxszKgtV2/jfUTEP14r
TQib8RHgMRayuXds/Qs7/TKBM6XVLhEfkHonainf7qQx+agm574v9L91B5MizwQt
LM54OHhX7XoY2XBgJ7HwUnJ5xiIpaluRKf2mlEkHQ7j7d3uZi/IzSfH6HRMTCH7o
Ei/RzY3nFP+2rQdSvH2qrqCjBZOvmt+7P5MsVkRa6Dg3Efd07OgUpYpRfbvdyz7f
dCkQZEqXj3D7yuCJEcu1EKVFgyZYZrejCXeBfkzG+sPauqD/Zmc/BWKSJ+qptnDw
s215aXDtIfl0bqvkgyd9J1bRjq1FbburXidBpy3Ul+WC2nGjC/4bXy+t7dNy2f36
uxRb1N6GO8Fv4PKCYZDv8Jh4Xm186AY5q2+mU9dLLA==
=c3Y2
-----END PGP SIGNATURE-----

--e59cmCxsGlzMyaN0--

