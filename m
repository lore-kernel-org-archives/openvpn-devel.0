Date: Fri, 10 May 2019 15:27:09 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20190510132709.GO31008@...1296...>
References: <E1hON0G-0007yB-3H@...2508...>
 <201905101303.x4AD3j6e081933@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="B2GzrzFQbYDXIsTK"
Content-Disposition: inline
In-Reply-To: <201905101303.x4AD3j6e081933@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: tests: remove dependency on
 base64
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

--B2GzrzFQbYDXIsTK
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

just for the record, so the archives know we're aware of it - "something"
is mishandling message-IDs - the mail I received from Steffan contains
the same patch that patchwork has [1] and that is visible on=20
mail-archive.org [2], but has subtly different message-ids

   E1hON0G-0007yB-3H@
   E1hON0G-0007yB-2h@
   E1hON0G-0007yB-1d@

[1] https://patchwork.openvpn.net/patch/728/
[2] https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg184=
31.html

so both my threading and the URL referenced in the commit are not
right.

The patch itself has not been mistreated.

gert


On Fri, May 10, 2019 at 03:03:45PM +0200, Gert Doering wrote:
> Acked-by: Gert Doering <gert@...1296...>
>=20
> "Does what it says, and succeeds on FreeBSD 10+11" (and should succeed
> everywhere that has a halfway posix compliant shell).  As a side note,
> "dd if=3D$0 bs=3D732 count=3D1" should also work on all unix plattforms a=
nd is=20
> *much* more efficient :-) (but then, we have more important work than
> making a developer test perfectly efficient).
>=20
> Your patch has been applied to the master branch.
>=20
> commit 90c61ef3df7255637cf84b6a23e51742954acde8
> Author: Steffan Karger
> Date:   Wed May 8 15:52:20 2019 +0200
>=20
>      tests: remove dependency on base64
>=20
>      Signed-off-by: Steffan Karger <steffan.karger@...1435...>
>      Acked-by: Gert Doering <gert@...1296...>
>      Message-Id: <E1hON0G-0007yB-3H@...2508...>
>      URL: https://www.mail-archive.com/search?l=3Dmid&q=3DE1hON0G-0007yB-=
3H@...2508...
>      Signed-off-by: Gert Doering <gert@...1296...>
>=20
>=20
> --
> kind regards,
>=20
> Gert Doering
>=20
>=20
>=20
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--B2GzrzFQbYDXIsTK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJc1XwsAAoJEB2Cnv7KVigSBJAL/0phY6kIVKGDz3HvWigt0Y23
9m0MfOHp5JN723pX/p/CKWXUNa7kbDPyOOQCSFacvWoxR0oGupycAMblzLh61qDA
NBj6OcOexR5nZkdxq8p1aR63RxHQ0pSuOa3pSm5ibrAcCTcZv9SUUUZxMTemtmel
PhZd3ajBoGil/GXvF6H4++UIW7tqi4FUe9Abyv/QMTF7uSEeVjY+IumoTE6WMJmI
AES6m4UvfiDbgJiLUI69oxPbY13Z6Ug8PlZ3f0wN65Vyj+7dX4/8zt7y6Czx0H/6
BZ8w+kcoqDBGbJlA17cg46H0Z92YoK5jhwUvvQrun/9FOJSdCy8TW97M4QH4LOW2
i1yGaE5fOppjLpSRkVTtOE2eQiSRsN8ESMpmGQ9WMHo/eHIeWfkMnxUvLWdJYhIF
piuQlo9eKwykya7Q0Wtw4HZGz/+/WmfMwgtPAyCzbQ7iJSK4kHbd5Uh3wBSNDZ1J
63eT6yAqGqkgLK+lrclEQ+71LAXLzK4NOM9bnbR1yA==
=8bJR
-----END PGP SIGNATURE-----

--B2GzrzFQbYDXIsTK--

