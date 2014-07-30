Message-ID: <53D8C935.4030408@...1847...>
Date: Wed, 30 Jul 2014 12:30:13 +0200
From: Andre Valentin <avalentin@...1847...>
MIME-Version: 1.0
References: <1406654929-6079-1-git-send-email-jm@...1926...>	<20140729185713.GX1118@...1296...>	<53D803BE.1040500@...1926...>	<20140729210527.GY1118@...1296...>	<53D84749.6060601@...1926...>	<20140730054253.GC1118@...1296...>	<53D8BAEE.7030402@...1926...>
	<20140730093748.GH1118@...1296...>
In-Reply-To: <20140730093748.GH1118@...1296...>
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
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Hi!

I followed your discussion because I also tested the fragmentation with pmt=
u discovery and came to the results that it does not help me. Therefore I c=
urrently use fragmentation.

On 30.07.2014 11:37, Gert Doering wrote:
> Hi,
>
> On Wed, Jul 30, 2014 at 11:29:18AM +0200, Julien Muchembled wrote:
>>> I know that part, but the ICMP packets are seen by the kernel, not by
>>> OpenVPN.  So how does the information arrive in OpenVPN?  sendto() fail=
s,
>>> but how does OpenVPN know which max message size will be acceptable?
>>
>> Although I didn't try all MTU-related options of OpenVPN, it seems to
>> ignore EMSGSIZE.
>
> Well, handling that error will not lead anywhere, as it just tells us
> "the packet got lost, because it was too big".  More interesting is the
> information "so, how big is 'not too big'" and that won't be in the
> error code, but most likely in ancilliary socket data.
>
> I'll go and find out...

If the mtu discovery currently is not implemented, how about this idea:
-A client sends a big packet.
-the vpn server encapsulates it
-a router on the path sends back the corresponding ICMP packet "too big".
-the vpn server gets the packet and reads the max mtu size
-the vpn server creates a fake icmp packet for the client to tell him the m=
tu for this connection
-the client uses this information and sends a perfect fitting packet, or 2 =
:-)

This way it is all at the client and the server does not have to implement =
fragmentation.

Just an idea ;-)

Andr=E9


