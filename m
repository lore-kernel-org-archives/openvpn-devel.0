Date: Tue, 7 Aug 2012 11:39:31 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120807093930.GK2535@...1296...>
References: <20120806202605.GI2535@...1296...>
	<1344328396-32121-1-git-send-email-arne@...1227...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wmhq21yAGFMoSpeN"
Content-Disposition: inline
In-Reply-To: <1344328396-32121-1-git-send-email-arne@...1227...>
Subject: Re: [Openvpn-devel] [Version 3] Merge getaddr_multi and getaddr6
	into one function
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--wmhq21yAGFMoSpeN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Aug 07, 2012 at 10:33:16AM +0200, Arne Schwabe wrote:
> the getaddr6 and getaddr_mutli functions are duplicates of each other. Si=
nce we always require getaddrinfo to be present both function are merge int=
o one openvpn_getaddrinfo.
>=20
> This functions also returns a standard struct addrinfo* so our resolve in=
terface is closer to the standard unix interface. The getaddr function is a=
 wrapper which provides backward compatibility for IPv4 addresses. Ipv6 cal=
ls and calls to getaddr_multi are replaced with the new interface.
>=20

Getting closer, but something is still funny.

Connecting to IPv6 tcp or udp server works now, but the resolving of
route destinations seems to result in triplication of all IPv4 routes.

Unchanged "master" code connecting to a server that pushes 2 IPv4 routes:

Tue Aug  7 12:39:05 2012 /sbin/ifconfig tun1 10.194.1.6 10.194.1.5 mtu 1500=
 netmask 255.255.255.255 up
Tue Aug  7 12:39:05 2012 /sbin/ifconfig tun1 inet6 fd00:abcd:194:1::1000/64
Tue Aug  7 12:39:05 2012 /sbin/route add -net 10.194.0.0 10.194.1.5 255.255=
.0.0
add net 10.194.0.0: gateway 10.194.1.5
Tue Aug  7 12:39:05 2012 /sbin/route add -net 10.194.1.1 10.194.1.5 255.255=
.255.255
add net 10.194.1.1: gateway 10.194.1.5
Tue Aug  7 12:39:05 2012 add_route_ipv6(fd00:abcd:194::/48 -> fd00:abcd:194=
:1::1 metric -1) dev tun1
Tue Aug  7 12:39:05 2012 /sbin/route add -inet6 fd00:abcd:194::/48 -iface t=
un1
add net fd00:abcd:194::/48: gateway tun1
Tue Aug  7 12:39:05 2012 Initialization Sequence Completed


With your v3 patch:

Tue Aug  7 12:38:16 2012 /sbin/ifconfig tun1 10.194.1.6 10.194.1.5 mtu 1500=
 netmask 255.255.255.255 up
Tue Aug  7 12:38:16 2012 /sbin/ifconfig tun1 inet6 fd00:abcd:194:1::1000/64
Tue Aug  7 12:38:16 2012 /sbin/route add -net 10.194.0.0 10.194.1.5 255.255=
.0.0
add net 10.194.0.0: gateway 10.194.1.5
Tue Aug  7 12:38:16 2012 /sbin/route add -net 10.194.0.0 10.194.1.5 255.255=
.0.0
route: writing to routing socket: File exists
add net 10.194.0.0: gateway 10.194.1.5: route already in table
Tue Aug  7 12:38:16 2012 ERROR: FreeBSD route add command failed: external =
program exited with error status: 1
Tue Aug  7 12:38:16 2012 /sbin/route add -net 10.194.0.0 10.194.1.5 255.255=
.0.0
route: writing to routing socket: File exists
add net 10.194.0.0: gateway 10.194.1.5: route already in table
Tue Aug  7 12:38:16 2012 ERROR: FreeBSD route add command failed: external =
program exited with error status: 1
Tue Aug  7 12:38:16 2012 /sbin/route add -net 10.194.1.1 10.194.1.5 255.255=
.255.255
add net 10.194.1.1: gateway 10.194.1.5
Tue Aug  7 12:38:16 2012 /sbin/route add -net 10.194.1.1 10.194.1.5 255.255=
.255.255
route: writing to routing socket: File exists
add net 10.194.1.1: gateway 10.194.1.5: route already in table
Tue Aug  7 12:38:16 2012 ERROR: FreeBSD route add command failed: external =
program exited with error status: 1
Tue Aug  7 12:38:16 2012 /sbin/route add -net 10.194.1.1 10.194.1.5 255.255=
.255.255
route: writing to routing socket: File exists
add net 10.194.1.1: gateway 10.194.1.5: route already in table
Tue Aug  7 12:38:16 2012 ERROR: FreeBSD route add command failed: external =
program exited with error status: 1
Tue Aug  7 12:38:16 2012 add_route_ipv6(fd00:abcd:194::/48 -> fd00:abcd:194=
:1::1 metric -1) dev tun1
Tue Aug  7 12:38:16 2012 /sbin/route add -inet6 fd00:abcd:194::/48 -iface t=
un1
add net fd00:abcd:194::/48: gateway tun1
Tue Aug  7 12:38:16 2012 Initialization Sequence Completed

(again, just reporting symptoms, not having stared at the code)

Even though it might be frustrating - thanks for working on this!

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--wmhq21yAGFMoSpeN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBUCDiUqkuBuNlUUl1AQJ5GgP/VcoB8oSg1RU2C8rlzcFC/CNCS+uIu8bA
JNYv4I3ePJ7JT4lTONwOq6qv9uzcswfFrwLi7oyuas91s8fIElBlHAiu2AzuZfTs
ND2JymSeeQfXOYDac6KgKBA1pHezNfUmjDTqsw42bzB+8W/xmhzIrv5qRiTUrciR
Fyc5KWCKx5o=
=CZu/
-----END PGP SIGNATURE-----

--wmhq21yAGFMoSpeN--

