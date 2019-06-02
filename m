Date: Sun, 2 Jun 2019 20:30:41 +0200 (CEST)
Message-Id: <201906021830.x52IUfY0035103@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20181219050118.6568-3-a@...2181...>
References: <20181219050118.6568-3-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: introduce sitnl: Simplified
 Interface To NetLink
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

I'm (sorry) again not totally happy with it - it introduces the configure
changes for sitnl, namely, breaking the "do route and ifconfig command
exist?" check on all Linux systems (have_sitnl=yes is unconditionally
set for Linux, and that will then always skip the check), without 
actually providing calls to sitnl yet.  A better granularity would have
introduced the configure checks only at the very end, when the actual
HAVE_SITNL code is not only "it is there and compiles" but also functional,
and route/ifconfig are kicked out.

Additonally, it introduces "sitnl.h" which is not included in 
openvpn_SOURCES and not referenced from anywhere... which is also an
extra burden on me (will this disappear in a future patch?  will it
be included?  will it appear in openvpn_SOURCES eventually?).

The code in networking_sitnl.* looks mostly reasonable, though I 
wonder if it wasn't more elegant to do the sitnl_socket() dance only
once in the init, and store the file descriptor in the context
afterwards... right now, you're doing the whole open/bind/../close
for every function called.

The upcoming networking_we_are_done() function doing the gc_free()
calls for non-linux implementations could then do the close() for
sitnl...

Besides this, there are a few warts...

+    if (up)
+        req.i.ifi_flags |= IFF_UP;
+    else
+        req.i.ifi_flags &= ~IFF_UP;

..
+    ifindex = if_nametoindex(iface);
+    if (ifindex == 0) {

.. which you might want to run through uncrustify eventually...


commit c6542257019ba66a98b817d3b851621dd553f80a
Author: Antonio Quartulli
Date:   Wed Dec 19 15:01:13 2018 +1000

     introduce sitnl: Simplified Interface To NetLink

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20181219050118.6568-3-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg18030.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


