Reply-To: openvpn-devel@lists.sourceforge.net
References: <c39d1e54-04f8-8ca3-34dc-5d023078286a@...2181...>
 <1505457556-8557-1-git-send-email-steffan.karger@...1435...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <af093d4a-50c1-d18c-11d7-1f6a84fa130c@...2080...>
Date: Thu, 21 Sep 2017 23:03:51 +0200
MIME-Version: 1.0
In-Reply-To: <1505457556-8557-1-git-send-email-steffan.karger@...1435...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="Tp1hwsBl09O9ec3OgxeMM9VB7d4aN94wt"
Subject: Re: [Openvpn-devel] [PATCH v2] pf: clean up temporary files if
 plugin init fails
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...1435...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Tp1hwsBl09O9ec3OgxeMM9VB7d4aN94wt
Content-Type: multipart/mixed; boundary="jBtcRKXGcntLs29rEq82UH76ANHDVeOgJ";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Steffan Karger <steffan.karger@...1435...>,
 openvpn-devel@lists.sourceforge.net
Message-ID: <af093d4a-50c1-d18c-11d7-1f6a84fa130c@...2080...>
Subject: Re: [Openvpn-devel] [PATCH v2] pf: clean up temporary files if plugin
 init fails
References: <c39d1e54-04f8-8ca3-34dc-5d023078286a@...2181...>
 <1505457556-8557-1-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1505457556-8557-1-git-send-email-steffan.karger@...1435...>

--jBtcRKXGcntLs29rEq82UH76ANHDVeOgJ
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 15/09/17 08:39, Steffan Karger wrote:
> close_instance() tries to remove the file in c2.pf.filename, but that only
> works if we actually set that if we fail.  So, set that filename as soon
> as we know we've created the file.
>=20
> Signed-off-by: Steffan Karger <steffan.karger@...1435...>
> ---
> v2: As suggested by Antionio, get rid of local 'gc' and 'file' vars.
>=20
>  src/openvpn/pf.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>=20
> diff --git a/src/openvpn/pf.c b/src/openvpn/pf.c
> index 5fe1734..7479347 100644
> --- a/src/openvpn/pf.c
> +++ b/src/openvpn/pf.c
> @@ -618,19 +618,18 @@ pf_load_from_buffer_list(struct context *c, const s=
truct buffer_list *config)
>  void
>  pf_init_context(struct context *c)
>  {
> -    struct gc_arena gc =3D gc_new();
>  #ifdef PLUGIN_PF
>      if (plugin_defined(c->plugins, OPENVPN_PLUGIN_ENABLE_PF))
>      {
> -        const char *pf_file =3D create_temp_file(c->options.tmp_dir, "pf=
", &gc);
> -        if (pf_file)
> +        c->c2.pf.filename =3D create_temp_file(c->options.tmp_dir, "pf",
> +                                             &c->c2.gc);

Patch looks good.  But it introduces a new compile warning.

pf.c: In function =E2=80=98pf_init_context=E2=80=99:
pf.c:624:27: warning: assignment discards =E2=80=98const=E2=80=99 qualifier=
 from pointer target type [enabled by default]
         c->c2.pf.filename =3D create_temp_file(c->options.tmp_dir, "pf",

I'm pondering if we need create_temp_file() to actually return
a const char * - wouldn't just a plain char * be enough?

The alternative is to cast the const away here; but that just
feels too hacky in this code path.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--jBtcRKXGcntLs29rEq82UH76ANHDVeOgJ--

--Tp1hwsBl09O9ec3OgxeMM9VB7d4aN94wt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJZxCk4AAoJEIbPlEyWcf3yb+8QAMokm3vsoyRlBwjQOyjBbBH/
8o+0CrU4z3mjlcR9vr997xrpc6chdBwtdb8AWWt7RMhRBxdoRMOoGfOVeyOWgp1R
dBDA++6mJNc0LK5Ose4gBME8qIa4NnTae6rsWPHEkTKDwLbSnKLpJqabdQ132ddM
qDW2ilRq6pv2XXk3Vy49hCHTK0SF3wOPN9r5Tw0wiOHx6ES7OPCcVWi+pfp0EpIs
edibhimixBBLzHpI5lZcxRFo4ipFRrSwgATewwK5K9M9wvdjlyhbnxCHJC3Eg8UK
aZ7FnNFpBf6uDLEdpldQvaoEX8yg1H11Fzz/6TibTovrlrRIpEI67gFmiiXFa2Jk
WR9EIM25LG6K2h+7+vszLK5/axJMPghJFRI3vJrvGFuRgTVfoj5vmdPZbS9lckMT
oymPfsVbb3itfMJE40niiUcvzOB25C42ChxL9zOsF903dr4u/SaS2rqZuabljZcK
bJi0sx87qmYYKxccjcCm8JwWvrTDF1OYqjIx1N7oDvkg0TmirPVrX6UZX1B1/DqG
FyfZ+8slXKybDLs2cMi0QunA77AvhL+HbPXnE//m6xne1SmNHUkUnSdnXZApS3jO
/HRQhPxepsNMRdwgmqv12oyLQgSAgX4yANfBqRrbUel5tmwBpH+y9UcBUMCzorhM
OR/whFvHkG2iQbepMX5a
=ow6H
-----END PGP SIGNATURE-----

--Tp1hwsBl09O9ec3OgxeMM9VB7d4aN94wt--

