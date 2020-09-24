Date: Thu, 24 Sep 2020 12:55:26 +0200 (CEST)
Message-Id: <202009241055.08OAtQpb008689@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200924064452.1001-1-simon@...2293...>
References: <20200924064452.1001-1-simon@...2293...>
Subject: [Openvpn-devel] [PATCH applied] Re: netsh: Specify interfaces by
 index rather than name
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
To: Simon Rozman via Openvpn-devel <openvpn-devel@lists.sourceforge.net>
Cc: openvpn-devel@lists.sourceforge.net

This patch is good and a useful change (I have stared-at-code and
it make sense, and Lev has reviewed and tested it on Win10/MSVC).

I have test compiled this in MinGW on Ubuntu 18.04 and tested IPv6 route
installation/removal on Win7/64 with the GUI running as Administrator
(= netsh commands used, not iservice) and it is also doing the right
things.  I have tested "ipv6 ifconfig", "ipv6 route" and "ipv6 DNS",
but not "IPv4 configs" or "enable DHCP".


At this point in the release cycle I would normally have not 
included it into release/2.5 anymore - we're trying to eventually 
reach a release, and not merge refactoring things anymore - *but* 
since this is well-contained, and 2/3+3/3 are actual bugfixes that 
sort of need this as prerequisite, so be it.

Let's see if we beat the number of release candidates 2.1 had... :-)

Your patch has been applied to the master and release/2.5 branch.

commit 6020e94bcf9eda89aa6573cb2eb1faf6d267cb46 (master)
commit 422343040f137cf970aea0cf8f1f248d5dc50b9d (release/2.5)
Author: Simon Rozman via Openvpn-devel
Date:   Thu Sep 24 08:44:50 2020 +0200

     netsh: Specify interfaces by index rather than name

     Signed-off-by: Simon Rozman <simon@...2293...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <20200924064452.1001-1-simon@...2293...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21076.html
     Signed-off-by: Gert Doering <gert@...1296...>

--
kind regards,

Gert Doering


