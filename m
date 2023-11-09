Date: Thu, 9 Nov 2023 12:31:49 +0100 (CET)
Message-Id: <202311091131.3A9BVnNV020333@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20231108124947.76816-2-gert@...1296...>
References: <20231108124947.76816-2-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Double check that we do not use
 a freed buffer when freeing a session
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

Second in the series.  This one is "should we ever do stupid things again,
catch us doing so", so not the actual bugfix but belt&suspenders.

Your patch has been applied to the release/2.6 and master branch.

commit cd4d819c99266fa727c294225cafdb4ae331d02e (release/2.6)
commit f09d75083e8d7f6db3d90a25480e44de91bd8154 (master)
Author: Arne Schwabe
Date:   Wed Oct 25 17:46:24 2023 +0200

     Double check that we do not use a freed buffer when freeing a session

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: David Sommerseth <davids@...515...>
     Acked-by: Heiko Hund <heiko@...2662...>
     Message-Id: <20231108124947.76816-2-gert@...1296...>
     URL: https://www.mail-archive.com/search?l=mid&q=20231108124947.76816-2-gert@...1296...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


