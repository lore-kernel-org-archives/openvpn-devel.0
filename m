Date: Sun, 8 Oct 2017 17:38:14 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20171008153814.GO70062@...1296...>
References: <1506735276.3927298.1123095944.62A302FF@...2307...>
 <20170930074629.GT70062@...1296...>
 <20170930161910.GX70062@...1296...>
 <1506794899.87173.1123548520.4DA7A99E@...2307...>
 <20170930181555.GA70062@...1296...>
 <1506797785.3933973.1123579944.40D80593@...2307...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="mUkVHLrPAbedpyr7"
Content-Disposition: inline
In-Reply-To: <1506797785.3933973.1123579944.40D80593@...2307...>
Subject: Re: [Openvpn-devel] Unreferenced function in 2.4.4 Linux build
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: logcabin@...2306...
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--mUkVHLrPAbedpyr7
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Sep 30, 2017 at 02:56:25PM -0400, logcabin@...2306... wrote:
> This has solved the problem:
>=20
> ./configure LZ4_CFLAGS=3D-I/usr/local/include LZ4_LIBS=3D"-L/usr/local/lib
> -llz4"
>=20
> My mistake was to assume that since ./configure had found LZ4 version >=3D
> 1.7.1, it would also locate the latest lz4 library. My bad.

Just as a small followup - we've discovered that this was not (only)
a problem of your installation, but hit all Debian 8 systems.

We have adjusted our "configure" script to check for this particular
problem (the version number reported is "130", which is "greater than 1.7.1=
",
but actually a very old version), so 2.4.5 should build out of the box
just fine.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--mUkVHLrPAbedpyr7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJZ2kZlAAoJEB2Cnv7KVigS0CAMAIgk2OLKRWlTXmxPbpakPg3B
WU03IVqC7bPAsBDs1vgGwRuk+tqhwmaNJ58NR4rKTHl+EkbAwHWRbV3rJdPD3aod
4K9i9MAHEzh2FTvajBrr+5fdH2e+IS+lFEjYaJ/p1Q/Ic1AvO6M1fXjKTIvXkshB
ryiXfAx75IOARAWRkMVm4M3G5G178LVUbJOBS1Ji5OeYjYH39I30nJueiBstU48R
FX821Io8rdroo9VTFfrHLLE8cbqBoftIbhxJwlG4HuqBy61xI6Zba9+14ljjOBk0
C3R2Yzp324arvoRYEAmnZT5CldTdwOuwQ3ZvlbLFm53n1J1GysEh7MU9QrmanbGo
EhwdDzCdsoJMGby96o72HXNP33zI0poMswkO/+KkqIy+VEE6xGABlKBlDMnUNGgP
BBOi3fD7aj56xvQ1WRX5yah4u2p95TAseMjYZxVdicR15aVgZIxYhxlS0Nxwp5oP
gkS+NlI1Iz3rdly8XeuJMvzFYPCItb3evVULuO0Hxg==
=tzQh
-----END PGP SIGNATURE-----

--mUkVHLrPAbedpyr7--

