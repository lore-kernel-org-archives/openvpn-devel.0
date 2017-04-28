From: Hubert Kario <hkario@...1347...>
Date: Sat, 29 Apr 2017 00:14:00 +0200
Message-ID: <2865913.JP0f70X5bG@...2232...>
In-Reply-To: <de60bac0-2491-44af-2a65-00654b14f55b@...2080...>
References: <CAKh=nwGz-NSEcSY9KhQ12gC1GNXP6XOBTEO3FdP8gyJN5VTggg@...278...>
	<de60bac0-2491-44af-2a65-00654b14f55b@...2080...>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2141465.tycXRiuii4";
	micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [Openvpn-devel] build against openssl 1.1.0
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--nextPart2141465.tycXRiuii4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Friday, 17 February 2017 18:18:27 CEST David Sommerseth wrote:
> On 17/02/17 17:35, Emmanuel Deloget wrote:
> > I understand that I'm the new guy in town, but can you allow me to
> > make the formal request to ditch OpenSSL 0.9.8, 1.0.0 and 1.0.1 and
> > require at least version 1.0.2?
>=20
> So to the RHEL releases and the OpenSSL versions.  RHEL 5 ships with
> openssl-0.9.8e.  Both RHEL 6 and RHEL 7 ships with openssl-1.0.1e.
>=20
> The way Red Hat releases works is that versions are close to never
> rebased, at least not core libraries such as OpenSSL.=20

Both core libraries and non-core libraries are rebased in RHEL. Case in poi=
nt,=20
RHEL 6 originally shipped with openssl-1.0.0[1].
But rebases to releases that are ABI incompatible happen only to packages t=
hat=20
are explicitly excluded[2] from ABI guarantee. OpenSSL is not one of such=20
packages. For obvious reasons, I hope.

> But Red Hat
> employs a lot of users to ensure all packages they distribute is secure
> and maintained.  That means that security and important bug fixes will
> be backported from newer OpenSSL releases to the openssl-1.0.1e
> baseline.  And this happens for the whole life cycle of each major releas=
e.

Correct[3].

> Sometimes even features are backported as well.

Unfortunately because RHEL-6 is currently in Production Phase 2, soon enter=
ing=20
Phase 3, providing new feature like openssl-1.0.2 would be an exception[4].

> But I have gotten
> fairly clear signals that TLSv1.3 from openssl-1.1 will not be
> backported, as the code has changed too much since the 1.0.1 baseline.
> But I would be surprised if a future RHEL 8 does not ship with openssl-1.=
1.x

Well, openssl-1.1.0 is already available for Fedora rawhide :)

(Hope I don't sound too much like a markedroid, but I appreciate the suppor=
t=20
for RHEL you provide so I wanted to let you know exactly where everything i=
s,=20
the least I can do)

 1 - http://vault.centos.org/6.0/os/x86_64/Packages/
openssl-1.0.0-4.el6.x86_64.rpm
 2 - https://access.redhat.com/articles/rhel-abi-compatibility
 3 - https://access.redhat.com/security/updates/backporting
 4 - https://access.redhat.com/support/policy/updates/errata
--=20
Regards,
Hubert Kario
Senior Quality Engineer, QE BaseOS Security team
Web: www.cz.redhat.com
Red Hat Czech s.r.o., Purky=C5=88ova 99/71, 612 45, Brno, Czech Republic=

--nextPart2141465.tycXRiuii4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJZA76oAAoJEJKo0bgB0vX1W8oP/i7m4DGS32Dp9XJQZEWzZUm3
l95CBzlxtaCSj4LkZNrG9K2L0lUrjk3JjAJOY9Hi2cYrVaodJJCxn/dE3GQZw+5/
RQHI033Rr66BxuSR+l31yBSWUu5Dbq0jNTdzJgPh25hbZn/tdltwGYe8IHFRVDm+
k9OIJOAPl0VzX4Tk1eiEBAJ4tq7axswhQbYxmDK5na5L4JbWN9KiNfRZf08QyWA2
lB2rIa57EjhG7VZLa93EW/Pi+C0WnCdqqGCaV/U4cRJsRuLpeQ2jiI23/xdAE573
hRB5GHbW4h8S1wtIipc9D+hxbLeipi0CTz9qFpYZsGQzrc/ZoNre6m/SPIiKguJL
qu48poKEb1e9+GrwnEszyD6Ua5l++XLxucbs9TsbTDQOuyNyowwzbtd/xzNcwigs
Nvgtiag6lsAONylBvVSkSxW/Z5qShSmCKfESoK7YMzfrDn4t8f8GNhhXL2FmeEei
NQmtAFKcJuxfDr1m35AdkoUVaTeaJGXyVHkijjSXZqvxk607vSm6noD3m5Zw8rnL
G4xnJc2SyghicyvWSCrv3QaYTO/bm07IqVUfoOMuWq/NpJwqmm70Bb7AbxCBkvm5
ZGeGHi+eJHXLK+F/GV/gRJ+kk2ddPy46gVA3wB9ph4OMRXJQuNVWzibUu49vmZHi
VHh6W8M6194jJNL/EqoV
=5hBa
-----END PGP SIGNATURE-----

--nextPart2141465.tycXRiuii4--


