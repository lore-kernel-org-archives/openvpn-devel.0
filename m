Message-ID: <55CA0FDC.6020004@...1227...>
Date: Tue, 11 Aug 2015 17:08:12 +0200
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <55CA09E0.3020503@...2052...>
In-Reply-To: <55CA09E0.3020503@...2052...>
Subject: Re: [Openvpn-devel] SRV record support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Gergely Czuczy <gergely.czuczy@...2052...>, openvpn-devel@lists.sourceforge.net



Am 11.08.15 um 16:42 schrieb Gergely Czuczy:
> Hello,
>
> I would like to ask some help, I'm looking at the OpenVPN source tree
> from GitHub as I would like to see how much effort would it be me to add
> SRV record support, as it has increasing demand these days (and really
> makes sense, especially for enterprises).
>
> So, the question is, what would be the best place to hook up the support
> for SRV records?
> SRV record mechanism/requirements are the following:
>   - It's protocol-specific, so at lookup time it has to be known whether
> it's for UDP or TCP
If proto were optional that would fit OpenVPN better. But SRV records
seem not support that.
>   - The SRV records supply the service port, so in this case it's not
> taken from the configuration file.
>   - Basically for a service it's one or more DNS records in the
> following format:
>    _service._proto.name. TTL class SRV priority weight port target.
>    I guess _service should be _openvpn, _proto is either _tcp or _udp.
> port is obvious, and target is the target host to connect to using the
> previously specified port.
>    If there are multiple records, then priority makes sense, first the
> hosts with the lowest values have to be tried, then rest increasingly
>    If there are multiple hosts with the same priority then weight kicks
> in, a host to be chosen is determined by the weight factors. Attempts to
> a different priority can be made after all hosts from this priority are
> exhausted.

Multiple records are difficult. At the moment we have a list of
connection entries in the config which may expand into multiple
addresses (from getaddrinfo). The question if we do a dns lookup at the
start for SRV enabled connection entries and mutate these entries into
multiple entries or this should be done as part of the normal resolve
process for each entry, introducing the concept of subconnections or
something like this.

Doing a one reordering after priority and doing a weighted randomizing
between connections with same priority should not be a problem.
>
> So, basically first there has to be a lookup against the server's SRV
> record, once that lookup returned results, and the priority/weight
> algorithm returns the first candidate, the existing connection mechanism
> can be used to check it. If it succeeds, life goes on as it is
> currently, if it fails, then the prio/weight algorithm's next target has
> to be tried.
>
> So, where should I be looking at the source that would probably be a
> good place to hook this up?
>
We should have a design idea before doing that and a fair warning the
connnection connect logic is not for the faint hearted. In init.c is the
next_connection method that iterates through the server. Almost all
resolv related functions call openvpn_getaddrinfo, so going back from
there is also a good starting point.

And if you modify anything use -master and not 2.3 as starting point.
The code in question has changed a lot between releases (dual stack
client patches).

Arne

