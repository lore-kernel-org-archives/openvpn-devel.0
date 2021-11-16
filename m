Date: Tue, 16 Nov 2021 15:12:28 +0000
From: tincantech <tincantech@...2282...>
Reply-To: tincantech <tincantech@...2282...>
Message-ID: <D2OPKuSUx8FowpmPNE6tX10p_oYhcZpuyMtQVtttGR4qnhbXi5e0ILrN8mcABaP-lKAgcgx1hnY30GfUZoEN-hEMDuPS9NQs0ccE5MAh9GQ=@protonmail.com>
In-Reply-To: <20211116144907.630587-1-tincantech@...2282...>
References: <20211116144907.630587-1-tincantech@...2282...>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1_hNRLBJcsLSBBJDb3n7Jq95XZuH3t7LZkQvXFsLh2I"
Subject: Re: [Openvpn-devel] [PATCH] Log message: Replace NCP ciphers with
 --data-ciphers (NFC)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Richard T Bonhomme <stringvest88@...277...>
Cc: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.

--b1_hNRLBJcsLSBBJDb3n7Jq95XZuH3t7LZkQvXFsLh2I
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Superseded - Due to incorrect option name.

Sent with ProtonMail Secure Email.

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90

On Tuesday, November 16th, 2021 at 14:49, Richard T Bonhomme <stringvest88@=
...277...> wrote:

> Signed-off-by: Richard T Bonhomme tincantech@...2282...
>
> src/openvpn/options.c | 2 +-
>
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
>
> index 4a5db8a6..7822f21e 100644
>
> --- a/src/openvpn/options.c
>
> +++ b/src/openvpn/options.c
>
> @@ -3240,7 +3240,7 @@ options_postprocess_mutate(struct options *o)
>
> o->ncp_ciphers =3D mutate_ncp_cipher_list(o->ncp_ciphers, &o->gc);
>
>      if (o->ncp_ciphers =3D=3D NULL)
>
>      {
>
>
> -          msg(M_USAGE, "NCP cipher list contains unsupported ciphers or =
is too long.");
>
>
>
> -          msg(M_USAGE, "--data-cipher list contains unsupported ciphers =
or is too long.");
>
>
>     }
>
>     if (o->remote_list && !o->connection_list)
>
> --
>
> 2.25.1
-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsBzBAEBCAAGBQJhk8pGACEJEE+XnPZrkLidFiEECbw9RGejjXJ5xVVVT5ec
9muQuJ1YMAgAjo7FUlGvpm1DwEN/EzLTQegAuD9yyclb+C/x++DzdQPc1/FK
3xt/xT2wH159v/bDXtFu3FSOuQxRIwyiDpJUSX1bhIGqyq2jkXVCbTdQtLUV
xrdOmM+fLN810BGHiUIrhsx4R+eSyEdFUnvw7o0xuOl+2RfQ5ZOQXmm9M1nO
UbhGbRdmPTxEsq4toaMu4blwszg1zdcj0CviKULOARytPdHh4YcvmmNhtEmg
cqBXarbERdI3XUtm8UbVxPBHm7DGqf8dxZFa94JVCwbN4zR7YTqURnXuFgah
bA7M0BvXslxJqlfVZ5cvXXaMLpDwFjGZiLtPQFB5IKks6MMUzXrjFA=3D=3D
=3D4Uqz
-----END PGP SIGNATURE-----

--b1_hNRLBJcsLSBBJDb3n7Jq95XZuH3t7LZkQvXFsLh2I
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

--b1_hNRLBJcsLSBBJDb3n7Jq95XZuH3t7LZkQvXFsLh2I
Content-Type: application/pgp-signature; name="publickey - tincantech@...2282... - 0x09BC3D44.asc.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - tincantech@...2282... - 0x09BC3D44.asc.sig"

wsBzBAABCAAGBQJhk8pGACEJEE+XnPZrkLidFiEECbw9RGejjXJ5xVVVT5ec9muQuJ2ALgf/YZTL
qi2qKJ99Ku+Q8sOrces+wZ7+/csslvBeQl1P/UefHNolQtPelvbh1A0Fk2s9BZdxzKJfzHVDtxRO
V91+fF3EmHzCW+E7+KSj/j9uk/DqX8Qr5mexS8B77wbsnAfa64w3RlNCJLe8I9Gu/7ILXvXWOr8V
g61e93Ng69ssq3ClAdDTWhRqd998fF+NsmQDlrt+dxcHhE0ze+l0VGLWiyZ3WaKegu3lrkIWj9j3
bVyo53KV3KgGQ9uTXurM9w9mybu47NLgarjcSQ+r89OPUlcZEWEIRVb4rFaCo7TFSeHMkIIWCxxD
uH5txnIZZHhxFwCdf21eT06U9Noy9qayUQ==

--b1_hNRLBJcsLSBBJDb3n7Jq95XZuH3t7LZkQvXFsLh2I--


