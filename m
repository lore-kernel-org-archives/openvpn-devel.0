Message-ID: <53D8BAEE.7030402@...1926...>
Date: Wed, 30 Jul 2014 11:29:18 +0200
From: Julien Muchembled <jm@...1926...>
MIME-Version: 1.0
References: <1406654929-6079-1-git-send-email-jm@...1926...>
	<20140729185713.GX1118@...1296...>
	<53D803BE.1040500@...1926...>
	<20140729210527.GY1118@...1296...>
	<53D84749.6060601@...1926...>
	<20140730054253.GC1118@...1296...>
In-Reply-To: <20140730054253.GC1118@...1296...>
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
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Hello,

Le 07/30/14 07:42, Gert Doering a =E9crit :
> On Wed, Jul 30, 2014 at 03:15:53AM +0200, Julien Muchembled wrote:
>> Le 07/29/14 23:05, Gert Doering a =E9crit :
>>>> For example:
>>>>   A --[mtu=3D1500]-- B --[mtu=3D1400]-- C
>>>>
>>>> Given a UDP6 socket on A with IPV6_MTU_DISCOVER=3DIP_PMTUDISC_DO,
>>>>     sendto(1452 bytes, B) will succeed
>>>> but sendto(1452 bytes, C) will return EMSGSIZE (except for the first s=
end to C)
>>>> Yes, at some point, there are icmp packets.
>>>
>>> So (being lazy again, sorry) how is the maximum message size communicat=
ed
>>> back to OpenVPN?  Ancilliary data again?
>>
>> ICMP packets contains the size and ping/ping6 even reports it (this is r=
eal example with mtu=3D1433 between B & C):
>=20
> I know that part, but the ICMP packets are seen by the kernel, not by
> OpenVPN.  So how does the information arrive in OpenVPN?  sendto() fails,
> but how does OpenVPN know which max message size will be acceptable?

Although I didn't try all MTU-related options of OpenVPN, it seems to ignor=
e EMSGSIZE. It's not something I planned to study immediately and I don't k=
now how to get the maximum message size programmatically (I could look at t=
he code of ping).

What I can say is by only adding '--mtu-disc yes' option, the MTU of the tu=
n/tap interface remains 1500 and does not change automatically to anything =
else. If a packet is small enough for mtu=3D1500 but too big for the underl=
ying network, then it's simply dropped.

> [..]
>> What I've experienced is that fragmentation is bad for perf and that som=
e routers on the internet don't route fragmented UDP packets properly, whic=
h is why I've switched to TCP-only for the moment:
>>   http://git.erp5.org/gitweb/re6stnet.git/commit/cd653523a1474ff9f8956a3=
31c42235454887f65
>=20
> Of course.  Having that functionality for IPv6 is a good thing.  I was
> just trying to understand code that I've not yet had to look into :-)

By the way, I forgot to mention that this patch could be a regression for p=
latforms that define IP_MTU_DISCOVER but not IPV6_MTU_DISCOVER. I don't kno=
w if such platform exist. Maybe the 'switch' clause added by the patch shou=
ld be splitted.

