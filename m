Message-ID: <a6de8a2b-feea-fe02-0162-2f70d23190f1@...2181...>
Date: Wed, 24 Aug 2022 00:51:37 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220820140124.11325-1-gert@...1296...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <20220820140124.11325-1-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] DCO: require valid netbits setting for
 non-primary iroutes.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

Hi,

On 20/08/2022 16:01, Gert Doering wrote:
> The existing DCO code had extra logic for "if this is not
> MR_WITH_NETBITS, set 32/128 as address length", but only for
> iroute addition.  For iroute deletion, this was missing, and
> subsequently iroute deletion for IPv4 host routes failed on
> FreeBSD DCO (commit 3433577a99).
> 
> Iroute handling differenciates between "primary" iroutes (coming
> from anm IP pool or ccd/ifconfig-push), and "non-primary" iroutes,
> coming from --iroute and --iroute-ipv6 statements in per-client config.
> 
> "Primary" iroutes always use "-1" for their netbits, but since these
> are not installed via DCO, this is of no concern here.  Whether these
> can and should be changed needs further study on internal route
> learning and cleanup.
> 
> Refactor options.c and multi.c to ensure that netbits is always set
> for non-primary iroutes - and ASSERT() on this in the DCO path, so we can
> find out if there might be other code violating this.
> 
> Change options.c::option_iroute() to always set netbits=32 for IPv4
> host routes (options_iroute_ipv6() never differenciated).  Since
> netmask_to_netbits() also insists on "-1" for host routes, change
> to netmask_to_netbits2().
> 
> Remove all the extra MR_WITH_NETBITS logic from dco.c, where it should
> have never appeared.
> 
> Signed-off-by: Gert Doering <gert@...1296...>

Thanks for this. It indeed makes sense and helps cleaning up a bit this 
netbits madness.

I agree with Kristof that you need to have spaces around boolean 
operator. (How come that uncrustify did not complain? we may need to add 
another toggle..)

sitnl does the right thing:

2022-08-24 00:50:50 net_route_v4_add: 8.8.8.8/32 via 10.10.0.3 dev tun0 
table 0 metric 100

So, other than the space issue:

Acked-by: Antonio Quartulli <a@...2181...>


-- 
Antonio Quartulli

