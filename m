Date: Fri, 24 Jul 2020 22:23:34 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200724202334.GL1431@...1296...>
References: <20200724141445.302-1-lstipakov@...277...>
 <20200724184020.GJ1431@...1296...>
 <CAGyAFMXkD2LJ+z8hVo8DphZL2pJC77ABqVeHxtYzx6Pj9AsUxQ@...278...>
 <20200724194053.GK1431@...1296...>
 <CAGyAFMVE_sEzCZjOPwsgN0JzVdgFo9yQR-=xfOgmF+HvUJiqzQ@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="wtMdaaydyJvbgShY"
Content-Disposition: inline
In-Reply-To: <CAGyAFMVE_sEzCZjOPwsgN0JzVdgFo9yQR-=xfOgmF+HvUJiqzQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Improve Windows version detection with
 manifest
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>, Lev Stipakov <lev@...515...>

--wtMdaaydyJvbgShY
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jul 24, 2020 at 10:49:07PM +0300, Lev Stipakov wrote:
> > How do you build?  I use the "build-snapshot" script, and that does
> > a "make dist" somewhere in between.
>=20
> ubuntu@...2570...:~/openvpn-build/windows-nsis$
> OPENVPN_VERSION=3Dfix-remove-impersonation
> OPENVPN_URL=3Dhttps://github.com/lstipakov/openvpn/archive/fix/remove-imp=
ersonation.zip
> ./build-complete --use-depcache

Ah, you point it at (effectively) a ready-made tarball.

I use "build-snapshot" which fetches a git repo + branch

Maybe build-complete does the same if "OPENVPN_URL" points to a
git repo... dunno.  I have

OPENVPN_URL=3D"git://github.greenie.net/openvpn-236.git"
OPENVPN_VERSION=3D"${OPENVPN_VERSION:-2.5_git}"; export OPENVPN_VERSION
OPENVPN_BRANCH=3D"${OPENVPN_BRANCH:-master}"

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--wtMdaaydyJvbgShY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfG0NFAAoJEB2Cnv7KVigS6nIL/j3UgrUMRjW0DXINB8w8qEk/
bOviTR39JzhtKWupDU9E/aLIiBVHboRq8YeGWhJcG+b/yH447VkBX3tTE4erBqyV
tCuwwEO8dqY/IzmuqlXxXcRlBzWXWwRqmRfXNtAKAEgMko70/cI3aXsFTQT9CZ4u
pCSkFPj0pG+CbxEYF4WWlD2+T8JU6REIJQnbld11yeDQomtXlWjP7Qvusbg/zntW
tqN0rIxtt3+4iAdUetmo6OgRqdpcy3rzHa4eF7488cGAAC+zVu0oEeIF0OiPu7Xu
Ts86F10hc5lKcuHTlVZc4s0zf1B2t7QpBfEIaIz5K7iA1kBx9vwgyPOZdMJY/rJO
c5Ro9qqXOkq9OWwe0i/YTlZaY04LqUj8XmNC9NYftntHh1jYqjkZAumkCp+OdMCR
W6EbSMERf4MZSLO7XAm/k4A8OVeM6wdzdFLCUs7uhRcijbrmmLvwca6DKK68TXX3
RLM5qVwI29pKaoKYKYJBorDb4aZgtTzq8AQfEjhmfg==
=SYFO
-----END PGP SIGNATURE-----

--wtMdaaydyJvbgShY--

