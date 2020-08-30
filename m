From: Arne Schwabe <arne@...1227...>
References: <20200830140736.16571-1-arne@...1227...>
 <20200830140736.16571-3-arne@...1227...>
Message-ID: <04fe1758-4b84-9acc-5109-be332ec5c25d@...1227...>
Date: Sun, 30 Aug 2020 18:29:19 +0200
MIME-Version: 1.0
In-Reply-To: <20200830140736.16571-3-arne@...1227...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="paJsBEXZAVuBZmCTgPRBJtHzKlcwnOF18"
Subject: Re: [Openvpn-devel] [PATCH 2/2] Also announce IV_CIPHERS as client
 in OpenVPN 2.4
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--paJsBEXZAVuBZmCTgPRBJtHzKlcwnOF18
Content-Type: multipart/mixed; boundary="iUOZS20TgEeMAbc2NatahAqbwwZs059gy"

--iUOZS20TgEeMAbc2NatahAqbwwZs059gy
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


> +++ b/src/openvpn/ssl.c
> @@ -2311,7 +2311,18 @@ push_peer_info(struct buffer *buf, struct tls_sess=
ion *session)
>          if (session->opt->ncp_enabled
>              && (session->opt->mode =3D=3D MODE_SERVER || session->opt->p=
ull))
>          {
> +            /* We keep announcing IV_NCP=3D2 in OpenVPN 2.4 even though =
it is
> +             * technically wrong to ensure not to break 2.4 setups on a
> +             * minor release */
>              buf_printf(&out, "IV_NCP=3D2\n");
> +            buf_printf(&out, "IV_CIPHERS=3D%s", session->opt->config_ncp=
_ciphers);
> +            if (!tls_item_in_cipher_list(session->opt->config_ciphername,
> +                                         session->opt->config_ncp_cipher=
s))
> +            {
> +                buf_printf(&out, ":%s", session->opt->config_ciphername);
> +            }
> +            buf_printf(&out, "\n")

This line misses a ';' at the end :(

I forgot this amending. I can resend the patch if needed.

Arne



--iUOZS20TgEeMAbc2NatahAqbwwZs059gy--

--paJsBEXZAVuBZmCTgPRBJtHzKlcwnOF18
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl9L098ACgkQFRhsZwKx
RFRVEA/9FZW6Acj7kvDtH79jJR/PkMPafDPWc9rbimcEV1gF/v+k+SWK8NryKCr1
5rEkUkr/X+yzOGapIXaxlh55LYhXBPMVRqR25XeISOuzRWzwtqlu0qwHdUINGusd
N8MonOpx8TAqXva49SoF/I5hhgpX9+mRwzoqu+xhg2a2aqQuA0P1cbj3yJa09v3M
639y4VJ0jIUHH2IIjKoNLLF3SrX4Avt83p9GGzBzeH4rDPyh54V7ttDpFH6uE7h0
RDucOc4nmn0z66NMWWVVEFF89iIQIfwm7T+ha7FOmDsbVNdUBFnN4i1u6H5+ipYt
ZdEKbS2c2aQg4RFBH+xYS/Q4krwhgo4FWtIZRhRxr2acsBfJugCWjr0Ey1AWqP7q
Q4foehTyfoTDQ78Clthm4iIwmyONHz4OFy4SQGXGI4qtOZ8ZO2rdt1SmEnn7fbGM
xhzCBi6AMOIkYJ1sDbPOQb63dv0FcmVlrvirqsAhIrotrAeX7EMvSk22RdT+ySRb
vU8HZ1uU0Hap/VVEj4cW04QeafdnOko9x3I82oSICvEpptSnhXWzfdvpu3fnCnJ+
5/ee/+bBQAtu5qKm9zqeDVJsr5Rww62HsllvqRqLl3hwkoag97++x9oegJMHN9AO
NttAxzn68aKNNUY2LAMg4A9PEktSnM7+B177qgYPYSQf20q8fss=
=RoAu
-----END PGP SIGNATURE-----

--paJsBEXZAVuBZmCTgPRBJtHzKlcwnOF18--

