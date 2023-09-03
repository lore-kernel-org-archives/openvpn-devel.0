Date: Sun, 3 Sep 2023 21:22:15 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <ZPTc50Xjm8Eqmger@...1296...>
References: <20230903142947.20906-1-orbea@...2744...>
 <c0ecc754-7dda-313f-8cd2-047ebd1ae8cd@...2181...>
 <20230903091721.4a810beb@...2745...> <20230903095545.0f6d9d03@...2745...>
 <5e877862-457b-7241-f9fd-086adb9fe518@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="KVGsDFJPQgBDZM1H"
Content-Disposition: inline
In-Reply-To: <5e877862-457b-7241-f9fd-086adb9fe518@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] configure: disable engines if
 OPENSSL_NO_ENGINE is defined
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: orbea <orbea@...2744...>, openvpn-devel@lists.sourceforge.net

--KVGsDFJPQgBDZM1H
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Sep 03, 2023 at 08:15:05PM +0200, Antonio Quartulli wrote:
> On 03/09/2023 18:55, orbea wrote:
> > Here is a patch that preserves the version check and adds a second
> > check for OPENSSL_NO_ENGINE which seems to also be useful for BoringSSL.
>=20
> I prefer this version, but I'll let other chime in.
> On top of that I think we may need a proper v2 PATCH having no extra body,
> as I am not sure your message can be properly parsed by git-am.

It should be fine, and if not, I'll massage it to make it go in.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--KVGsDFJPQgBDZM1H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJk9NznAAoJEB2Cnv7KVigSwAoL/AlJ/6hUUBrMs5AkoRSzYV4G
qQrXUmeeXQOcaSksE6JTb/WdLZGvJAdWUPl9Je/svWsvYFXcL8IBw8sIyHhK9UYg
w9TDAQX679WH/8cxUX7JthuN0LPe4EQbiLSV71K5s69ikI4ETFgj7rpITunf78F4
3PiU/c+tdNFIfNuDuUwy7+LWYE6peH5V8sVfPwsyBDBgr9h6BbDm2XKuOydVk7bo
OLA7L/xWw/SbsQDSgWaJDWjBPmlhJOE8XuIIvYJ0vR+ap5ZiEzM9cBdpfP76pc0l
wlHmiDxhNximKgpX5ZdzL5OUEVC/BKk47BC/J5I4wVbNK5DlEDlGHNbs54iGh12X
BHDHcn92OF7zJ30mRkUoFcAdWCcsu1IlWg3Jfc/cQao6+JJbzJZYgnQ1YrRbbzaI
g2LhkOC451GhcX5DSePLvO8Pn8LjLBUboXIow/r3AFdP9Qhsc4qXj7N2tqC2K6aX
4v7QjVogOSla6BJWWw01Hoi2Il5zUeN7juXz5HNiPg==
=sPT5
-----END PGP SIGNATURE-----

--KVGsDFJPQgBDZM1H--

