References: <20191110133525.6069-1-a@...2181...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <bb7d7a21-bcdb-61fc-565a-df67410961e7@...1227...>
Date: Sun, 10 Nov 2019 15:38:41 +0100
MIME-Version: 1.0
In-Reply-To: <20191110133525.6069-1-a@...2181...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="KxLw3Dl3fSJlytRg3QW1KssJPiIZbndNr"
Subject: Re: [Openvpn-devel] [PATCH 1/3] auth_token_kt: ensure key_type
 object is initialized
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KxLw3Dl3fSJlytRg3QW1KssJPiIZbndNr
Content-Type: multipart/mixed; boundary="Nq0pKOSex4dikDLyvYtaknDK6XlZIbbYv"

--Nq0pKOSex4dikDLyvYtaknDK6XlZIbbYv
Content-Language: de-DE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 10.11.19 um 14:35 schrieb Antonio Quartulli:
> Fixes the following warning:
>=20
> auth_token.c: In function 'auth_token_init_secret':
> auth_token.c:47: warning: 'kt.cipher_length' is used uninitialized in thi=
s function
> auth_token.c:34: note: 'kt.cipher_length' was declared here
>=20
> Signed-off-by: Arne Schwabe <arne@...1227...>
> Signed-off-by: Antonio Quartulli <a@...2181...>
> ---
>  src/openvpn/auth_token.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/src/openvpn/auth_token.c b/src/openvpn/auth_token.c
> index 1edc8069..6275299d 100644
> --- a/src/openvpn/auth_token.c
> +++ b/src/openvpn/auth_token.c
> @@ -31,7 +31,7 @@ const char *auth_token_pem_name =3D "OpenVPN auth-token=
 server key";
>  static struct key_type
>  auth_token_kt(void)
>  {
> -    struct key_type kt;
> +    struct key_type kt =3D { 0 };
>      /* We do not encrypt our session tokens */
>      kt.cipher =3D NULL;
>      kt.digest =3D md_kt_get("SHA256");
>=20

Acked-by: Arne Schwabe <arne@...1227...>

Arne


--Nq0pKOSex4dikDLyvYtaknDK6XlZIbbYv--

--KxLw3Dl3fSJlytRg3QW1KssJPiIZbndNr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl3IIPIACgkQFRhsZwKx
RFTQZw//WOJ7aqstmSEEujCVoqPTJWiqByYp8j9MGHLQ1jDZhEX2aJ78E4EsMUmS
31Kdb7ivkCENwUjuCxrZ0r5X2e7TjTttVhzDWReP5dOuyyixi2B8k893xPi1aees
Zuir12QRit+L66zojS3Nt3yt05equHUtzGYIatkIMI/n+ndPAHDtSRlF8/0luXai
+c3Ckx9eJ4IzJD1Lbk0a+4zat0fw/UWjnEOtseG0h3SBHq8hn2PTnqcFx+Kk7/BE
fXSl5vqpqz9c5SF7i3IdTTzvFqkCGB1EqOZqn5pAwtuyFlLj4AGtph4tx04JEC4Y
/PtKcQisa0KJGIDQmmvFzFMy4YLyGPcxFyKlA+u4s1I+t+gTydlObj2x4XQc1cB4
IIJMGyI0QzzVwfFhWoiaaNk4d7IHlKZXYEiTbqqH4mXwuGwSS9b2NVb6KlNizOX7
PzmsMoI+6YfJCkLhSyUiX68BOzHLKhQssSNAEydEWPMCqtyZLQgy5zyos15uflyd
+D11ZzDFHUjKJ/AIbhwrD38rQT6jjO0plD1obG2QReHiKyGZxlCSrla6qgckmdO/
2lUYwWachb83ZGNVgq3mbrdqL+KqYSrYUX27+olJI3MQHKPTyqCx8tkp0kDuYqsg
F4Pb0roktjGmq9xOgZ/68c0mh+T6Uizzhq7BdNUfUnYXyozoXLA=
=st5M
-----END PGP SIGNATURE-----

--KxLw3Dl3fSJlytRg3QW1KssJPiIZbndNr--

