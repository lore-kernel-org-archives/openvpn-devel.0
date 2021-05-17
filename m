References: <20200717171036.20687-1-davids@...515...>
 <6062d64c-14ef-0e0d-4e83-925b79b4900b@...1227...>
 <7030cf8b-d047-107d-21b8-f02c8a1338c9@...1227...>
 <77750051-9589-15db-34cb-3aacc8b69694@...2181...>
 <c120ccab-50b8-fc24-1edc-6229d2b75ac5@...1856...>
 <a2007ed7-87ae-9445-17ef-643c6729c447@...1227...>
 <11e69821-1b9b-7aa2-b865-16ac4dd6977f@...2080...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <0cea895c-02df-1d39-13cb-91afc9ef9650@...1227...>
Date: Mon, 17 May 2021 12:43:27 +0200
MIME-Version: 1.0
In-Reply-To: <11e69821-1b9b-7aa2-b865-16ac4dd6977f@...2080...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH] Remove --no-replay
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: David Sommerseth <openvpn@...2080...>, Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

Am 17.05.21 um 01:58 schrieb David Sommerseth:
> On 16/05/2021 19:14, Arne Schwabe wrote:
> 
> First of all, I do like Steffan's proposal:
> 
>> Remove the option, and:
>>  * if auth != none -> replay prevention is always enabled;
>>  * if auth == none -> replay prevention is disabled.
> 
> And with "remove the option", if it exists in a config, it should be
> considered a NOOP.

If I am not mistaken no-replay changes the wire-format so we cannot
ignore it when present. I vaguely remember that the packet id does not
get added to cbc mode packets if no-replay is active.

> Then on compatibility ...
> 
>>> Given 2, how clear is our timeline on sunsetting non-AEAD ciphers? That
>>> would automatically sunset --no-replay. (I've lost track a bit...)
>>
>> Heated debate as that is equal to drop compatibility completely with
>> OpenVPN 2.3. We have already a heated debate if dropping 2.3 config
>> compatibility is possible or not (e.g. you need to add ciphers to
>> data-ciphers to still to connect to a 2.3 peer).
> 
> Just to be clear, since I have been involved in several of these
> discussions.  I consider 2.3 dead.  I care about 2.4 and upwards, based
> on the agreement we had long time ago about which versions we want to
> support [0].  2.3 is now in git-only support and we have only promised
> that support level until end of June (essentially ~6 more weeks).
> 
> [0] <https://community.openvpn.net/openvpn/wiki/SupportedVersions>
> 
> For me, I care only about 2.4 and newer at this point.  If someone
> desperately need to support 2.3 clients, it is not our task to provide
> such support.  If someone need a 2.6 client to connect to a 2.3 server,
> that is also not our task to provide.  If 2.3 is so badly needed, you
> cannot expect to blend in 2.6 without issues.

That is always easy to say if you don't have to deal with the users.


> What I do care about is that _client_ configuration files targetted for
> _2.4_ clients can connect to 2.4 and newer servers without modifying the
> configuration files.  But I am at the same time willing to accept that
> DCO will change that game.  Also, if a site has deployed a server
> configuration for 2.5 or 2.6 explicitly and have accordingly scoped
> their client configuration for the same version, supporting older
> clients should _not_ be expected to work.  But for existing 2.4 servers,
> we should not break configurations on 2.4 or newer clients.  So
> basically, 2.4/2.5/2.6 should be able to work out-of-the-box without any
> changes, regardless of versions.
> 
> However, if connecting to a *DCO enabled host*, updating client
> configurations *is* acceptable *because* that is a completely new
> technology which is not targetting everything 2.4 supports by design
> *and* _not_ making use of DCO will still work.


I think people that upgrade their clients should also able to benefit
from DCO. And in most setups distributing new configuration files is not
so easy. So if extra steps are needed to enable DCO, most people will
simply not use DCO or worse, end up with a setup that doesn't work
anymore if they switch to ovpn-dco-win.

> 
> For sites wanting to support both DCO and non-DCO, we could consider
> looking into ensuring that connection-blocks can be used where the
> server side will have an openvpn server running with DCO and another one
> without DCO.  This means adding DCO on an already existing server could
> be done using a different port or IP address (--local).  Unless we want
> ovpn-dco to be able to be a simple and passive forwarder of both control
> and data channel packets if the configuration is not DCO compliant.

This whole discussion is mute if you don't want support 2.3 anyway as
the problem does not exist if you want to support 2.4+ only.

> 
> But I also do know NCP is a bit tricky with the current DCO
> implementation, where this needs to be settled on a DCO supported cipher
> before connecting.  Maybe we should consider a similar approach to
> OpenVPN 3, where the tun/DCO interface is setup *after* the connection
> to the server has been established with the PUSH_REPLY received and pass
> UDP/TCP socket to ovpn-dco at that point *if* the server side
> cipher/auth/compression is compliant with DCO?  (Otherwise, use a tun
> interface)

OpenVPN 2.x can also work without pull. Most importantly the server
needs to open the interface before any connection. And I think also
OpenVPN3 breaks apart when you put persist-tun into the mix. Furthermore
under Windows with ovpn-dco-win this approach does not work at all anyway.

Arne

