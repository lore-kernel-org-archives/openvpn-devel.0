Date: Fri, 9 Nov 2018 11:24:38 +0100
From: Christian Hesse <list@...1798...>
Message-ID: <20181109112438.668bc2b5@...1799...>
In-Reply-To: <1541757573-30178-1-git-send-email-lstipakov@...277...>
References: <1541757573-30178-1-git-send-email-lstipakov@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/kDa9IZ0Q.Oh4ZJVBv..QK3A"; protocol="application/pgp-signature"
Subject: Re: [Openvpn-devel] [PATCH] Remove extra token after #endif
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--Sig_/kDa9IZ0Q.Oh4ZJVBv..QK3A
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Lev Stipakov <lstipakov@...277...> on Fri, 2018/11/09 11:59:
> Commit ee80ce3d6f2ebc59068338757311e0488ae620fc wrapped
> code in #ifdef/#endif and added extra token after #endif,
> which produces compiler warning.
>=20
> This removes unneeded extra token.
>=20
> Signed-off-by: Lev Stipakov <lstipakov@...277...>
> ---
>  src/openvpn/init.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
> index 586e4ca..1cdef31 100644
> --- a/src/openvpn/init.c
> +++ b/src/openvpn/init.c
> @@ -624,7 +624,7 @@ save_ncp_options(struct context *c)
>      c->c1.ciphername =3D c->options.ciphername;
>      c->c1.authname =3D c->options.authname;
>      c->c1.keysize =3D c->options.keysize;
> -#endif ENABLE_CRYPTO
> +#endif

Perhaps this should go into comment:

#endif /* ENABLE_CRYPTO */
--=20
main(a){char*c=3D/*    Schoene Gruesse                         */"B?IJj;MEH"
"CX:;",b;for(a/*    Best regards             my address:    */=3D0;b=3Dc[a+=
+];)
putchar(b-1/(/*    Chris            cc -ox -xc - && ./x    */b/42*2-3)*42);}

--Sig_/kDa9IZ0Q.Oh4ZJVBv..QK3A
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXHmveYAHrRp+prOviUUh18yA9HYFAlvlYGYACgkQiUUh18yA
9HaBtAf/RnvDLOpi1CAWB1fkG01agFQ30YC+tJfWyVT3cvZNJvYuB7b+48xvVssK
VWnVzsqCaEoMfQ34NCbLMbzKhrKNcd1aEcRt1+sg7Oi41KwMUATLpc2HZaUFWbyf
AYxgkIAcyxZ6ijJ8BwE6slGUVN8mHbdQ29z6RAMERS/6zXYH91vB2moZvdJxb8M0
Ae/7+nzRG+5pFPBV8+8u5M5jX5dF64dsk4OI/a7o139ikzROBFALLGhDbkSSn1Ot
yZ+KjJ8whit6KkXFmMGq3ns2JUV2bovH9TCNw8tD4boxUem4PVVOG/vwxJAmVDyt
p5IKqljeNir7MW69yBnJ1ZLAYq6wJw==
=9q19
-----END PGP SIGNATURE-----

--Sig_/kDa9IZ0Q.Oh4ZJVBv..QK3A--

