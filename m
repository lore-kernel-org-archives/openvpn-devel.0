References: <1474666458.11690.23.camel@...1866...>
	<57E5A654.60503@...1147...> <1474672864.11690.27.camel@...1866...>
	<57E7E1FB.9070202@...1147...> <1474817465.11690.54.camel@...1866...>
	<57E907AE.5060100@...1147...> <1474891690.45169.224.camel@...1866...>
From: Jan Just Keijser <janjust@...1147...>
Message-ID: <022fae5c-8993-2988-7855-083546051302@...1147...>
Date: Fri, 30 Sep 2016 10:11:07 +0200
MIME-Version: 1.0
In-Reply-To: <1474891690.45169.224.camel@...1866...>
Subject: Re: [Openvpn-devel] p2p topology on Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: David Woodhouse <dwmw2@...1866...>, openvpn-devel@lists.sourceforge.net

Hi David,

On 26/09/16 14:08, David Woodhouse wrote:
> On Mon, 2016-09-26 at 13:34 +0200, Jan Just Keijser wrote:
>> this sounds like a typical use case for "assign a public IP address".
>> This is already possible with topology subnet and some special config
>> stuff on the server side, e.g.
>> - give the openvpn server an IP range that overlaps with existing
>> (server-side) IP space
>> - don't assign address from a large DHCP pool, but use a client-connect
>> script to assign an address per certificate
>> - use proxy arp and some routing tricks to ensure that all client
>> traffic is routed properly via the server.
> Ewww! But OK, yes I suppose that can work i most cases =E2=80=94 at least=
 for
> the server's routing.
>
> It still leaves the client routing more than it should down the VPN,
> and for some client IP addresses like x.x.x.127 you end up needing much
> more than a /30 =E2=80=94 Windows won't let you have that IP address on t=
he
> client side unless you use a netmask wide enough that it wouldn't be
> the broadcast address, so you have to send a whole /24 down the VPN
> from the client. When you only actually wanted *one* IP address to be
> routed that way. An IP address which might not even be in even that /24
> subnet, in the general case of a p2p setup.
>
>> the one thing I'm afraid of with your new type of p2p addressing is that
>> we'd introduce yet-another topology system: net30, "old" p2p, subnet and
>> now "new" p2p - or would this simply be an extension of the never-used
>> "old" p2p topology?
> It wouldn't even be "an extension". It is *precisely* the original p2p
> mode. It would simply be a case of "this never used to work on Windows;
> now it does".
I'm still grappling for the "killer use case" for this - yes, it would be n=
ice to implement support on all platforms for all=20
modes, **BUT** I don't think anybody actually uses 'topology p2p' at this m=
oment (because Windows clients don't support it -=20
catch 22).
How would client routing become easier in this case compared to 'topology s=
ubnet' ?   you will still need to set some routes on=20
the client side - all of which can also be set in subnet mode.
Also, in theory you don't have to put a client inside the server-side netwo=
rk (/24) range in any mode - it's just a matter of=20
setting the right routing rules on both client and server, regardless of th=
e mode (net30, p2p or subnet).

Finally, in view of the fact that I seem to be the only one responding to t=
his thread, I'm afraid that not too many people are=20
getting enthousiastic ...

cheers,

JJK



