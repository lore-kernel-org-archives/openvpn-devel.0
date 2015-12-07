Date: Mon, 7 Dec 2015 16:47:40 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20151207154740.GD24952@...1296...>
References: <1449446507-16654-1-git-send-email-selva.nair@...277...>
	<20151207071641.GR24952@...1296...>
	<CAKuzo_iriPYgazMiq=FKwvYbvVE39t9X8zheKP4PqOVwbtjQ7Q@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vimm9O0gM1Jj7bTP"
Content-Disposition: inline
In-Reply-To: <CAKuzo_iriPYgazMiq=FKwvYbvVE39t9X8zheKP4PqOVwbtjQ7Q@...278...>
Subject: Re: [Openvpn-devel] [PATCH master] Add an autoconf macro to check
 WINAPI functions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--vimm9O0gM1Jj7bTP
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Dec 07, 2015 at 10:31:39AM -0500, Selva Nair wrote:
> > This looks interesting, but I'm not convinced that this actually *works=
* -
> > the reason why I had to add an explicit compile test is that the standa=
rd
> > configure.ac test will claim "inet_pton is not there" because the way
> > the test program is built conflicts with the definitions in wstcpip.h
> >
>=20
> I saw that commit in master after I wrote the macro. The commit works wel=
l,
> but a macro makes it scalable. There is no reason to force define HAVE_PO=
LL
> in windows when it doesn't really have poll etc.. Not that it matters in =
the
> current code..
>=20
> Why AC_CHECK_FUNC doesnt detect inet_ntop or many other winsock functions
> is because
> (i) the function name is redefined in the header (inet_ntop is actually
> InetNtopA in the librray)
> (ii) declared as stdcall.

Understood :-)

> AC_CHECK_FUNC essentially does
> char symbol();
> main() { (void) symbol(); return}

... and that totally blows up here, for multiple reasons...  the include
file is not there, so the redefinition does not apply and the library
indeed does not have inet_ntop() - and if you add <ws2tcpip.h>, it will
still blow up because it now redefines the prototype...

> AC_CHECK_DECL would detect inet_pton etc., because it only looks for the
> declaration in a header. The macro I submitted works almost exactly like
> AC_CHECK_DECL but defines HAVE_symbol instead of HAVE_DECL_symbol.

Not good enough.  I want to be sure that the symbol is there, and that
we actually have the right libraries (so maybe a double check "the symbol
is there, but we cannot link, so fail" might be even better).

> > Which environments did you test this on?  It needs to work on mingw as
> I use debian jessie, but it should work elsewhere.
>=20
> > shipped with ubuntu 12.04 (no inet_pton), mingw as shipped with 14.04
> > (inet_pton, *and* the definition its using conflicts with our compat/
> > libraries, so a false negative will fail later) and cygwin.

Well, the reason why I pointed out these two is that they are different
regarding header file brokenness - I'm not sure I remember the details,=20
but stuff that broke for me on 12.04 worked for samuli on 14.04.

It's not like unix where stuff like this just works :-)

> > It's not pretty, but it's the way it is for a reason :-)
> >
> > > +          [AC_TRY_COMPILE([#include <$2>], [(void) $1;],
> >
> > This is wrong on multiple levels, actually
> >
>=20
> Its the AC_CHECK_DECL way of testing for a symbol. One could replace the
> COMPILE with a LINk and it will still work, though that doesn't test
> anything more than the copile in this case.
>=20
> Note that its not (void) $1(), its just (void) $1.

So it's building a test program that does this?

#include <ws2tcpip.h>
main()
{
  (void) inet_ntop;
}

... which shouldn't compile at all...?

> If you prefer I can rewrite the macro completely in terms of AC_CHECK_DECL

Convince me that it improves things :-)

Right now, it makes stuff *less* clear to the autoconf-non-enlightened,
like me.  I do understand the check that we have no, I do not understand
your stuff (quite obvious from my dumb questions)...

(I agree that we shouldn't force-define HAVE_POLL if we don't use that
stuff on windows at all - so I'm happy to see such things just go out...)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--vimm9O0gM1Jj7bTP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVmWqG6kuBuNlUUl1AQL6QAQAkZUEFmthKIc8IE1o1uTgQpPE1/VpljG1
5lOxxzXrdjflF6u7oKYq52PebgZBxBORrbId7TPdZeGsiEDAYG8Xlr11ND0icNWJ
qPciLcXm0MxyBg6A+I0ZpG5xHQONBt1fBcRThuKO92bOhMDx7IVuocorcMEQ3SBn
IXJtW4980hk=
=/z3l
-----END PGP SIGNATURE-----

--vimm9O0gM1Jj7bTP--

