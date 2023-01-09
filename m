Date: Mon, 9 Jan 2023 12:52:05 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y7v/5VUW6S9+Pb8a@...1296...>
References: <20230105022718.1641751-2-selva.nair@...277...>
 <20230106150412.1667492-1-selva.nair@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="rOnlFfcPBu6Uk9ow"
Content-Disposition: inline
In-Reply-To: <20230106150412.1667492-1-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH v2 2/3] Distinguish route addition
 errors from route already exists
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

--rOnlFfcPBu6Uk9ow
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jan 06, 2023 at 10:04:12AM -0500, selva.nair@...277... wrote:
> Note:
> net_route_v4/v6_add using netlink filters out EEXIST before returning
> this looks like a bug as add_route() and add_route_ipv6() should set
> RT_ADDED only if route was really added.

Actually we do have a Trac ticket that might be related to this
somewhere, about multiple instances of OpenVPN messing each other's
routing that way...  maybe it's that very issue, maybe not.  But worth
having a very close look.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--rOnlFfcPBu6Uk9ow
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJju//lAAoJEB2Cnv7KVigSZmQL/RXbplkcssOKFpH/MWl/hHPk
uVFDnshHNcICikylLEeD/JoJhZGgbnHDxGpU5e3eKaZ6VkXpW+JJs0a82MJ6+Zrr
PALDxNggbdHt9sXd6rSnJj2DSTOUisYOQc8fn2JV70UzahWYccXQDboffq/rKefI
PhZN7JDq+bDnT1qhlfigZ076gdhDBGrQgqEBCX4rcKqoTxoH9Zfr1LrXI7Ou3eEN
uZMC0tcG5M2rYnksmVig8W2I/n66KK1CfcXeut+ZNcBdZGQR6/rutgE12yd5FOU0
SEFg/CXg8XmiWbfq/QXdL2Ex4f3/q+uf+EqESNuK4CQXEKK/NAovrHHTWIjMTi0k
lGI1Mp6erraO+uqoXfeWTMkFUAPNiTZPXm+jJWb9dUuII/liJ85xhG19BXTbA6Vu
urG8B1mNZ0hl7YanjCanN+DwXRznfWhsya62b9aJbF+YpGuc67roAxbnt4E++jWq
81KNaLvmpbyE9XPf88tqHtnksAj8Z42+VhlesIF9BQ==
=aWNf
-----END PGP SIGNATURE-----

--rOnlFfcPBu6Uk9ow--

