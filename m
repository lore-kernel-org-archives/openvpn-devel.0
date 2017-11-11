Date: Sat, 11 Nov 2017 15:21:27 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20171111142127.GB958@...1296...>
References: <20171111133649.20192-1-gert@...1296...>
 <98643661-9d58-328c-36da-b314c456af8f@...1856...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="1R3djOICCIfo/gUr"
Content-Disposition: inline
In-Reply-To: <98643661-9d58-328c-36da-b314c456af8f@...1856...>
Subject: Re: [Openvpn-devel] [PATCH] Remove warning on pushed tun-ipv6
 option.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

--1R3djOICCIfo/gUr
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Nov 11, 2017 at 03:16:13PM +0100, Steffan Karger wrote:
> (I'll leave review of the correctness of the change to someone who
> actually understands what tun-ipv6 exactly does.)

"exactly and absolutely nothing" :-)

(It *used* to be a flag to tell openvpn "switch the tun interface into=20
ipv6-compatible mode", but after Arne's revamping of this it's basically
a no-op, which we keep around for compatibility reasons with old config
files - and the warning points out that it does not do anything)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--1R3djOICCIfo/gUr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJaBwdmAAoJEB2Cnv7KVigSYA4L/AsxOOeF2B307TLF172gIp0H
f3RzdSd4JwRCU2NYNaZDmfKAq/cBzWk6JEBB7R3zn124AHis69f7X5P+HENuLF0j
Sj2AfUSiQ8NzRRI0/o6ynwahTR9dv1zqDnXO7SyFOtKQzFi2OYAPIdjIc7USbNaL
3po51OkiRqhKPKQwGFF5kzLARuaa/6N6AUEaOHzJ3ZmyKe/OrCZplFWIwmrIB8e4
atISuuBW3uII8Lt9OFn3EGc7FZMBfx2M50Vgugq5Wizz+c9X6DPBSA8rfW6CyiQl
igOXe0pJ7z2zOSRc6Q09jTze1bGm2EFUBCEGY+vUJCrxrjmj36JwDsuGzVnK0KnL
/LkIbnLBhg3LTskDUDHUbPpBzPeD7bZnLFXLfL2zXCKvj7Xh8my+rxK/MzxYLcE6
7/yNYDVOMiQAHqQOa/7pb9PjL9rmP+pgvqHi4AfzwRQrpSAop+3ExnVGd4+qk7vI
D2z4gOAPd9fgOtlbifGL1JvlFiXTfb1t783jWOHhSg==
=BzXZ
-----END PGP SIGNATURE-----

--1R3djOICCIfo/gUr--

