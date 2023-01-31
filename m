Date: Tue, 31 Jan 2023 17:16:36 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y9k+5C6kTwXF3O9A@...1296...>
References: <20221130205718.79765-1-gert@...1296...>
 <20221229072746.19169-1-themiron@...2010...>
 <Y73EuV4BJLLcg7WU@...1296...>
 <CAK5QT=ykkPXnOOktChAx5GZRSLpFWe7Wuhh_z+qUXr-FiXrv7g@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="GHMDjrJPos2Jrtex"
Content-Disposition: inline
In-Reply-To: <CAK5QT=ykkPXnOOktChAx5GZRSLpFWe7Wuhh_z+qUXr-FiXrv7g@...278...>
Subject: Re: [Openvpn-devel] [PATCH v15] Add DNS SRV remote host discovery
 support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Vladislav Grishenko <themiron.ru@...277...>
Cc: Gert Doering <gert@...1296...>, Vladislav Grishenko <themiron@...2010...>, openvpn-devel@lists.sourceforge.net

--GHMDjrJPos2Jrtex
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Jan 11, 2023 at 01:42:31AM +0500, Vladislav Grishenko wrote:
> Hi, sure, will do.
> Yes, I???ve noticed undesired code dup in v14 and have fixed everything f=
ound
> in v15 rebase, same will be rechecked in v16 of course.

Did you find time to have a look into this?

2.6.0 is out, but since there is demand for the SRV patch, we've agreed
to do an exceptional feature merge for 2.6.1 for SRV and dynamic tls-crypt
- but that means "we need to have a fully reviewed v16"...

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--GHMDjrJPos2Jrtex
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJj2T7kAAoJEB2Cnv7KVigSx+QL/2116KHcvVqgaScfu2N5Mx8R
zXeI2Yt/iuEcadRE7E7J1UF5e0poYUc99JoC3EshYeteF2eJpUfdVBxvwm6r+brC
ttFkKyvCoczZBioaKKz/hjGZoKGnddRUQ6g8seBoOBMkBx8eoqV52CsxXEpFUyKo
8qtNzVnRPAd9dXCA77cmPhl2T6kvqMoSHqxsVZiXDK221lt2VQKL8yHg1vj3/eMg
N9WsmVvaAGFDUCS2W/bEKUKW58MPYDBFFdFQ2ATPV/VeRSMZXBSJQJmTtr5QtyiS
cSNdfiUvS4cEHAeA/NloFm0JNz5DhKGWrpEqL6esDs7Bg/YI1HfY8PDCF15J+64k
x3PYPjNsyCxTkoDKfgAhjpkLWa/0kQjU789MAIxknu7RK93fmqdrjkdg9R4fm5eT
w1qauTavTCtPBep+BG/65k2+osNiXsZG+Ft3Vvzlp37T232Jx9T/CkyZywMycJoY
HamM3+zGbuRoJYR+UNjK+SbMGWiSKIBLNSFA78VwnA==
=r7RT
-----END PGP SIGNATURE-----

--GHMDjrJPos2Jrtex--

