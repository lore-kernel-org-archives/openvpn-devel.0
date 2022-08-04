Date: Thu, 4 Aug 2022 17:17:38 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YuvjEsNvYOKQRhmM@...1296...>
References: <20220804071401.12410-1-a@...2181...>
 <202208041330.274DUPeo032611@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="9ZhXLpTvaoDfOu00"
Content-Disposition: inline
In-Reply-To: <202208041330.274DUPeo032611@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: dco: implement dco support
 for p2p/client code path
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

--9ZhXLpTvaoDfOu00
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Aug 04, 2022 at 03:30:25PM +0200, Gert Doering wrote:
> 	Test sets failed: 2b 2c 2f.

So, this is an interesting one.

To trigger this, you need to connect over UDP + IPv6 transport, and
then you need to inject a packet into "openvpn with DCO" that is
fragmented into two parts, which *both* create an UDP packet after
encapsulation which is bigger than 1500 bytes.

$ ping -c1 -s 2900 10.194.2.1

does this.

Tcpdump on the "tun0" interface shows

15:49:16.433666 IP (tos 0x0, ttl 64, id 18639, offset 0, flags [+], proto I=
CMP (1), length 1500)
    ubuntu2004 > 10.194.2.1: ICMP echo request, id 170, seq 1, length 1480
15:49:16.433703 IP (tos 0x0, ttl 64, id 18639, offset 1480, flags [none], p=
roto ICMP (1), length 1448)
    ubuntu2004 > 10.194.2.1: icmp

so this is one "full sized 1500 byte frame", containing the first fragment,
and then a 1448 byte frame containing the rest.


Connecting with --disable-dco yields this on the outside:

17:09:14.763519 IP6 (flowlabel 0x0082a, hlim 62, next-header Fragment (44) =
payload length: 1456) ubuntu2004 > phillip: frag (0x277a4245:0|1448) 34646 =
> 51194: UDP, bad length 1524 > 1440
17:09:14.763548 IP6 (flowlabel 0x0082a, hlim 62, next-header Fragment (44) =
payload length: 92) ubuntu2004 > phillip: frag (0x277a4245:1448|84)
17:09:14.763576 IP6 (flowlabel 0x0082a, hlim 62, next-header Fragment (44) =
payload length: 1456) ubuntu2004 > phillip: frag (0x1dec474f:0|1448) 34646 =
> 51194: UDP, bad length 1472 > 1440
17:09:14.763593 IP6 (flowlabel 0x0082a, hlim 62, next-header Fragment (44) =
payload length: 40) ubuntu2004 > phillip: frag (0x1dec474f:1448|32)

this is "4 packets are sent" (and, subsequently, 4 packets come back).

Both "(close to) full inside packets" are too big for an external 1500 byte
packet, and get fragmented.   Is this ugly?  Yes.  Is it according to IP
specs?  Yes.  Do I expect this to work?  Yes!  (t_client excercises this
case with the 3000-byte-pings).


Now, *with* DCO, we get this:

17:10:43.771215 IP6 (hlim 62, next-header Fragment (44) payload length: 145=
6) ubuntu2004 > phillip: frag (0xe79d84cc:0|1448) 58755 > 51194: UDP, bad l=
ength 1524 > 1440
17:10:43.771246 IP6 (hlim 62, next-header Fragment (44) payload length: 92)=
 ubuntu2004 > phillip: frag (0xe79d84cc:1448|84)

(only *two* packets, then only keepalives)

And at the same time, the client (!) complains

2022-08-04 17:10:38 net_iface_new: add tun0 type ovpn-dco
2022-08-04 17:10:38 DCO device tun0 opened
(so, we're using DCO)
2022-08-04 17:10:43 read UDPv6 [CMSG=3D50|EMSGSIZE Path-MTU=3D1500]: Messag=
e too long (fd=3D3,code=3D90)



Now... reducing the ping size to 2500...

gert@...2687...:~$ ping -c1 -s 2500 10.194.2.1
2508 bytes from 10.194.2.1: icmp_seq=3D1 ttl=3D64 time=3D126 ms

... actually works.

What is sent out by DCO in this case is 3 packets, 2 fragments, and
one regular UDP packet

17:12:21.512762 IP6 (hlim 62, next-header Fragment (44) payload length: 145=
6) ubuntu2004 > phillip: frag (0x12728a31:0|1448) 58755 > 51194: UDP, bad l=
ength 1524 > 1440
17:12:21.512806 IP6 (hlim 62, next-header Fragment (44) payload length: 92)=
 ubuntu2004 > phillip: frag (0x12728a31:1448|84)
17:12:21.512864 IP6 (hlim 63, next-header UDP (17) payload length: 1080) ub=
untu2004.58755 > phillip.51194: [udp sum ok] UDP, length 1072

... because the second half of the fragmented ICMP packet now fits into
one UDP/1500 byte even after openvpn encapsulation.


So my current guess is that the linux kernel sets *some* flag on
"non-primary ICMP fragments" (inside) that get carried over to the final=20
encapsulated packet, preventing further fragmentation (outside), but
eliciting an "PMTU fail" error instead - which the newly renovated
extended socket error handler picks up.  In userland :-)


To add a data point:

gert@...2687...:~$ ping -c1 -s 3500 10.194.2.1

creates *3* packets in the DCO case

17:14:08.780733 IP6 (hlim 62, next-header Fragment (44) payload length: 145=
6) ubuntu2004 > phillip: frag (0x16acdc72:0|1448) 58755 > 51194: UDP, bad l=
ength 1524 > 1440
17:14:08.780757 IP6 (hlim 62, next-header Fragment (44) payload length: 92)=
 ubuntu2004 > phillip: frag (0x16acdc72:1448|84)
17:14:08.780842 IP6 (hlim 63, next-header UDP (17) payload length: 600) ubu=
ntu2004.58755 > phillip.51194: [udp sum ok] UDP, length 592

... and one error message.

In the non-DCO case, this creates *5* packets - 2 1500-inside packet
that get outside fragmented to 2+2 and one smaller "leftover" packet.

So the 2nd fragment is, again, refusing to be fragmented again...


(ping -s 5000 yields 7 packet without DCO, and only 3 with DCO, so a
pattern starts to form ;-) )

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--9ZhXLpTvaoDfOu00
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJi6+MSAAoJEB2Cnv7KVigSV/AL/jT52CxrkkLiYtiDrE5bFBF9
hWi1tt2yOmEN3Tdk4Wyis/pVeiJT0r41wyESWJJFsv6eLBd7H5t0aXELLKEaX88Q
LcnXsuoY9D4epZDiA965yywJcFS23Djg9xuLffmCSQ1KR/DtUqVlw6CQU3ihztvm
htCOpA1PY9FbnVyq6B9vabg4MD9P82f//HMAQK00KjAS3qJSHF169pLodJLjgHH0
2ILya+qRBeETEHrIisNKH5BYD0KVNojkTABrs50wU40F9tfBqY/52hXU1596MdYO
MvAEa1Y0P/mzTHTy9zsXjZZ54j4l5/gUodiwvG2GiSf7J1DVmF4YnephkFnSMbZi
9InK0cDmNZ+rqVv8SfJQiRfT1d6iz0TGjNZBz+c8Fbke/PbTtAEK0YK1Tw9iKCob
JItQ/RUOVgIqTiVM+iqmXLhGW6LCFGnnkbb8aV49eVpMewbAsvgG/JXAE9bQuRhs
jpUcQR6iM2aNTmwVrLQ72J2Aqr+3X6uvfBbFB0ygSg==
=XtkG
-----END PGP SIGNATURE-----

--9ZhXLpTvaoDfOu00--

