Date: Wed, 15 May 2019 21:28:06 +0200 (CEST)
Message-Id: <201905151928.x4FJS63B036376@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20181219050118.6568-2-a@...2181...>
References: <20181219050118.6568-2-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: implement networking API for
 iproute2
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

Your patch has been applied to the master branch.

I'm not really happy with this patch - it adds lots of code which is
not used yet.  It claims that this is "the code from route.c / tun.c",
but as it is not moved over but just copied, "git diff --color-moved=zebra"
won't help in actually verifying that it is, indeed, the same code - and
it cannot be tested because it is never called...  so this is not a good
patch granularity.  But since Arne has already ACKed the whole series,
I'm not holding this up, just grumbling a bit, hoping for a slightly
more convincing (= there is a way to actually test the code changes every
single commit brings) granularity in future series.

Oh, and as a side note - can we please stop configuring broadcast
addresses?  This was silly 15 years ago already...  the machine knows
quite well what the broadcast address is.

+    char *brd_str = (char *)print_in_addr_t(*broadcast, 0, NULL);
+
+    argv_printf(&argv, "%s addr add dev %s %s/%d broadcast %s", iproute_path,
+                iface, addr_str, prefixlen, brd_str);

.. and as yet another side note - this code introduces string allocations
using (implicit) malloc() and free()...  so this is very much *different*
code than "what we have in route.c/tun.c" - and it questions the design
of this API if every single backend *except* sitnl will have to start
doing local memory management.  ** This needs to be fixed **.


commit 678111936ffb33992684dd3b96dc5b21693dfa58
Author: Antonio Quartulli
Date:   Wed Dec 19 15:01:12 2018 +1000

     implement networking API for iproute2

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20181219050118.6568-2-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg18031.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


