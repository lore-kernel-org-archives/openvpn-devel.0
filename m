Date: Tue, 19 Oct 2021 13:50:03 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YW6w6x9jMfZ+GZ8o@...1296...>
References: <20210628080832.510-1-lstipakov@...277...>
 <202108011741.171HfPFk045977@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="6ws157dk5jrZqxUa"
Content-Disposition: inline
In-Reply-To: <202108011741.171HfPFk045977@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: contrib/vcpkg-ports: remove
 openssl port
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lev@...515...>
Cc: openvpn-devel@lists.sourceforge.net

--6ws157dk5jrZqxUa
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Aug 01, 2021 at 07:41:25PM +0200, Gert Doering wrote:
> Acked-by: Gert Doering <gert@...1296...>
>=20
> Since we never wanted to maintain our own patch, this is welcome.
>=20
> I have left out the hunk to .github/workflows/build.yaml, as that has
> been superseded by commit de8871f86db.
>=20
> (I have not tested this in any way, just looked at the patch to see
> which files it modifies and whether those look halfway reasonable)
>=20
> Your patch has been applied to the master branch.
>=20
> commit 7e33127d566da6dc4e412c11a445be74a542729e
> Author: Lev Stipakov
> Date:   Mon Jun 28 11:08:32 2021 +0300
>=20
>      contrib/vcpkg-ports: remove openssl port

As requested (and as this is more a "build thing, depending on external
factors" than "openvpn code") I have backported this to 2.5 as well now.

commit a0e6707ab384a9ae408993363c767d38e022c025 (HEAD -> release/2.5)
Author: Lev Stipakov <lev@...515...>
Date:   Mon Jun 28 11:08:32 2021 +0300

    contrib/vcpkg-ports: remove openssl port


The resulting Windows installer needs a bit of testing before releasing
the next official one...

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--6ws157dk5jrZqxUa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJhbrDrAAoJEB2Cnv7KVigSoRgMAKMURbPp/I5PhrviF1mXE0Wv
lGxsvlNk9l+yCc8L5w5Uf+MhrEO71ZJ3gsVJWFhjMmdDQUMdA6gEuFq6wnoC98uu
lSeFTy6o5XEczZD3Y5fsgji02405SEXfha5lstoj0eicFFkKoZeSRCeXffy0sm4S
INhdsKsHDa4Kf43R1jke7c4l6/xsjBC/ZFAUem87agGQKvZTgV/Jl0xmpjDxlRV+
ViPHpuFutyiK8vtnp7xRG5P8a/SVK5mYExjFMc66q6P11F48KpIWVbW9usOb14MH
HLEYbEt+fY6qF/EDprwBPrnBNMONfvRrbYn3vQt/qiSRKDCohE6nacyqCWLr5+qM
yLuWqNfNGkTw8MPZVOpNG0sBCIdsoZL3cvsXXHb0kPwTL639HTbtywwuj9/SE+7L
ahOPL+d5nZae8aGtXOqDzcomymGuG3IpSfKRuyXEXY3J6cU7iPSWiQR5CtctK0pI
bSvC6ydB5kGyrbvHOUCHcr3NhUYcIoipcpBmKkmHTg==
=U3am
-----END PGP SIGNATURE-----

--6ws157dk5jrZqxUa--

