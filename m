Date: Sun, 10 Oct 2021 16:57:13 +0000
From: tincantech <tincantech@...2282...>
Reply-To: tincantech <tincantech@...2282...>
Message-ID: <FrD0Hkyr7V4cQfbg9n2wbt1UpIYqjeO93kuJXRsqVdQLsK3SmLkrOLVJTKJQH5bYrd_piwL98DX1LCi1Akz-B2kp9rSDk2jAGcGoQipMiKo=@protonmail.com>
In-Reply-To: <20210917153526.912375-1-tincantech@...2282...>
References: <20210917153526.912375-1-tincantech@...2282...>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1_7SmFLZuypnX9kpJCfi0RhLXsORB60cuCVQkWqxGBb2I"
Subject: Re: [Openvpn-devel] [PATCH] Correct value for --client-disconnect
 env variable common_name
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: stringvest88@...277...
Cc: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.

--b1_7SmFLZuypnX9kpJCfi0RhLXsORB60cuCVQkWqxGBb2I
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi,

I NAK this for the following reasons.

The original problem:
  "Openvpn does not set common_name for --client-disconnect",
  for reasons which have not been identified, no longer occurs.

The code has changed enough since 2011 that a new problem occurs.

The new problem:
  Openvpn sets common_name to X509-CN for --client-disconnect,
  after a client has attempted to float, successfully or not.

If this patch is applied to current Openvpn then similar behaviour
of the original problem occurs.  That being, after a client attempts
to float then common_name is not set at all.

I have also written Easy-TLS to work around this bug, as it stands,
and Easy-TLS manages connection tracking 100% successfully.

Regards
R


Sent with ProtonMail Secure Email.

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90

On Friday, September 17th, 2021 at 16:35, <stringvest88@...277...> wrote:

> From: Richard T Bonhomme tincantech@...2282...
>
> A server configured with --client-disconnect and --username-as-common-name
>
> will pass the X509-CN not username, after the client has completed a
>
> renegotiation, to --client-disconnect.
>
> Explicitly set the environment variable common_name to the current value,
>
> which will be username in this case, prior to calling --client-disconnect.
>
> Trac: #160
>
> Signed-off-by: Richard T Bonhomme tincantech@...2282...
>
> src/openvpn/multi.c | 4 ++++
>
> 1 file changed, 4 insertions(+)
>
> diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
>
> index 22357cfb..c72e8e95 100644
>
> --- a/src/openvpn/multi.c
>
> +++ b/src/openvpn/multi.c
>
> @@ -557,6 +557,10 @@ setenv_stats(struct context *c)
>
> static void
>
> multi_client_disconnect_setenv(struct multi_instance *mi)
>
> {
>
> -   /* setenv client current common-name */
>
> -   setenv_str(mi->context.c2.es, "common_name",
>
> -                 tls_common_name(mi->context.c2.tls_multi, true));
>
>
> -   /* setenv client real IP address */
>
>     setenv_trusted(mi->context.c2.es, get_link_socket_info(&mi->context));
>
>
> 2.25.1
-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsBzBAEBCAAGBQJhYxtZACEJEE+XnPZrkLidFiEECbw9RGejjXJ5xVVVT5ec
9muQuJ1suAgAkjPdY7Zh0qZpnSjd2nUoBwnsafzflGlzlTjzokRURa5+aAdK
zDZvyN3TTayZgVlnFWRf+lvrIQTbYyUkLSRqxWfiDabr6BxIEGeFxqWardLn
YAdfvwI8MX17HBZPXI02EJiaCnKWA90uU9OM1DRzswarc8Kakqrs61vIy/iL
LhamBby/984WrJhJq1Gv90aM25E6/GLCi9GUAHixhvxDiaeCiWDpO/asB19d
TYxJWt1yVxuELAIaot02ESMPEogorK3V9W52oN64xCieoKWYsW51OxgSFMfu
0JIv20gJdPLMM0GOPFOi3ZHVPChiLg+gh7tiQixsi4+LGMkwOT4+hw=3D=3D
=3D+jcn
-----END PGP SIGNATURE-----

--b1_7SmFLZuypnX9kpJCfi0RhLXsORB60cuCVQkWqxGBb2I
Content-Type: application/pgp-keys; name="publickey - tincantech@...2282... - 0x09BC3D44.asc"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - tincantech@...2282... - 0x09BC3D44.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tDQpWZXJzaW9uOiBPcGVuUEdQLmpz
IHY0LjEwLjEwDQpDb21tZW50OiBodHRwczovL29wZW5wZ3Bqcy5vcmcNCg0KeHNCTkJGdndTY2NC
Q0FET21IRW5RbExtT2pKUnRKTDJsNTNNTHd3RlR5N1huRXBzM2IxUTBVd1dZRkN2DQpMMm9OcDBu
cmRHbEtLREpxNTBZMDlTUitVUllCUW1LbVkzRW16cHlVSUtNL3JnbzFSeXViSHBNUkhiRHANCjdK
cDhMeGtmZkZCVkpqL3Q1Vk1wRDZlTVI2YVVjaVFqZ1JMOE5aZTYrVDd4ZlhYWHdWNWhvUmVaM2pP
Kw0KekhpNlNSN3hUdkdYbGErTVF6NkVFcFdubGJMdmcyb3J0OUtzZXVWallycXZSTXhjZFAwbzlj
WldKNWVwDQpKTm1nZUI2TTcrT1cwOFUxU3NYdEtycExSY0k2eUttVjM4amh6UHIyWmdQOXJtcmxF
clIvMWlxUVFIWFkNCm84LzBEZlB5RjBtSDl5blFJaUxFL2wrRll1NHJzRzhWaUtseGhYY3plUHpB
dExDamlCMGEwbVJWQUJFQg0KQUFITk55SjBhVzVqWVc1MFpXTm9RSEJ5YjNSdmJtMWhhV3d1WTI5
dElpQThkR2x1WTJGdWRHVmphRUJ3DQpjbTkwYjI1dFlXbHNMbU52YlQ3Q3dIOEVFQUVJQUNrRkFs
dndTY2NHQ3drSENBTUNDUkJQbDV6MmE1QzQNCm5RUVZDQW9DQXhZQ0FRSVpBUUliQXdJZUFRQUtD
UkJQbDV6MmE1QzRuUUJEQi85WlVvOUJPWEpSNjFObQ0KMDJvWi84YVJYTzlOblVTRnQ2R0xPV2NE
TnZBczRJSldNRFZFUWZZYW5iKzQyMVFOZC81ZDZIMWlYRitpDQo0TERLME02YWdDK2dzTkZKbmpQ
R0l0dlB0ajdXeWp5blpSeDhENDBQUFhpZ2ZIWXV3Mm9SdTBscitQMXANCjFxZVVlNE5iY3FJdjhJ
SXZMejJ6Q2xZWk9OZ0FzUVZjTkFIaTdaNG9ydFEyaW8yQkFWai84MTlKUFlNdA0KdEhnWTgxd1Mx
Vjd2OEdEVFpnOG9hUGhYR2ZhQzRUWkZHdFpyL2J5YmNxcnNvMzVqYVFtQzU0eE1iWHBGDQpBVXJj
M3VHVk9IK09kRy9CVzJnY1lxcHZVRkJ1a1h4Q1VCWUhQMk5mWGhOZnpHdDluQzF1bE5LWWVQMTkN
ClRHbE9vckJNWUlBRUhvR3h2cGJVWGZiYU5XQ1V6c0JOQkZ2d1NjY0JDQUM5S3lWWlJTNWFNYUc1
UGkwbg0KZng4YU5vczNiWXAyNDZNdGZhb0tCZlRRQXJkK0daVytXbkZ5SkVpU3lMZHowclV1dHlD
QWRmNWxnVkgrDQpXdkx2SW1pR3JTcnpWcE1UMm5DUzA5THFMNTBRano4QTdncDVIL2hRenRaOGlO
eXNHRDlOTzQ2T25JNzUNCjkwZEhmQ3JYalFQU0Z0RkdzVHpnRHhRSWlNdXp6OURSN0Jla0tQbXVP
RkloQmU5ZUVacWJ4YzhSV2VRdA0KaGE3aS9EckpUUk5LMWFPQURRRlZ1VjEvQW01VGhHUFdGTS9Z
SlV5VFloTVcweWVQaDQ1T2JXdVJRWmtzDQpsK2FPbTRMMEtHRERZbG0vRlF4L0VNQ3Vidmx6eS96
eERkQjZucUZpaDJxWnJmeW1uaVNPS2FqRzBqb1QNCnBab3ovRXorNGZBdGc2eTBQc3BOUjZpZEFC
RUJBQUhDd0drRUdBRUlBQk1GQWx2d1NjY0pFRStYblBacg0Ka0xpZEFoc01BQW9KRUUrWG5QWnJr
TGlkUmUwSC9qNUNJRklBdWN1YWlFTWtMa05LRUFPNXM3eDQ3ZU55DQpHUGZac2x5WStIanpHVTBk
MDdNa2tHbVZrUFRWendxVnpOWmJueTdaQXYxemxXMFV5MHlIcDFBUHB5WXQNCjhidVVwcFRCcTdk
NDdvZ3hFUll6dC9MYzJMNWEvVktGTlJiaE4xL1hRbVBpejJFbGU0dHlpcGJUYXBjeQ0KK3pieWZ6
QU1EMTNjSWRaMTNoVHNOUDBvbGdCaEFxVUFVVVlweFJsa0FIZUorRHQzTmJ6SFM0S1FLNTM4DQpO
Si9sN2JYU0tzR3FvWXFKZVo4Vk5CeHdXV1VidUc0ampyaDQzTUlSZ1VaNVdzUFVZVjZIeDA1NmtN
amINCi9iWUJqSTBURU12SDgxNjB1cXpGWGVIdll5VWxxMFNpbkQvWjlpb0llOFFkc0hHQkRVSVJZ
WXViMXBPOA0KcXJDelJaeDBvTkE9DQo9L0RlYQ0KLS0tLS1FTkQgUEdQIFBVQkxJQyBLRVkgQkxP
Q0stLS0tLQ0K

--b1_7SmFLZuypnX9kpJCfi0RhLXsORB60cuCVQkWqxGBb2I
Content-Type: application/pgp-signature; name="publickey - tincantech@...2282... - 0x09BC3D44.asc.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - tincantech@...2282... - 0x09BC3D44.asc.sig"

wsBzBAABCAAGBQJhYxs7ACEJEE+XnPZrkLidFiEECbw9RGejjXJ5xVVVT5ec9muQuJ0ZsAgAviE8
XXk/NSkHsPKl+Z7BlncTUfMH3Zb05SQE8H/ZL6GB2eNX4yr5wK1myQEnRbanBAoYXjmZi4XC2QG0
9P4LYNfS5A55LHEVH7Y2DRK4W9LBqB4fCGYh51EvkQQlWYKGOn/+J3mj4y2ncJsuiQmBqXlt5SvP
Az8tTBL/mfDlT52hiwUV5q4DYgC61QuoS/awRe17UsMpUN0XDoJcv+eA2UEKJMs+MwlPqa5owFH3
670eAE9LIeF0Iq9GlAZ/OsiZVZJxmBLsX5kQQ3dUDVGH4XjYA8925m84fx0UcQ2mSioMvuhsz3Zh
0e4Y6J5xznbPr3qt6rGH/XyGACKhxZWmtQ==

--b1_7SmFLZuypnX9kpJCfi0RhLXsORB60cuCVQkWqxGBb2I--


