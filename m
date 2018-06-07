MIME-Version: 1.0
In-Reply-To: <665fcdae-dad7-b6c8-14ee-512ff7992963@...2181...>
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
 <CAKuzo_gp9jcVocxgf79TNQpgP-ScioC1pM_3oTq9+SHHAhEonw@...278...>
 <665fcdae-dad7-b6c8-14ee-512ff7992963@...2181...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 7 Jun 2018 12:14:51 -0400
Message-ID: <CAKuzo_jLhL=pLrkRoqWXHPRLzBGBiUCgq20Wzxd+DiidoAmOJA@...278...>
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
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On Thu, Jun 7, 2018 at 1:51 AM, Antonio Quartulli <a@...2181...> wrote:
>
> Hi Selva,
>
> I have tried to account most of your comments, but something might still
> be off. Building openvpn for Windows might need some time here as I
> don't have the entire environment ready yet.
>
> Would you mind giving my latest branch a try and let me know how it goes
> with regards to your previous observations?



Did some quick tests and this seems to work quite well (but see the
note at the bottom):

- v4 routes via tun just fail with a warning which is good (our route
errors not being FATAL pays off here)
- v4 routes via net_gateway just works : no idea why we support this,
but good to see this patch doesn't break it
- redirect-gateway causes warnings as v4 routes fail:
  If its not too hard could we check !tt->did_ifconfig_setup before
attempting v4 redirect? Saying this because "--redirect-gateway with
no options automatically implies ipv4" is just a hangover from the
past that we are stuck with. For other routes it may be harder to
detect whether its via the tun or not so just letting them error out
is fine. And those warnings provide useful feedback to the user.

A minor thing:

- The warning
"WARNING: OpenVPN was configured to add an IPv4 route. However, no
IPv4 has been configured for this interface, therefore the route
installation may fail or may not work as expected."
is printed without the M_WARN flag  --- so syslog won't see it as a
warning nor does the GUI. M_INFO|M_WARN will make it print at verb > 0
with the warning tag. If that sounds like a strange combination,
invent a warning level like D_GENERIC_WARNING = LOGLEV(1,0,M_WARN). We
don't have one.

Note: All that said, I can't seem to connect to the server via ipv6
when there is no v4 address. tracert fails before the first hop.
v6 does work when ifconfig is not filtered out.

One difference from my  earlier test using your previous
version with the minor change to allow tap initialize is that the tap
adapter now gets the link-local v4 address (169.254.x.y) as opposed to
staying at 0.0.0.0 earlier. But this may be just dependent on the order
in which I tried various combinations and may not matter.

So, is the tap-driver mis-behaving when the v4 ip/net/mask is set as
0/0/0 ? Will test this further when I get time later today.

Thanks for working on this,

Selva

