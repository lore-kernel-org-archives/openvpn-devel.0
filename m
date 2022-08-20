Date: Sat, 20 Aug 2022 16:01:02 +0200 (CEST)
Message-Id: <202208201401.27KE12Cm014083@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220812134154.16729-3-kprovost@...2661...>
References: <20220812134154.16729-3-kprovost@...2661...>
Subject: [Openvpn-devel] [PATCH applied] Re: Support creating iroute route
 entries on FreeBSD
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
To: Kristof Provost <kp@...1376...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Stared-at-code, tested on FreeBSD 14 with and without DCO as client, 
and with DCO as server, with a number of interesting iroute problems
(--route /24, --iroute /32, --route /24 and --iroute same /24, no
--route at all, but --iroute /24).  See below.

The "big packet / fragment" thing still haunts us, but that's not something
this patch would address, so out of scope wrt "does iroute work".

Some notes

 - uncrustify had some remarks on #else/#endif with comments -> applied

 - inet_ntop(3) says one shouldn't use magic numbers, but
   "INET_ADDRSTRLEN and INET6_ADDRSTRLEN" - this could be addressed in
   a followup patch

 - "the rest of the code" uses print_in_addr_t() and print_in6_addr()
   today, to get a formatted IPv4/IPv6 address out of an in*_addr
   - but these excel if there is a &gc around, and adding extra 
   gc_new()/gc_free() around the argv_printf() did not really sound
   like "the resulting code is much nicer".

 - any particular reason you used argv_printf() + argv_printf_cat(),
   instead of just putting all into a single argv_printf() call?

 - the "openvpn_execve_check()" messages state "route *add* command failed",
   while it could be "del" as well.  Making this "proper" might not be
   worth it, as it would need string manipulation (or "duplicate whole
   message").

 - iroute installation works for the easy cases (--route in server.conf,
   --iroute with a more-specific of that in ccd/).  It does not work
   for the nasty cases (--route and --iroute with same netbits).

   I will send a followup e-mail with more details on this soon.


 - route *deletion* does not work for IPv4 host routes, because of
   "other code stupidity" - this is not a problem of your code, but
   of an omission in dco.c (and I do wonder why this works for Linux)

	2022-08-20 14:06:56 us=764185 /sbin/route del -net 10.114.200.74/-1 10.114.2.8 - fib 0
	route: bad mask length: -1

   our internal routes carry a flag structure that says "this is a host
   route!!" and if it is, "netbits" is not valid and needs to be set
   to 32 / 128 explicitly.  This is pending a larger refactoring, but
   for the time being, I'll send a patch to fix this in dco.c
   (interesting enough, my code for IPv6 does this correctly, only the
   old IPv4 cruft...)

 - in one case I saw something that looks like a race condition between
   DCO, "ifconfig route propagation", and "route add"

	2022-08-20 15:14:58 us=882323 DCO device tun1 opened
	2022-08-20 15:14:58 us=882357 do_ifconfig, ipv4=1, ipv6=1
	2022-08-20 15:14:58 us=882393 /sbin/ifconfig tun1 10.114.2.1 10.114.2.2 mtu 1500 netmask 255.255.255.0 up
	2022-08-20 15:14:58 us=887080 /sbin/route add -net 10.114.2.0 10.114.2.2 255.255.255.0
	add net 10.114.2.0: gateway 10.114.2.2
	2022-08-20 15:14:58 us=890690 /sbin/ifconfig tun1 inet6 fd00:abcd:114:2::1/64 mtu 1500 up
	2022-08-20 15:14:59 us=902853 /sbin/ifconfig tun1 inet6 -ifdisabled

	2022-08-20 15:15:02 us=57619 freebsd-74-amd64/2001:608:0:814::f000:3 /sbin/route add -net 10.114.202.74/32 10.114.2.8 -fib 0
	route: writing to routing socket: Network is unreachable
	add net 10.114.202.74: gateway 10.114.2.8 fib 0: Network is unreachable

   ... repeating the "route add" call manually (copy-paste) worked without
   error, so I'm not sure what upset things here.  3 Seconds between 
   interface init and route addition should be more than enough for 
   cooldown as well.


Your patch has been applied to the master branch.

commit 3433577a99270845cbce7fe738534e0b0ffd5780
Author: Kristof Provost
Date:   Fri Aug 12 15:41:54 2022 +0200

     Support creating iroute route entries on FreeBSD

     Signed-off-by: Kristof Provost <kprovost@...2661...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220812134154.16729-3-kprovost@...2661...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24895.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


