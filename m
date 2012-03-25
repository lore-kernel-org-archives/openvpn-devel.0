Date: Sun, 25 Mar 2012 13:12:20 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120325111220.GH1359@...1296...>
References: <1332616557-15727-1-git-send-email-alon.barlev@...277...>
	<CAOazyz3p-pZ=Sbmomnr2b9431hFxsxjte_P7ucSCAA4gJBpC_Q@...278...>
	<CAP+U6tKTRJ8ybhd9xgyZrj0vDXPFAk+=r=Ai46sUjDsio3bsgw@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PMnBCHLB6K0Tl81y"
Content-Disposition: inline
In-Reply-To: <CAP+U6tKTRJ8ybhd9xgyZrj0vDXPFAk+=r=Ai46sUjDsio3bsgw@...278...>
Subject: Re: [Openvpn-devel] [PATCH] build: rename bool->obool
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Fabian Knittel <fabian.knittel@...1547...>
Cc: Alon Bar-Lev <alon.barlev@...277...>, Openvpn-devel@lists.sourceforge.net

--PMnBCHLB6K0Tl81y
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Mar 25, 2012 at 12:51:55PM +0200, Fabian Knittel wrote:
> 2012/3/24 Alon Bar-Lev <alon.barlev@...277...>:
> > On Sat, Mar 24, 2012 at 9:15 PM, Alon Bar-Lev <alon.barlev@...277...> w=
rote:
> >> PPC architectures and conflict with stdbool.h.
> >>
> >> basic.h defines a type 'bool' that conflicts with the altivec
> >> keyword bool which has to be fixed upstream, see bugs[1][2].
> >>
> >> [1] https://bugs.gentoo.org/show_bug.cgi?id=3D293840
> >> [2] https://bugs.gentoo.org/show_bug.cgi?id=3D297854
>=20
> The approach attempted in [2], using stdbool.h, looks far less
> intrusive than renaming "bool" to "obool" everywhere, so why did you
> choose the latter approach? Jan Scholz's comment #6 [3] sounds like
> the right approach to me ...

The problem is that stdbool.h seems to define a data type that is not
necessarily what the rest of OpenVPN expects (structure sizes etc),
which is also mentioned in these two bug reports - read: it will *break*
OpenVPN, or at least the plugin interface.  So moving to stdbool.h
would require careful analysis of every single usage of "bool" to see
whether this is really only doing "boolean" stuff, or whether there's
other issues lurking here (causing the breakage David noticed in [2]).


Personally I think that this is a regression in GCC, and we should NOT
do anything about it.  If the compiler is documented to have a new
data type "bool__", it should not mess with "bool", which is a different
name by all means - bad enough that we have to jump through hoops to
care for MSVC, but that's at least a mainstream platform, as opposed
to "PPC with a specific compiler option (-maltivec)".

But I'm not insisting on this either way.  This is personal optionion,
and stuff like that is close to coding style and religion anyway.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--PMnBCHLB6K0Tl81y
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBT279lKkuBuNlUUl1AQIvsQP/XCPzVbgHj1i/LPRT34Y66x4SeUMauKG+
u2MPxG1mwYQcbkejpiu51K5tqoTfNa9uv8IZWrAF0zBqIAv5M/H+ES6xHJeuwXqK
rAFcoF8F/HFlBXJAXF4z848DsKvZ/h3QnGe4BXJJCEHU1XLecXBuUo2dUsfTHXQn
F2NROndOnBU=
=nATG
-----END PGP SIGNATURE-----

--PMnBCHLB6K0Tl81y--

