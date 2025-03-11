Date: Tue, 11 Mar 2025 22:59:29 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Z9CyQV_V55ffZ8Ar@...1296...>
References: <20221010071229.7935-1-gert@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="IuZTr2eXQWGdkxp7"
Content-Disposition: inline
In-Reply-To: <20221010071229.7935-1-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] TLS: do not lock empty usernames
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--IuZTr2eXQWGdkxp7
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Oct 10, 2022 at 09:12:29AM +0200, Gert Doering wrote:
> We do not permit username changes on renegotiation (=3D username is
> "locked" after successful initial authentication).
>=20
> Unfortunately the way this is written this gets in the way of using
> auth-user-pass-optional + pushing "auth-token-user" from client-connect
> (and most likely also "from management") because we'll lock an empty
> username, and on renegotiation, refuse the client with
>=20
>    TLS Auth Error: username attempted to change from
>             '' to 'MyTokenUser' -- tunnel disabled
>=20
> Fix: extend "is username a valid pointer" to "... and points to a
>      non-empty string" before locking.

FTR, this patch was superseded by Arne's "--override-username" patch
which just now landed in master.

commit ebd433bd1e40917793903f76883d114d820e992d=20
Author: Arne Schwabe <arne@...1227...>
Date:   Tue Mar 11 16:59:04 2025 +0100

    Implement override-username


Also FTR, this is also https://github.com/OpenVPN/openvpn/issues/299

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--IuZTr2eXQWGdkxp7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJn0LJBAAoJEB2Cnv7KVigSMG4L/1/E6MxyE7IjXR1FoVY3/vOz
BMo09YVZba2jtdGW11SiT/egkM2Loqt1rIemIQ2VxtQw9VDmIOxrhWoMHtUnN+PM
jcFIiH03m7t8g7cV8n9u3ORflhqJH7QHleqZaOFRur2+wTzWXSdSc9T4RZ2nOwkQ
E+YO8OxCNBINO9BI1mhgmuWpAFcifEdSh1uZHzHnDqd40LiQjhP8LYq4RXuE6CY6
n0x43xz5U4do/RgwEoUQR9wNWm+CMZA8Wd8VxKY01rTPg/chlIZYDphzNWYN346f
0q1A3bC7Fae57YFIoxVOFPjIC3IhIOc8jIUrw8czLYsWnRGOGmRG/6EiCWixfz47
RR+XESWD0ew5Rbp+cRsm196jnTRpkx3OsEGsC0zlw8m74S2IRl5dQYEpIKQxSDnV
6l+FU9qG+cSoukshthEqOiIwxYVuoFcGfOoos5brmrxul+WiB+1bYvaTwYcaFtOF
4Osqvw4TffZuwtnKiYdg94Apo+dXzMaoJM0Kg9EdUA==
=e6dP
-----END PGP SIGNATURE-----

--IuZTr2eXQWGdkxp7--

