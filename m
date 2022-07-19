Date: Tue, 19 Jul 2022 22:17:31 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YtcRWzVsMARPQscP@...1296...>
References: <20220624083809.23487-1-a@...2181...>
 <20220624083809.23487-21-a@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="YEAo8B9Xux9u0o87"
Content-Disposition: inline
In-Reply-To: <20220624083809.23487-21-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 20/25] dco-win: add platform dependant
 check on incompatible options
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net, Lev Stipakov <lev@...515...>

--YEAo8B9Xux9u0o87
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

this one has an ACK, but needs a v2 still, because...

On Fri, Jun 24, 2022 at 10:38:04AM +0200, Antonio Quartulli wrote:
> Some platforms may have different constraints in terms of incompatible
> opions, therefore we add a function that explicitly checks those.
>=20
> Also, add generic option check for when ovpn-dco-win is in use.
>=20
> Signed-off-by: Antonio Quartulli <a@...2181...>
> Signed-off-by: Lev Stipakov <lev@...515...>
[..]
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -2376,6 +2376,11 @@ options_postprocess_verify_ce(const struct options=
 *options,
>      {
>          msg(M_USAGE, "--windows-driver wintun requires --dev tun");
>      }
> +
> +    if (options->windows_driver =3D=3D WINDOWS_DRIVER_WINDCO)
> +    {
> +        dco_check_option_conflict(M_USAGE, options);
> +    }
>  #endif /* ifdef _WIN32 */

... the WINDOWS_DRIVER_WINDCO enum is only introduced in one of the
later hunks.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--YEAo8B9Xux9u0o87
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJi1xFaAAoJEB2Cnv7KVigSzcML/1Bf6oYy6AGRIFGCVc+4CBF8
TIaisVkT4dqgtASu9TnNcA+U//wRTlswneD1GknGDeDEuf2raxxZdRP6EG0eZHkf
Oe9z1CANZvQbjOPBLHNr68YulcfNv4B4Pd44cDqWH6YE5x/e+Xp47swijSWftwSL
3ITVgo7a2jsl+07yDroH1ZewrMf4eDmlHnLhvgVvm99AmKTPXYGXyYvQyG6BdiHM
ri5NXcbTgREf5V2d8U/F0wxwShpkPSZ2VS6emaYlmrJ4ABhSahGwI/l5to+5r0U2
0ViLlr/or+OF0c7+453nMkcech5jlImBgVzlX0M4lIc0wXfTlTuZZzt86b5XTYny
nbe3t/amxLLhdR0CxrVGORjp/TBEQZloKU/HoaQkklyiqBOakAlYuSJ29nFiB0ei
9lHEEITWgiJwdImNd55N/WIJ8hOvSaqjg7CXyNKP/A8TGD+FCCNB5rid1E8zOMS2
p4zeowSclwYiVTPVHjO+413vnC60VGM783fHuCUVoA==
=FXJR
-----END PGP SIGNATURE-----

--YEAo8B9Xux9u0o87--

