Date: Sun, 20 Jun 2021 18:21:13 +0000
From: tincantech <tincantech@...2282...>
Reply-To: tincantech <tincantech@...2282...>
Message-ID: <e4EFnR6rEYdv8hNyXYWLJAY5zIlBwaK6mXNNP8-hc9BCOgAOtpIf-AvTotWukId0BBX7JolJKOuT5iS6nLcQkwWf4_xNqFvqpTxL1hT4FLo=@protonmail.com>
In-Reply-To: <y60d38jRc53qhENFyfitumlM27ROUL_TY-NLACes1Ti3jgo1WNMDUQW24_7sJnB00tKhj3D-hFNBGsAo8YNKHmJiXMb2VqDWGfhPltuup0Q=@protonmail.com>
References: <20210512131511.1309914-1-arne@...1227...>
 <20210512131511.1309914-9-arne@...1227...>
 <y60d38jRc53qhENFyfitumlM27ROUL_TY-NLACes1Ti3jgo1WNMDUQW24_7sJnB00tKhj3D-hFNBGsAo8YNKHmJiXMb2VqDWGfhPltuup0Q=@protonmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1_XyR6mY5H3yWGqJTrl8esmtMobk25PC6bdWQXNsnn3h8"
Subject: Re: [Openvpn-devel] [PATCH 8/9] Document stub-v2 being basically an
 alias for no compression at all
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: tincantech <tincantech@...2282...>
Cc: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.

--b1_XyR6mY5H3yWGqJTrl8esmtMobk25PC6bdWQXNsnn3h8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Ignore me .. this has been applied

Sent with ProtonMail Secure Email.

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90

On Sunday, June 20th, 2021 at 19:09, tincantech via Openvpn-devel <openvpn-=
devel@lists.sourceforge.net> wrote:

> Hi
>
> text corrections.
>
> Sorry about protonmail making '+' to '-'
>
> =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original =
Message =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
>
> On Wednesday, May 12th, 2021 at 14:15, Arne Schwabe arne@...1227... wrote:
>
> > Signed-off-by: Arne Schwabe arne@...1227...
> >
> > doc/man-sections/protocol-options.rst | 5 +++++
> >
> > 1 file changed, 5 insertions(+)
> >
> > diff --git a/doc/man-sections/protocol-options.rst b/doc/man-sections/p=
rotocol-options.rst
> >
> > index 4b6928c68..34d4255ee 100644
> >
> > --- a/doc/man-sections/protocol-options.rst
> >
> > +++ b/doc/man-sections/protocol-options.rst
> >
> > @@ -96,6 +96,11 @@ configured in a compatible way between both the loca=
l and remote side.
> >
> > other variants always add one extra framing byte compared to no
> >
> > compression framing.
> >
> > -   Especially :code:`stub-v2` is essentially identical to no compressi=
on and
> > -   no compression framing as its header indicates IP version 5 in a tu=
n setup
> > -   and can (ab)used to complete disable compression to clients. (See t=
he
> > -   :code:`migrate option below)
> > -   If the `algorithm` parameter is :code:`stub`, :code:`stub-v2` or em=
pty,
>
> Re-write:
>
> The :code:`stub-v2` is essentially identical to no compression and
>
> no compression framing as its header indicates IP version 5 in a tun setup
>
> and can be (ab)used to completely disable compression to clients. (See the
>
> :code:`migrate` option below)
>
> If the `algorithm` parameter is :code:`stub`, :code:`stub-v2` or empty,
>
> >     compression will be turned off, but the packet framing for compress=
ion
> >
> >     will still be enabled, allowing a different setting to be pushed la=
ter.
> >
> >     --
> >
> >     2.31.1
> >
> >
> > Openvpn-devel mailing list
> >
> > Openvpn-devel@lists.sourceforge.net
> >
> > https://lists.sourceforge.net/lists/listinfo/openvpn-devel
-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsBzBAEBCAAGBQJgz4cFACEJEE+XnPZrkLidFiEECbw9RGejjXJ5xVVVT5ec
9muQuJ3SOwgAmIYtimEns1a2LT4CwKUU3lfhXEr2IHvNCZGbTl56p7FYgsVe
L3my1KclB/z6NVPydgBs/FAowSPOnWWoaWuh/+eMo1O8+nfA7+5YhNTL6Hyn
pRKJDJ6trAWXlGQm8N1kzRKUCjrDkPzFKoKsQvXgmjypQeyfwVLL4gJ+XQFk
gsP3gve88tb/q8F5FJfPcuM2NrNsLN0c+f4CKlfb6sr/U7ALp7Rf00hQ71CV
28RSZir15r+aahRmJs6SWng0K5gpN50Ed9PICBYQNmsQSqVAg6f2n1OA3ACQ
C68i58Vv85ElzG2VRymSzWAHdzA/KFM3qaKCnEZyviTkB00rbgWm0g=3D=3D
=3D1Bdk
-----END PGP SIGNATURE-----

--b1_XyR6mY5H3yWGqJTrl8esmtMobk25PC6bdWQXNsnn3h8
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

--b1_XyR6mY5H3yWGqJTrl8esmtMobk25PC6bdWQXNsnn3h8
Content-Type: application/pgp-signature; name="publickey - tincantech@...2282... - 0x09BC3D44.asc.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - tincantech@...2282... - 0x09BC3D44.asc.sig"

sOkDgryUUOk6jEeT4Etv5by5+jjiJxxJcAxTUCmmGDRtuToAdTysPtX/3tEr

--b1_XyR6mY5H3yWGqJTrl8esmtMobk25PC6bdWQXNsnn3h8--


