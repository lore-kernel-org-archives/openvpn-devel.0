Date: Sat, 17 Dec 2016 11:44:10 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20161217104410.GS78624@...1296...>
References: <f5ca3f0f-dd01-e82e-b339-68f5791e0928@...1435...>
	<20161216182659.18194-1-jm@...1926...>
	<dfbcd54a-29c2-d8e5-1200-66f217832063@...1435...>
	<44d2e307-1954-de7f-9979-68728de900b3@...1926...>
	<20161217100520.GR78624@...1296...>
	<CAA1AbxJ+noz-HNHXS0Zrq3mScHJBRH7fQgSBP9F-b9J2LjKRPg@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cC4dCx2W6DcYPM7t"
Content-Disposition: inline
In-Reply-To: <CAA1AbxJ+noz-HNHXS0Zrq3mScHJBRH7fQgSBP9F-b9J2LjKRPg@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Build with a few -Werror= flags if the
 compiler supports them
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--cC4dCx2W6DcYPM7t
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Dec 17, 2016 at 11:16:10AM +0100, Steffan Karger wrote:
> > NAK to "-Wall -Werror", unless you've tested that this does not break
> > compilation on any of the supported platforms.
>=20
> Sure, but I think we should help out with that.  Such as, do a test
> build on the supported platforms and see what fixes / extra flags we
> need to make it work.  (I say we, because although I don't have access
> to the build systems, I am willing to help out with fixing fallout.)
>=20
> I'm willing to invest in this, because I think using the compiler as a
> sanity checker more will save us time in the long run.

I'm not generally disagreeing to add -Werror, but then we might consider
having either a --disable-strict setting, or something easily accessible
to certain platforms to disable it.

Right now I'm somewhat concerned about Solaris, and very concerned about
AIX - the latter is like a unix system built by people who have never seen
one, and only had hearsay about POSIX standards.  "Stuff does work", but
the header files are always just slightly different, and unless you spend
large amounts of time on special-case #ifdef TARGET_AIX, it's nearly
impossible to get rid of all warnings.

So, having "first class ports" that build with -Wall -Werror, and=20
"second class ports" that can opt-out (because it's too painful to the=20
code base as a whole to fix these) would work for me...

Taking 2.4_rc2 and building on AIX with -Wall -Wno-pointer-sign is
actually much less bad than I thought :-) - but there are things in=20
there which are annoying, like these

../../../git/src/openvpn/route.c: In function 'add_route_ipv6':
../../../git/src/openvpn/route.c:1834:10: warning: variable 'gateway_needed=
' set but not used [-Wunused-but-set-variable]
     bool gateway_needed =3D false;
          ^

(fixing is easy, but implies adding an #ifdef TARGET_... orgy or=20
refactoring this whole code part - which should be done, but won't=20
happen "over night")

More problematic are these:

../../../git/src/openvpn/socket.c: In function 'print_link_socket_actual_ex=
':
../../../git/src/openvpn/socket.c:2802:21: warning: implicit declaration of=
 function 'if_indextoname' [-Wimplicit-function-declaration]
                     if_indextoname(act->pi.in6.ipi6_ifindex, ifname);
                     ^
../../../git/src/openvpn/socket.c: In function 'unix_socket_get_peer_uid_gi=
d':
../../../git/src/openvpn/socket.c:3950:5: warning: implicit declaration of =
function 'getpeereid' [-Wimplicit-function-declaration]
     if (getpeereid(sd, &u, &g) =3D=3D -1)

../../../git/src/openvpn/tun.c: In function 'open_tun_generic':
../../../git/src/openvpn/tun.c:1787:13: warning: implicit declaration of fu=
nction 'if_nametoindex' [-Wimplicit-function-declaration]
             if (if_nametoindex( dev ) > 0)

... since we're really not supposed to redeclare system prototypes
(and if we do, it will break on other versions of AIX).


-Werror is going to blow up in our faces if we do not fix ntlm.c first,
anyway :-)

gert


--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--cC4dCx2W6DcYPM7t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYVRb6AAoJEB2Cnv7KVigSRc0MAKopMrIvBkjw5K01ZIPFmhES
h/caLDftt3yAQWkPkGUsVEal8urNOrifv4XNeB+FCUNKQu4T4wCKHnXF7SRWCOWd
M9Zk92+XPv7Cbd0Gw+KyWii80ldBIlu7VlYeAy9Y0dXTcF2584dkzLSbLnijBmYX
KduXaKWuFKKxCpEj9rh89Ydu9zRtErNzzCI1k+plH/C7v9btgnmS9ivpqsiOtjmn
5m+JXbB2lRVr4LWWFwO6ZIvUeJYUfrS4Lggx133Y0faS7+8oFhFDo8K9zB2E6had
EwNKXzYxRXZGnKfM86H0piG8xemcIw1gRydf1ntob9fAJAYXpDfP07HS4MtNjAOZ
ZEGeE7NshAB+juiLsXtWcEkiR0aOZx7Bd4v25NCunK6EkCZyg+8YSeaRycB8gM/z
4NLtt4kA+7HDMbJV9vaYMH68TQjavrW0CA/yipaOQ9gF2C4NWF7/lk/rrMGI7OO6
WYwsHKD1Xk5gn6XVjqn0+95+o650pwEujwYWt/3OjA==
=ySpT
-----END PGP SIGNATURE-----

--cC4dCx2W6DcYPM7t--

