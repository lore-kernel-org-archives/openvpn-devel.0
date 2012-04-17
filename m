MIME-Version: 1.0
In-Reply-To: <4F8D2C40.2060609@...515...>
References: <4F7DA7EF.1010709@...515...>
	<CAOazyz2K0RDYv-zgVt+FUb9Egwykj0Aft9KvxUuQoF0WEf=xKw@...278...>
	<CAHyOtRmSpUxdtGeFYbu=CQ-erZMS54hXG9zxOC=cDO9vXnBn0A@...278...>
	<CAOazyz0WbwVO4QGDomZWycfwhmb_eHHVZpyQqpD0FDOqpt+1Xg@...278...>
	<4F84562E.3020208@...1114...>
	<CAOazyz1oxqCt-4UVyc71YhMq04bQY9+TrTJyGqa4Sjfe0-sykQ@...278...>
	<4F8D2C40.2060609@...515...>
Date: Tue, 17 Apr 2012 14:47:29 +0300
Message-ID: <CAOazyz1ms=FOvXLLjKo+fYQa0JMTWi2i+C9cgY_uzaU9=L1hxw@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
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
To: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

2012/4/17 Samuli Sepp=C3=A4nen <samuli@...515...>
>
> Hi Alon,
> >
> > Current active developers are interested in specific features which
> > are never complete.
> >
> > For example Gert cares about the IPv6 implementation, but did not take
> > all the routing and tun handling on him self as a whole.
> >
> > Adriaan added the PolarSSL support, but did not take all the crypto
> > interfaces of OpenVPN.
> >
> > Heiko took the MSVC build + unicode support, bit did not take the
> > windows (non-tun none-routing) subsystem.
> I think having subsystem maintainers would make sense. Current
> feature-based development will probably work for a few years, but as you
> say, it can result in problems down the road. That said, there are a few
> practical obstacles if we take the subsystem maintainer approach:
>
> 1) Do the developers have the (extra?) time to commit to the project

If not, the large feature should not be merged at all, as they can
disappear at any time.
This is why project progressed so slowly when only James was core developer.
It is wise to do so.

> 2) Do the developers have enough knowledge to take over a subsystem? If
> not, go to 1).

They should, as large patch like IPv6 or PolarSSL are complex enough
to touch the whole subsystem, if they do not have enough knowledge so
their patch and maintenance will be low quality.

> What would the core tasks for subsystem maintainers be, in your view?

I don't exactly understand the question...
Maybe you ask what is core subsystem I refer to?
The initialization, termination, the interfaces (if we create them) to
sub modules, protocol, configuration, communications.

Alon.

