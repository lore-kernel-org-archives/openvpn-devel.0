Date: Wed, 18 Jul 2018 22:48:10 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180718204810.GO55859@...1296...>
References: <20180715190508.64874-1-gert@...1296...>
 <20180715204331.65442-1-gert@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Pjk796cY0SfIo9Z2"
Content-Disposition: inline
In-Reply-To: <20180715204331.65442-1-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH v2] Fix typo in IPv6 address in comment.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--Pjk796cY0SfIo9Z2
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

should have tagged this better - quite obviously this is for tap-windows6,
and since nobody complained about fixing bugs in comments, I've applied
lazy ACK rules, merge & and pushed it.

commit c8bea201a8975e247cfc910131f6539f5add9277

(tap-windows6 has a slightly weird process with "development taking place
in github PRs or not at all", so the whole openvpn-devel bit is actually
the exception here)

gert


On Sun, Jul 15, 2018 at 10:43:31PM +0200, Gert Doering wrote:
> Comment talks about ff02::1::ff00:8, correct address is ff02::1:ff00:8,
> and about fe80::1 where fe80::8 is the proper magic number.
>=20
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>  src/txpath.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/src/txpath.c b/src/txpath.c
> index 97b9862..5b61177 100644
> --- a/src/txpath.c
> +++ b/src/txpath.c
> @@ -108,8 +108,8 @@ HandleIPv6NeighborDiscovery(
>      // - it's either a multicast MAC, or the userland destination MAC
>      // but since the TAP driver is point-to-point, all packets are "for =
us"
>=20=20
> -    // IPv6 target address must be ff02::1::ff00:8 (multicast for
> -    // initial NS) or fe80::1 (unicast for recurrent NUD)
> +    // IPv6 target address must be ff02::1:ff00:8 (multicast for
> +    // initial NS) or fe80::8 (unicast for recurrent NUD)
>      if ( memcmp( ipv6->daddr, IPV6_NS_TARGET_MCAST,
>          sizeof(IPV6ADDR) ) !=3D 0 &&
>          memcmp( ipv6->daddr, IPV6_NS_TARGET_UNICAST,
> --=20
> 2.18.0
>=20
>=20
> -------------------------------------------------------------------------=
-----
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
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

--Pjk796cY0SfIo9Z2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJbT6eJAAoJEB2Cnv7KVigSgdIL/AkCiVYAOMr5K3oYw0crHlT2
BhGijUCMCVn8Kr9IgSF1AoPaLS6dfkRsZw5fnjOZlyag9sTss2YBc6UjZAhlC28X
fHKq1Dt8WZDfBe3dQAhqtGmK2wzRwicM5QG/FRLH7c2tGgTL9/3S1ik7ROSf7ium
yBj2hJu+tHHaLHeftA9mgVFMrZ2zokTUV/zU357c9jy6yjIiQtJu9+giYTBV0H1/
4zA4+W06nVoxjon79FxMnog6MZx0EsyKKTzjdZaFIRKuHK/Brdiw7MAPyJTAOq38
t3vwTueNhSFiPCbmDmjzaluXLqqdg8jgsuJ5PZynv+NMgnYsJm+QHInBJC2Kc304
/k8z42BBwO7cJMuGkEYtt60Y0T9BxGonHImm10L7sDhuqleFD2TIithI8O4KhkH3
/2mKBLJZ8u5l2jwViTp6zURY0bfOZ1hdpP2QMXsEzgtiG8Brhdwf4Yo/ekibZZxo
S/nTabyOTJ9N0xs2VOeNy5CPgo99UXCA1O8uX1ev7Q==
=dgZW
-----END PGP SIGNATURE-----

--Pjk796cY0SfIo9Z2--

