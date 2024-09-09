Date: Mon, 9 Sep 2024 13:43:50 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <Zt7fduQb-EWx6Bs_@...1296...>
References: <20240906145745.67596-1-frank@...2641...>
 <202409091139.489BdULT062449@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="W8bfN2a+YBPsGGWu"
Content-Disposition: inline
In-Reply-To: <202409091139.489BdULT062449@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Ensures all params are
 ready before invoking dco_set_peer()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gianmarco De Gregori <gianmarco@...2726...>
Cc: openvpn-devel@lists.sourceforge.net

--W8bfN2a+YBPsGGWu
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Sep 09, 2024 at 01:39:30PM +0200, Gert Doering wrote:
> Your patch has been applied to the master branch.

Note: while this is a bugfix, it does not need to go to 2.6 - there is
no mssfix support in-kernel for DCO v2, and the upcoming DCOv3-no-called-
"ovpn" will be 2.7-only.

(FreeBSD DCO does not support mssfix either, as of today)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--W8bfN2a+YBPsGGWu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJm3t92AAoJEB2Cnv7KVigSLhAL/2cdTC2Xm0vO6lSI90DruTK4
y62OUsi0WdR3lMMSWgGFysDJ1nvTajJUEtjuc2NJ0+y6I4xMUVOuCzvvE5yM50KW
qihkd5omECxGiue7o320v4i8UakBOWb7ngP4xO9DRdn/ZI850qARuRbZIeWOFQlr
2yP/R3qCi8ev57sUviJBT/Kl5/8Co/vg/5kxfVBsAwC8ZNtSUW1lAIozaM2Idsuo
XeWavpMFOcQtCnD3N46cm4ezAm9o2GlcR7pKPiZvbbDiuq6HWSQYgkSyc+pOYG3B
jBnUFlEbM6BVZoM6JrMVUYq02k38CYNqe5bsv5yCTkKJ1Vzuzaq0+WIDeAnpUw5O
UKNeZt1Rc2BZNiUBXF2rK1QTkveFqFtDUb5+Mk5vFJAz4f4SSbPUYDSqB6pAGcvS
80XnoEJTTnTMhe+9PyeoVP9PaKcL8L6mpsbQaVbnVYugRy2W4duTjfGwg6S+aC/C
GPpy4x0Sk7cmqzKjssPIBSzJWu5dWnfFhsHPFIbBkA==
=XJUK
-----END PGP SIGNATURE-----

--W8bfN2a+YBPsGGWu--

