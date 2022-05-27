Date: Fri, 27 May 2022 10:19:15 +0200 (CEST)
Message-Id: <202205270819.24R8JFwL047234@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220527012457.1819262-2-heiko@...2662...>
References: <20220527012457.1819262-2-heiko@...2662...>
Subject: [Openvpn-devel] [PATCH applied] Re: remove foreign_option() call
 for IPv6 DNS servers
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
To: Heiko Hund <heiko@...2662...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Indeed, this is inside an WIN32/ANDROID block, which does not need/use
foreign options for DHCP.  Out it goes.  Trivial otherwise :-)

Your patch has been applied to the master branch.

commit 2c4cf1a6490b875a4c666d781c30f1033f739118
Author: Heiko Hund
Date:   Fri May 27 03:24:54 2022 +0200

     remove foreign_option() call for IPv6 DNS servers

     Signed-off-by: Heiko Hund <heiko@...2662...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220527012457.1819262-2-heiko@...2662...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24433.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


