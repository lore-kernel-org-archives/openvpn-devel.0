Date: Mon, 5 Apr 2021 13:53:08 +0200 (CEST)
Message-Id: <202104051153.135Br8lo060460@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210404110602.20374-1-arne@...1227...>
References: <20210404110602.20374-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove conditionals compilation
 for P2MP, ENABLE_SHAPER and TIME_BACKTRACK_PROTECTION
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

(As the original mail already claimed :-) )

I have stared-at-diff and grepped for P2MP, SHAPER and BACKTRACK remains
(no complaints).  Client-side tested, server-side tested in all combinations
I have (p2mp, p2p), no surprises.  I did not test --shaper, but I am 
reasonably convinced that the bits removed only the "if ENABLE_SHAPER is
not defined", as for "TIME_BACKTRACK_PROTECTION".

Out it goes, lots of #ifdefs and especially "#else" code variants that
are hard to test gone.

Your patch has been applied to the master branch.

commit 725dda00f809e5d9768a1aa33c8e73f2e38d9a7e
Author: Arne Schwabe
Date:   Sun Apr 4 13:06:02 2021 +0200

     Remove conditionals compilation for P2MP, ENABLE_SHAPER and TIME_BACKTRACK_PROTECTION

     Message-Id: <20210403184626.23067-1-arne@...1227...>
     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20210404110602.20374-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22030.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


