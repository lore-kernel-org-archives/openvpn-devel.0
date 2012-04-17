Message-ID: <4F8D2C40.2060609@...515...>
Date: Tue, 17 Apr 2012 11:39:28 +0300
From: =?UTF-8?B?U2FtdWxpIFNlcHDDpG5lbg==?= <samuli@...515...>
MIME-Version: 1.0
References: <4F7DA7EF.1010709@...515...>
	<CAOazyz2K0RDYv-zgVt+FUb9Egwykj0Aft9KvxUuQoF0WEf=xKw@...278...>
	<CAHyOtRmSpUxdtGeFYbu=CQ-erZMS54hXG9zxOC=cDO9vXnBn0A@...278...>
	<CAOazyz0WbwVO4QGDomZWycfwhmb_eHHVZpyQqpD0FDOqpt+1Xg@...278...>
	<4F84562E.3020208@...1114...>
	<CAOazyz1oxqCt-4UVyc71YhMq04bQY9+TrTJyGqa4Sjfe0-sykQ@...278...>
In-Reply-To: <CAOazyz1oxqCt-4UVyc71YhMq04bQY9+TrTJyGqa4Sjfe0-sykQ@...278...>
Subject: Re: [Openvpn-devel] ACK system review finished
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

Hi Alon,
>
> Current active developers are interested in specific features which
> are never complete.
>
> For example Gert cares about the IPv6 implementation, but did not take
> all the routing and tun handling on him self as a whole.
>
> Adriaan added the PolarSSL support, but did not take all the crypto
> interfaces of OpenVPN.
>
> Heiko took the MSVC build + unicode support, bit did not take the
> windows (non-tun none-routing) subsystem.
I think having subsystem maintainers would make sense. Current
feature-based development will probably work for a few years, but as you
say, it can result in problems down the road. That said, there are a few
practical obstacles if we take the subsystem maintainer approach:

1) Do the developers have the (extra?) time to commit to the project
2) Do the developers have enough knowledge to take over a subsystem? If
not, go to 1).

What would the core tasks for subsystem maintainers be, in your view?

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


