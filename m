MIME-Version: 1.0
In-Reply-To: <9a878b99-12ef-47b4-fc85-a16ecc196363@...2181...>
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
From: Selva Nair <selva.nair@...277...>
Date: Wed, 6 Jun 2018 11:40:40 -0400
Message-ID: <CAKuzo_hU64ML71iL7Xdt5_k08QLXwDytXd1W2TVze=7SUhLLSQ@...278...>
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

Hi,

On Wed, Jun 6, 2018 at 7:33 AM, Antonio Quartulli <a@...2181...> wrote:
> Hi,
>
> On 06/06/18 04:30, Selva Nair wrote:
>>>> However, even with !ipv4, redirect-gateway ipv6 appears to error out
>>>> -- it fails with
>>>>
>>>> "TEST ROUTES: 0/2 succeeded len=1 ret=0 a=0 u/d=up
>>>> Route: Waiting for TUN/TAP interface to come up..."
>>>
>>> Interesting.  This is route.c, test_routes(), using test_route_helper()
>>> -> test_route(), which basically tries to find the adapter index where
>>> a given (route)->gateway is configured on.  Since it cannot find anything,
>>> it assumes "tun interface is stuck in DHCP" and is unhappy.
>>>
>>> This shouldn't actually try to do anything in the first place - it
>>> looks at "struct route_list *rl", which should not be populated if
>>> we have no v4 address to point the routes to.  (Or maybe it should,
>>> but only for "non-tun/tap routes").
>>
>> Yeah, we cant ignore v4 routes completely. So the logic for checking the
>> tun is ready has to change?
>>
>
> I am not sure why you get those 2 routes. Do you have a more extensive
> log to show? It may help clearing up some doubts.

Don't have access to those logs right now -- will post later.

I had looked into it further and noticed that there was one other v4
route being pushed from the server. On taking that out the error still
persisted but with "TEST ROUTES: 0/1...".

That one remaining route was from redirect-gateway: even with
"redirect-gateway !ipv4", the direct v4 route to the server is being
set (redundant but shouldn't hurt). That route did succeed but our
logic for testing routes involves waiting for the interface to come up
with a v4 address which needs some tweaking.

On Windows, v4-only works as long as a ifconfig address is in the
config (or pushed) as the address/mask is required for the tap driver.
Adding some v6 routes doesn't break it (I think) although those routes
may fail with warnings if there is no v6 address. I would like to see
v6-only work with minimal caveats as well. So, some
suggestions/comments for Windows:

- Require either a v4 or a v6 address must be specified (this is not
essential for v6-only tunnels but makes the logic easier)

- The tap ioctl appears to work with 0/0 as address/mask, so no
special treatment needed there --- (improve the logging in this case).
This may need more testing

- Wait for the interface to come up only if a v4 address is specified
(this wait is needed as the address may be set asynchronously by dhcp,
unlike other platforms)

- Skip the above wait if there is no v4 address. As v6 address is set
synchronously no wait needed -- or change the logic used for deciding
whether the interface is up or not

- Make sure v4 routes do not break a v6-only connection -- either
filter out and warn about v4 routes via the tun interface or just let
them fail with a warning but proceed with the rest of the tasks.
Setting v4 routes via other adapters should work

- Redirect-gateway with no v4 address: mutate to !ipv4 and also omit
the bypass route to the server. Or leaving that route in could be an
easier option and should work once the logic for checking the adpater
mentioned above is fixed

- Test block-outside-dns (just to be sure as failure there is FATAL).

>
> On Linux the route_list is empty when there is no v4 and
> "gateway-redirect !ipv4" is set.

Some how on Windows the bypass route gets set even with !ipv4. But
as said above that and any other non-tap routes should just work.

Selva

