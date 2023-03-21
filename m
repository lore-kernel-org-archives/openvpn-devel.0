Date: Tue, 21 Mar 2023 17:22:18 +0100 (CET)
Message-Id: <202303211622.32LGMIM3093826@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230310050814.67246-1-heiko@...2662...>
References: <20230310050814.67246-1-heiko@...2662...>
Subject: [Openvpn-devel] [PATCH applied] Re: dns option: allow up to eight
 addresses per server
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
To: Heiko Hund <heiko@...2662...>
Cc: openvpn-devel@lists.sourceforge.net

I've submitted this to "basic client/server testing" plus "GHA build",
just to be sure that nothing breaks - but this doesn't excercise the
new code at all.

Stare-at-code says "it should do what it says on the lid", and the
code is actually a bit simpler this way, not having to maintain separate
addr4/addr6_defined variables etc.

Some basic tests (running openvpn from the cli with --dns option and
looking at "show_dns_options()" output) look good.  Didn't look at the
environment variables or Windows DHCP.

The error message for "--dns server 3 address" (with no addresses) is
a bit confusing now

   Options error: --dns: unknown option type 'server' or missing or unknown parameter

but it does not crash or otherwise misbehave.  Exceeding the number of
allowed addresses leads to

  Options error: --dns server 3: malformed address or maximum exceeded '9.9.9.9'

(good).

Your patch has been applied to the master and release/2.6 branch.

commit 424ae5906388af8769ae448080fa3b7ec266e8d8 (master)
commit 3b967e7e05f679203ce26e027fcea5f7b4709eaa (release/2.6)
Author: Heiko Hund
Date:   Fri Mar 10 06:08:12 2023 +0100

     dns option: allow up to eight addresses per server

     Signed-off-by: Heiko Hund <heiko@...2662...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20230310050814.67246-1-heiko@...2662...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26386.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


