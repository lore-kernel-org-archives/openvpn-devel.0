Date: Sat, 29 Jun 2019 11:57:32 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20190629095732.GV1097@...1296...>
References: <CAKuzo_j6F2+_JxosdVF3iB4kzWsR7Wq2FT8Vgi9Cg3yvT_A1JQ@...278...>
 <20190628210334.GU1097@...1296...>
 <CAKuzo_ji9qNyc1vtQRhuuuYXgmpb6Qey2+L7GRqbhLNqbSwx9A@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="5O+LjL9oTw7vAELi"
Content-Disposition: inline
In-Reply-To: <CAKuzo_ji9qNyc1vtQRhuuuYXgmpb6Qey2+L7GRqbhLNqbSwx9A@...278...>
Subject: Re: [Openvpn-devel] Using AllowNonAdmin in the advanced options of
 tap adapter
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--5O+LjL9oTw7vAELi
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jun 28, 2019 at 05:43:13PM -0400, Selva Nair wrote:
> That's what lev's patch would do, but it wont respect the registry key
> which is "supposed" to toggle non-admin access to tap-windows6
> adapters on and off.

I'm still not following, sorry.  Maybe I did not review the patch enough
(I stopped after the "lots of extra arguments" bit and wanted to do more,
but then family and too-warm weather stole attention).

So Lev's patch proposes to do service calls for wintun *and* tap6, and
do so "always"?  Or only if the registry key says so?

> > With a registry key to re-enable "full
> > access as today", for compat reasons.
>=20
> For some reason that registry key appears to be doing nothing in
> current versions of tap-windows6. I know this is confusing...

This sounds like a bug...

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--5O+LjL9oTw7vAELi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJdFzYLAAoJEB2Cnv7KVigSPnsMALD/k4NIWENKbUetUFkwFWip
swor7gDaLGfxzc/TvLQwrBztx2FsMGVkKLXWGe+BXiCvVTRQ2B8XOa01TIJOxBj0
zfzwB2HwO4H41OXi1lIbwxBJVKIZZ7pScfDHH/XGUQcn73fGjtM2WR83nwxyKn2h
NYWxSNgyPYGiqYZ2U1t8P9N8wnc0cQDpu85Iz2qBjYY52D90j+Eey5CdQvYxIaME
ERiVaPY3pySYVcPaC0wiIkv+arbHcoyOefBFwUiP5NoeA1KEk6XUGwpm0tSaf0zU
L5YhkdmPI09L1bvrEGmPtgUmA6IartqrS/7X95iKQxVHD9tagY5g+qVM1d1BElEP
VAIWK392DIzt4qDhkziymSOPyozItgTqqs227TDUMsswp2sPFHrPlaI0XLv73Sq5
OPlFhowsRhxfbpKojwtrtOFFJMSO5KCyxTnUX0y4+wD/fH/ibLxM3xUSApV0TRHy
vbbZCmJsePHTA5RaWo6EYpqlwFvceAl+ZassZzFIuQ==
=bTyN
-----END PGP SIGNATURE-----

--5O+LjL9oTw7vAELi--

