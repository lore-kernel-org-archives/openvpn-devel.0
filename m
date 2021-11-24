Date: Wed, 24 Nov 2021 16:40:55 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <YZ5dB7Im0c61YEsA@...1296...>
References: <20210922095756.1929-1-chipitsine@...277...>
 <4654662a-587a-ca90-6678-5c5ff71e9c66@...1227...>
 <CAGyAFMWXBpvo-mxOkNsFrYR9oB9MVRcFEQ6SBs7rP0A6LeNu6Q@...278...>
 <CAFHpkQECg=UVywGzXXBeA1V5R7M5zSr8QkCT=Mj7ThBFB5c+yg@...278...>
 <CAGyAFMVXK16xNkBDbsb_VTC9qrYSAWTxnc=iOXOzUBGH_LqPhw@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="kujcsmDfSJ3jGDAb"
Content-Disposition: inline
In-Reply-To: <CAGyAFMVXK16xNkBDbsb_VTC9qrYSAWTxnc=iOXOzUBGH_LqPhw@...278...>
Subject: Re: [Openvpn-devel] [PATCH v2] BUILD: enable CFG and Spectre
 mitigation for MSVC
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: ???????? ?????????????? <chipitsine@...277...>, Gert Doering <gert@...1296...>, Arne Schwabe <arne@...1227...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--kujcsmDfSJ3jGDAb
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Nov 24, 2021 at 04:21:38PM +0200, Lev Stipakov wrote:
> Since we're preparing the next 2.5 release, let's take this in. The
> performance numbers, reported in different thread, look good.

Yes, sir!

commit dab73f90983c929645c74f1c1c045e175d5ca2b6 (HEAD -> release/2.5)
Author: Ilya Shipitsin <chipitsine@...277...>
Date:   Wed Sep 22 14:57:55 2021 +0500

    BUILD: enable CFG and Spectre mitigation for MSVC
=20=20=20=20
    found by BinSkim
=20=20=20=20
    Signed-off-by: Ilya Shipitsin <chipitsine@...277...>
    Acked-by: Lev Stipakov <lstipakov@...277...>
    Message-Id: <20210922095756.1929-1-chipitsine@...277...>
    URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/m=
sg22870.html
    Signed-off-by: Gert Doering <gert@...1296...>
    (cherry picked from commit e80e36d75538abff0661b21392f541d946be6d29)


... totally untested, but this is all MSVC build stuff, not code change...

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--kujcsmDfSJ3jGDAb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJhnl0HAAoJEB2Cnv7KVigSTWEMAKtG+PymtVQEmryfUSbAMRdn
/2ObSzVSU2L083YG4Drgofzy6wXamEKIus1PhlKpJ+rblnZGSC2fFzZJdWm8tSPF
eO0hulj6slqOYujjW88ShH2sbfGaA6leppwiwxz0GaNN2nnXwjD5pAeGvnwNG9B9
pa1pWZp6WWu3q7sauKNffv3rjjhwWl9qQ7nqb4lqENsGxI/gY/3djVtW1JFvopfz
NSBcOBSHwZxj5OzhEPeIT3HA1/gZh4hqSD9F/g3UXDiyBUCMGNx/wvPZX5GT+lln
dLhAl0LtMYySYf1J7SX4CcMjFtbF2YlgmEqK48XFEqn7gSWGtXpDLT+pmEP6Abz5
Hkjk59I13+PE3nAgt62ZT8xMm60bd8xGDtj/iRrpnDtch9vBAfIKifXPOjuyNsUv
pMrsU1yuBf3pbqLQtaSod3mXMQD9hNJfYeteoIxeg+VOJCicVELjUKngVA90LXeD
RUOJGZzMV2XYe5GVRki9H6WqETZwl2SJH/CYfDyA5g==
=zDI0
-----END PGP SIGNATURE-----

--kujcsmDfSJ3jGDAb--

