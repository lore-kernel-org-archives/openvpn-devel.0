Date: Thu, 15 Feb 2024 17:17:56 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Zc45NJAyJyLoTRee@...1296...>
References: <gerrit.1708012740000.I4b5e8357d872c920efdb64632e9bce72cebee202@...2715...>
 <a91d834e2d9f284b0278cf9940f50dd0a539f057-HTML@...2715...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="KoRpYEV8GUfdLEQU"
Content-Disposition: inline
In-Reply-To: <a91d834e2d9f284b0278cf9940f50dd0a539f057-HTML@...2715...>
Subject: Re: [Openvpn-devel] [S] Change in openvpn[master]: Minor fix to
 process_ip_header
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: gianmarco@...2726..., arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net, frank@...2641...

--KoRpYEV8GUfdLEQU
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Feb 15, 2024 at 03:59:02PM +0000, its_Giaan (Code Review) wrote:
>      if (buf->len > 0)
>      {
> -        /*
> -         * The --passtos and --mssfix options require
> -         * us to examine the IPv4 header.
> -         */
> -
> -        if (flags & (PIP_MSSFIX
> -#if PASSTOS_CAPABILITY
> -                     | PIPV4_PASSTOS
> -#endif
> -                     | PIPV4_CLIENT_NAT
> -                     ))
> +        if (flags & PIP_OPT_MASK)

NAK, as this is not the same thing.  PIP_OPT_MASK will also match on
the IPv6 flags, which are not something we need to test for here (=3D if
only an IPv6 flag is active, why should we enter this branch?).

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--KoRpYEV8GUfdLEQU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJlzjk0AAoJEB2Cnv7KVigS/IgL+wdbBEDjLfRrvTBi5399FUDn
H5+293n5Dbjfw2bJ9pqJ7XwQtR4Cf6z/nF9aebmcniqCk6Hdf7HUxc+Z4yy7tLu2
aHR5x2J8ycwJ+fYiVIv2rkSQAYZCyBtQTVzOwt/huHgSSJsHdQb/1UJrZ68mTFke
ajSwqiDMpIc2EAMZyMGQ7P+3OhIiTLZ29r/aR35It62CxK8Ec41gyug0NVlHf9LD
w2+gkw39WLMJFo+3QsfW9pq32+8f7/SKPHHa4v0r1SzOdaAcN+GhpYsj7e4WQjPA
tb9Safg9tuBJih+a8xkm57SWDx7l2VlEdfR0PwVETFjaFpmDYh3FUz3Osapg2bXm
3pfhaojXKSrAabXPD4aTX5qQ45pzJC0O6w56rVDEsEVhdDKOd5PiDKA6uQu3FlFf
Q2mRDcPPzOkFIxmX22rpfsds/KTAk9xZVBIRFdCed3wJMwKZiOZ4dRP3RQNtxVuj
3FHIkyfomzb+OoR6XW/y4vTAPMNQvqXUspshRWtKsg==
=NmIb
-----END PGP SIGNATURE-----

--KoRpYEV8GUfdLEQU--

