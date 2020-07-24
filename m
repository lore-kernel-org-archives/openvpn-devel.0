Date: Fri, 24 Jul 2020 21:40:53 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200724194053.GK1431@...1296...>
References: <20200724141445.302-1-lstipakov@...277...>
 <20200724184020.GJ1431@...1296...>
 <CAGyAFMXkD2LJ+z8hVo8DphZL2pJC77ABqVeHxtYzx6Pj9AsUxQ@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Unr0GAwC1Xucki3H"
Content-Disposition: inline
In-Reply-To: <CAGyAFMXkD2LJ+z8hVo8DphZL2pJC77ABqVeHxtYzx6Pj9AsUxQ@...278...>
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
Cc: Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>, Lev Stipakov <lev@...515...>

--Unr0GAwC1Xucki3H
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jul 24, 2020 at 10:34:17PM +0300, Lev Stipakov wrote:
> 2) When I tested mingw build, I pointed source url to git repo, not to
> tarball - that's why it worked.

How do you build?  I use the "build-snapshot" script, and that does
a "make dist" somewhere in between.

> That XML is required (no matter msvc or mingw) to tell Windows that
> your app is Win10-aware and allows you
> to use API which detects Windows >=3D 8.1

Thanks for explaining.

> I'll send V2 with above issues fixed.

Thanks :)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--Unr0GAwC1Xucki3H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfGzlFAAoJEB2Cnv7KVigSAPcL/0Mv5qbQSqJrdkgQIsPjMVgk
8JgES750jWHYWAhS6HOZ73CfyoRH17z2OckJuJX3wq6kGvKF2CLd/7WxqcuGX9EO
Uj595hTtJA86VH74iXYFVyWzIBrjeuuo5PF3V5JC0mQO/WZL9DTUOp5JHQ5emex1
IgzFd2nALWsO8gYC5hjZm52uj/tqnCczAiEQV0jbPm1hamS4Tr285kM0zA31RWrZ
OpbV5NGmNWHwUsFRecbKs8lyRJGmKW+45pxWxzwxiL42zCvEunmZJ72OJ66vbdIw
deaMB0So7hgojSwpyi2ezywfAnGBkm+lVrEgohuu+HsibO0+6GWt+yh+errJiwfY
hKlRRhG0q7km7te7iImy/my1vW+bM0gjKF/QW08TCR9qjKOSZXdfJXh2EFBl1oPU
XASZqRaBLJ+3ggdjP3ILOHKHWbbyfvPwyiHFY3CCp9I0uCllO6Il0RouhunGHilr
m7tni/kw23zMchjsDwDny1M/Z3q8SZHqfnvBPGxprQ==
=VT4E
-----END PGP SIGNATURE-----

--Unr0GAwC1Xucki3H--

