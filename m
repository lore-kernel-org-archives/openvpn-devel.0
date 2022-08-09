Date: Tue, 9 Aug 2022 11:22:00 +0200 (CEST)
Message-Id: <202208090922.2799M0ci047164@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220809072220.255-1-lstipakov@...277...>
References: <20220809072220.255-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: tun.c: remove unused gc_arena
 from init_tun()
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

Your patch has been applied to the master branch.

Good catch.  No idea when and why we lost the users of this...

commit 0585a4bf1a5ba9cf2051a7d65ac0628bf7164299
Author: Lev Stipakov
Date:   Tue Aug 9 10:22:20 2022 +0300

     tun.c: remove unused gc_arena from init_tun()

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Antonio Quartulli <a@...2181...>
     Message-Id: <20220809072220.255-1-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24851.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


