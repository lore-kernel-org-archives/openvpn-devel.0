Date: Mon, 06 Sep 2021 13:30:53 +0000
From: tincantech <tincantech@...2282...>
Reply-To: tincantech <tincantech@...2282...>
Message-ID: <IMIxe7CrsDvnWYf2D0HHDlk48CK5DNlTWCc3yRwTW8mkBQkL3jK4imdmmxIGQu-sYDMcBbpUtM34-8IG5mKOi4kZWuGqNHMaEH517vmiYjQ=@protonmail.com>
In-Reply-To: <56febc9b-ca20-9b12-1a54-0f1a6c79cf8c@...1227...>
References: <20210904095629.6273-1-a@...2181...>
 <20210904095629.6273-2-a@...2181...>
 <56febc9b-ca20-9b12-1a54-0f1a6c79cf8c@...1227...>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1_w3VinoV80KAds0apTm8KYBccPqeDc5a2e7gO5qVQ"
Subject: Re: [Openvpn-devel] [PATCH 1/7] simplify condition detecting pure
 P2P mode
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.

--b1_w3VinoV80KAds0apTm8KYBccPqeDc5a2e7gO5qVQ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256



Sent with ProtonMail Secure Email.

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90

On Monday, September 6th, 2021 at 14:19, Arne Schwabe <arne@...1227...> wro=
te:

> Am 04.09.21 um 11:56 schrieb Antonio Quartulli:
>
> > The new condition is equivalent to the old one, but easier to grasp.
> >
> > Also add message to inform uset that cipher negotiation, in this case,
> >

uset -> user


> > it indeed disabled.
> >

it -> is

> > Signed-off-by: Arne Schwabe arne@...1227...
> >
> > Signed-off-by: Antonio Quartulli a@...2181...
> > -----------------------------------------------------------------------=
---------------------
> >
> > src/openvpn/options.c | 6 +++++-
> >
> > 1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> >
> > index 00ba6044..0d6b85cf 100644
> >
> > --- a/src/openvpn/options.c
> >
> > +++ b/src/openvpn/options.c
> >
> > @@ -3076,8 +3076,12 @@ options_postprocess_verify(const struct options =
*o)
> >
> > static void
> >
> > options_postprocess_cipher(struct options *o)
> >
> > {
> >
> > -   if (!o->pull && !(o->mode =3D=3D MODE_SERVER))
> >
> > -   if (!o->tls_server && !o->tls_client)
> >
> >     {
> > -          /* we are in the classic P2P mode */
> >
> >
> > -          msg(M_WARN, "Cipher negotiation is disabled since TLS "
> >
> >
> > -                      "mode is not enabled");
> >
> >
> > -          /* If the cipher is not set, use the old default of BF-CBC. =
We will
> >             * warn that this is deprecated on cipher initialisation, no=
 need
> >             * to warn here as well */
> >
> >
>
> Yes. Makes sense. The change makes it is a lot more clear. I think it is
>
> actually not equivalent but the new one is definitively the correct one.
>
> Acked-By: Arne Schwabe arne@...1227...
>
> Arne
>
> Openvpn-devel mailing list
>
> Openvpn-devel@lists.sourceforge.net
>
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsBzBAEBCAAGBQJhNhflACEJEE+XnPZrkLidFiEECbw9RGejjXJ5xVVVT5ec
9muQuJ2H0wgAup4i4ArQzzTGnSsFtHYAjzeKiwIPemMiOw76gv64TqI7dRST
6SsSkpS4Xs10HQysdYzyoCW4Pju2u1zEn654UeonDa43HPYtrL0V3NDmtRYT
3+aJOtqkE74MAZXpMxh1zo1KVkP+UMtpJmFVngK9IvMnSMjBnEj/1np2aZeE
KJSRKpskDgBXC5ISzo6JB3T48zbbl1+4zq8TOKrr9uvyXluw5Cme+YGL1yC5
l0ApubT29ANQMOIwBMwGaHm49sRZtkFod/hO630NNcjD/veksS2eyT0fo7oY
P38ZVT0rbQWO06D1/0D4PGlXeukYHa0aVRqCR+nWm01dqa22gedDzg=3D=3D
=3DS+qj
-----END PGP SIGNATURE-----

--b1_w3VinoV80KAds0apTm8KYBccPqeDc5a2e7gO5qVQ
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

--b1_w3VinoV80KAds0apTm8KYBccPqeDc5a2e7gO5qVQ
Content-Type: application/pgp-signature; name="publickey - tincantech@...2282... - 0x09BC3D44.asc.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - tincantech@...2282... - 0x09BC3D44.asc.sig"

wsBzBAABCAAGBQJhNhflACEJEE+XnPZrkLidFiEECbw9RGejjXJ5xVVVT5ec9muQuJ3tAQgAgjJR
q7fQa5Ubq/M/Cju4P+jL3ZHCkPxJqhNVYVAc6VtM3qu99zGMzhDKlGS0BPPVKnBlCFKWfeahChTQ
bxxnN+RJVlXZC3IjiA+ghq/9fisweuSSuesIh7AHjNP0TZBLSwvBQXEKnX2zjdIhtVRpzgTSNGKq
PjBWpaPNjMmnJKxg+E7g7dClFjw14JtFAT+EnhdBdgCqKnGiZoPFs+MPbBrOkcGo+p/HDXQlm/M5
kTz63K0JjEyEudYWSk62Mzs61dxWw7qBGba4iBGYvSt4YDlwguSKZSPwx3IM9tXjYr9tqPxGjXL1
z0CZ4DBGSAOlIXGkirf+kNLIG5VDqVJyzA==

--b1_w3VinoV80KAds0apTm8KYBccPqeDc5a2e7gO5qVQ--


