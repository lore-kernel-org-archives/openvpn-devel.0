Date: Tue, 13 Dec 2022 22:40:55 +0100 (CET)
Message-Id: <202212132140.2BDLetrD053741@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20221205164103.9190-2-kprovost@...2661...>
References: <20221205164103.9190-2-kprovost@...2661...>
Subject: [Openvpn-devel] [PATCH applied] Re: Read DCO traffic stats from the
 kernel
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

I've stared at the code for a bit (reasonable, with the enhancements
to come from Arne / Lev), and tested on Linux without DCO (client/server),
Linux with DCO (client/server) and FreeBSD with DCO (client/server),
and everything worked.

To make this new code work for the "configure --disable-dco" case,
I had to add an empty stub to dco.h

+static inline int
+dco_get_peer_stats(dco_context_t *dco, struct multi_context *m)
+{
+    return 0;
+}
+

.. which is not something I normally do, but this is the same 
"non function" as for the "no linux and no windows implementation yet",
and we want this to proceed now.  It's quite obviously no code that
does anything.


I have not tested the actual counter functionality, as the kernel
side bits are not merged yet (in FreeBSD review process, but they
all look quite straightforward).  It will log warnings about
not being able to get the stats...

Dec 13 22:40:03 fbsd14 tun-udp-p2mp-topology-subnet[19846]: Failed to get peer stats: Operation not supported (errno=45)

.. but this is "just cosmetic", if a bit annoying.  Will go away
as soon as the kernel bits are there :-)


Uncrustify demanded a few whitespace amendments, which I've done.

Your patch has been applied to the master and release/2.6 branch.

commit ce2b459dabc29d071be28b8ddaa0512f8c8143ec (master)
commit 7695a55be06ccdcfae070b0cb3f0dfddca605003 (release/2.6)
Author: Kristof Provost
Date:   Mon Dec 5 17:41:00 2022 +0100

     Read DCO traffic stats from the kernel

     Signed-off-by: Kristof Provost <kprovost@...2661...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Message-Id: <20221205164103.9190-2-kprovost@...2661...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25618.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


