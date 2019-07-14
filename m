References: <20181207142003.73175-1-gert@...1296...>
 <20181207202829.76371-1-gert@...1296...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <720328c3-d976-844e-4903-104f11954603@...1856...>
Date: Sun, 14 Jul 2019 11:39:10 +0200
MIME-Version: 1.0
In-Reply-To: <20181207202829.76371-1-gert@...1296...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH v3] Stop state-exhaustion attacks from a
 single source address.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi,

Sorry for the terrible response time, but here goes for initial review:

On 07-12-18 21:28, Gert Doering wrote:
> If an attacker sends lots of RESET packets from different source
> ports (but the same source address), every packet will create a
> new multi_instance, leading to resource waste on the server, and
> to lots of reply packets while OpenVPN tries to establish a
> TLS handshake.
> 
> This can be rate-limited with "connect-freq", but if this is set
> too tightly, an attacker can drown out legitimate users of the
> same OpenVPN server.
> 
> So, when deciding whether or not to create a new instance, iterate
> over all existing instances, counting all from the same source IP
> (ignoring source port info) that are "in TLS negotiation" state -
> if more than <n> instances are already active, refuse new instance.
> 
> The cutoff parameter can be configured by a newly introduced 3rd
> argument to "connect-freq".  So something like this might be
> reasonable for a medium-sized server:
> 
>    connect-freq 20 20 3
> 
> ("permit 20 new connections per 20 seconds, but only 3 from the same
> source IP address")
> 
> Drawback: if many users are sitting behind a shared NAT ip address
> and they all reconnect at the same time, session setup will take
> longer for some of the users while the server is still handshaking
> with others.

This seems a very reasonable way - on top of tls-auth/tls-crypt - to
mitigate floods from a single IP. I'm not very familiar with this code
paths, what happens when a cient gets rejected? Does it get told "try
next server", or do we give it a silence treatment?

Also, I think it would be nice to have separate log messages in the
server log for "generic limit reached" and "per-ip limit reached".

Finally, aside from removing the debug prints, this will need some
whitespace polishing. The patch mixes tabs/spaces and styles surrounding
the parentheses in ifs.

-Steffan

