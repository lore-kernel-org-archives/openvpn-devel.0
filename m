MIME-Version: 1.0
In-Reply-To: <30206ee5-f602-57f3-2ce4-4a7b768200f2@...2181...>
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
 <CAKuzo_jLhL=pLrkRoqWXHPRLzBGBiUCgq20Wzxd+DiidoAmOJA@...278...>
 <30206ee5-f602-57f3-2ce4-4a7b768200f2@...2181...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 7 Jun 2018 12:43:12 -0400
Message-ID: <CAKuzo_iurDewSjgZXfL=npR0MWduJHGx1yOrfkstu0t2QDVQBA@...278...>
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
>
>> Note: All that said, I can't seem to connect to the server via ipv6
>> when there is no v4 address. tracert fails before the first hop.
>> v6 does work when ifconfig is not filtered out.
>>
>> One difference from my  earlier test using your previous
>> version with the minor change to allow tap initialize is that the tap
>> adapter now gets the link-local v4 address (169.254.x.y) as opposed to
>> staying at 0.0.0.0 earlier. But this may be just dependent on the order
>> in which I tried various combinations and may not matter.
>>
>
> This happens because I have factored out the set 0/0/0 in open_tun(). I
> have added a "if (tt->did_ifconfig_setup)" that prevents the entire
> setup if no ipv4 is present. I wanted to see if this could make any
> difference. Should be at tun.c:5721. Feel free to remove that if and see
> if it makes any difference again.

Oh, no, that wont work. Some configuration steps for the tap will not happen
in this case -- one of the ioctls (TUN or POINT_TO_POINT) needs to happen.

See the two-line diff I had sent earlier.

So that explains why the tunnel doesn't work when no v4 address is set.

While we do need to do further tests to ensure setting tap for TUN
mode using 0/0/0 doesn't break anything, skipping it is not an option.

Selva

