Message-ID: <559D4F39.5000603@...1147...>
Date: Wed, 08 Jul 2015 18:26:33 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <55966BE0.5090400@...1147...> <55966F4A.7010008@...1114...>
	<559672D0.1030904@...1147...> <20150703115639.GC57772@...2041...>
	<20150703131545.GZ382@...1296...> <5596980F.6010600@...1147...>
In-Reply-To: <5596980F.6010600@...1147...>
Subject: Re: [Openvpn-devel] Adding routes on Windows using DHCP
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>, =?windows-1252?Q?J=C1K=D3_Andr=E1?= =?windows-1252?Q?s?= <jako.andras@...2041...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

Jan Just Keijser wrote:
> On 03/07/15 15:15, Gert Doering wrote:
>> On Fri, Jul 03, 2015 at 01:56:39PM +0200, J=C1K=D3 Andr=E1s wrote:
>>>> yes this is possible; it's possible to push multiple gateways and
>>>> multiple (classless) routes (dhcp options 121 & 249).
>>>> If the metric on the tap-win adapter is set manually and is set low
>>>> enough the redirecting the gateway will also work.
>>>> However, changing the metric requires evelated access...
>>> Sorry for the noise if that has been discussed before: Instead of
>>> modifying the metric, how about pushing two /1 routes (0.0.0.0/1 and
>>> 128.0.0.0/1)?
>> Would work *if* windows supports the "classless routes" option (which
>> I'm not sure of) - and if it accepts DHCP on tap to provide a host
>> route for the VPN server to the original gateway on the normal LAN
>> interface.  Without that host route, routing would loop (we'd send
>> packets *to* the VPN server into the tunnel, encapsulate, send
>> to the VPN server, into the tunnel, encapsulate, ... *boom*)
>>
> AFAICT windows does support that option (that's what I was referring=20
> to with options 121 or 249) . OTOH, I am *not* sure if it allows you=20
> to set a 0.0.0.0/1 route using that option, but I guess there's only=20
> one way to find out.

FWIW: I've patched openvpn to set routes using DHCP on Windows and yes,=20
it works: I can add any route to the system routing tables, including=20
0.0.0.0/1 and 128.0.0.1/1 ; this could be used as an alternative to=20
requiring elevated privileges.

JJK




