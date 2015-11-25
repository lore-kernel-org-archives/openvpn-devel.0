Date: Wed, 25 Nov 2015 08:57:24 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20151125075724.GS24952@...1296...>
References: <564BA6DB.4070703@...2070...>
	<564DE8B3.9030803@...2070...>
	<20151124083944.GY24952@...1296...>
	<5654A314.3080607@...2070...>
	<20151124201135.GM24952@...1296...>
	<CAKuzo_jdcOjunyVmpT8er3HqWG7yh6pr+i8Tn8kD3omj=G_Pqw@...278...>
	<565547AB.9030607@...2070...>
	<CAKuzo_j6LMPKAkLDpJWiMLCerZ5ORhheUXNPhyRsbEqC6jZaEg@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SAeLYP8kwBCGlqB7"
Content-Disposition: inline
In-Reply-To: <CAKuzo_j6LMPKAkLDpJWiMLCerZ5ORhheUXNPhyRsbEqC6jZaEg@...278...>
Subject: Re: [Openvpn-devel] [PATCH v4-master] Add Windows DNS Leak fix
 using WFP ('block-outside-dns')
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--SAeLYP8kwBCGlqB7
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Nov 25, 2015 at 01:32:38AM -0500, Selva Nair wrote:
> On Wed, Nov 25, 2015 at 12:31 AM, ValdikSS <iam@...2070...> wrote:
>=20
> > It's cron2 who wanted clear ifdefs for master, because there's no WinXP
> > support there.
>=20
> If WinXP support is really going away in 2.4,=20

It already is - the GetBestRoute2() stuff is not available on XP, and since
we decide long ago that we'll stop XP support in 2.4 if it becomes too
painful, this was the point of no return.

Theoretically, this could be handled at runtime (try to open the right
library and find the symbol, and if the library is not there, just disable
the functionality) but this is something we did not consider important - we
do not care about XP in 2.4, period :-)

If someone really *really* cares about XP support in 2.4 and submits clean
patches that do not cause extra build work for Samuli, we might reconsider
- but hey, XP is really dead (and who wants XP can still just stick to 2.3.x
which we'll continue supporting for a while)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--SAeLYP8kwBCGlqB7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVlVp46kuBuNlUUl1AQK8awQAnZBJ+gNjLMQ5iFR4Ss6+9B7pELkdod2r
VbqCUu3QqSGT/Zo1VWqgG1BIyJkBE85iyW+jTIdMcjXtA+f7poai0lY/5Bni6zyP
0hkFSjIe96kVKSuY3o7pHCpyu59yjP5qDLHYN+zF3PHL8Oow2Dh3CgVnHcOvsf/A
XkpgjribYxw=
=TH2q
-----END PGP SIGNATURE-----

--SAeLYP8kwBCGlqB7--

