Date: Fri, 11 Sep 2020 18:18:06 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200911161806.GH75094@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="HeirNmDatrwrWTrV"
Content-Disposition: inline
Subject: [Openvpn-devel] OpenSolaris / OpenIndiana help sought
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--HeirNmDatrwrWTrV
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

as you know, OpenVPN supports OpenSolaris / OpenIndiana / Illumous / ...

OTOH, none of us really understands the magic incantations that are
needed to open/close the tun/tap driver there - it's very different
from all other platforms.

Now, things do work today, except for one detail - if we close/reopen
the tun/tap device (for example because a server went away and we
succeeded in reconnecting), this always fails with

   Can't set PPA 0: File exists (errno=3D17)

and "just ignoring this error on EEXIST" does not make it magically
work, so I assume we're not cleaning up "something" in the proper way
in solaris_close_tun().


Thus: if one of you really understands Solaris networking, and can tell
me what we are missing, this would be highly appreciated!

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--HeirNmDatrwrWTrV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfW6M+AAoJEB2Cnv7KVigSTAUMAIrk5swJL7qJRjLDdJ8qkX/y
7Wrzdhv0+wk67Go4iytA4vQY0KRKV9bYvF9O1C2zKNWklsTr1SGX5GhxPzhCpUI/
ARkhyE/S/fCSK305k7vFuPWc62oYngeEMMWN+OfTp1TFBdiimv7cIW/MMNMqNXwo
mI7AVFAIe2JGwCF65f0IEoWWl+rdDXxnkksovl1htg2U5q5S5mS7BBJ1BQRVkt8l
xxmsa/rlLAjoDhogfejswG9bK/ZimrVEoStlXDFia05oWAizIxnnnz7i8gZZOI62
4/hSY6aTgrm1jjCQ/e50IdCjHykQhLa+67EZgi8XZ7bEpEAUivpgaydIfDzNprJN
sUEuGTMPxB9EUSNpYWTzem+0BL2j60nQkjsyvomZdg0Lnin6z3LOT4FOCz1+dmPW
crvyMj4vm0RPCfbJ7Ada2L0pjV1bZg3Nr9Yt+2j8x7XmX6tm3oLAKRvbp5joCMFq
KvNJm0IkOKQCEfUzbvwLv/MW0H+1VA65Ry7a3kadRA==
=nc02
-----END PGP SIGNATURE-----

--HeirNmDatrwrWTrV--

