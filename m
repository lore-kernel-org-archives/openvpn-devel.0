References: <20200530000600.1680-1-a@...2181...>
 <20200530000600.1680-3-a@...2181...> <20200601104048.GJ1431@...1296...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <6a0587ff-47bf-1082-2d48-a170400d0ea1@...2181...>
Date: Mon, 1 Jun 2020 21:58:23 +0200
MIME-Version: 1.0
In-Reply-To: <20200601104048.GJ1431@...1296...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v4 2/7] pool: allow to configure an
 IPv6-only ifconfig-pool
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net, Antonio Quartulli <antonio@...515...>

Hi,

On 01/06/2020 12:40, Gert Doering wrote:
> Hi,
> 
> On Sat, May 30, 2020 at 02:05:55AM +0200, Antonio Quartulli wrote:
>> From: Antonio Quartulli <antonio@...515...>
>>
>> With this change a server is allowed to allocate an
>> IPv6-only pool. This is required to make it capable
>> of managing an IPv6-only tunnel.
>>
>> Trac: #208
>> Signed-off-by: Antonio Quartulli <antonio@...515...>
>>
>> ---
>> Changes from v3:
>> - properly compute pool size taking into account the actual base address
> 
> Alas, we need a v5 of this patch.
> 
> One part is purely cosmetic...
> 
>> +        msg(D_IFCONFIG_POOL, "IFCONFIG POOL: base=%s size=%d",
>> +            print_in_addr_t(pool->ipv4.base, 0, &gc), pool->ipv4.size);
> 
> I think it should print "IFCONFIG POOL IPv4: ..." here, to make it
> symmetric with IPv6.  Which is what we want, two equally-well supported
> protocols, not "the primary" and "IPv6" :-)

Yeah, sounds good!


> 
> 
> The other part is bigger, unfortunately...
> 
> 
> Mon Jun  1 12:18:05 2020 us=584985 194.97.140.21:32015 [cron2-freebsd-tc-amd64] Peer Connection Initiated with [AF_INET6]::ffff:194.97.140.21:32015
> 
> Program received signal SIGSEGV, Segmentation fault.
> ifconfig_pool_release (pool=0x0, hand=-1, hard=hard@...1851...=false) at pool.c:361
> 361         int pool_size = ifconfig_pool_size(pool);
> 
> 
> if you have a server that has *no* pools configured, no v4 and no v6 
> pool (because address management is done outside openvpn) it will crash
> the first time a given client reconnects.
> 
> GDB backtrace:
> 
> (gdb) where
> #0  ifconfig_pool_release (pool=0x0, hand=-1, hard=hard@...1851...=false)
>     at pool.c:361
> #1  0x000055555558cc20 in multi_close_instance (m=0x7fffffffc520, 
>     mi=0x55555567d9a0, shutdown=<optimized out>) at multi.c:667
> #2  0x000055555558e852 in multi_delete_dup (new_mi=0x5555556bf620, 
>     m=0x7fffffffc520) at multi.c:1382
> #3  multi_connection_established (m=m@...1851...=0x7fffffffc520, 
>     mi=mi@...1851...=0x5555556bf620) at multi.c:1820
> #4  0x000055555558fccd in multi_process_post (m=m@...1851...=0x7fffffffc520, 
>     mi=0x5555556bf620, flags=flags@...1851...=5) at multi.c:2404
> #5  0x00005555555901d2 in multi_process_incoming_link (
>     m=m@...1851...=0x7fffffffc520, instance=instance@...1851...=0x0, 
>     mpp_flags=mpp_flags@...1851...=5) at multi.c:2768
> #6  0x000055555558a3dc in multi_process_io_udp (m=0x7fffffffc520) at mudp.c:231
> #7  tunnel_server_udp_single_threaded (top=0x7fffffffd580) at mudp.c:356
> #8  0x0000555555594fc9 in openvpn_main (argc=2, argv=0x7fffffffe588)
>     at openvpn.c:309
> #9  0x00007ffff7a86deb in __libc_start_main () from /lib64/libc.so.6
> #10 0x000055555555e86a in _start () at mudp.c:63
> 
> 
> Not sure what is happening here - that part of the code hasn't been 
> touched.  Still, a "master" server with the same config (no pools,
> client ifconfig by means of ccd/ files) does not crash.
> 
> 
> The ccd file looks like this:
> 
> --------------------------------------
> vlan-pvid 200
> 
> # braucht explizites ifconfig*push wegen "kein pool"
> ifconfig-push 10.204.4.10 255.255.255.0
> ifconfig-ipv6-push fd00:abcd:204:4::a:10/64 fd00:abcd:204:4::1
> 
> # for 2.3
> push "tun-ipv6"
> --------------------------------------
> 
> 
> Interesting enough, if I run "master" with the same config and do the
> same things, with a breakpoint set on ifconfig_pool_release(), I get
> a call that looks just the same:
> 
> Breakpoint 1, ifconfig_pool_release (pool=0x0, hand=-1, hard=hard@...1851...=false)
>     at pool.c:277
> 
> ... but continue'ing will just do that, not crash.
> 
> 
> 
> Ah. So trivial...
> 
> ifconfig_pool_release(struct ifconfig_pool *pool, ifconfig_pool_handle hand, con
> ...
>     int pool_size = ifconfig_pool_size(pool);
> 
>     if (pool && hand >= 0 && hand < pool_size)
> 
> 
> ...
> ifconfig_pool_size(const struct ifconfig_pool *pool)
> ...
>     if (!pool->ipv4.enabled && !pool->ipv6.enabled)
>     {
>         return 0;
>     }
> 
> 
> ... but if *neither* is enabled, "pool" actually is NULL...  so this
> needs to become something like this
> 
>     if (pool == NULL
>         || (!pool->ipv4.enabled && !pool->ipv6.enabled) )
>     {
>         return 0;
>     }
> 
> 
> ... which fixes the crash for good (all callers will verify that 
> "hand < size" etc.).

Oh yeah - I missed this code path where pool_size() could be invoked
with a null pool.

Will fix and send a v5.

Thanks a lot for digging into this!


-- 
Antonio Quartulli

