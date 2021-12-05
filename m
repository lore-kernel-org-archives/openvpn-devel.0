Date: Sun, 5 Dec 2021 19:08:15 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Ya0AD9CDm7Z2dSCw@...1296...>
References: <20211202125455.2593763-1-arne@...1227...>
 <2116536034.296245.1638548339523@...2642...>
 <eeacddfd-0819-0afb-4767-0dcc011f8c11@...1227...>
 <YaySTbKDclfC6PWL@...1296...>
 <1302542561.460963.1638703016633@...2642...>
 <YaylGFdqxlCPwJNc@...1296...>
 <c1bceec7-187e-4ed4-ba89-b368d7d0f05a@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="oAWtGbot3ZGu7hWv"
Content-Disposition: inline
In-Reply-To: <c1bceec7-187e-4ed4-ba89-b368d7d0f05a@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Make --nobind default for --pull
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--oAWtGbot3ZGu7hWv
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Dec 05, 2021 at 07:04:01PM +0100, Arne Schwabe wrote:
> The original code checks for socks. That is not changed.=A0 The orignal=20
> code basically has two ifs that checks for the code that is !bind_need=20
> and the particular condition (socks or tcp-client)

You're right.  As I said, that mass if conditions, half of them
negated, exceeded my coffee level...

> > for my coffee level ("if (!bind_needed && conditions) set bind_local=3D=
false",
> > what are these conditions?  why?)
>=20
> I can add more comments to the code. bind_needed is basically if the=20
> options have a condition that forces binding anyway.

I think that would be good.

thanks :)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--oAWtGbot3ZGu7hWv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJhrQAPAAoJEB2Cnv7KVigSr4EL/R8h0w6QznMt2ETQxZF0nDyZ
Nm+LB3z7TO9MbM6mmHdRKjFHU5X36UlWWB2Ybb9GlZ+/zdFFD44zKOto0bELknee
6d1IkgRqdvf5QF73yPNxggNYCM3HpOkacWZywZTLZ2M4RliBEp2XAd4HRn76vbD8
BGMkkxb+7blQminWkiValkBEFWGqN4ry21iltCasN24tsLEp4jhmgACudrKC0Vhw
3yR54qbZxAe8NtUql5/Fvmx+CiTJIkXpm9fjrIoamZr2zzgC2HR1WdILIHtr7jCK
HhyR6sTUb4njEwdOL8fT9EMhfPxp6Gorpa+OJIeiNPylSYAJU5KnIz/4Tswr0H1I
zrMKAZFHSDHbRicYaYz4UFtbYdboHHIrZume7Q66bw9+yAGemcXqJBb7RqmzAv+L
mvyNt2oE/yuRviyJ9g9Wzq/CQCAjOSjaBpg3ujQlQgu7NpMdZQ6/jUIgvqw1ZFfh
4maGq7HCXqjiTTzaD8M8lUpfPw7iyI9ojqTuAeFiYA==
=FIuT
-----END PGP SIGNATURE-----

--oAWtGbot3ZGu7hWv--

