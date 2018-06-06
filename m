MIME-Version: 1.0
In-Reply-To: <46042b3b-ff87-903a-315e-dd6d577a8a39@...2181...>
References: <20180605090421.9746-1-a@...2181...>
 <20180605090421.9746-2-a@...2181...>
 <20180605143603.GL57262@...1296...>
 <CAKuzo_i5wMwqSKjH-ohK8ujSApthxNrHsbFw2k5U9q_YKb_YqA@...278...>
 <9319a55d-c27e-aa07-749d-9c998271a5c4@...2181...>
 <CAKuzo_gfgG=6LxX-s0aPReZeaXDwEBM0zfrtWxZR9JzNvkraOA@...278...>
 <20180605185352.GR57262@...1296...>
 <CAKuzo_gaiCL1Y_zbHUBjaQwxtU2WYzg5Z4zv9tDUS-J4oeoLVg@...278...>
 <20180605195935.GU57262@...1296...>
 <CAKuzo_jP1F13rw2pdRx9zF0n-7+N29u3d4FE53tL9SrwxMwk9w@...278...>
 <9a878b99-12ef-47b4-fc85-a16ecc196363@...2181...>
 <CAKuzo_hU64ML71iL7Xdt5_k08QLXwDytXd1W2TVze=7SUhLLSQ@...278...>
 <46042b3b-ff87-903a-315e-dd6d577a8a39@...2181...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 6 Jun 2018 13:07:48 -0400
Message-ID: <CAKuzo_j5YRU-aYh=1hOCmH73tn3fFfmqPLeeTh3H8nrGv-NPmQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH 1/5] tun: ensure interface can be
 configured with IPv6 only
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Antonio Quartulli <a@...2181...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi

On Wed, Jun 6, 2018 at 12:02 PM, Antonio Quartulli <a@...2181...> wrote:
> Hi,
>
> On 06/06/18 23:40, Selva Nair wrote:
>>> I am not sure why you get those 2 routes. Do you have a more extensive
>>> log to show? It may help clearing up some doubts.
>>
..

>>
>> - Require either a v4 or a v6 address must be specified (this is not
>> essential for v6-only tunnels but makes the logic easier)
>>
>
> The check you already suggested to modify in open_tun() should do the
> trick, no?
> Apparently that should be enough to ensure that at least of address
> family was configured (but I haven't tested on windows yet).

Yes, it boils down to the check I had written about + your suggestion
to keep it FATAL, not WARN.

>
..

>
>> - Make sure v4 routes do not break a v6-only connection -- either
>> filter out and warn about v4 routes via the tun interface or just let
>> them fail with a warning but proceed with the rest of the tasks.
>> Setting v4 routes via other adapters should work
>>
>
> Do you think it makes sense to install other v4 routes (i.e. routes
> using the LAN gateway as next-hop) even though we have no IPv4 on tun?
> It feels like they would be totally unrelated.

I think such routes should be allowed as there is no reason to fail
them. And should work once we learn to skip the "waiting for tun to
come up with a v4 ip"
when there are no v4 routes to set on the tun/tap adapter.

> Gert? what do you think?
>
>> - Redirect-gateway with no v4 address: mutate to !ipv4 and also omit
>> the bypass route to the server. Or leaving that route in could be an
>> easier option and should work once the logic for checking the adpater
>> mentioned above is fixed
>>
>
> Yeah, this is actually happening also on linux, but it's applied
> externally to the route list. This is why I hadn't seen it before.
> I have a fix that prevents setting that route in the pipe.

Yes, this should be dependent on what is being redirected (v4 or v6)
and how the server is being reached (by v4 or v6). But to keep the
logic simple adding a bypass route when any kind of redirect-gateway
is in effect keeps the logic simple. I think that's the current state
and I don't see a need to change it.

Selva

