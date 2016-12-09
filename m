Date: Fri, 9 Dec 2016 22:54:50 +0100
From: Christian Hesse <list@...1798...>
Message-ID: <20161209225450.06ff8341@...1799...>
In-Reply-To: <5448e007-8871-9933-6f12-765d4c1a9e54@...2080...>
References: <20161129120559.5be3e4ad@...1799...>
	<20161129110716.3946-1-list@...1798...>
	<5448e007-8871-9933-6f12-765d4c1a9e54@...2080...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/Vy4G2N53hjdHrPa0mSkIPT7";
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

--Sig_/Vy4G2N53hjdHrPa0mSkIPT7
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

David Sommerseth <openvpn@...2080...> on Fri, 2016/12/09 22:37:
> On 29/11/16 12:07, Christian Hesse wrote:
> > From: Christian Hesse <mail@...1798...>
> >=20
> > Drop --with-plugindir, instead use an environment variable PLUGINDIR
> > to specify the plugin directory.
> >=20
> > This always defines PLUGIN_LIBDIR and enables plugin search path.
> >=20
> > Signed-off-by: Christian Hesse <mail@...1798...>
> > ---
> >  configure.ac            | 14 ++++++--------
> >  src/openvpn/Makefile.am |  3 ++-
> >  2 files changed, 8 insertions(+), 9 deletions(-)
> >=20
> > diff --git a/configure.ac b/configure.ac
> > index f4073d0..5fe652e 100644
> > --- a/configure.ac
> > +++ b/configure.ac
> > @@ -301,13 +301,12 @@ AC_ARG_WITH(
> >  	[with_crypto_library=3D"openssl"]
> >  )
> >=20=20
> > -AC_ARG_WITH(
> > -	[plugindir],
> > -	[AS_HELP_STRING([--with-plugindir], [plugin directory
> > @<:@default=3DLIBDIR/openvpn@:>@])],
> > -	,
> > -	[with_plugindir=3D"\$(libdir)/openvpn/plugins"]
> > -)
> > -
> > +AC_ARG_VAR([PLUGINDIR], [Path of plug-in directory
> > @<:@default=3DLIBDIR/openvpn/plugins@:>@]) +if test -n "${PLUGINDIR}"; =
then
> > +	plugindir=3D"${PLUGINDIR}"
> > +else
> > +	plugindir=3D"\${libdir}/openvpn/plugins"
> > +fi=20=20
>=20
> Finally had some time to dig into this one.  I like the idea here, I
> think it makes sense.  But I'm not sure ${libdir} is correct by default.
>  I think that should be /usr/local/lib64 by default on a 64bit system.
>=20
> My google-foo isn't helpful for me today ... This is somewhat related,
> especially towards the end of this doc page:
> <https://www.gnu.org/software/autoconf/manual/autoconf-2.69/html_node/Sit=
e-Defaults.html>
>=20
> But I believe there are better ways to do this.
>=20
> I haven't checked this in detail what happens with 'make install'.  We
> should ensure that the plug-ins we ship (./src/plugins) which are built
> are installed as well into this directory.

${libdir} is where plugins are installed to... That's why I choose it. ;)

Installing anything to $prefix/lib64/ does not make sense imho. Never.

32bit systems install to $prefix/lib/, 64bit system install to $prefix/lib/.
The only valid extra is $prefix/lib32/ for multilib on 64bit systemd.
--=20
main(a){char*c=3D/*    Schoene Gruesse                         */"B?IJj;MEH"
"CX:;",b;for(a/*    Best regards             my address:    */=3D0;b=3Dc[a+=
+];)
putchar(b-1/(/*    Chris            cc -ox -xc - && ./x    */b/42*2-3)*42);}

--Sig_/Vy4G2N53hjdHrPa0mSkIPT7
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXHmveYAHrRp+prOviUUh18yA9HYFAlhLKCoACgkQiUUh18yA
9HY0nQgA3itvqLD2yt+Fd1eew4yRLrcCwioKL4FJbEjqXdshOU+v38wNy71han7+
jDPbYnDndz2rUBboamaMFmRZlHEtj+wfgrd/fJQu+KkDZbvUpY6OWmdJyA+V+5Wj
SwtMWrqRvd9M8weLjPBTFCw/Si85x6+97EaxDDxPj8MCOGsI0StqK3mQt643fgRs
qEaDQMMnK9DsIYQVNdv6zCusbtTqO2d94hujkrZLNcAsXPlSp3ZGjTVNCoeyec+T
uofAy1GPlBYaNxKScfGSWK9YplNm4nrM4gjebPaL+6DtUEkZjQd0Xyu/GlfFJ3Ab
ci6+0ux/as3xB1p9rHKR9oAHOCC5AQ==
=sKhW
-----END PGP SIGNATURE-----

--Sig_/Vy4G2N53hjdHrPa0mSkIPT7--

