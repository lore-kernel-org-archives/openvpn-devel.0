Date: Tue, 14 Feb 2023 14:01:08 +0100 (CET)
Message-Id: <202302141301.31ED184r021563@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230210142712.572303-3-arne@...1227...>
References: <20230210142712.572303-3-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Combine extra_tun/frame
 parameter of frame_calculate_payload_overhead
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

Indeed, makes sense :-)

Stared-at-code, smoke tested on GH actions to be sure.

Your patch has been applied to the master and release/2.6 branch.

commit e759c0ea6fe8679edf4d5208f2f0dc8cee5e948c (master)
commit e1fac38c29e0d26eb3bd13812529721d9ba0591e (release/2.6)
Author: Arne Schwabe
Date:   Fri Feb 10 15:27:06 2023 +0100

     Combine extra_tun/frame parameter of frame_calculate_payload_overhead

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20230210142712.572303-3-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26223.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


