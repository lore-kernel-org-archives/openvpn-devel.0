Date: Mon, 20 Feb 2023 17:07:37 +0100 (CET)
Message-Id: <202302201607.31KG7bWV068966@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230220131424.1749736-1-arne@...1227...>
References: <20230220131424.1749736-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Exit if a proper message
 instead of segfault on Android without management
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

This code is all inside #ifdef TARGET_ANDROID, so I didn't test anything -
but it looks all reasonable.

Your patch has been applied to the master and release/2.6 branch.

commit 3132bead497deca24dc638e151bf7194df6f4884 (master)
commit d0c1abb4dee233834de540932ddcaef209696e79 (release/2.6)
Author: Arne Schwabe
Date:   Mon Feb 20 14:14:24 2023 +0100

     Exit if a proper message instead of segfault on Android without management

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20230220131424.1749736-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26288.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


