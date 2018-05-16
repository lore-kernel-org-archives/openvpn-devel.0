Date: Wed, 16 May 2018 23:08:59 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180516210859.GR1207@...1296...>
References: <2f575943f32de2328843b3cec3286ca1@...2399...>
 <20180516121616.GO1207@...1296...>
 <e47e242be0df9e29aa850d658a52149b@...2399...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="hCenlVgnDQUGHXTR"
Content-Disposition: inline
In-Reply-To: <e47e242be0df9e29aa850d658a52149b@...2399...>
Subject: Re: [Openvpn-devel] Darwin tap ipv6 fix
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Scott Shambarger <devel@...2399...>
Cc: openvpn-devel@lists.sourceforge.net

--hCenlVgnDQUGHXTR
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, May 16, 2018 at 11:26:15AM -0700, Scott Shambarger via Openvpn-deve=
l wrote:
> On 2018-05-16 05:16, Gert Doering wrote:
> > This part will break routes that need to go over the LAN interface, not
> > over the tap interface - namely, the /128 that is installed if you
> > have overlapping v6-over-v6 setups (... if you have link-local next
> > hops).
>=20
> Are you sure it won't work? There's some code higher up in the function=20
> that appears to handle that case:
>=20
> #ifndef _WIN32
>      if (r6->iface !=3D NULL)              /* vpn server special route */
>      {
>          device =3D r6->iface;
>          if (!IN6_IS_ADDR_UNSPECIFIED(&r6->gateway) )
>          {
>              gateway_needed =3D true;
>          }
>      }

You might be right.

Need to look more closely at the whole #ifdef mess - and look at our
MacOS X buildslave, which seems to work just fine with the current code
in tap mode... but I might have managed (again) to build a test rig
that does not excercise all relevant code paths.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--hCenlVgnDQUGHXTR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJa/J3qAAoJEB2Cnv7KVigSpgoL/3pjuRJF3wxUMPecidcN3fDK
2CdcSFSr9JOz1c4R9SniOY6BkZvC/pKUwzCYgUh48GOpjhibwS+vT2cWcrns9rIC
o7hrE3GyW/LQUmW21WJTng8mSIMc36fxRqdn7BYtfPbJlAbkAs8W13LIJFRrQ9cu
90zlL/lFboA6vcGXzJYCh7OModNnuQ9C9LHNUx8Oq0bKiDSHkoCcr7MAKjIcQop7
sUYvrFTYUclNN4OczsLUQ0YiCumP8+eOmRZdxwQ1Acs06+ku0T3RuZ0EaZ/NldiY
sZLY6RmAalmsQMSwkspptJ4Fg7NkuzYCgxuOyKdeMbO2YiqS1pPmObx/OTdwGvLr
LCJzFSMXef6CR1ew0mqKN0mzw4QZNPFWzTiyvAU2nKPMljUHcHql0zhRa49aKmqb
HI0VBg7W0yCUWuvJOkzGs9PV3pOGxRtcoA+d5t9K9gY/dJzk+kIYy3wtxuFWACCi
AIwlEkCgjGT7qmwFXKqz4x5zenjWIazPYNlLGEHQ3A==
=+70p
-----END PGP SIGNATURE-----

--hCenlVgnDQUGHXTR--

