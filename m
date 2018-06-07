MIME-Version: 1.0
In-Reply-To: <20180607165705.GP57262@...1296...>
References: <CAKuzo_gfgG=6LxX-s0aPReZeaXDwEBM0zfrtWxZR9JzNvkraOA@...278...>
 <20180605185352.GR57262@...1296...>
 <CAKuzo_gaiCL1Y_zbHUBjaQwxtU2WYzg5Z4zv9tDUS-J4oeoLVg@...278...>
 <20180605195935.GU57262@...1296...>
 <CAKuzo_jP1F13rw2pdRx9zF0n-7+N29u3d4FE53tL9SrwxMwk9w@...278...>
 <9a878b99-12ef-47b4-fc85-a16ecc196363@...2181...>
 <CAKuzo_hU64ML71iL7Xdt5_k08QLXwDytXd1W2TVze=7SUhLLSQ@...278...>
 <CAKuzo_gp9jcVocxgf79TNQpgP-ScioC1pM_3oTq9+SHHAhEonw@...278...>
 <665fcdae-dad7-b6c8-14ee-512ff7992963@...2181...>
 <CAKuzo_jLhL=pLrkRoqWXHPRLzBGBiUCgq20Wzxd+DiidoAmOJA@...278...>
 <20180607165705.GP57262@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 7 Jun 2018 13:05:19 -0400
Message-ID: <CAKuzo_j23Y5Q367cug-usSheh5h6WXUqswOqNBVS3073rMesVw@...278...>
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
To: Gert Doering <gert@...1296...>
Cc: Antonio Quartulli <a@...2181...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On Thu, Jun 7, 2018 at 12:57 PM, Gert Doering <gert@...1296...> wrote:
> Hi,
>
> On Thu, Jun 07, 2018 at 12:14:51PM -0400, Selva Nair wrote:
>> Note: All that said, I can't seem to connect to the server via ipv6
>> when there is no v4 address. tracert fails before the first hop.
>> v6 does work when ifconfig is not filtered out.
>
> This "should not happen".
>
> v6 should work no matter what we break in v4 land.
>
> But this is windows, and "should work" land...

It happens because the patch skips CONFIG_TUN ioctl when v4 address is
not set. I think that skips some initialization steps. I had expected
the patch to setup the driver using 0/0/0 as the addres/mask/net as we
discussed earlier. Fixing that should make the tap driver talk back to
us and v6 work.

Selva

