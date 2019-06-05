Date: Wed, 5 Jun 2019 12:34:39 +0200 (CEST)
Message-Id: <201906051034.x55AYdRT080096@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20181219050118.6568-6-a@...2181...>
References: <20181219050118.6568-6-a@...2181...>
Subject: [Openvpn-devel] [NAK] Re: route.c: use sitnl to implement
 get_default_gateway_ipv6()
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
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

Unfortunately, I need to NAK this, because this will break some people's
use of OpenVPN in an IPv6 context (namely, where the OpenVPN server is
sitting in the same LAN as the client - think "EduRoam WiFi").


I did the same thing as before - built an iproute2 binary and a sitnl
binary, and tested t_client plus some manual commands.

Under some conditions, the output is *differen*, and this is very bad.

Here's the output of "openvpn --show-gateway" for my local network...

iproute2 build:
Wed Jun  5 12:04:53 2019 ROUTE6_GATEWAY fe80::250:43ff:fe01:dc37 IFACE=enp0s25

sitnl build:
Wed Jun  5 12:04:56 2019 ROUTE6_GATEWAY fe80::250:43ff:fe01:dc37 ON_LINK IFACE=enp0s25

which I find surprising, since they should both use the same backend
now...?  "Older binaries" print the gateway without ON_LINK.

It gets weirder... if I ask for something which actually *is* on-link
(another address out of my on-link subnet), I get the same thing:

$ src/openvpn/openvpn --show-gateway 2001:608:4::1

iproute2 build:
Wed Jun  5 12:19:37 2019 ROUTE6_GATEWAY :: IFACE=enp0s25

sitnl build:
Wed Jun  5 12:18:20 2019 ROUTE6_GATEWAY :: ON_LINK IFACE=enp0s25 HWADDR=00:00:00:00:54:57

and *sometimes*
Wed Jun  5 12:19:56 2019 ROUTE6_GATEWAY :: IFACE=enp0s25


while my old code alwyays prints

Wed Jun  5 12:24:51 2019 ROUTE6_GATEWAY 2001:608:4::1 ON_LINK IFACE=enp0s25

("what you are looking for is on this link and it is the gateway").



This is a regression and needs to be fixed -> so, NAK.  

On-Link targets always need to have ON_LINK set for both builds, off-link 
targets (if there exists a default-gateway) must never have it set, and 
the gateway address should.

I have no idea what is going wrong here, because both implementations
should behave exactly the same, since they use the same backend - but
this smells like "something is not correct, and it depends on build
or run-time factors".  Maybe something isn't properly initialized 
when rewriting this...  the bug is not in code that is introduced
by this patch (it's hiding in networking_sitnl.c, I assume) but this
patch is what activates the code path, 


A few comments on the actual code changes :-) - the introduction of 
*ctx here cannot be avoided.

This strikes me as a bit funky, though...

+    struct in_addr gw;
+    CLEAR(gw);

.. and then "gw" is not used at all?

The introduction of a "flags" temporary variable can be certainly be
argued about (I find it less readable for a one-shot comparison), but 
if you do, why not define it where it's used (C99)?

While at it, please kick out the definition of "struct rtreq" in
route.c, right above the TARGET_LINUX get_default_gateway_ipv6() - no
longer needed since we do not do the netlink stuff here anymore.


thanks,

gert

--
kind regards,

Gert Doering


