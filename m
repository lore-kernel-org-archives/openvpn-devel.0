Date: Fri, 24 Jul 2020 20:40:20 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200724184020.GJ1431@...1296...>
References: <20200724141445.302-1-lstipakov@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="2ZvXTcHwHcSyNK6L"
Content-Disposition: inline
In-Reply-To: <20200724141445.302-1-lstipakov@...277...>
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
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net, Lev Stipakov <lev@...515...>

--2ZvXTcHwHcSyNK6L
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jul 24, 2020 at 05:14:45PM +0300, Lev Stipakov wrote:
> From: Lev Stipakov <lev@...515...>
>=20
> Add manifest file to detect Windows versions greater than Windows 8.

NAK, this breaks Ubuntu/MinGW builds.  Actually, I think it breaks all=20
windows builds, if you build from tarballs (which the "generic" build does -
first, make dist, then, build from there).

You introduce an include to "openvpn.manifest", but this is not bundled,
so

i686-w64-mingw32-windres -DHAVE_CONFIG_H -I. -I../.. -I../../include  -I../=
../include -I../../src/compat -DWIN32_LEAN_AND_MEAN -DNTDDI_VERSION=3DNTDDI=
_VISTA -D_WIN32_WINNT=3D_WIN32_WINNT_VISTA -i "openvpn_win32_resources.rc" =
-o "openvpn_win32_resources.o"
i686-w64-mingw32-windres: can't open file `openvpn.manifest': No such file =
or directory
Makefile:933: recipe for target 'openvpn_win32_resources.o' failed
make[4]: *** [openvpn_win32_resources.o] Error 1
make[4]: *** Waiting for unfinished jobs....

And this is what breaks MinGW builds:

../../src/compat/compat-versionhelpers.h: In function 'IsWindows10OrGreater=
':
../../src/compat/compat-versionhelpers.h:101:45: error: '_WIN32_WINNT_WINTH=
RESHOLD' undeclared (first use in this function); did you mean '_WIN32_WINN=
T_WINBLUE'?
     return IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_WINTHRESHOLD), LO=
BYTE(_WIN32_WINNT_WINTHRESHOLD), 0);
                                             ^
../../src/compat/compat-versionhelpers.h:101:45: note: each undeclared iden=
tifier is reported only once for each function it appears in


possibly the _WIN32_WINNT_WINTHRESHOLD is missing on MinGW, at least the
version bundled with Ubuntu 18.04 (I've skimmed the headers, and it's
missing).


The rest of the code changes look good, and I have no idea what all the
XML files do - but those are relevant for MSVC, and you are the expert
on that ("if you say this is beneficial, I'll merge").

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--2ZvXTcHwHcSyNK6L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfGysUAAoJEB2Cnv7KVigSAXgMAI0xOi5MnjYQpAx2CPdNA21d
bwoSD3BBdgTrW8lTvr7mAPUP4fkfbaPtyATEhgEI0HZAkq17Fz1AXMnwXC2t4JwA
oNFveDPmVEsHWKz6P1YjSxH7Wu4KBdwMA2571dXXOvxpgse6AKMwX9suT/CHOKbi
geJoMimOLYKx9DAiSxtluaUqRStdZ9xyExFKxkDgoYNGoWk8eZn877mdpTc89tkR
TTS1LrrBlxvKK39Wa0LA3Abxk6e3trXxwiA1/YzMZ4v6Pp7vlN8tfujbAm0pRSwn
Kw9/vIO3uEp9aXS/ULaXtzKKYiP6CH/maWzkgF1GxGb/j5F6j8IEfSTXuksyFZL+
iZGNdowPcfEBE2fDMkqIl5cR+6Z9Sn0du/7PBZDCdozJuPXaQE2300JWqGJBFBUy
JWmYq7aRuNDH8WdzPeoGKif67xxNFLW8jARZHuKkz7xEtG4PSC1RFrlZUYM3Eos3
VGcbOqz/j9Urdr6DXc5VovUNAZ7C9a4IHbXETL0loA==
=tKvu
-----END PGP SIGNATURE-----

--2ZvXTcHwHcSyNK6L--

