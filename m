Date: Thu, 16 Sep 2021 20:55:19 +0000
From: tincantech <tincantech@...2282...>
Reply-To: tincantech <tincantech@...2282...>
Message-ID: <K5hJyzENRjdMczbO04Quu9ExgvDLpLXIzuQ_gPwejW8P733VCuZLEPP3F5qk8kkPQJrwDxWTnQrbZSsm76-xovHpEjlKK_aERLpJ-nRzWpY=@protonmail.com>
In-Reply-To: <20210916164641.867248-1-tincantech@...2282...>
References: <20210916164641.867248-1-tincantech@...2282...>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1_GJHnnPdKHhAojrh2B6q9lglY9G04z8gMHruof5cjuY"
Subject: Re: [Openvpn-devel] [PATCH] Correct --client-disconnect environment
 variable common_name
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

--b1_GJHnnPdKHhAojrh2B6q9lglY9G04z8gMHruof5cjuY
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

The commit message is incorrect.

Not *always* but "after a renegotiation" then *always*

I'll resubmit again after some final testing.

R

Sent with ProtonMail Secure Email.

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90

On Thursday, September 16th, 2021 at 17:46, <stringvest88@...277...> wrote:

> From: Richard T Bonhomme tincantech@...2282...
>
> --client-disconnect is always passed the X509 certificate common_name,
>
> which is incorrect when --username-as-common-name is used.
>
> Set the environment variable common_name to the correct value, prior to
>
> calling --client-disconnect.
>
> Resolves https://community.openvpn.net/openvpn/ticket/160
>
> Signed-off-by: Richard T Bonhomme tincantech@...2282...
>
> src/openvpn/multi.c | 3 +++
>
> 1 file changed, 3 insertions(+)
>
> diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
>
> index 22357cfb..18ee5e52 100644
>
> --- a/src/openvpn/multi.c
>
> +++ b/src/openvpn/multi.c
>
> @@ -557,6 +557,9 @@ setenv_stats(struct context *c)
>
> static void
>
> multi_client_disconnect_setenv(struct multi_instance *mi)
>
> {
>
> -   /* setenv client current common-name */
>
> -   setenv_str(mi->context.c2.es, "common_name", tls_common_name(mi->cont=
ext.c2.tls_multi, true));
>
> -   /* setenv client real IP address */
>
>     setenv_trusted(mi->context.c2.es, get_link_socket_info(&mi->context));
>
>
> 2.25.1
-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsBzBAEBCAAGBQJhQ68bACEJEE+XnPZrkLidFiEECbw9RGejjXJ5xVVVT5ec
9muQuJ3Mogf+OX2Aj37g3VmepoBmyefgwHdxf6kf5Bfogns3GvEwcL459ciZ
OfDlWF1L7TyUX4ddSlApcbMCCb3r2iuLwgf4/LHc1RgybONaNCXk1lRqhQW4
eer6XYSGSjtdirdqCic3VGE0Zb61dtjEUzBFIGPsnZMD4bioXSwZ/aZ9ol/9
+zBZlkN4Pbk+I25D3AIXMCiZf3rl++BLlVYy/MND8VpiQi6wCj9K5r/YB2CI
AY1c+V7KjaUhSD6rwpchz9bQnYSTwvwOlv+3gggGXiiExy8HCieXLNybPJYq
3DhM3PPUt9zYgoOdD5BUUCArpU1DX1yt9FlD6Nl3Tjm1z2ST5TefnQ=3D=3D
=3DOGdj
-----END PGP SIGNATURE-----

--b1_GJHnnPdKHhAojrh2B6q9lglY9G04z8gMHruof5cjuY
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

--b1_GJHnnPdKHhAojrh2B6q9lglY9G04z8gMHruof5cjuY
Content-Type: application/pgp-signature; name="publickey - tincantech@...2282... - 0x09BC3D44.asc.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - tincantech@...2282... - 0x09BC3D44.asc.sig"

wsBzBAABCAAGBQJhQ68bACEJEE+XnPZrkLidFiEECbw9RGejjXJ5xVVVT5ec9muQuJ0zSwf/TqIc
dKGCzLKImV+5m4fEepKSyIcv11Gay2sjMp3OMWNOYHNW9qhJ+oEDmFcY03e35QbT00+FIVXhDfaC
VnX1e+VGBGyQoExJpaZ7Jp/DKtqEYD+BUJo+icMxMuNfiXi5mTK42izeAGmcBYECxW9ByLMMyJmU
CBl/TeIrZJmXi3sGh2AsB3/j9FBy3GyuEkhLaNLiHD2DDZp9hpdL8XZzNq6DUyv+xp+Dgmvczoja
2hcU4wtTqyrIrRotQRncO0Ntrtgsfi2wEpp0nIfQXh0mhwWKEPqgPPCNTXt+joIoBxNXjQfiG6qM
U3whuVGQrT1KxROwCCLkwce79BHxnYnRxA==

--b1_GJHnnPdKHhAojrh2B6q9lglY9G04z8gMHruof5cjuY--


