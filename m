Date: Thu, 6 Oct 2022 11:10:59 +0200 (CEST)
Message-Id: <202210060910.2969AxkL043029@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220628082024.19059-1-a@...2181...>
References: <20220628082024.19059-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: do not push route-ipv6 entries
 that are also in the iroute-ipv6 list
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

Stared-at-code for a bit...

The remove_iroutes_from_push_route_list() function would benefit from
our new "early exit" style - but that's outside the scope of this patch
(and actually not changing both at the same time helps readability).

The way the change is done is symmetric v4/v6, so whatever quality
problems the code might have, it's not introduced by this patch.

If I had written, this, I might have used "ir6" as iterator variable
for "struct iroute_ipv6 *ir6", but this is really minor - the code
is clear enough.

As a matter of optimization, I'd compare "netbits" first, and only then
run the memcmp()) - but for the normal volumes of ipv6 iroutes that
OpenVPN instances handle, this is inconsequential, and for Really Huge
Installations with 10.000s of iroutes, the "walk a linked list" approach
stinks anyway, one might want to change this to an iroute* hash lookup...


Tested on the FreeBSD 14 DCO instance, which excercises "push route-ipv6"
and "iroute-ipv6" quite heavily, with various netmasks, to see if
client-to-client routing works properly:

Client #1 "has no iroutes"

Oct  6 10:12:10 fbsd14 tun-udp-p2mp[43951]: SENT CONTROL [cron2-ubuntu-2004-amd64]: 'PUSH_REPLY,route 10.114.0.0 255.255.0.0,route-ipv6 fd00:abcd:114::/48,route-ipv6 fd00:abcd:114:200::74/128,route 10.114.201.0 255.255.255.0,route 10.114.201.0 255.255.255.128,route-ipv6 fd00:abcd:114:201::/64,route-ipv6 fd00:abcd:114:201::/65,route 10.114.202.74 255.255.255.255,route-ipv6 fd00:abcd:114:202::74/128,...,key-derivation tls-ekm' (status=1)

Client #2 "has all these more-specific iroutes, v4+v6"

Oct  6 10:12:52 fbsd14 tun-udp-p2mp[43951]: freebsd-74-amd64/2001:608:0:814::f000:3 SENT CONTROL [freebsd-74-amd64]: 'PUSH_REPLY,route 10.114.0.0 255.255.0.0,route-ipv6 fd00:abcd:114::/48,...,cipher AES-256-GCM' (status=1)

-> so, it works as it says on the tin, all matching iroute/iroute-ipv6
are removed from the to-be-pushed route/route-ipv6 entries, and it
says so in the log:

Oct  6 10:12:51 ... REMOVE PUSH ROUTE: 'route-ipv6 fd00:abcd:114:200::74/128'
Oct  6 10:12:51 ... REMOVE PUSH ROUTE: 'route 10.114.201.0 255.255.255.0'
Oct  6 10:12:51 ... REMOVE PUSH ROUTE: 'route 10.114.201.0 255.255.255.128'
Oct  6 10:12:51 ... REMOVE PUSH ROUTE: 'route-ipv6 fd00:abcd:114:201::/64'
Oct  6 10:12:51 ... REMOVE PUSH ROUTE: 'route-ipv6 fd00:abcd:114:201::/65'
Oct  6 10:12:51 ... REMOVE PUSH ROUTE: 'route 10.114.202.74 255.255.255.255'
Oct  6 10:12:51 ... REMOVE PUSH ROUTE: 'route-ipv6 fd00:abcd:114:202::74/128'

(the funny ordering comes from "this is the ordering of the push statements
in the server.conf", so, yes, this is as expected)


I discussed inclusion in release/2.5 with Antonio, and we agree that
this is more a "missing feature" than a bug, so I've not backported
it for now (it should apply trivially, so if someone comes screaming,
we can always do so).

Your patch has been applied to the master branch.

commit 437812d4eac9ac892fbfd2fd97c50384b2d2ec07
Author: Antonio Quartulli
Date:   Tue Jun 28 10:20:24 2022 +0200

     do not push route-ipv6 entries that are also in the iroute-ipv6 list

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Heiko Hund <heiko@...2662...>
     Message-Id: <20220628082024.19059-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24577.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


