Date: Tue, 9 May 2017 11:19:10 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20170509091910.GM97029@...1296...>
References: <1494317563-6303-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LKTjZJSUETSlgu2t"
Content-Disposition: inline
In-Reply-To: <1494317563-6303-1-git-send-email-steffan.karger@...1435...>
Subject: Re: [Openvpn-devel] [PATCH] mbedtls: correctly check return value
 in pkcs11_certificate_dn()
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

--LKTjZJSUETSlgu2t
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, May 09, 2017 at 10:12:43AM +0200, Steffan Karger wrote:
>          goto cleanup;
>      }
>=20=20
> -    if (-1 =3D=3D mbedtls_x509_dn_gets(dn, sizeof(dn), &mbed_crt.subject=
))
> +    if (!(ret =3D x509_get_subject(&mbed_crt, gc)))
>      {
>          msg(M_FATAL, "PKCS#11: mbed TLS cannot parse subject");
>          goto cleanup;
>      }
>=20=20
> -    ret =3D string_alloc(dn, gc);
> -

ACK.=20=20

x509_get_subject() does exactly the same thing, just with error handling
for the case "mbedtls_x509_dn_gets() returns 0".  So - less code, and
error case handled :-)

(Note: cleanup patch expected, to remove the "goto cleanup" calls after
a msg(M_FATAL, ...) line which is guaranteed to never return)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--LKTjZJSUETSlgu2t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJZEYmNAAoJEB2Cnv7KVigSc0kL+wfgS8nf4Tkr2oTJ61JbwziF
jk19k1Hp3KiKwvwAn6yhp3HoDHNG9nBPYPiXZ/+a20BU3JreBIiCgMVIITBfluaK
4IDowcu7CXSwadplkfn7jCZSF+3FgNIjXIwO6vYbxHh8+pMOw2ccOS+F0sk2VSkJ
q03IKsViGyBUIEE650w77+KxOgB7GDbATjj7sY4CFMm4aQMSSN0rgTLeJ0TVMVrs
cwhTB4uyFB1mD5cYj3AmesQ5C/LWtpwW8jMYdA0oSEr/xCA+GEkPAhXO1QNWuBlV
qCJKyGYyrG5b20NctesAKozA6Hz28MU5N7WuyTN1kSho38T1E1mnzJfNPKnLu5Xe
C5RDaaIrhYx2JJwoHQCIRKnGVE1BlcGzO6plSYT3FedHdP9Z9ShhsnIUm0TuVX1K
Lr5MCUXyiBP4H6w+U+abIiCAWOFVP+PGCtpH1nvFGWmpEqO33kECj41+xJGY34nJ
jRGbJDaxkaSLrA7qNzehbLSFulqZIh0Mm3CgqcvOPA==
=WFPT
-----END PGP SIGNATURE-----

--LKTjZJSUETSlgu2t--

