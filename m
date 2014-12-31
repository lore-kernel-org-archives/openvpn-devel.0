Date: Wed, 31 Dec 2014 15:30:43 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20141231143043.GE8134@...1296...>
References: <1414269324-14102-1-git-send-email-steffan@...1856...>
	<1414269324-14102-6-git-send-email-steffan@...1856...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s9fJI615cBHmzTOP"
Content-Disposition: inline
In-Reply-To: <1414269324-14102-6-git-send-email-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH 5/6] openssl: use crypto_msg(),
	get rid of openssl-specific code in error.c
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

--s9fJI615cBHmzTOP
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Oct 25, 2014 at 10:35:23PM +0200, Steffan Karger wrote:
> @@ -395,17 +396,20 @@ key_des_check (uint8_t *key, int key_len, int ndc)
>        DES_cblock *dc =3D (DES_cblock*) buf_read_alloc (&b, sizeof (DES_c=
block));
>        if (!dc)
>  	{
> -	  msg (D_CRYPT_ERRORS, "CRYPTO INFO: check_key_DES: insufficient key ma=
terial");
> +	  msg (D_CRYPT_ERRORS, "CRYPTO INFO: check_key_DES: insufficient key "
> +	      "material");
>  	  goto err;

Shouldn't that be a "crypto_msg()" here?

In general, I'd prefer to avoid breaking strings into multiple lines if
it's just for one or two words - I don't think it improves readability,=20
and so it's "just an extra change"...

(Besides these, feature-ACK)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--s9fJI615cBHmzTOP
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVKQIk6kuBuNlUUl1AQKNaQP/Ujm9aIfkl5HcoO1uLd6mEBIQSPhDVQJa
XFwCPrmdnIR5MXwyrFk04MtArQnibRasaXt2DmYzb9id9lXplbESdrGnGE+DCq3x
ij8UopQICB/LtRfJH4DMi3ZOmorJ6RavkZYdjacA44p1FY/HKEwS9LvRaHOcm9n+
1bgpP/IfJdg=
=0lmk
-----END PGP SIGNATURE-----

--s9fJI615cBHmzTOP--

