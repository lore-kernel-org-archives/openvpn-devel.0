Date: Sun, 28 Nov 2021 01:27:19 +0000
From: tincantech <tincantech@...2282...>
Reply-To: tincantech <tincantech@...2282...>
Message-ID: <PTmXO82Q-_rcWHwAf9qRzYJBP4Gubkn4GtLH5jQyCurIXuzPr36lH5ilDCw-k3KsQvpPpGNL5n050jETtm3iNUoWxwGC9MaY-6ok9X3OK4s=@protonmail.com>
In-Reply-To: <d2c11a34-bb5a-34f5-76a4-cc4be325d17b@...2181...>
References: <20211126144331.2400062-1-tincantech@...2282...>
 <d2c11a34-bb5a-34f5-76a4-cc4be325d17b@...2181...>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1_SNiJUsca2g4ieDkuYnbjhFzHDrHjrBgCHaG7mGzGeU"
Subject: Re: [Openvpn-devel] [PATCH] Doc openvpn.8: Add deprecation notice
 to --compress
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: Richard T Bonhomme <stringvest88@...277...>, openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.

--b1_SNiJUsca2g4ieDkuYnbjhFzHDrHjrBgCHaG7mGzGeU
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Seems I jumped the gun a little..

NACK, --compress is not deprecated in 2.4

Sorry
R


Sent with ProtonMail Secure Email.

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90

On Friday, November 26th, 2021 at 14:48, Antonio Quartulli <a@...2181...> w=
rote:

> Hi,
>
> On 26/11/2021 15:43, Richard T Bonhomme wrote:
>
> > Signed-off-by: Richard T Bonhomme tincantech@...2282...
> > -----------------------------------------------------------
> >
> > doc/openvpn.8 | 1 +
> >
> > 1 file changed, 1 insertion(+)
> >
> > diff --git a/doc/openvpn.8 b/doc/openvpn.8
> >
> > index 598d5fce..dfe0ad10 100644
> >
> > --- a/doc/openvpn.8
> >
> > +++ b/doc/openvpn.8
> >
> > @@ -2501,6 +2501,7 @@ limit repetitive logging of similar message types.
> >
> > .\"*********************************************************
> >
> > .TP
> >
> > .B \-\-compress [algorithm]
> >
> > +.B DEPRECATED
> >
> > Enable a compression algorithm.
> >
> > The
>
> We already have this. Against what branch did you create this patch?
>
> Cheers,
>
> -------------------------------------------------------------------------=
-------
>
> Antonio Quartulli
>
> Openvpn-devel mailing list
>
> Openvpn-devel@lists.sourceforge.net
>
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsBzBAEBCAAGBQJhotroACEJEE+XnPZrkLidFiEECbw9RGejjXJ5xVVVT5ec
9muQuJ1VPgf+O45rGSxFsovrhOa2OQ3r9DFCiG8Wsc51hs24jqH8CJd7fiaI
Bqy3ZIJsxi/PQocn2JCqE0odfFSiHOQVLpGEkCS2dSnbOG7wrA+LKqWbuTMu
xnly3U0a1ekMwunKbXxE6tGgQXrS0aBPkcx5oNWyxvFGNruYoDUwHkOex2zh
mUvjQS1F/TWxwBaXm/2awzBOLghIqUNE+l+Fm5eAN+025jUP9g3TUVlxBF6S
j6FOjIEXukN75t/K01g2ME/P4RJgvjNcRLw2kQewD8ajtGJhweRQKyaFQOJY
xSKE3ePA7wWoTVX0xpY41Gruin3usMXwL6XeU3/WyX6CLZY5nQIQ4g=3D=3D
=3DnFcI
-----END PGP SIGNATURE-----

--b1_SNiJUsca2g4ieDkuYnbjhFzHDrHjrBgCHaG7mGzGeU
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

--b1_SNiJUsca2g4ieDkuYnbjhFzHDrHjrBgCHaG7mGzGeU
Content-Type: application/pgp-signature; name="publickey - tincantech@...2282... - 0x09BC3D44.asc.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - tincantech@...2282... - 0x09BC3D44.asc.sig"

wsBzBAABCAAGBQJhotroACEJEE+XnPZrkLidFiEECbw9RGejjXJ5xVVVT5ec9muQuJ27ygf/WQ36
G4HzmTqYvXAeGV2sGWPrtnpJVJC0KHg2shIQlV85phtN+L07v5HgVJ6SYgjoojd32AB5jU0AXx+D
XLgy7lhTQyFvxSgDE1+2rfnCmk1cZ+QYeqjkahf7CcNl0A2zQzKzmRu6H7ljUSWLXfWihChKXA4S
c02wMTv5FcSDgzhyBNVIukj2UB80sD1G3ITH3nz/LrSyZI67zQEAD5iHMqIPICtKIB8dFBHWilGB
Xkvpy1n0LlwGOdrft06oDh+5Kc94wyib5VQtfLnk6dKOmScYto60lixRmb46kc04lMH44b2RhQXr
PELjRzQdz2a+r2pblBXgerH9HSo3pj4MyQ==

--b1_SNiJUsca2g4ieDkuYnbjhFzHDrHjrBgCHaG7mGzGeU--


