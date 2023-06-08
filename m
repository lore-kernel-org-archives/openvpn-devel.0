Date: Thu, 8 Jun 2023 21:52:42 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <ZIIxis5u5JG3Zzj0@...1296...>
References: <20230414094227.9153-1-kprovost@...2661...>
 <202305081155.348BtYlh004143@...2054...>
 <20D50979-90A2-45C2-9C10-FDD8E0CDC803@...1376...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="ls/9POWmshUweZaB"
Content-Disposition: inline
In-Reply-To: <20D50979-90A2-45C2-9C10-FDD8E0CDC803@...1376...>
Subject: Re: [Openvpn-devel] [PATCH applied] DCO: support key rotation
 notifications
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Kristof Provost <kp@...1249...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--ls/9POWmshUweZaB
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, May 08, 2023 at 06:15:52PM +0200, Kristof Provost wrote:
> I???ve also landed the (FreeBSD) kernel side of that: https://cgit.freebs=
d.org/src/commit/?id=3Df7ee28e755820375d5f441e19c1f1376a200e834

I now had (finally) time to test this.

 - Upgraded FreeBSD current to "as of today"
 - modified the kernel to set OVPN_SEQ_ROTATE to "10000" and added
   a printf() call (to make this easier to observe)
 - pinged!

-> and it works nicely, every 10.000 packets, I see my kernel printf()

Jun  8 21:47:24 fbsd14 kernel: ovpn: seq64=3D10000, need key rotation

and then=20

Jun  8 21:47:36 fbsd14 tun-udp-p2mp[917]: myclient peer-id=3D0 UDPv6 WRITE =
[14] to [AF_INET6]2001:608:0:814::f000:3:61067: P_CONTROL_SOFT_RESET_V1 kid=
=3D1 [ ] pid=3D0 DATA len=3D0
...
Jun  8 21:47:36 fbsd14 tun-udp-p2mp[917]: myclient peer-id=3D0 dco_install_=
key: peer_id=3D0 keyid=3D1, currently 1 keys installed
Jun  8 21:47:36 fbsd14 tun-udp-p2mp[917]: myclient peer-id=3D0 dco_new_key:=
 slot 1, key-id 1, peer-id 0, cipher AES-256-GCM
Jun  8 21:48:37 fbsd14 tun-udp-p2mp[917]: myclient peer-id=3D0 Swapping pri=
mary and secondary keys to primary-id=3D1 secondary-id=3D0
Jun  8 21:48:37 fbsd14 tun-udp-p2mp[917]: myclient peer-id=3D0 dco_swap_key=
s: peer-id 0
...
Jun  8 21:50:38 fbsd14 tun-udp-p2mp[917]: myclient peer-id=3D0 dco_install_=
key: peer_id=3D0 keyid=3D2, currently 1 keys installed
Jun  8 21:50:38 fbsd14 tun-udp-p2mp[917]: myclient peer-id=3D0 dco_new_key:=
 slot 1, key-id 2, peer-id 0, cipher AES-256-GCM


-> so kernel triggers the userland re-keying, userland swaps key in
kernel, ping does not notice...

--- fd00:abcd:114:2::1002 ping6 statistics ---
20000 packets transmitted, 20000 packets received, 0.0% packet loss
round-trip min/avg/max/std-dev =3D 0.249/0.377/11.693/0.150 ms


Good work, folks :-)

gert

PS: Antonio, so where's the Linux side...?

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--ls/9POWmshUweZaB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJkgjGKAAoJEB2Cnv7KVigSyI4L/1t5RVXID5b7Cv6cWIU6nGUV
hiO9H//r+kjKkBtty1l33OqmiLcblc9m2YwVaxubhdQ0hC4e1oapIVK8TkQyJwo7
kRoeTlMffr+aTIHo/Q++YNcedQPfHimEjWyuW57HHfMmIZueakIvgIBkXDEtDDXQ
DE4Etqt8TY27vTRKGRRLmsLLk1Jd5n6EzQDBVXtRDKtEyskm+Yts0b/dNeO9wehJ
j2EMQwygR5kQEeAshG0tEzHM1otMPwNz48DrpHkJUjS+Q0TnYmwMTCG+/hoBtxNS
nD2JRrHgITI3VJg903dTTJqarY/bF1iBs0jaCUPoLoIVHAlknL608hEbJWOYY/Qr
JN8YmAZfi0NsD2wPPrEoUAqvL9cm7LrpLxqJBbUDcAvVFCSJAMxdSz50/H2Jgf6y
I9bZJSf/BMtMWweuYQ4nCfgTloNzXAxx3wSpGh9xKuGyT2ocnEllW1Rnxu9uTKZT
Ku3gH8SlDDI4TZ2N2RJkMyRZ0MzkXnntii/v7AIDcQ==
=oo/M
-----END PGP SIGNATURE-----

--ls/9POWmshUweZaB--

