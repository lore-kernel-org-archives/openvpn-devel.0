Date: Mon, 27 Sep 2021 11:52:29 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YVGUXTJsm7BItkl8@...1296...>
References: <20210825164752.808-1-lstipakov@...277...>
 <202109120926.18C9Q4or095004@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="yT785ZMJm24qNxaX"
Content-Disposition: inline
In-Reply-To: <202109120926.18C9Q4or095004@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Add building man page on
 Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lev@...515...>
Cc: openvpn-devel@lists.sourceforge.net

--yT785ZMJm24qNxaX
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Sep 12, 2021 at 11:26:04AM +0200, Gert Doering wrote:
> Your patch has been applied to the master branch.
>=20
> commit d814581a9375713a0a4d70f751f84e750a5d661a
> Author: Lev Stipakov
> Date:   Wed Aug 25 19:47:52 2021 +0300
>=20
>      Add building man page on Windows

... and pulled up to release/2.5

commit 35c8281ef20de507dc08637bff02ce7895b48ec6 (HEAD -> release/2.5)
Author: Lev Stipakov <lev@...515...>
Date:   Wed Aug 25 19:47:52 2021 +0300

    Add building man page on Windows

    (cherry picked from commit d814581a9375713a0a4d70f751f84e750a5d661a)

(one minor conflict due to the ".pdb" artefacts patch not being in 2.5,
but that was trivially solved)


I have not tested this myself, but Lev confirmed on IRC that it works
with 2.5 as well.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--yT785ZMJm24qNxaX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJhUZRdAAoJEB2Cnv7KVigS17cMAIgPjX3Fa40IG6JM3QmBZurc
oC7e95cn98kvZCcVh6kzx5zP+UKFBQThaF3U1JIoXBGKEi5ZP6nNaPvE8QX5bzA8
UDqB4zIiaIABr46O2/QU0ZjfiOJFdqU2rFEuHuS8HD17hoTZOQlQV35WGlJAylEi
U7g7DrjY801pUWud7WjGCUSH1xNwFl0B78ps+BYqkAJFJnzSCT+afNSRUBYa+cJC
vlsbyEaO8kt6xzOnfmYSym4qxRJXIIuz53vTZTCvpMxPQutJhT13DD/RJr3KAuqO
vDNNl4qL5QcTIGwYSkgHO4M3hJIRnZOVJPmA0L2IUTFLRhaF3rPAP8v7HPX6NDsP
VW+5x70yIo5bAOqiXNCHbW0O02Mzf/QNu1yR1iWwIkF4H/FqGLVzrOtZz1tW+p2b
bRKdmRjvtmk3UzJAcOs8jSfVAeDhVlIBY115TwV+Ljy8mHI8EOL2/AZAhJOe18qW
LIrFKCF+ka3U3KcraTez9GrZ4Y5LT7OcTtrP0yyohw==
=NUD5
-----END PGP SIGNATURE-----

--yT785ZMJm24qNxaX--

