Date: Fri, 20 Dec 2024 22:41:13 +0100 (CET)
Message-Id: <202412202141.4BKLfDxO098851@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20241213164552.265863-1-frank@...2641...>
References: <20241213164552.265863-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: dns: store IPv4 addresses in
 network byte order
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

Patch looks good, ACK from Frank, all *consumers* of addr[].in.a4.s_addr
(today) are "print_in_addr_t()" calls which have a flag to deal with
the changed byte order.

Have not actually tested anything, just test compiled.

Your patch has been applied to the master branch.

commit 6f2d222c92bb4555dc931c2aed3510a64bd53df3
Author: Heiko Hund
Date:   Fri Dec 13 17:45:52 2024 +0100

     dns: store IPv4 addresses in network byte order

     Signed-off-by: Heiko Hund <heiko@...2662...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20241213164552.265863-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30111.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


