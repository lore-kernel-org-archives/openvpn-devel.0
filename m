Date: Mon, 25 Sep 2023 22:10:39 +0200 (CEST)
Message-Id: <202309252010.38PKAdLM017988@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230925094409.40429-1-frank@...2641...>
References: <20230925094409.40429-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: Mock openvpn_exece on win32
 also for test_tls_crypt
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

"It does something", namely, build a pkt_testdriver-mock_win32_execve.o
and link that to pkt_testdriver.exe (on my mingw test system).  And I
seem to remember that's all it intends to do - so the ...execve.o can be
used by another test driver in one of the next patches.

Your patch has been applied to the release/2.6 branch.

commit 2ecad2403c4589f204e0fc7d1c9218f016c1de07
Author: Arne Schwabe
Date:   Mon Sep 25 11:44:09 2023 +0200

     Mock openvpn_exece on win32 also for test_tls_crypt

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Heiko Hund <heiko@...515...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20230925094409.40429-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27097.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


