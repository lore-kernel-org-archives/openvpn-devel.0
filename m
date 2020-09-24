Date: Thu, 24 Sep 2020 13:31:15 +0200 (CEST)
Message-Id: <202009241131.08OBVF5B009174@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200924064452.1001-2-simon@...2293...>
References: <20200924064452.1001-2-simon@...2293...>
Subject: [Openvpn-devel] [PATCH applied] Re: netsh: Clear existing IPv6 DNS
 servers before configuring new ones
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

Your patch has been applied to the master and release/2.5 branch.

In my win7 tests this does not seem to be *needed* - I ran a test
with an IPv6 DNS server, and then the same test without, and the
"ipconfig /all" output showed "no more IPv6 DNS server" (before
applying this patch) - but this might have an effect if no IPv4 
servers are there.  

I was a bit worried that this might break in the "ip-win32 netsh" case,
so I tested that one as well.  It seems to do the right thing, though,
decoupling IPv4 DNS servers and IPv6 DNS servers (and not deleting
"just all" with the delete command).

Incidentially I tested "netsh interface ip set address 17 dhcp" here
as well (works).

commit dd754221024cf60226ebaa679ec65ccc23f4e402 (master)
commit 77c62003c263304f8b411d664cf56179f8d4df08 (release/2.5)
Author: Simon Rozman via Openvpn-devel
Date:   Thu Sep 24 08:44:51 2020 +0200

     netsh: Clear existing IPv6 DNS servers before configuring new ones

     Signed-off-by: Simon Rozman <simon@...2293...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <20200924064452.1001-2-simon@...2293...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21078.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


