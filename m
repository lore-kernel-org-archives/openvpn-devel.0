Date: Mon, 6 Aug 2012 19:39:38 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120806173938.GD2535@...1296...>
References: <1343837470-3923-1-git-send-email-arne@...1227...>
	<1343837470-3923-3-git-send-email-arne@...1227...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Jbyekxk18hnEXT0m"
Content-Disposition: inline
In-Reply-To: <1343837470-3923-3-git-send-email-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 2/4] Merge getaddr_multi and getaddr6
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

--Jbyekxk18hnEXT0m
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Aug 01, 2012 at 06:11:08PM +0200, Arne Schwabe wrote:
> the getaddr6 and getaddr_mutli functions are duplicates of each other. Si=
nce we always require getaddrinfo to be present both function are merge int=
o one openvpn_getaddrinfo.
>=20
> This functions also returns a standard struct addrinfo* so our resolve in=
terface is closer to the standard unix interface. The getaddr function is a=
 wrapper which provides backward compatibility for IPv4 addresses. Ipv6 cal=
ls and calls to getaddr_multi are replaced with the new interface.
>=20

ACK on the feature, but there's something weird in the implementation
(which I've not had time to track down yet).

When connecting to a TCP ipv6 server (--client --proto tcp6-client), things
fail in interesting ways:

$ openvpn --client --nobind --comp-lzo --verb 3 --dev tun --proto tcp6-clie=
nt --remote conn-test-server.openvpn.org --port 51194
...
Mon Aug  6 19:49:06 2012 Attempting to establish TCP connection with [AF_IN=
ET6]2607:fc50:1001:5200:::51194 [nonblock]

This is buggy already, because "conn-test-server" is "2607:fc50:1001:5200::=
4",
and the ":4" got lost...

Mon Aug  6 19:49:16 2012 TCP: connect to [AF_INET6]2607:fc50:1001:5200:::51=
194 failed, will try again in 5 seconds: Operation timed out
Mon Aug  6 19:49:22 2012 TCP connection established with [AF_INET6]2607:fc5=
0:1001:5200::4:51194

Nevertheless, it eventually it *does* connect - and that looks really
weird in tcpdump:

20:29:53.410339 IP6 2001:608:0:814::f000:3.51581 > 2607:fc50:1001:5200::.51=
194: S 3439435758:3439435758(0) win 65535 <mss 1440,nop,wscale 3,sackOK,tim=
estamp 1696266663 0>
20:29:56.609888 IP6 2001:608:0:814::f000:3.51581 > 2607:fc50:1001:5200::.51=
194: S 3439435758:3439435758(0) win 65535 <mss 1440,nop,wscale 3,sackOK,tim=
estamp 1696266983 0>
20:29:59.809652 IP6 2001:608:0:814::f000:3.51581 > 2607:fc50:1001:5200::.51=
194: S 3439435758:3439435758(0) win 65535 <mss 1440,sackOK,eol>

3 tries with "5200::"...

20:30:05.520033 IP6 2001:608:0:814::f000:3.52113 > 2607:fc50:1001:5200::4.5=
1194: S 1364097067:1364097067(0) win 65535 <mss 1440,nop,wscale 3,sackOK,ti=
mestamp 1696267874 0>
20:30:05.658230 IP6 2607:fc50:1001:5200::4.51194 > 2001:608:0:814::f000:3.5=
2113: S 278837698:278837698(0) ack 1364097068 win 65535 <mss 1440,nop,wscal=
e 6,sackOK,timestamp 1030394651 1696267874>
20:30:05.658368 IP6 2001:608:0:814::f000:3.52113 > 2607:fc50:1001:5200::4.5=
1194: . ack 1 win 8211 <nop,nop,timestamp 1696267887 1030394651>

... and then it tries the proper host, which answers...

After connecting, it then fails on verifying the remote (huh, for TCP?!):

Mon Aug  6 19:49:22 2012 TCPv6_CLIENT link local: [undef]
Mon Aug  6 19:49:22 2012 TCPv6_CLIENT link remote: [AF_INET6]2607:fc50:1001=
:5200::4:51194
Mon Aug  6 19:49:22 2012 TCP/UDP: Incoming packet rejected from [AF_INET6]2=
607:fc50:1001:5200::4:51194[28], expected peer address: [AF_INET6]2607:fc50=
:1001:5200:::51194 (allow this incoming source address/port by removing --r=
emote or adding --float)
Mon Aug  6 19:49:22 2012 TCP/UDP: Incoming packet rejected from [AF_INET6]2=
607:fc50:1001:5200::4:51194[28], expected peer address: [AF_INET6]2607:fc50=
:1001:5200:::51194 (allow this incoming source address/port by removing --r=
emote or adding --float)

(and of course, from there on it will not go anywhere).  This happens on
FreeBSD 7.4 with yesterday's "master" and patch2/4 applied - without
the patch, it works.
--Jbyekxk18hnEXT0m--
