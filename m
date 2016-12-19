References: <f5ca3f0f-dd01-e82e-b339-68f5791e0928@...1435...>
	<20161216182659.18194-1-jm@...1926...>
	<dfbcd54a-29c2-d8e5-1200-66f217832063@...1435...>
	<44d2e307-1954-de7f-9979-68728de900b3@...1926...>
	<20161217100520.GR78624@...1296...>
	<CAA1AbxJ+noz-HNHXS0Zrq3mScHJBRH7fQgSBP9F-b9J2LjKRPg@...278...>
	<20161217104410.GS78624@...1296...>
From: Julien Muchembled <jm@...1926...>
Message-ID: <84783135-c6c8-7e72-56d9-d426cdc4ef11@...1926...>
Date: Mon, 19 Dec 2016 11:34:56 +0100
MIME-Version: 1.0
In-Reply-To: <20161217104410.GS78624@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vIw55hCXNuCtDv8JW4CqaKanCKJwnfVAO"
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
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vIw55hCXNuCtDv8JW4CqaKanCKJwnfVAO
Content-Type: multipart/mixed; boundary="uFOAKNkTbSWNUNv7FxOxTCgmRUgMJS2dp";
	protected-headers="v1"
From: Julien Muchembled <jm@...1926...>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Message-ID: <84783135-c6c8-7e72-56d9-d426cdc4ef11@...1926...>
Subject: Re: [Openvpn-devel] [PATCH] Build with a few -Werror= flags if the
	compiler supports them
References: <f5ca3f0f-dd01-e82e-b339-68f5791e0928@...1435...>
	<20161216182659.18194-1-jm@...1926...>
	<dfbcd54a-29c2-d8e5-1200-66f217832063@...1435...>
	<44d2e307-1954-de7f-9979-68728de900b3@...1926...>
	<20161217100520.GR78624@...1296...>
	<CAA1AbxJ+noz-HNHXS0Zrq3mScHJBRH7fQgSBP9F-b9J2LjKRPg@...278...>
	<20161217104410.GS78624@...1296...>
In-Reply-To: <20161217104410.GS78624@...1296...>

--uFOAKNkTbSWNUNv7FxOxTCgmRUgMJS2dp
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Le 12/17/16 =E0 11:44, Gert Doering a =E9crit :
> Taking 2.4_rc2 and building on AIX with -Wall -Wno-pointer-sign is
> actually much less bad than I thought :-) - but there are things in=20
> there which are annoying, like these
>=20
> ../../../git/src/openvpn/route.c: In function 'add_route_ipv6':
> ../../../git/src/openvpn/route.c:1834:10: warning: variable 'gateway_need=
ed' set but not used [-Wunused-but-set-variable]
>      bool gateway_needed =3D false;
>           ^
>=20
> (fixing is easy, but implies adding an #ifdef TARGET_... orgy or=20
> refactoring this whole code part - which should be done, but won't=20
> happen "over night")

That's why I also suggested to have -Wno-unused, at least in a first time.
My idea was to avoid regression and detect issues easily on exotic configur=
ation (openssl without crypto), not to change the code style in OpenVPN.

> More problematic are these:
>=20
> ../../../git/src/openvpn/socket.c: In function 'print_link_socket_actual_=
ex':
> ../../../git/src/openvpn/socket.c:2802:21: warning: implicit declaration =
of function 'if_indextoname' [-Wimplicit-function-declaration]
>                      if_indextoname(act->pi.in6.ipi6_ifindex, ifname);
>                      ^
> ../../../git/src/openvpn/socket.c: In function 'unix_socket_get_peer_uid_=
gid':
> ../../../git/src/openvpn/socket.c:3950:5: warning: implicit declaration o=
f function 'getpeereid' [-Wimplicit-function-declaration]
>      if (getpeereid(sd, &u, &g) =3D=3D -1)
>=20
> ../../../git/src/openvpn/tun.c: In function 'open_tun_generic':
> ../../../git/src/openvpn/tun.c:1787:13: warning: implicit declaration of =
function 'if_nametoindex' [-Wimplicit-function-declaration]
>              if (if_nametoindex( dev ) > 0)
>=20
> ... since we're really not supposed to redeclare system prototypes
> (and if we do, it will break on other versions of AIX).

:(
But we could detect such case during configure and add declarations if need=
ed.

Julien


--uFOAKNkTbSWNUNv7FxOxTCgmRUgMJS2dp--

--vIw55hCXNuCtDv8JW4CqaKanCKJwnfVAO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYV7fSAAoJEEwjvlkacWMkIZwQANE3H/qyOMfsge6imnoHfKOD
5HERy9s+ZsDwjivm264Aj8LXWoRClZN5LF+9CzyQ5/oozLdreSLlZl8bGhTovgb3
d8aRUpJjrXFRdyw7WZLMk5qB8XP61CWC5NxPJA/X6OB9XzxzYll1sN0XyLtmaAwl
iZrAyWEoaDaXEFhFNQhPRxf3B2Nlz6/SegoUfqsmU/yFDhmzMLkih9YF62AHw4EJ
8qxKbQddbsDEMMWg5dN8lo6CatToPefE63pWWdMcwnTHC3igdUG8nRUrp8+pYjQc
Hbpc2KFJoQsyPiWB2MNjHDjonUbUGoNON/7ZEIGPHpVLpfAHIrng2CTBioAR+twJ
vJH8U4t+8ln16Z2VUkrwCbW9ykG9JhwPrV357Zg97Uibnoz2/193N8ukPbxbCY+/
8xOYa17sNTcRLlsP+TOD3ZIMKJtvjKXWf4utfdXEYab0F79Gqchr2Wdlh1Cj19Zt
xuo97XfNHPuyZhmAQQirFKzsnSSeaWadSOQsPK8UzG/eHNV95nLoAq++syESVpwI
/G6CB/q9tFw8JjhkzL8k4ce6ufJBsDl2e4prgJwEmVJYJCtT1eqXsRA84UcHxrmb
GFd5g0krSDzy+fxsfvY8g6mWfjIVsn4R++OOA8ISV5YPRR8Aaj3KeSQIxjcElGRW
9AtQdGRIWATufRalFPrQ
=hAn9
-----END PGP SIGNATURE-----

--vIw55hCXNuCtDv8JW4CqaKanCKJwnfVAO--

