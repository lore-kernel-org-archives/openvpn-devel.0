Message-ID: <52D154B7.5070802@...1227...>
Date: Sat, 11 Jan 2014 15:27:03 +0100
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <52CFF667.7080600@...1790...> <52CFFAF4.8050306@...1227...>
	<52CFFDA4.4060601@...1790...> <52D07F70.8030609@...1227...>
	<52D08946.6010906@...1790...> <52D08AC6.7080808@...1227...>
	<52D08C75.8020903@...1790...> <52D1408B.6070902@...1227...>
	<20140111130723.GM226@...1296...>
In-Reply-To: <20140111130723.GM226@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="0USdBoaLfhBOEPmXePw5I9QqDRjHOqHqB"
Subject: Re: [Openvpn-devel] git master proto udp6+multihome is broken
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: Tore Anderson <tore@...1790...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0USdBoaLfhBOEPmXePw5I9QqDRjHOqHqB
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Am 11.01.14 14:07, schrieb Gert Doering:
> Hi,
>
> On Sat, Jan 11, 2014 at 02:00:59PM +0100, Arne Schwabe wrote:
>>> Jan 11 01:07:47 greed ovpn-server[10222]: ::ffff:84.209.244.191 TLS: In=
itial packet from [AF_INET6]::ffff:84.209.244.191:38878 (via 2a02:c0:1001:1=
00::253%eth0), sid=3D98e4314f 9ea08578
>>>
>>> I find the "via 2a02:c0:1001:100::253%eth0" part interesting, as that's
>>> not even the primary IPv6 address of the interface.
>> Yeah. We are probably out of luck at this point without implemting a
>> socket for v4 and a socket for v6. If the operating system does not give
>> us a valid incoming interface/ip combination, we cannot fix that later.
> Where's that "via" coming from?  Is that the local socket address that
> IPV6_PKTINFO (etc) told us the UDP packet was addressed to?
>
Yes.

Arne


--0USdBoaLfhBOEPmXePw5I9QqDRjHOqHqB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (Darwin)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlLRVL8ACgkQe8+cMNS4zRejTQCfR2aDFjRBE4JjsLQyIX85Xe7w
sVEAoPM5lkQU8MVVH5F1BEwgQQvxJP41
=uD+c
-----END PGP SIGNATURE-----

--0USdBoaLfhBOEPmXePw5I9QqDRjHOqHqB--

