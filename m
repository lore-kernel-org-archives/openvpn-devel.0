Date: Thu, 25 Feb 2016 13:57:42 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20160225125742.GA21087@...1296...>
References: <1455937988-12414-1-git-send-email-selva.nair@...277...>
	<201602251201.u1PC1qiO020709@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline
In-Reply-To: <201602251201.u1PC1qiO020709@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Restrict options/configs
 for startup through interactive service
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Feb 25, 2016 at 01:01:52PM +0100, Gert Doering wrote:
> ACK.  Needed functionality, and the implementation looks good to me
> (I wouldn't mind more closed scrutiny by one of the more experienced
> windows programmers, but since they are all too busy, my reading of
> the code will have to do).  I fixed one typo ("Retrurns") in a comment.
>=20
> Your patch has been applied to the master branch.

Mmmh.  It breaks compilation on Samuli's buildbot...

/bin/bash ../../libtool  --tag=3DCC   --mode=3Dlink i686-w64-mingw32-gcc -m=
unicode -D_UNICODE -UNTDDI_VERSION -U_WIN32_WINNT -D_WIN32_WINNT=3D_WIN32_W=
INNT_VISTA    -o openvpnserv.exe openvpnserv-common.o openvpnserv-automatic=
.o openvpnserv-interactive.o openvpnserv-service.o openvpnserv-validate.o o=
penvpnserv_resources.o -ladvapi32 -luserenv -liphlpapi -lshlwapi -lnetapi32=
 -lws2_32=20
libtool: link: i686-w64-mingw32-gcc -municode -D_UNICODE -UNTDDI_VERSION -U=
_WIN32_WINNT -D_WIN32_WINNT=3D_WIN32_WINNT_VISTA -o .libs/openvpnserv.exe o=
penvpnserv-common.o openvpnserv-automatic.o openvpnserv-interactive.o openv=
pnserv-service.o openvpnserv-validate.o openvpnserv_resources.o  -ladvapi32=
 -luserenv -liphlpapi -lshlwapi -lnetapi32 -lws2_32
openvpnserv-validate.o:validate.c:(.text+0x54): undefined reference to `Pat=
hIsRelativeW'
openvpnserv-validate.o:validate.c:(.text+0x31f): undefined reference to `Ne=
tApiBufferFree'

the microsoft documentation says, PathIsRelativeW() is in "Shlwapi.dll",
and I can see the link line pulling that in...  "NetApiBufferFree()" is
in "Netapi32.dll", and that is *also* linked...

I'm a bit at a loss why it is bombing here...

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVs76RakuBuNlUUl1AQKh+gP/URwZdotmqa1QG1c82zrLmaoK0uqDZ2vF
ZeF26DzUoO+Zyrt2zRIHNDjDxFMMAlbjEV3IitWpocQIm6N9jgtuEmh0wQ+4/gvV
rQVRwx/jJ2yHTtE1q7yX+mvKqZxG3vaSbWzM0jXLAxBSbIFBHVo+H3uQ5wOTTClT
5A6VTkz2bHQ=
=QQt7
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--

