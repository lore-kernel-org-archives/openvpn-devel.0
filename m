Date: Fri, 4 Dec 2020 12:20:57 +0100 (CET)
Message-Id: <202012041120.0B4BKvSL051250@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20201130123813.21388-1-arne@...1227...>
References: <20201130123813.21388-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix port-share option with
 TLS-Crypt v2
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

Magic heuristics... but if Arne and Steffan agree that this is correct,
who am I to dispute it :-) - it passes client tests and is not
"obviously wrong".

Your patch has been applied to the master and release/2.5 branch.

commit 1387f52682dcd3789c56c9979ccedca281ff88f4 (master)
commit c27f97dc0ac99344659cca57bd048543a9899266 (release/2.5)
Author: Arne Schwabe
Date:   Mon Nov 30 13:38:13 2020 +0100

     Fix port-share option with TLS-Crypt v2

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Steffan Karger <steffan.karger@...2507...>
     Message-Id: <20201130123813.21388-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21290.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


