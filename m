Message-ID: <53D84749.6060601@...1926...>
Date: Wed, 30 Jul 2014 03:15:53 +0200
From: Julien Muchembled <jm@...1926...>
MIME-Version: 1.0
References: <1406654929-6079-1-git-send-email-jm@...1926...>
	<20140729185713.GX1118@...1296...>
	<53D803BE.1040500@...1926...>
	<20140729210527.GY1118@...1296...>
In-Reply-To: <20140729210527.GY1118@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="GM5gRS5NxsPM7dNFJFRWxm3rpbOnC5mV4"
Subject: Re: [Openvpn-devel] [PATCH] Fix --mtu-disc option with IPv6
	transport
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GM5gRS5NxsPM7dNFJFRWxm3rpbOnC5mV4
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Le 07/29/14 23:05, Gert Doering a =E9crit :
>> For example:
>>   A --[mtu=3D1500]-- B --[mtu=3D1400]-- C
>>
>> Given a UDP6 socket on A with IPV6_MTU_DISCOVER=3DIP_PMTUDISC_DO,
>>     sendto(1452 bytes, B) will succeed
>> but sendto(1452 bytes, C) will return EMSGSIZE (except for the first sen=
d to C)
>> Yes, at some point, there are icmp packets.
>=20
> So (being lazy again, sorry) how is the maximum message size communicated
> back to OpenVPN?  Ancilliary data again?

ICMP packets contains the size and ping/ping6 even reports it (this is real=
 example with mtu=3D1433 between B & C):

# ping6 -c 1 -M do -s 1452 B
PING B (...) 1452 data bytes
1460 bytes from B: icmp_seq=3D1 ttl=3D255 time=3D0.430 ms
# ping6 -c 1 -M do -s 1454 B
PING B(...) 1454 data bytes
--GM5gRS5NxsPM7dNFJFRWxm3rpbOnC5mV4--
