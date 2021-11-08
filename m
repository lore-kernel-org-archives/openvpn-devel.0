Date: Mon, 08 Nov 2021 13:55:16 +0000
From: tincantech <tincantech@...2282...>
Reply-To: tincantech <tincantech@...2282...>
Message-ID: <BS4eTg3RZbZyNgr5frLf1vH4lANrI_RGq-Seh7ZL9zQ-m3r2pRJqdqH_d4uZOerVzLe3SATl9FkutGwK3D-FJsIFY4yXIZEONIB5UzKlN68=@protonmail.com>
In-Reply-To: <183961674.290978.1636374227246@...2642...>
References: <20211107174000.16210-1-frank@...2641...>
 <9bf5fef1-e2e5-4612-5f52-b083e45b2f74@...1227...>
 <183961674.290978.1636374227246@...2642...>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1_eVdy8spJyVKfVYn0dig2cO53d0bnonvExrkVTki8gA"
Subject: Re: [Openvpn-devel] [PATCH] Fix error in example firewall.sh script
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Frank Lichtenheld <frank@...2641...>
Cc: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net, Adrian <adrian.crespo@...2282...>

This is a multi-part message in MIME format.

--b1_eVdy8spJyVKfVYn0dig2cO53d0bnonvExrkVTki8gA
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi

Sent with ProtonMail Secure Email.

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90

On Monday, November 8th, 2021 at 12:23, Frank Lichtenheld <frank@...2641...=
> wrote:

> > Arne Schwabe arne@...1227... hat am 08.11.2021 12:36 geschrieben:
> >
> > Am 07.11.21 um 18:40 schrieb Frank Lichtenheld:
> >
> > > From: Adrian adrian.crespo@...2282...
> > >
> > > The man page says:
> > >
> > > [!] -s, --source address[/mask][,...]
> > >
> > > Signed-off-by: Frank Lichtenheld frank@...2641...
> > > ------------------------------------------------------
> > >
> > > sample/sample-config-files/firewall.sh | 2 +-
> > >
> > > 1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > As part of an initative to clean up the Github PR submissions, submit=
ting
> > >
> > > this patch to the mailing list for inclusion. Looks obviously correct=
 to
> > >
> > > me.
> > >
> > > diff --git a/sample/sample-config-files/firewall.sh b/sample/sample-c=
onfig-files/firewall.sh
> > >
> > > index 19d75ee9..456700ca 100755
> > >
> > > --- a/sample/sample-config-files/firewall.sh
> > >
> > > +++ b/sample/sample-config-files/firewall.sh
> > >
> > > @@ -50,7 +50,7 @@ iptables -A OUTPUT -p tcp --sport 137:139 -o eth0 -=
j DROP
> > >
> > > iptables -A OUTPUT -p udp --sport 137:139 -o eth0 -j DROP
> > >
> > > Check source address validity on packets going out to internet
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > -iptables -A FORWARD -s ! $PRIVATE -i eth1 -j DROP
> > >
> > > +iptables -A FORWARD ! -s $PRIVATE -i eth1 -j DROP
> > >
> > > Allow local loopback
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > iptables -A INPUT -s $LOOP -j ACCEPT
> >
> > I have a vague idea that this is actually different. Like one is that
> >
> > condition is not fulfilled and the other is that it is not part of the
> >
> > subnet if is different when there is different protocol but I might
> >
> > misremember.
>
> Certainly does not work with my iptables:
>
> iptables -A OUTPUT -s ! 10.0.0.0/8 -j ACCEPT
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Bad argument `10.0.0.0/8' Try` iptables -h' or 'iptables --help' for more=
 information.
>
> iptables -A OUTPUT ! -s 10.0.0.0/8 -j ACCEPT
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>

From: https://ipset.netfilter.org/iptables.man.html

[!] -s, --source address[/mask][,...]
    Source specification. Address can be either a network name, a hostname,=
 a network IP address (with /mask), or a plain IP address. Hostnames will b=
e resolved once only, before the rule is submitted to the kernel. Please no=
te that specifying any name to be resolved with a remote query such as DNS =
is a really bad idea. The mask can be either an ipv4 network mask (for ipta=
bles) or a plain number, specifying the number of 1's at the left side of t=
he network mask. Thus, an iptables mask of 24 is equivalent to 255.255.255.=
0. A "!" argument before the address specification inverts the sense of the=
 address. The flag --src is an alias for this option. Multiple addresses ca=
n be specified, but this will expand to multiple rules (when adding with -A=
), or will cause multiple rules to be deleted (with -D).

R
-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsBzBAEBCAAGBQJhiSw2ACEJEE+XnPZrkLidFiEECbw9RGejjXJ5xVVVT5ec
9muQuJ1jZAf/b2mzU/9kXQIIvNAhICrkyDc68AnyR5GRlMItdo91prqcH/bn
ksBxh5OolZeq7Md7K6O63DZgL3Kdj0HpUGavPonVgIrBXj1QoQW69KiEp9/A
98UixypgCCi3yy4wii510Wn9F8ZFmfQBk9l/ilRB5tT+oU6/KyvaZmwz2kRQ
pkmcvXWI40LEvjMXA1Ye5Usn7a1yf5lP2YbJyvhE8mG64mZo6/2fePyTuASd
EhCzxoQ1QIUy/jHL6FCHac6Gt2lx5JH73CI9lKzczvfZmq4Y7a3I5+rjpP2w
Gx4YdA/PkRK5QJtn/KHppCZx4FdYBSvW2Aqq+fSrhzPam//qXQLt6g=3D=3D
=3D8IIR
-----END PGP SIGNATURE-----

--b1_eVdy8spJyVKfVYn0dig2cO53d0bnonvExrkVTki8gA
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

--b1_eVdy8spJyVKfVYn0dig2cO53d0bnonvExrkVTki8gA
Content-Type: application/pgp-signature; name="publickey - tincantech@...2282... - 0x09BC3D44.asc.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - tincantech@...2282... - 0x09BC3D44.asc.sig"

wsBzBAABCAAGBQJhiSw2ACEJEE+XnPZrkLidFiEECbw9RGejjXJ5xVVVT5ec9muQuJ0vQgf/erkS
4KQGZDML1yVXa4u+b/CLQyFSX1AlkjqyNbRafX0d16UK3ER3bNNRMnZoY67suy6qHovGZGJ2ryjG
LrmFeBEEBGGtuI5OBPhIUVe9QV4Scaf9yztJeP/Uiia8hx9PXJbMuU9WhIrmrKw9XLWJ5WuGO32o
G0KnJ2+3f1ygyMq0pnaNmT2oqsthYxaTHJrW/Fyt0yJziJchETK9ZFCMRYBEf59AiDyggGeaEa0x
nC+95mT+coBJdE0pCvkGrlyPbzoQ5kDVOmeApYp9VwIJyaGn+BRB65UBelEGTlUtTtLoQcDMEuFy
0bPkUojA/XAbj6eS/llChzu/SzaJih7tCw==

--b1_eVdy8spJyVKfVYn0dig2cO53d0bnonvExrkVTki8gA--


