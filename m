Date: Mon, 19 Dec 2022 13:18:44 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y6BWpDOwE/65gBRq@...1296...>
References: <20221215190143.2107896-9-arne@...1227...>
 <202212161742.2BGHgPmW018977@...2054...>
 <Y6BVYDrkTXeEPxRg@...2685...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="3vNXRDU0X9uZqo3e"
Content-Disposition: inline
In-Reply-To: <Y6BVYDrkTXeEPxRg@...2685...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Deprecate NTLMv1 proxy auth
 method.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Frank Lichtenheld <frank@...2641...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--3vNXRDU0X9uZqo3e
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Dec 19, 2022 at 01:13:20PM +0100, Frank Lichtenheld wrote:
> On Fri, Dec 16, 2022 at 06:42:25PM +0100, Gert Doering wrote:
> > Acked-by: Gert Doering <gert@...1296...>
> >=20
> > Have not tested beyond "we agreed on that, message looks good,
> > and it compiles".
> >=20
> > Your patch has been applied to the master and release/2.6 branch.
>=20
> Just noticed that this is missing a corresponding Changes.rst change.
> Should I send a patch for that?

Our handling of Changes.rst is not always consistent - somtimes patches
bring that along, for the rest I try to make sense of "git log" when
preparing the next release and add what is missing to Changes.rst.

So, I don't think we need an extra patch for this, will cover when
preparing _beta3 / _rc1, whatever and whenever it will be... :-)

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--3vNXRDU0X9uZqo3e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjoFakAAoJEB2Cnv7KVigSfeQMAKrBWl7G82dcjACAKqSgwrUz
McRf++cLqdDRBvlBdtdKqwOjJkMmc49fhoR7j9QTWAWbVh/NDtr6X1P46EdQhHjU
acUR2Yyvm4wDpQ98JbT7pABHNUcYmBiDYcU2bFD84SxVrFHg8y7LX//z0ib9/Ob0
+uAu8dGZHpOAJfXQ/8Sg8Y7V3ANKvDsxlapeOM0FGkqfA6dhWUZCVaYoSfFea5FT
gsVKWz2ILWCsQdscrjE+odq4d3KSVz/19s+ceAx64XF0FVU5ll0Q4n+YkP1oiCQU
Rd1N+sMCCLjbPtG/BHhKzKwIr3ajp6pr1UayRQ1mXhD5eeCWlsy76tG7sIBwlmH9
Cu0kqYa0l5r9dMui+mcKdFwizPRpBC0fy5bHokMqqTbz+JoOXHiDHWSp7OOLmw6b
GoJXqaHiqICYKf6/3nQqVl4QT/ShtX+NIIWkisTYk+0DXC49p/g21IaHEMv/HZHt
DIQ43F4yrjOQMiPDfeniGx5cA8tqNxNrAB28bH9Gtg==
=kfo+
-----END PGP SIGNATURE-----

--3vNXRDU0X9uZqo3e--

