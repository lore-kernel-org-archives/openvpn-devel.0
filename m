Date: Sat, 14 Mar 2020 13:35:31 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20200314123531.GD1431@...1296...>
References: <20200312020135.20510-1-lstipakov@...277...>
 <20200312030323.19293-1-lstipakov@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="ydr+kCxCcP3yQKPN"
Content-Disposition: inline
In-Reply-To: <20200312030323.19293-1-lstipakov@...277...>
Subject: Re: [Openvpn-devel] [PATCH v2] Fix building with
 --enable-async-push in FreeBSD
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--ydr+kCxCcP3yQKPN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Mar 12, 2020 at 05:03:23AM +0200, Lev Stipakov wrote:
> This option can be used in FreedBSD with devel/libinotify
> installed.
>=20
> Detect presence of libinotify and link with its _LIBS variable.
>=20
> Trac #1256
>=20
> Signed-off-by: Lev Stipakov <lstipakov@...277...>

Doesn't want to work for me...

FreeBSD 11.3 here, with "libinotify-20180201_1" installed, which
brings in /usr/local/include/sys/inotify.h

Running configure like this (out of tree):

../openvpn/configure LZO_CFLAGS=3D-I/usr/local/include LZO_LIBS=3D"-L/usr/l=
ocal/lib -llzo2" --enable-async-push

ends in...

checking whether the compiler accepts -Wno-unused-parameter... yes
checking whether the compiler accepts -Wall... yes
checking sys/inotify.h usability... no
checking sys/inotify.h presence... no
checking for sys/inotify.h... no
configure: error: inotify.h not found.

which is not exactly surprising, given that it wants to find this
header *before* pkg_config tells it where to look...


if test "${enable_async_push}" =3D "yes"; then
        AC_CHECK_HEADERS(
                [sys/inotify.h],
                AC_DEFINE([ENABLE_ASYNC_PUSH], [1], [Enable async push]),
                AC_MSG_ERROR([inotify.h not found.])
        )
        case "$host" in
                *-*-freebsd*)
                        PKG_CHECK_MODULES(
                                [OPTIONAL_INOTIFY],
                                [libinotify]
                        )
                ;;
        esac
fi


so unless you happen to have "-I/usr/local/include" in your CFLAGS
at this point, it will still fail.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--ydr+kCxCcP3yQKPN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJebM+TAAoJEB2Cnv7KVigSQAIMAIi3AL3L4UQJxqvxEPvYW1Jl
lDk/G10u0GgRxhkpVYBbuXrjNCbmOB6iyXe7J7ozHSspF7sMq7/EJszLtODpb0tu
ogk2TrbZH3wiQohTrt42M7D8jjo+jPCvq8ewxf6sopkBIBp1jTgj2fmjkiuDX7oj
5uupQ9Jk0Lfy/6rVitvJphrgPRe8sx3tD2jdTqX12XFJv0PJKUxf0VbWeyNrmi43
YvJtEX77ZZMhbo0h/H5t303VYv9RLPM4uVDVnL1KUD6NsgQD78uZDKE6KLZ5Lz6i
cVd4KMpQYHqnNnAqe+LBeCG7OcLo3dP9aegYwx3tqReTOCWDreIBQOonqsVP0zlj
gO78J5YcxfBRjBaOVpg/HEqhmDIM2751j2LJdqdLvcT3XqMeP92E8XMkacPKgPMP
j8NCb2RmPg29xTEyP6IW4uPLsX3O3LXp6PwA8rxhgTpRyJuMGywFTgVGAVAogRPz
/5Qsc6mMWutLh9uS6FzqBzzyqswV9EQMXDfDsoP+7A==
=7gxN
-----END PGP SIGNATURE-----

--ydr+kCxCcP3yQKPN--

