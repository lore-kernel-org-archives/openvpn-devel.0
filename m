Date: Sat, 5 Nov 2022 10:40:33 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y2YvkfZa8HC81e5N@...1296...>
References: <20221104090247.167-1-lstipakov@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="jjShnWjZG62cBT61"
Content-Disposition: inline
In-Reply-To: <20221104090247.167-1-lstipakov@...277...>
Subject: Re: [Openvpn-devel] [PATCH] win32: detect arm64 architecture and
 emulations
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net, Lev Stipakov <lev@...515...>

--jjShnWjZG62cBT61
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Nov 04, 2022 at 11:02:47AM +0200, Lev Stipakov wrote:
> From: Lev Stipakov <lev@...515...>
>=20
> Properly detect process architecture and
> machine architecture, including arm64.
>=20
> Print process architecture and, if machine
> architecture is different (we are running in
> emulation), print that too.

This looks generally good, so definitely a "feature ACK".

Do you have a set of installers available so we can ask for testers?=20=20
I can do win10+win11 on arm64, but would perfer if someone else would
do i386/amd64 win7/10/11/server* testing.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--jjShnWjZG62cBT61
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjZi+RAAoJEB2Cnv7KVigSn4QL/R2Ry0kGggoqCkgrjm+xU8Xx
rVzfrJwOa3iUhmhPN44AQ1s42FMghwgQNC7WKJEuiux02oLdZqISQB2drxn4ZsRv
J0t71YABi5mPK9SNqzh5NInxT/o71QfPEXnu7eV3aam0viwq50Q6QzgwZQ60J9tF
WpxEUqpLuBuuWilK3c9u1YOQYFGfG0JgxVVqeedGvUb2dLdNboQ4Zq9+Osbb4y+K
wl4Rexcu1O8PbWEbgevDuvE+PXghXRdHQaDgzivyovAMfmFtrzFBwdDDiEPJkac/
sddut5Z4pJjlyaGytRSK7vIcPXwKy1vhAK2/0Jpjh9qndeplE8k/FTIdeVcmW79d
98UbzWpUNkcsQcyZHJ3VtVl4asE+Ewf2ybLqwGJP/EBX3fbUmswYdp1edtJ9LsXW
ILlEHiyOxHSfqHF8Oh7czSF5blfwcZBGOTD5mJhvKB2GQuZF+IqdJoop8sLWnDS6
2bvao19CeG5H8BK1I1O8bzdGXGY4AQo5sfRSyDx05g==
=zg2e
-----END PGP SIGNATURE-----

--jjShnWjZG62cBT61--

