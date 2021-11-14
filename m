Date: Sun, 14 Nov 2021 15:10:54 +0100 (CET)
Message-Id: <202111141410.1AEEAssh049351@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20211114130311.4043536-1-arne@...1227...>
References: <20211114130311.4043536-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Move IV_TCPNL from
 comp_generate_peer_info_string to push_peer_info
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

"because it makes sense".

Briefly tested if it's still sent to the server (it is).  Not much 
else to see here :-)

Your patch has been applied to the master branch.

commit 648e871e50e76586d65a267cf598d8f1ec0d0057
Author: Arne Schwabe
Date:   Sun Nov 14 14:03:11 2021 +0100

     Move IV_TCPNL from comp_generate_peer_info_string to push_peer_info

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20211114130311.4043536-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23182.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


