Date: Thu, 17 Mar 2022 11:47:33 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <YjMRxbebLJLUl5Du@...1296...>
References: <20220316080912.118-1-lstipakov@...277...>
 <202203160839.22G8dfkY031659@...2054...>
 <1592362800.422327.1647422977914@...2642...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="ViU3/EEwYYZq2Nfx"
Content-Disposition: inline
In-Reply-To: <1592362800.422327.1647422977914@...2642...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: vcpkg-ports: add openssl
 1.1.1n
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Frank Lichtenheld <frank@...2641...>
Cc: Gert Doering <gert@...1296...>, Lev Stipakov <lev@...515...>, openvpn-devel@lists.sourceforge.net

--ViU3/EEwYYZq2Nfx
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Mar 16, 2022 at 10:29:37AM +0100, Frank Lichtenheld wrote:
> > As discussed on IRC, we need to build with the new security-fixed 1.1.1n
> > release, and vcpkg port is not there yet.  Somewhat annoying, we should=
=20
> > find a better way to decouple "build" and "openvpn main repo" commits...
>=20
> We could always move the whole contrib/vcpkg-ports directory to a separate
> repository, right? Or is there a strong technical reason why this should =
be
> in the main repository?

Just for the sake of the archives - this is what we discussed in the
meeting yesterday, and the plan is

 - "building openvpn should be possible from the openvpn repo, without
    any extra submodules either way" - but will give the person building
    the vcpkg default packages (like, 1.1.1m yesterday)

 - "for release building", we add whatever is needed to the openvpn-build
   repo, to do "take openvpn repo, add vcpkg port overlays for newer=20
   versions etc." and build from there

so this patch will go away again, in the not so distant future.

(Thanks, Lev, for all the work on this)

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--ViU3/EEwYYZq2Nfx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJiMxHFAAoJEB2Cnv7KVigSWgoL/i49S7Cr6FRhJM6qurs50xOD
CesbakjO6LPNdcpyB5QPFXl9pkK3mYFq4GiQM/DGWrEd4qC1mG6rXX9WR23zOHey
UD8q0+xJ3hlJvib1sbnJOXLla8egngERMVtykoevykz/1Uy+XD62EGLn75rSN4K1
1weFb3G2dOoAAWqne2cp6/+qZN23R2FGf0e2w0QAMNyuKEsmCsxuSt0re9tEPKdd
PnVirZ8bIeE0gDBJkaFCw3MOfyGLeaiye75QQzlYbFj8IiICWV8jv0OVC0zLYIVH
3frB9HgEZhljSQ9uefX0nFQyEod+ph8DTLpNqhMqCjeQq6LccXdVnLm/Tvd5gCL8
SjQqXSyPM2/QFjvecWocxZi0ynPCdUnSOylIqU8nzBN+M5PQN5/zBm8ovPyNAKIf
QjGRkea8Z+CxFs6mHcLrvrl4kIzS+XLS0uCnPaaeASnnFtDeOgTlXGKoa/PGPwq7
4Mk8eu23xaR/d3FfqNPLguqOvfT3CdQNnNGoEqQ8ag==
=7hGq
-----END PGP SIGNATURE-----

--ViU3/EEwYYZq2Nfx--

