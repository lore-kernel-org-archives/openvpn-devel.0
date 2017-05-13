From: Antonio Quartulli <a@...2181...>
Message-Id: <33FD94D8-6860-45F6-AC9D-7CD7D8D93CD9@...2181...>
Content-Type: multipart/signed;
	boundary="Apple-Mail=_2614C57C-A992-44E2-97E6-CC8543D00F04";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Date: Sat, 13 May 2017 21:40:30 +0800
In-Reply-To: <CAO5O-EKGgpYAsJC5j+osB_LAteoUDbOwVYVqkB2=cA3a6VVHoA@...278...>
References: <CAO5O-EKGgpYAsJC5j+osB_LAteoUDbOwVYVqkB2=cA3a6VVHoA@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Avoid a 1 byte overcopy in
 x509_get_subject (ssl_verify_openssl.c)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Guido Vranken <guidovranken@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--Apple-Mail=_2614C57C-A992-44E2-97E6-CC8543D00F04
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Guido,

comments below,

> On 13 May 2017, at 18:37, Guido Vranken <guidovranken@...277...> wrote:
>=20
> Signed-off-by: Guido Vranken <guidovranken@...277...>
> ---
> src/openvpn/ssl_verify_openssl.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_op=
enssl.c
> index 8374783..d64f83c 100644
> --- a/src/openvpn/ssl_verify_openssl.c
> +++ b/src/openvpn/ssl_verify_openssl.c
> @@ -285,11 +285,11 @@ x509_get_subject (X509 *cert, struct gc_arena *gc)
>=20
>   BIO_get_mem_ptr (subject_bio, &subject_mem);

I don=E2=80=99t think you patch is based on master, isn=E2=80=99t it?
The codestyle has been recently revisited and there should be no invocation=
 of a function with a space between its name and the =E2=80=98(=E2=80=98. S=
o this code looks old.

>=20
> -  maxlen =3D subject_mem->length + 1;
> -  subject =3D gc_malloc (maxlen, false, gc);
> +  maxlen =3D subject_mem->length;
> +  subject =3D gc_malloc (maxlen+1, false, gc);


Please keep the spaces around arithmetical operators (i.e. =E2=80=9Cmaxlen =
+ 1=E2=80=9D);


>=20
>   memcpy (subject, subject_mem->data, maxlen);

wouldn=E2=80=99t the patch just be way easier if you had changed =E2=80=9Cm=
axlen=E2=80=9D with =E2=80=9Cmaxlen - 1=E2=80=9D in the line above? This wa=
y you wouldn=E2=80=99t need to change the rest and maxlen would still be th=
e real maxlen.

But this is just my personal taste.

> -  subject[maxlen - 1] =3D '\0';
> +  subject[maxlen] =3D '\0=E2=80=99;


Cheers,

--
Antonio Quartulli




--Apple-Mail=_2614C57C-A992-44E2-97E6-CC8543D00F04
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJZFwzUAAoJENPhyAjNbKBQLkkP/28FQM+qv7M2SBNdEDwn/Zsr
HjEbUzkJVMZ1VRVUW2GxjSuwgM0mLUKRXIkgACZC26FvPAG0ZLqRZLWPDVsOnkI2
VfXK89z1FgCOhbJfCHUqRGkIQ8Jp8pTh5TxOo29hPLNGXBxNXPDp1kPt7mTJBVwM
wp8rwx3Ub07TBxV2WpkHSM21xzRugPCnixu6zMBKOWDYELtY1b/62YyUfqKD/4Hs
iF8nv257wFRNaIP2YyFwnzK1y8aZ6UcO10+Dwl+OoG/hoC9ZNeJhs24U/B11k0Hq
uwGgkk93l6SbvWbXHSVLuVM+Ib+v5WVXcddFMEO3v6GslrhXqVxyV1fUBDQbrmnz
Ef+kWvz/KiznxAUOSKYi2413zHbXQMVcWqlDCytShvoFc8sLZ0rlTTnY8hU00vLw
XsVe8k+MLxefFYaCsUaUrD13Co1XtVIiCzMfsu3zOWydhfHP9pQCLr9IEPd5Z1DA
qMASpOEn3zbDDOvSJADPNYkqWt2IoPJf2ITy4rOtp80ekjAv6rj/lJ9L7EIKvmZc
dfzeiCjRS8m/NJNLnt46hXtnhiMO0FPmMSmP0P+NingCWAnp0R/kDef3DywBOkZc
g8Ywgi2t6Z3xUZpainEajqgMYqlOKvWOGtbLjyxdH1GHfldILG4+6gzore1aELJz
Oq/L5yB0HSdlvnHQXHIE
=ZOFw
-----END PGP SIGNATURE-----

--Apple-Mail=_2614C57C-A992-44E2-97E6-CC8543D00F04--

