MIME-Version: 1.0
References: <20200724141445.302-1-lstipakov@...277...>
 <20200724184020.GJ1431@...1296...>
In-Reply-To: <20200724184020.GJ1431@...1296...>
From: Lev Stipakov <lstipakov@...277...>
Date: Fri, 24 Jul 2020 22:34:17 +0300
Message-ID: <CAGyAFMXkD2LJ+z8hVo8DphZL2pJC77ABqVeHxtYzx6Pj9AsUxQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Improve Windows version detection with
 manifest
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, Lev Stipakov <lev@...515...>

Hm.. I tested mingw build (windows-nsis) on Ubuntu 19.04 and
everything worked fine.

That's because:

1) Ubuntu 19.04 probably has recent enough mingw with _WIN32_WINNT_WINTHRES=
HOLD

2) When I tested mingw build, I pointed source url to git repo, not to
tarball - that's why it worked.

That XML is required (no matter msvc or mingw) to tell Windows that
your app is Win10-aware and allows you
to use API which detects Windows >=3D 8.1

I'll send V2 with above issues fixed.

pe 24. hein=C3=A4k. 2020 klo 21.40 Gert Doering (gert@...1296...) kirjoitti:
>
> Hi,
>
> On Fri, Jul 24, 2020 at 05:14:45PM +0300, Lev Stipakov wrote:
> > From: Lev Stipakov <lev@...515...>
> >
> > Add manifest file to detect Windows versions greater than Windows 8.
>
> NAK, this breaks Ubuntu/MinGW builds.  Actually, I think it breaks all
> windows builds, if you build from tarballs (which the "generic" build doe=
s -
> first, make dist, then, build from there).
>
> You introduce an include to "openvpn.manifest", but this is not bundled,
> so
>
> i686-w64-mingw32-windres -DHAVE_CONFIG_H -I. -I../.. -I../../include  -I.=
./../include -I../../src/compat -DWIN32_LEAN_AND_MEAN -DNTDDI_VERSION=3DNTD=
DI_VISTA -D_WIN32_WINNT=3D_WIN32_WINNT_VISTA -i "openvpn_win32_resources.rc=
" -o "openvpn_win32_resources.o"
> i686-w64-mingw32-windres: can't open file `openvpn.manifest': No such fil=
e or directory
> Makefile:933: recipe for target 'openvpn_win32_resources.o' failed
> make[4]: *** [openvpn_win32_resources.o] Error 1
> make[4]: *** Waiting for unfinished jobs....
>
> And this is what breaks MinGW builds:
>
> ../../src/compat/compat-versionhelpers.h: In function 'IsWindows10OrGreat=
er':
> ../../src/compat/compat-versionhelpers.h:101:45: error: '_WIN32_WINNT_WIN=
THRESHOLD' undeclared (first use in this function); did you mean '_WIN32_WI=
NNT_WINBLUE'?
>      return IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_WINTHRESHOLD), =
LOBYTE(_WIN32_WINNT_WINTHRESHOLD), 0);
>                                              ^
> ../../src/compat/compat-versionhelpers.h:101:45: note: each undeclared id=
entifier is reported only once for each function it appears in
>
>
> possibly the _WIN32_WINNT_WINTHRESHOLD is missing on MinGW, at least the
> version bundled with Ubuntu 18.04 (I've skimmed the headers, and it's
> missing).
>
>
> The rest of the code changes look good, and I have no idea what all the
> XML files do - but those are relevant for MSVC, and you are the expert
> on that ("if you say this is beneficial, I'll merge").
>
> gert
>
> --
> "If was one thing all people took for granted, was conviction that if you
>  feed honest figures into a computer, honest figures come out. Never doub=
ted
>  it myself till I met a computer with a sense of humor."
>                              Robert A. Heinlein, The Moon is a Harsh Mist=
ress
>
> Gert Doering - Munich, Germany                             gert@...1296...



--=20
-Lev

