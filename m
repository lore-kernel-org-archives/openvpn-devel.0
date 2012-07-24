Date: Tue, 24 Jul 2012 18:11:37 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120724161137.GC2535@...1296...>
References: <CAO5YuCXYLusXiOcqFXF0Ni77b73Z+XTKsE_JpBrN45bTiMfdHQ@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
In-Reply-To: <CAO5YuCXYLusXiOcqFXF0Ni77b73Z+XTKsE_JpBrN45bTiMfdHQ@...278...>
Subject: Re: [Openvpn-devel] Windows building error
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: jay alco <jproxy22@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jul 24, 2012 at 11:50:36PM +0800, jay alco wrote:
> I'm trying to build openvpn on windows with mingw but having trouble.
> I tried building both openvpn 2.1.4 and 2.2.2 from source without
> changing configuration, just executing domake-win and it builds the
> exe perfectly. But when i change configurations in makeopenvpn file i
> cause me the error.

2.3_alpha2 contains a completely rewritten build system, which eases
building windows binary enormously (cross-build on linux using mingw64).

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBUA7JOakuBuNlUUl1AQLlMAP8CYK5gWtGncaoYZEe9FOBqGvsbgsKeu8G
PDAd0hTtxJnePJi4+gvFJk/V+3xxFmTpaHIoD0Flc05t/S4DrF/uG+KeRjoham3V
H9nbTFQCiIX6E4tVImmb+1nhnenxegkAFt2DB3znru5zlFrjCmLXnmenobIoD+3J
L87gZ6uBAPk=
=fIAI
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--

