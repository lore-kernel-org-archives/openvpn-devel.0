Date: Mon, 19 Jan 2026 18:09:27 +0100 (CET)
Message-Id: <202601191709.60JH9RpP046939@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260119122556.15225-1-gert@...1296...>
References: <20260119122556.15225-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: socket: Avoid conversion
 warning in get_addr_generic
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
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

Easy enough, simplifies things, and while it doesn't "get rid of #pragma",
it at least reduces the non-monitored scope.

Good find, ipv6_addr_safe_hexplusbits() :-)

Your patch has been applied to the master branch.

commit 2cc00e80bca26c1c7129fa45e48714ca68b56b28
Author: Frank Lichtenheld
Date:   Mon Jan 19 13:25:51 2026 +0100

     socket: Avoid conversion warning in get_addr_generic

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1475
     Message-Id: <20260119122556.15225-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35324.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


