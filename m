Message-ID: <1591313693.4288.22.camel@...2316...>
From: James Bottomley <James.Bottomley@...2316...>
Date: Thu, 04 Jun 2020 16:34:53 -0700
In-Reply-To: <8aea6171-f862-ca03-dbce-fc03da38d3b2@...1227...>
References: <1590709611.3515.22.camel@...2316...>
 <8aea6171-f862-ca03-dbce-fc03da38d3b2@...1227...>
Content-Type: multipart/signed; micalg="pgp-sha256";
 protocol="application/pgp-signature"; boundary="=-Xncx1vv3bh930ZE9m9BG"
Mime-Version: 1.0
Subject: Re: [Openvpn-devel] [BUG] test_ncp.c failing
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

--=-Xncx1vv3bh930ZE9m9BG
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-06-05 at 00:37 +0200, Arne Schwabe wrote:
> Am 29.05.20 um 01:46 schrieb James Bottomley:
> > I'm getting this failure of test_ncp.c
> >=20
> > [ RUN      ] test_check_ncp_ciphers_list
> > [  ERROR   ] --- 0x7d67e8 !=3D 0
> > [   LINE   ] --- test_ncp.c:65: error: Failure!
> > [  FAILED  ] test_check_ncp_ciphers_list
> >=20
> > I'm building under openssl-1.1.0i
> >=20
> > The problem seems to be openssl uses a mixed case name for the
> > cipher and EVP_CIPHER_name() is case sensitive.  Applying the patch
> > below fixes this for openssl and gets make check to pass all tests,
> > but I rather wonder why this isn't part of cipher_kt_name() to
> > prevent this type of problem?
>=20
> Without double checking if I remember correctly OpenSSL 1.1.0 is a
> corner case in this regard. OpenSSL 1.1.1 accepts mixed and non mixed
> case.

It was fixed by:

commit fc196a5eb97dc3a5465c37a6761428ddd81b023d
Author: Pauli <paul.dale@...2299...>
Date:   Tue Sep 4 07:35:45 2018 +1000

    Make OBJ_NAME case insensitive.
=20=20=20=20
    Reviewed-by: Richard Levitte <levitte@...2559...>
    (Merged from https://github.com/openssl/openssl/pull/7089)

So yes, all of 1.1.1 has this fix.

James

> I want to fix this oddity in a proper way and write at least a small
> unit test to ensure that always end up with the same cipher on the
> wire protocol (in IV_CIPHERS and in the options string).
>=20
> Arne
>=20

--=-Xncx1vv3bh930ZE9m9BG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABMIAB0WIQTnYEDbdso9F2cI+arnQslM7pishQUCXtmFHQAKCRDnQslM7pis
ha5jAP9yCkbq+aQlrNVEml80n6b1l8dNNoM1vH3Cwb6FApC8VQEAxtK5GlgUGth2
iNFr6FJT09vVzhLh8QuCCx5IJBDsUy0=
=DYIy
-----END PGP SIGNATURE-----

--=-Xncx1vv3bh930ZE9m9BG--


