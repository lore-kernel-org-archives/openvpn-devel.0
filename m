Date: Thu, 25 Aug 2022 13:29:04 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YwddALlQ32m4MkxB@...1296...>
References: <CAKuzo_hyreVwf5DEDGQNOXNtci8pE8Kf=tBCnhw0X+Xh0PEEFQ@...278...>
 <20220822085647.389-1-lstipakov@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="28srfa0VzmL3/Nng"
Content-Disposition: inline
In-Reply-To: <20220822085647.389-1-lstipakov@...277...>
Subject: Re: [Openvpn-devel] [PATCH v103] dco-win: implement ovpn-dco
 support in P2P Windows code path
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net, Lev Stipakov <lev@...515...>, Antonio Quartulli <a@...2181...>

--28srfa0VzmL3/Nng
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Aug 22, 2022 at 11:56:47AM +0300, Lev Stipakov wrote:
> From: Antonio Quartulli <a@...2181...>
>=20
> With this change it is possible to use ovpn-dco-win when running OpenVPN
> in client or P2P mode.
>=20
> Signed-off-by: Arne Schwabe <arne@...1227...>
> Signed-off-by: Lev Stipakov <lev@...515...>
> Signed-off-by: Antonio Quartulli <a@...2181...>
> ---
>  Changes from v102:
>  * use "windows-driver ovpn-dco" without trailing "-win", since
>    "windows" is already implied by option name.

I have received sufficient test reports to be happy about it.  The change
for v102 makes sense.

Alas, there is one change in v101 that I initiated which I'm now no
longer happy about:

> @@ -3434,6 +3436,10 @@ options_postprocess_setdefault_ncpciphers(struct o=
ptions *o)
>          /* custom --data-ciphers set, keep list */
>          return;
>      }
> +    else if (dco_enabled(o))
> +    {
> +        o->ncp_ciphers =3D dco_get_supported_ciphers();
> +    }
>      else if (cipher_valid("CHACHA20-POLY1305"))
>      {
>          o->ncp_ciphers =3D "AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305";

This change does the right thing for DCO-enabled *Windows* builds, but
it does bad things for DCO-enabled FreeBSD, because of

const char *
dco_get_supported_ciphers()
{
    return "none:AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305";
}

in dco_freebsd.c - so with the above change, we'd advertise "NONE!" as
cipher we're willing to accept.  Which is a hard no for the *default*
setting...

I still think using dco_get_supported_ciphers() to set the default
on Windows is a good idea (because "no none" there) - so I'd suggest
to do this:

> +#ifdef _WIN32
> +    /* CHACHA-POLY availability on DCO for Windows depends on system wide
> +     * availability -> query DCO layer for default --data-ciphers set
> +     */
> +    else if (dco_enabled(o))
> +    {
> +        o->ncp_ciphers =3D dco_get_supported_ciphers();
> +    }
> +#endif

sorry for adding more complications.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--28srfa0VzmL3/Nng
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjB10AAAoJEB2Cnv7KVigSmMoL/2q6dIpNHLN7lNeZrzUmmLn3
g6neG0xmIVVngefLzL4mDKhSyrybPfftJox7FjxNRFSrkbpMaJzKEJZOCFe5fVI+
UpXCbEGMoY8HkG60CeRwLYDYO35Vgx5Yd7WhMhXNeQX8kc2FDRLe2jnp9OYjQrTu
GSpIvC2KGtHi7GdVvSCMAbGLVO3ZoRFv+w8ZwxSiK32Fug6sOmm4yfKbF7I8+QDl
evVfW0glA3MjORvJ1XdO2qHGMDrCzYtleuK05jBcq7Zgz7lJdaZdi+R0IqhjDavQ
NuRNYOjAHgPXgUvv/elF8oXZR7wHIR1AMUQ3qTiDX8d0/pwWHm1L8zWA1sZZDXt6
lLzQhDfxmd1tH0JxIEE4TSEE1qbLSI5fjkPu69WoNeZkQ3T+uq1tfUEZz03vCm3s
D6RWgA7pC5tGPvN5pSePD9spPDFqxtiLQPgqNSfpqOE/IHpvbqVkvEXVd0nqiGvV
JylQzodqgsE+aHhhXWCLLt/lmiAWkwOH4k8EVQFGYQ==
=Za1G
-----END PGP SIGNATURE-----

--28srfa0VzmL3/Nng--

