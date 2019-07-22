Date: Mon, 22 Jul 2019 20:57:20 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20190722185720.GJ1097@...1296...>
References: <20190218153129.3818-1-bengen@...2496...>
 <201907221854.x6MIsEvG010586@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="3DRm6T3aFkHkz+Qz"
Content-Disposition: inline
In-Reply-To: <201907221854.x6MIsEvG010586@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Do not set pkcs11-helper
 'safe fork mode'
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Hilko Bengen <bengen@...2496...>
Cc: openvpn-devel@lists.sourceforge.net

--3DRm6T3aFkHkz+Qz
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Jul 22, 2019 at 08:54:14PM +0200, Gert Doering wrote:
> Your patch has been applied to the master and release/2.4 branch (bugfix).
>=20
> Taking Steffan's comments on the list and AlonBL's comments in trac as
> ACK.  David had issues on CentOS, but this might have been a problematic
> version of pkcs11-helper - which should be tested, though.
>=20
> I have not really tested this as I have no pkcs11 test environment today
> (but since Steffan has, and this has been part of OpenVPN-NL for a while
> now, I assume it is good).
>=20
> commit 59e45a8bbc9084329c683730325bc5b676058e71 (master)
> commit 59e45a8bbc9084329c683730325bc5b676058e71 (release/2.4)

That was too fast.  release/2.4 is

commit 5fd3d1d58ef0e26616e34a9144d0c984cf435444 (release/2.4)

sorry for the noise.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--3DRm6T3aFkHkz+Qz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJdNgcPAAoJEB2Cnv7KVigSK9sMAKKv2We768g1445NiT64kR9v
o8fMT/IFo6mTjngXdASUitzwWr7LL/FnKduuMq9+ztuOllsRR/uwg+LZFo5ttDBl
bluL+NdWA2nXpsUtavzrXMYYcFNoyZ8Pnwi00ZGdkF+qh5MqoAwlIEQqE1HSLREw
qk0M4TH1HwgJYCUns6Z9IWwCu0o0W0nmw23bgJPV4KgsZNnApuuyjTr/tVXjGI75
BQs2uhe2re5M2HlcwqSR54AlSwbuLHS3bvyO6PqJ4kXAK0zpOQtEb1PoV9HPXvEZ
li2ndWILklm5Wa1+t/qMojuMZd+siyngQCk77Ze+w6Ptk/y5bLo12evjrBqRkmqj
DVFW50hPoxrogzD9nB8fzGYAQ6fWh+JjFO76qPsqt4gs5o8eaKp+qgpQ+nTUsv9h
/19usYisFO8cUDnj4sJ74sPqNKZw6AoibxM3zxsx4PyIGBEFrjtqF6Y+u5fCXPtt
ISu3pszrP2WSyVKj1pHV3BIOS6jDF1OdudO7NWfc9g==
=5M2d
-----END PGP SIGNATURE-----

--3DRm6T3aFkHkz+Qz--

