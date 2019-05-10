Date: Fri, 10 May 2019 15:59:23 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20190510135923.GP31008@...1296...>
References: <20181219050118.6568-1-a@...2181...>
 <20181219050118.6568-2-a@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="TbCLU7yw/pV5zSId"
Content-Disposition: inline
In-Reply-To: <20181219050118.6568-2-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v3 1/7] implement networking API for
 iproute2
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

--TbCLU7yw/pV5zSId
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Dec 19, 2018 at 03:01:12PM +1000, Antonio Quartulli wrote:
> iproute2 is the first user of the new networking API and
> its one of the two currently supported functionalities on
> Linux (the other being net-tools).
>=20
> This patch simply copies the current code from tun.c/route.c
> to networking_ip.c without introducing any funcional
> change to the code.
>=20
> Signed-off-by: Antonio Quartulli <a@...2181...>
> ---
>  src/openvpn/Makefile.am           |   2 +-
>  src/openvpn/networking.h          |   2 +-

"something is missing".  It is nice that Arne ACKed this, but this
patch does not apply to master, because we do not have a networking.h
that it could modify...

I have quickly checked my inbox for other patch sets that would
introduce "networking.h" but the only place I can see this mentioned
is this patch set - so could you please send a "-1/7" that makes
this patchset apply?

Or rebase on a clean "master", re-test, and re-send as v4?

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--TbCLU7yw/pV5zSId
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJc1YO7AAoJEB2Cnv7KVigSIbQMAJcDAnrDTAk36ISsmctnKlPv
pap19Khb+iG11BFDWkrr4sNAKPRf8KrUDGrjGejQjgX7zIus2dJB/b0Ek2iFmgPZ
bMBbpLw96ujYmbKvWt6JyKVp92rrfU7y+1iFV9oxHl7t2l0SmkUzQURj56s80qPt
LNaDvdFZcQHKJ4ZLxq9GNl5GT7CveE56NIrF9lomZxdBQGulpSj3hI/UE0L31pc3
i3g/FK0flXOCK9h1wno048EN3VfVIXs0keJ3+op/vfOpPEJQyoQdY5kEfJV4vHON
AcQ7rSlPduq3xMyWRQ8HOJf2v+oZrJbQJXj3c2acaBk+oyufK1Q3dUABF0/BVo+R
xa/K15MDY1Tr+TUbFJ3gA5jZaXMhRzHwtSBlWQTz69A5mzLLIGAPxIcKuKMvx/KB
mxfdAYKnm0ZK6i/NJTa9wqVXZ5r4e+IulYjejQ70q1O9IKZHiKY2tvu/oUmtpL6E
YXbGuB2h0gRRkRK3smVfOqlzi9Meg1U9yzagr+aOVQ==
=0LQN
-----END PGP SIGNATURE-----

--TbCLU7yw/pV5zSId--

