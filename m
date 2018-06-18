Date: Mon, 18 Jun 2018 22:56:10 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180618205610.GI57262@...1296...>
References: <42bafab6-9e6f-56b5-2c44-b449ec503ce7@...515...>
 <20180611075242.GF57262@...1296...>
 <bb55cab5-2523-b899-0ead-6f34886c4d2b@...515...>
 <DM5PR2101MB1112279487CBA7B6DE9A3ABDB0710@...2412...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Wd8eLvd86OzG0Ju4"
Content-Disposition: inline
In-Reply-To: <DM5PR2101MB1112279487CBA7B6DE9A3ABDB0710@...2412...>
Subject: Re: [Openvpn-devel] Regarding tap-windows6 driver signatures and
 driver distribution
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jon Kunkee <jkunkee@...2393...>
Cc: Samuli =?iso-8859-1?Q?Sepp=E4nen?= <samuli@...515...>, Gert Doering <gert@...1296...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--Wd8eLvd86OzG0Ju4
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Jun 18, 2018 at 08:27:31PM +0000, Jon Kunkee wrote:
> >> Our projected deadline for the next tap-windows6 release is June=20
> >> 20th.
>=20
> Is this still the target?=20

No, we moved it to (tentatively) June 27th.  There was some sort of
major outage of Samuli's Infrastructure which took too much time to
fix.

> How can I help with testing? My 'can I ping the appliance VM's VPN
> address' test doesn't feel very thorough at all.
>=20
> Is there a chance the ARM64 changes (NDIS 6.30+build+installer) will
> make it in? (Are we trying to get the MSI changes in for this release?)

The goal is to have the 3 ARM64 related PRs plus the version number PR
merged after a bit of smoketesting on other platforms - as in, Samuli=20
repairs his build environment, builds a driver with all these (plus
the security patch), gets it signed and distributed for testing on=20
Win7, Win10, possibly Server 2016.  If that all works, we merge=20
everything, bump the version number and do a "formal release".


Samuli can shed some more light on whether this is still doable, or
"more unexpected time wasting surprises" have happened...

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--Wd8eLvd86OzG0Ju4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJbKBxpAAoJEB2Cnv7KVigSOd4L+wRYRUXM6yxZab6CkT8l1eoz
CYaXRBEE2EmQE1wZKeEborr6c8SVe+tUDCUaIaDKKaVtXxhokhOAceyWCXISW31I
dbImlHe+zH2Y93ZWKTwZ3qcVrMsc4nG91xbH8clIQX0dh6qFrzLsqs1d+aXjgGiS
z8ifLKQkQvviHkC4+1BqXU3RI05i4t22GjGKCjJ52W6Yjp3IKCYN96zi8SJWh86o
8jfoLOQFXvkz4WY5Czltp4fNxHvvv3Fy0mOkMjla30ajGovu+PZK6SHSNzrHaGQ4
anyKbmP/02/ZJfglE/QpwJQphVi+BUi6v9kBxc07aFCqxlR8dRP0jS7hrcqcSx7Z
76z3Pgy/IFQyjv9P1c7re9fhxY30T9ETyzRZ0oDnSzPQBJzyauF2WfJ5NR1eG9Dd
U3OeCuGpg9qpD3O0pP6wGefMuYhBPXy+MmmLJnEIawtHxhR3nTj7hY9tEicZf9By
Q8piUvoe6LWzQ739JHv7EGuWBEh7Rx0ED9u1P1WoTg==
=iIkE
-----END PGP SIGNATURE-----

--Wd8eLvd86OzG0Ju4--

