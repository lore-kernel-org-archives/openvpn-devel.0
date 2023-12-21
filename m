Date: Thu, 21 Dec 2023 14:48:02 +0100 (CET)
Message-Id: <202312211348.3BLDm2fe096481@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20231220133637.60996-1-frank@...2641...>
References: <20231220133637.60996-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: tun.c: don't attempt to delete
 DNS and WINS servers if they're not set
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

Have only test compiled... but stare-at-code looks quite reasonable.

Nice catch on the possible gc_arena leak in do_dns_domain_service().

Your patch has been applied to the master and release/2.6 branch (bugfix).

commit c590868a721881dd21bfb77ecf846e6c8720e4ef (master)
commit 030afe64198e6c32297dcdbf33ff9c5f6a35f5e1 (release/2.6)
Author: Lev Stipakov
Date:   Wed Dec 20 14:36:37 2023 +0100

     tun.c: don't attempt to delete DNS and WINS servers if they're not set

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20231220133637.60996-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27843.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


