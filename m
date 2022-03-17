Date: Thu, 17 Mar 2022 11:41:22 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <YjMQUsyqUaxzlAWn@...1296...>
References: <20220308230621.1532809-1-heiko@...2662...>
 <20220312135810.242028-1-heiko@...2662...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="GFKpr+nEtSIYO7l8"
Content-Disposition: inline
In-Reply-To: <20220312135810.242028-1-heiko@...2662...>
Subject: Re: [Openvpn-devel] [PATCH] add support for --dns option
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Heiko Hund <heiko@...2662...>
Cc: openvpn-devel@lists.sourceforge.net

--GFKpr+nEtSIYO7l8
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

(this is about v2)

On Sat, Mar 12, 2022 at 02:58:10PM +0100, Heiko Hund wrote:
> As a first step towards DNS configuration in openvpn and a unified way
> to push DNS related settings to clients in v2 and v3, this commit adds
> support for parsing the new --dns option. Later commits will add support
> for setting up DNS on different platforms.
>=20
> For now, --dns and DNS related --dhcp-option can be used together for
> smoother transition. Settings from --dns will override ones --dhcp-option
> where applicable.
>=20
> For detailed information about the option consult the documentation in
> this commit.
[..]
> +    for (i =3D 1, d =3D o->search_domains; d !=3D NULL; i++, d =3D d->ne=
xt)
> +    {
> +        name_ok =3D openvpn_snprintf(env_name, sizeof(env_name), "dns_se=
arch_domain_%d", i) && name_ok;
> +        setenv_str(es, env_name, d->name);
> +    }

With the "&& name_ok" this code does not really improve, even if it
was requested in the v1 review...

I wonder why we bother to actually *do* this?  As in "we already know
that this can never overflow here" (because all strings involved are=20
known, and the max width of %d is known, too), but *if* it ever did,=20
calling the subsequent setenv_str() wouldn't be a good idea to do - no?

Can we make transform these into a miniwrapper that does

 - openvpn_snprintf()
 - check result, warn if overflow
 - call setenv_str() otherwise

like

   for (i =3D 1, d =3D o->search_domains; d !=3D NULL; i++, d =3D d->next)
   {
        _do_dns_env_thing( "dns_search_domain_%d", i, d->name );
   }

so, shorter lines, clearer code, actual error checking, and no && ugliness =
:-)

(As far as I could see, it's all "setenv_str()" anyway)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--GFKpr+nEtSIYO7l8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJiMxBSAAoJEB2Cnv7KVigSe8EL/1UxG8j1OZiroEHETaHvu1jX
bR0EsdqG3ru+i3/pS1DumBxiOgXM3pBp6ENoxSD1V10MDUAftbuNoCqodm515RJB
Z9/iQXGfkYnfNXQNlmn4M/LmdHeec0FKjBd6lzefZ9XDM6aPhEK6eruGcIYMRyKe
rlm7178Cd+m6cORfzq2HQnqn9SGmvm9IvJPqxJG/K9EeXrwW9hAju38sV08CD10y
+Ip31lS9RduJ4mRpEswPnk/O5NcORPInvGQTieJ2YuyVn8fnt1uNiX0QxflaZS+f
/K06ecK72aD6+kc0/b8/NSRVZ3ufwD3yKa80P/4owLg0jzu3Zn0reoK41LJ9yuZP
87EWpBXK/+kXuRnf2JCjYIoD60mMCjKfSt+tEgCZpJXatccIMxM7uD5U6VeENjNT
j9yZLdib1GxMfGqQzxRomfwkSxopaVp8CR3BSxR88zKNR+BLTblLjoVKH3FYCZJd
5Dml/DSZt3nh3i9iy13JUKxFqwtSlnTxl2/lU3TQKQ==
=cmDi
-----END PGP SIGNATURE-----

--GFKpr+nEtSIYO7l8--

