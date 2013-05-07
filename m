Message-ID: <5188CBA0.80701@...1114...>
Date: Tue, 07 May 2013 11:38:40 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1367759408-16770-1-git-send-email-gert@...1296...>
	<1367826941-22412-1-git-send-email-gert@...1296...>
In-Reply-To: <1367826941-22412-1-git-send-email-gert@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="----enig2KJMJVHPOTOBGFCGIIMCG"
Subject: Re: [Openvpn-devel] [PATCH v2] Use constrain_int() instead of
 MIN()+syshead.c compat definition - v2.
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2KJMJVHPOTOBGFCGIIMCG
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 06/05/13 09:55, Gert Doering wrote:
> Reverts commit 15ca5c297b556fbb, instead change ssl_openssl.c to use
> "constrain_int()", which already exists in "integer.h".
>=20
> Using this instead of min_int() ensures that the result is always bounded
> to 0...256 even in the case of a potential MAX_INT overflow.
> ---
>  src/openvpn/ssl_openssl.c |    2 +-
>  src/openvpn/syshead.h     |    7 -------
>  2 files changed, 1 insertions(+), 8 deletions(-)

I like this version better, as it ensures that the "field" length (of
'%.*s') is enforced to be between 0 and 256.

So ACK from me.

> diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
> index 79cc056..c1b19dc 100644
> --- a/src/openvpn/ssl_openssl.c
> +++ b/src/openvpn/ssl_openssl.c
> @@ -232,7 +232,7 @@ tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, co=
nst char *ciphers)
>            // %.*s format specifier expects length of type int, so guaran=
tee
>            // that length is small enough and cast to int.
>            msg (M_WARN, "No valid translation found for TLS cipher '%.*s'=
",
> -              (int) MIN(current_cipher_len, 256), current_cipher);
> +                 constrain_int(current_cipher_len, 0, 256), current_ciph=
er);
>          }
>        else
>  	{
> diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
> index 0c3e4ee..db02c23 100644
> --- a/src/openvpn/syshead.h
> +++ b/src/openvpn/syshead.h
> @@ -399,13 +399,6 @@
>  #endif
>=20=20
>  /*
> - * do we have the MIN() macro?
> - */
> -#ifndef MIN
> -#define MIN(a,b) (((a)<(b))?(a):(b))
> -#endif
> -
> -/*
>   * Do we have the capability to report extended socket errors?
>   */
>  #if defined(HAVE_LINUX_TYPES_H) && defined(HAVE_LINUX_ERRQUEUE_H) && def=
ined(HAVE_SOCK_EXTENDED_ERR) && defined(HAVE_MSGHDR) && defined(HAVE_CMSGHD=
R) && defined(CMSG_FIRSTHDR) && defined(CMSG_NXTHDR) && defined(IP_RECVERR)=
 && defined(MSG_ERRQUEUE) && defined(SOL_IP) && defined(HAVE_IOVEC)
>=20


--=20
kind regards,

David Sommerseth


------enig2KJMJVHPOTOBGFCGIIMCG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlGIy6QACgkQDC186MBRfrqa/QCcDvGKf0RX7QIFQa5wX90b2Tqr
abwAoJZUmJSdpKzj6bPlZUDS2mSqriVR
=g+J7
-----END PGP SIGNATURE-----

------enig2KJMJVHPOTOBGFCGIIMCG--

