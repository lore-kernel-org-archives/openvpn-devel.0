Date: Tue, 15 Apr 2014 12:19:20 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140415101919.GF16637@...1296...>
References: <20140413152613.GT16637@...1296...>
	<20140414193422.GN16637@...1296...>
	<534C42AB.7040700@...1114...>
	<20140415074239.GR16637@...1296...>
	<534CF7FD.9070204@...1528...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Pvh1ppoAQFOy1nWA"
Content-Disposition: inline
In-Reply-To: <534CF7FD.9070204@...1528...>
Subject: Re: [Openvpn-devel] RFD: ssl library version numbers
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "M. Braun" <michael-dev@...1528...>
Cc: openvpn-devel@lists.sourceforge.net

--Pvh1ppoAQFOy1nWA
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Apr 15, 2014 at 11:12:29AM +0200, M. Braun wrote:
> Am 15.04.2014 09:42, schrieb Gert Doering:> char *
> > get_ssl_library_version(void)
> > {
> >     static char polar_version[30];
> >     unsigned int pv =3D version_get_number();
> >     sprintf( polar_version, "PolarSSL %d.%d.%d",
> >                 (pv>>24)&0xff, (pv>>16)&0xff, (pv>>8)&0xff );
> >     return polar_version;
> > }
> >
> > this is well-defined (polarssl/version.h), and guaranteed to not overfl=
ow.
>=20
> wouldn't be using snprintf with length sizeof(polar_version) instead of
> just sprintf be better as to make sure this will not be broken by
> accident in future?

How can this ever be broken?  0xff bounds the numbers to 3 digits,=20
there are only 3 numbers in there, which adds up to 21 bytes, at
maximum.

Now if someone changes that code to add more text, it might...

(but I actually tend to go back to the previous version, as PolarSSL
guarantees that they won't overrun these "magic 18 bytes", as that is
"2 digits for each number", and if they ever add more text to the
string, they will introduce a new API which is more sane than this - had
a side-track discussion with Paul and David on it, of which David missed
most due to his MTA bouncing all mails...)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--Pvh1ppoAQFOy1nWA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBU00Hp6kuBuNlUUl1AQLdjwP9FDmsO7gyBwvWI2xBCs5vnXzMZCCrcrMC
uHM7FSo7j86ou9T41P6aLwXG9qrJ7jJgYaqiCoRZmiFc4suXxPFP8ONra9rOO5ZC
sEnBYFctSsW/Uxb53LCbC3On/ceXyZJRaJhw16/YsjwJsuEugqWBAVDK2i2N5qHP
jnj/P8XrzKw=
=eVzv
-----END PGP SIGNATURE-----

--Pvh1ppoAQFOy1nWA--

