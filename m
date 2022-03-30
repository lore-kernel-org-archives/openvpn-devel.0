Date: Wed, 30 Mar 2022 13:57:07 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YkRFk80glGw62CWy@...1296...>
References: <20220329192934.1415-1-timo@...2669...>
 <0886f123-9243-f7df-347c-68b62c469675@...2080...>
 <1a4c7f58-16fb-b909-0b40-41f20390179b@...2080...>
 <8b9722eb-3282-dc1b-abbe-91cc37083af3@...2669...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="y2432ur4spPkEk9+"
Content-Disposition: inline
In-Reply-To: <8b9722eb-3282-dc1b-abbe-91cc37083af3@...2669...>
Subject: Re: [Openvpn-devel] [PATCH] Retain CAP_NET_ADMIN when dropping
 privileges
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Timo Rothenpieler <timo@...2669...>
Cc: David Sommerseth <openvpn@...2080...>, openvpn-devel@lists.sourceforge.net

--y2432ur4spPkEk9+
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Mar 30, 2022 at 01:31:24PM +0200, Timo Rothenpieler wrote:
> > It is possible to argue that sitnl does low-level calls to the kernel a=
s=20
> > well.=A0 But potential libraries had an API which was making everything=
=20
> > far more complex on the OpenVPN side.=A0 For libcap-ng at least, that i=
s=20
> > not the case; as the API it provides is pretty simple.
>=20
> Shouldn't caps support also be enabled when sitnl is in use?
> Given it also needs CAP_NET_ADMIN.

That was a misunderstanding.  David explained why we are not using a=20
library but directly talk to the netlink socket for SITNL.

And yes, we want CAP_NET_ADMIN for sitnl+--user as well ;-)

Thanks for your help on this,

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--y2432ur4spPkEk9+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJiREWTAAoJEB2Cnv7KVigSrqAMAKrcCHh4AveHPNWFqW7LX0Mt
/Clk+TO2RqmLuFIc+N/bFKR3IT8FMaKwT1AplgXccQk3g5AXcjuM4aFp7kPGvjxs
KFrQoyJW1yjOrnMKOldogBaURpRVZLbOebQdq5IgnZUan9q+s9tyB6NtMt6KXxJT
ztl/t45z5JWhldeBIZD/ynMSKdpYnygR2qhsDXeoZps80tmk5f+I7cLYuuM/oCQ4
XKHzp0lHrn7XK5CDY2/wdw/2ae1oc2duo6y0ghwYNaYp+6dbZeYdBIxrt7BuTqUM
XH69t4MMfZJrjySyvPD7X4/PyWRhpcNH82aATu7cDI5mwytowCQboIPPvKETRcbd
cyu0miHOn6TKngX4PVs65p+TiHD9GmGKfXOFPMkgzFGReNNm8MnropXsQPgWPA2z
jjdZb2UDpFbOBIhwOc1ja5Gwu0SVnCwDe2LyESGYupy7Ovx9Y7GfiHcFMKMFfkjx
eVbcHVEqeRutfqHZYB54igoRm9dp89D/Yrh3fK2Nhg==
=/yWy
-----END PGP SIGNATURE-----

--y2432ur4spPkEk9+--

