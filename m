Date: Mon, 6 Mar 2023 09:24:27 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <ZAWjO1dXEnBRsltG@...1296...>
References: <20230306053346.796992-1-selva.nair@...277...>
 <20230306053346.796992-2-selva.nair@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="YedkAhvAtKpexxJQ"
Content-Disposition: inline
In-Reply-To: <20230306053346.796992-2-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH 2/2] Include supplementary groups when
 checking management-client-group
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: selva.nair@...277...
Cc: openvpn-devel@lists.sourceforge.net

--YedkAhvAtKpexxJQ
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Mar 06, 2023 at 12:33:46AM -0500, selva.nair@...277... wrote:
> From: Selva Nair <selva.nair@...277...>
>=20
> - When management-client-group is in use, allow access if any of
>   the supplementary groups of the user matches the specified group.
>=20
>   Currently only the effective gid of the peer socket is checked
>   which is normally the primary group of user. As unprivileged users
>   have no easy way of changing the effective gid of a process,
>   group based access control is of very limited use without this change.

I'm not really convinced this is a good way forward - it's yet another
extra function for a very niche use case, as in "the code has been like
this for 100 years, and nobody has ever used it".

What you do is also not exactly "the user connecting has this gid at the
time of connection" but "the uid reported by getpeerid() has this group
listed in /etc/groups", which will be the same in many cases, but is
still checking something different.

I would propose to extend the documentation with "this only checks the
primary gid at time of connection, if this does not work for your use
case, put the socket into a directory with the right gid and mode 750
and do not use that openvpn option" - as you wrote in the github ticket.

> - Also accept if uid =3D 0 irrespective of the group.

This part is fine for me, as it follows the traditional unix way of
"root may pass".

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--YedkAhvAtKpexxJQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJkBaM7AAoJEB2Cnv7KVigSu/UL/14/QlKlnhqHe6/W9OvMMWYu
Z/i451wVsS0VvEAZpr2Y58nAC7IwYpMghCkBK0j0jn8C0eaPZ+6PcPOTIjPVRhPq
bCvEKIuyVjTCnmR8+Luy70Ya9w21Faogo+VloLHzhdnUaHe2+8FeScsqtjwNN5Xk
0HXX7SSpLBcUzGNg/AvyoHF7++DVUnJLe9RwbpJHk+z50YOdgjBaSFhMWrF6RRGQ
0YPxDNaQiJ5FRpZp5IYme76MMETpvAq887edy+hTtA5YqkJxUzuQ7HLZDvPWZKR3
rL3ZYtwKv6MUmcOG17wzRHR56XMK3bB+i7BQDEluSA/cP41rrt4X38x0SH8b7zdt
UEBpIs92okAuPPhFU2nZ38s2LI5uwMXvHrGdhUALpCYEJ4N221JWEXo0/F2jxrZg
G3amLgA1RIBSma96KL1DfvXrTto2S7jCq4rOJpT/iG49VgZGQJKFCrhWCq1Ia/ZE
T/WB91tOWXamvF+I/cQ5F38bO22zFZnJzi3wM88+6w==
=GN0p
-----END PGP SIGNATURE-----

--YedkAhvAtKpexxJQ--

