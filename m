Date: Sun, 7 Jun 2020 12:42:08 +0200 (CEST)
Message-Id: <202006071042.057Ag83B041370@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200606211624.10877-1-a@...2181...>
References: <20200606211624.10877-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: pool: add support for
 ifconfig-pool-persist with IPv6 only
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
To: Antonio Quartulli <antonio@...515...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Much nicer code than in v4 :-)

Stared-at-code, and ran the t_client and t_server tests with ipv4-only,
ipv4+ipv6 and ipv6-only pools (ipv4-only is something I never wanted to
do again... :-) ).

Tested pool mishandling ("corrupt" and "out-of-bounds" v4+v6 addresses,
mismatching pool indexes, etc.) - and that all behaves like planned. \o/

Something for the cleanup patch: pool.c seems to have grown an include
for "options.h", but I can not see a reason why this is needed (it
compiles fine without)...?

Your patch has been applied to the master branch.

commit 6a8cd033b1812a26b9b35c17eef33240d7ac2719
Author: Antonio Quartulli
Date:   Sat Jun 6 23:16:24 2020 +0200

     pool: add support for ifconfig-pool-persist with IPv6 only

     Signed-off-by: Antonio Quartulli <antonio@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20200606211624.10877-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg19990.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


