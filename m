Date: Fri, 2 Feb 2024 19:19:19 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Zb0yJ60xhJdiKpot@...1296...>
References: <20240201123039.174176-1-frank@...2641...>
 <202402011928.411JSLjs077061@...2054...>
 <ZbzRl+enVP67Lcod@...2685...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="lmEYy+qHWpcIjCCv"
Content-Disposition: inline
In-Reply-To: <ZbzRl+enVP67Lcod@...2685...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: README.cmake.md: Document
 minimum required CMake version for --preset
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

--lmEYy+qHWpcIjCCv
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Feb 02, 2024 at 12:27:19PM +0100, Frank Lichtenheld wrote:
> On Thu, Feb 01, 2024 at 08:28:21PM +0100, Gert Doering wrote:
> > Makes sense (I did read the GH issue).
> >=20
> > Your patch has been applied to the master branch.
>=20
> I think it would make sense to apply this to release/2.6 as well, since
> that uses the same CMake build.

Done!

commit 9ec524613662989ab165d8ca507c2e0abffc3dff (HEAD -> release/2.6)
Author: Frank Lichtenheld <frank@...2641...>
Date:   Thu Feb 1 13:30:39 2024 +0100

    README.cmake.md: Document minimum required CMake version for --preset


gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--lmEYy+qHWpcIjCCv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJlvTInAAoJEB2Cnv7KVigSgvoMAKKed81NlwCRZ81v0Zptgsb2
nkIndIKpIbDGSoHjb7g94gHL8CNcmaHVoTZqKTU2316888CISaEmO/PmuBFqWMnK
4Sv9yhLAyMrhAcp3u5VgtiQ66sEA+fCmAgpDnqsSlVOkoNog1SGXoLt5YU2sUX06
TVgbqw+pxgU5aLQoFBhNpWrA+JbfgJf7qS5VgoFWCIqfyH38eWt+fBT3m2/b4Gkw
LoMM1U7mjBJu/7aC4L1yENtfj7iwlmemPrhHrahBu/uVGV4kuaVHanAEVHhOz/pX
TKjK9tLii7GxzI+Cm39guLmV8bNBHSvdtdrhom/D1ggvZxfyDbzgJ5hXiPX2BKLH
nsOhN9ETxEwnALbsURDFQxiscLLVlw4YhUJGAWyXdhonQSLUxtbPBFuMveFjLOUS
iFATBO1n7t00NlfTZ/PZ1Sh8PovYSLIQD6cCOYOcTxOnGIKElxhXUe/P1nfYGs5o
tklJmDy7pDTllISXOcMpmyyNDbh3IAMlJr0KNsibdA==
=F7Qu
-----END PGP SIGNATURE-----

--lmEYy+qHWpcIjCCv--

