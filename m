Date: Thu, 3 Feb 2022 17:39:32 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <YfwFRFzA0063yY9R@...1296...>
References: <20220101162532.2251835-1-arne@...1227...>
 <20220101162532.2251835-10-arne@...1227...>
 <YfvY/nkJOQ5qS8hG@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Qo7TBiTy662X1S9d"
Content-Disposition: inline
In-Reply-To: <YfvY/nkJOQ5qS8hG@...1296...>
Subject: Re: [Openvpn-devel] [PATCH v3 09/14] Add mtu paramter to --fragment
 and change fragment calculation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--Qo7TBiTy662X1S9d
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Feb 03, 2022 at 02:30:38PM +0100, Gert Doering wrote:
> and server pushes this:
>=20
> 2022-02-03 14:28:24 PUSH: Received control message: 'PUSH_REPLY,route 10.=
194.0.0 255.255.0.0,route-ipv6 fd00:abcd:194::/48,tun-ipv6,route 10.194.2.1=
,topology net30,ping 10,ping-restart 30,compress lz4,ifconfig-ipv6 fd00:abc=
d:194:2::100c/64 fd00:abcd:194:2::1,ifconfig 10.194.2.54 10.194.2.53,peer-i=
d 0,cipher AES-256-GCM,key-derivation tls-ekm'

Looking more closely, this is followed by...

2022-02-03 17:34:29 PUSH: Received control message: 'PUSH_REPLY,route 10.19=
4.0.0 255.255.0.0,route-ipv6 fd00:abcd:194::/48,tun-ipv6,route 10.194.2.1,t=
opology net30,ping 10,ping-restart 30,compress lz4,ifconfig-ipv6 fd00:abcd:=
194:2::100c/64 fd00:abcd:194:2::1,ifconfig 10.194.2.54 10.194.2.53,peer-id =
1,cipher AES-256-GCM,key-derivation tls-ekm'
2022-02-03 17:34:29 WARNING: Compression for receiving enabled. Compression=
 has been used in the past to break encryption. Sent packets are not compre=
ssed unless "allow-compression yes" is also set.
2022-02-03 17:34:29 OPTIONS IMPORT: timers and/or timeouts modified
2022-02-03 17:34:29 OPTIONS IMPORT: compression parms modified
2022-02-03 17:34:29 OPTIONS IMPORT: --ifconfig/up options modified
2022-02-03 17:34:29 OPTIONS IMPORT: route options modified
2022-02-03 17:34:29 OPTIONS IMPORT: peer-id set
2022-02-03 17:34:29 OPTIONS IMPORT: adjusting link_mtu to 1625
2022-02-03 17:34:29 OPTIONS IMPORT: data channel crypto options modified

"adjusting link_mtu to 1625" which then maps to a tun_mtu of 1572,=20
and

2022-02-03 17:34:29 /sbin/ifconfig tun0 10.194.2.54 10.194.2.53 mtu 1572 ne=
tmask 255.255.255.255 up

Which happens in adjust_mtu_peerid() iff there is no --link-mtu in
the config (which it isn't)...

This binary is extremely stubborn about it, as in "even if I configure
--tun-mtu 1490, I get a larger mtu configured afterwards".

Maybe this is a transient effect which will disappear when all of the
patchset is in... trying this next.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--Qo7TBiTy662X1S9d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJh/AVEAAoJEB2Cnv7KVigSkA4L/jYjiDr5XPrtcMd0ZieN9gKG
fqJIr1T+BGyoylPxgG3ClNfidBB837pLjZQ1JAkyeG/zFdGrZ7gqtd5swUjGUf/M
9LxUPvisHJTjOZMPMswcr1DurpiWIVqqisqXK25G9zORxxtY2ACzVDDpyrKAIkUU
0WyLuQOFKpnZxjyI7/JNTYwcpnSzNCtSI/yK7rHzO2U1SeH8rXrThO0p/a1enArK
o8aG7Ada/5gnBK+7WJUb9KVhpvqLF9XDVXwChrJZkoWt48VMsybs/DCe/yli6ZxW
bjg7sc4fXcPImZw7YD7/DBichYsgKvqqmrpRZdr097ErPPXuzKQGN317P5Rdu2vY
a0TZWMtuYUX4dtVK9a97kylEcSNSpviTmLn9+afj6mCQzTvpCG350r43dG3H8HD4
YhtOmsOf90pk+GhX+O4QfyTyQSd1toYtaOxWfqjrFgBESqrKTMXwGFVCxq+WtIzL
XnMvbiayG6i4z6MTx6z8VuhYjjQCDYm6U0X4xBd4sQ==
=ohVh
-----END PGP SIGNATURE-----

--Qo7TBiTy662X1S9d--

