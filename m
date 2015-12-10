Date: Thu, 10 Dec 2015 11:19:08 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20151210101908.GC24952@...1296...>
References: <5668A592.8080802@...2101...> <20151210083641.GZ24952@...1296...>
	<56694CC9.6020103@...2101...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T3xtKrNDT5m6cmz/"
Content-Disposition: inline
In-Reply-To: <56694CC9.6020103@...2101...>
Subject: Re: [Openvpn-devel] MSVC "parser stack overflow"
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gisle Vanem <gvanem@...2101...>
Cc: openvpn-devel@lists.sourceforge.net

--T3xtKrNDT5m6cmz/
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Dec 10, 2015 at 10:58:33AM +0100, Gisle Vanem wrote:
> Gert Doering wrote:
>=20
> > For the time being we just use a compiler that is not mainly a pain in =
the
> > back, solidly stuck in the last century before C99 - as in, none of the
> > core developers compile on windows, we all do cross-compilation with=20
> > mingw64 on Linux.
>=20
> Well, MSVC 2015 is pretty up-to-date WRT C99. So I think you should remove
> all the *.vcxproj and msvc-*.bat files to prevent more people getting
> the impression you care about Windows.

We provide a working build environment to make windows binaries.

We also provided working MSVC files that worked fine until Microsoft broke
their compiler - all older versions of MSVC can compile OpenVPN just fine
(we actually have quite a few commits in our tree to make compilation with
MSVC work, given it's non-support of this or that which works perfectly
well with gcc or clang).

But we're not going to invest large efforts into fixing something that
Microsoft broke.  If you find the magic option to increase their stack=20
size which needs to be added to the vcxproj file - we're happy to add
that, but the onus for "it breaks with MSVC" is on who wants that
environment.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--T3xtKrNDT5m6cmz/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVmlRm6kuBuNlUUl1AQIpsQP/eawSmdpExD3I8w9k3EOt6KxvdNx04xP8
+lj3YNIdfihhwcEbpdjoFWwnkuNPlYSkY8C90kg0ikTNMLkLE8zfhUJOTfaoGVv6
Bu0VAS7km+CFBUy2HdVz7HOJOUyKo8M8PEq8t3gQngbFSNBLKwPnuyMfIwdXYmY8
1xSQraxNz2w=
=/xmD
-----END PGP SIGNATURE-----

--T3xtKrNDT5m6cmz/--

