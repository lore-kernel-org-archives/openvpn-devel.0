Date: Sat, 10 Dec 2016 00:30:41 +0100
From: Christian Hesse <list@...1798...>
Message-ID: <20161210003041.7d711d7b@...1799...>
In-Reply-To: <fb1ab332-e444-64e1-73e0-3ef290299ab6@...2080...>
References: <20161129120559.5be3e4ad@...1799...>
	<20161129110716.3946-1-list@...1798...>
	<5448e007-8871-9933-6f12-765d4c1a9e54@...2080...>
	<20161209225450.06ff8341@...1799...>
	<fb1ab332-e444-64e1-73e0-3ef290299ab6@...2080...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/c=1SGo7Sosr/P/0TdoNyU86";
	protocol="application/pgp-signature"
Subject: Re: [Openvpn-devel] [PATCH 1/1] Clean up plugin path handling
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn@...2080...>
Cc: Christian Hesse <mail@...1798...>, openvpn-devel@lists.sourceforge.net

--Sig_/c=1SGo7Sosr/P/0TdoNyU86
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

David Sommerseth <openvpn@...2080...> on Fri, 2016/12/09 23:40:
> On 09/12/16 22:54, Christian Hesse wrote:
> > David Sommerseth <openvpn@...2080...> on Fri, 2016/12/09
> > 22:37:=20=20
> >> On 29/11/16 12:07, Christian Hesse wrote:=20=20
> >>> From: Christian Hesse <mail@...1798...>
> >>>
> >>> Drop --with-plugindir, instead use an environment variable PLUGINDIR
> >>> to specify the plugin directory.
> >>>
> >>> This always defines PLUGIN_LIBDIR and enables plugin search path.
> >>>
> >>> Signed-off-by: Christian Hesse <mail@...1798...>
> >>> ---
> >>>  configure.ac            | 14 ++++++--------
> >>>  src/openvpn/Makefile.am |  3 ++-
> >>>  2 files changed, 8 insertions(+), 9 deletions(-)
> >>>
> >>> diff --git a/configure.ac b/configure.ac
> >>> index f4073d0..5fe652e 100644
> >>> --- a/configure.ac
> >>> +++ b/configure.ac
> >>> @@ -301,13 +301,12 @@ AC_ARG_WITH(
> >>>  	[with_crypto_library=3D"openssl"]
> >>>  )
> >>>=20=20
> >>> -AC_ARG_WITH(
> >>> -	[plugindir],
> >>> -	[AS_HELP_STRING([--with-plugindir], [plugin directory
> >>> @<:@default=3DLIBDIR/openvpn@:>@])],
> >>> -	,
> >>> -	[with_plugindir=3D"\$(libdir)/openvpn/plugins"]
> >>> -)
> >>> -
> >>> +AC_ARG_VAR([PLUGINDIR], [Path of plug-in directory
> >>> @<:@default=3DLIBDIR/openvpn/plugins@:>@]) +if test -n "${PLUGINDIR}";
> >>> then
> >>> +	plugindir=3D"${PLUGINDIR}"
> >>> +else
> >>> +	plugindir=3D"\${libdir}/openvpn/plugins"
> >>> +fi=20=20=20=20
> >>
> >> Finally had some time to dig into this one.  I like the idea here, I
> >> think it makes sense.  But I'm not sure ${libdir} is correct by defaul=
t.
> >>  I think that should be /usr/local/lib64 by default on a 64bit system.
> >>
> >> My google-foo isn't helpful for me today ... This is somewhat related,
> >> especially towards the end of this doc page:
> >> <https://www.gnu.org/software/autoconf/manual/autoconf-2.69/html_node/=
Site-Defaults.html>
> >>
> >> But I believe there are better ways to do this.
> >>
> >> I haven't checked this in detail what happens with 'make install'.  We
> >> should ensure that the plug-ins we ship (./src/plugins) which are built
> >> are installed as well into this directory.=20=20
> >=20
> > ${libdir} is where plugins are installed to... That's why I choose it. =
;)
> >=20
> > Installing anything to $prefix/lib64/ does not make sense imho. Never.=
=20=20
>=20
> Well, that is the default for Fedora/RHEL families.  32bit systems uses
> /usr/lib, 64bit uses /usr/lib64.
>=20
> $ uname -m
> x86_64
> $ cat /etc/redhat-release
> Red Hat Enterprise Linux Server release 7.3 (Maipo)
> $ rpm --eval '%{_libdir}'
> /usr/lib64
>=20
> I've tested this on Fedora 24 and Scientific Linux 6 and 7 as well, with
> the same result.
>=20
> And you'll find the same in openSUSE too:
> <https://en.opensuse.org/openSUSE:Packaging_Conventions_RPM_Macros#.25_li=
b>
>=20
> Unless it has changed in Debian/Ubuntu, it is a similar policy there too.

Uh, interesting... Probably I did not look at these distributions for too
long... (And/or relied on the package manager.)

For Arch Linux we use /usr/lib/, though /usr/lib64/ is provided by a symlink
to lib nowadays.
--=20
main(a){char*c=3D/*    Schoene Gruesse                         */"B?IJj;MEH"
"CX:;",b;for(a/*    Best regards             my address:    */=3D0;b=3Dc[a+=
+];)
putchar(b-1/(/*    Chris            cc -ox -xc - && ./x    */b/42*2-3)*42);}

--Sig_/c=1SGo7Sosr/P/0TdoNyU86
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXHmveYAHrRp+prOviUUh18yA9HYFAlhLPqEACgkQiUUh18yA
9HZZLwf/W/h5Xuk8XyalBcaVoid3YJ15Kv58HOxVjUbD7xl0cHwBsWZbkojHybFR
8c8fHC14x0Z3PVyVbu0Vt2Ri5Un01jxgrO5vxgj4qvvGd/wElsSDxH8v/QwVgLxY
Rjb9rE490XEhFzytESkxeL0sdvRTy8kp2O6Fkc47hIWAAmYiSp4yMlxMu+sRhA64
3INOSf3sGC7FML6LWzceFxpk8b96Wxat+ICerE1g/3vOsFBmCsT4SkobC06UgpyF
ajCEnZQsygvWBq9s+hgq/S6Rr306VelcXTg23QjYCEN6VB/zldCaTgoGGYxGlLKl
NSb/rR+jcFRrwpVl8fLFOJDkJUawWA==
=Uwb7
-----END PGP SIGNATURE-----

--Sig_/c=1SGo7Sosr/P/0TdoNyU86--

