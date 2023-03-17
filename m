Date: Fri, 17 Mar 2023 14:36:12 +0100 (CET)
Message-Id: <202303171336.32HDaC5P094557@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230315133808.1550-1-lstipakov@...277...>
References: <20230315133808.1550-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Support --inactive option for
 DCO
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
To: Lev Stipakov <lev@...515...>
Cc: openvpn-devel@lists.sourceforge.net

Stared a bit at the code until I understood the control flow, then
discussed a bit on IRC.  Code looks reasonable, and compiles, but
I did not test on an actual Windows system.

Both Linux and FreeBSD are currently broken wrt DCO and --inactive - this
patch does not make the situation worse, but does not improve it either.

Linux: no dco_get_peer_stats() or dco_get_peer_stats_multi() yet ("pending").

FreeBSD: no dco_get_peer_stats() yet, and this implementation never
queries the dco_get_peer_stats_multi() function.  Doing so might be
a bit of overkill ("one client might be expiring, please give me all!")
so the way counters are queried needs to be changed, or FreeBSD needs
to grow a "query peer stats for single client" function on the kernel side
(+ userland implementation).  I might look into this :-)


As a side effect this change makes dco_get_peer_stats() update
c2.tun_read/write_bytes, which is relevant for F2/SIGUSR2 status
printing (but notably not for --server status files).

As discussed, I've extended the check_inactivity_timeout() comment
quite a bit, explaining the different control flows with and without DCO.

Your patch has been applied to the master and release/2.6 branch.

commit 514eefb14ace41a5790e59b81654d1d5eed60670 (master)
commit fd71bce651d5f606d3c1d430c7c0911fe119f075 (release/2.6)
Author: Lev Stipakov
Date:   Wed Mar 15 15:38:08 2023 +0200

     Support --inactive option for DCO

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Heiko Hund <heiko@...2662...>
     Message-Id: <20230315133808.1550-1-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26421.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


