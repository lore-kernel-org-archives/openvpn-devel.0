Date: Thu, 15 Jan 2026 11:10:07 +0100 (CET)
Message-Id: <202601151010.60FAA7sV052711@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260115091124.23360-1-gert@...1296...>
References: <20260115091124.23360-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: forward: Avoid conversion
 warning in ipv6_send_icmp_unreachable
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

And here comes the last one for today... straightforward enough,
mostly adding a few "const" and untangling the ntohs(sum) call
into two lines.  Plus ripping out a dead gc_arena.

Your patch has been applied to the master branch.

commit 8c3671dbd538f89159a258acf0306999abf7ecb0
Author: Frank Lichtenheld
Date:   Thu Jan 15 10:11:16 2026 +0100

     forward: Avoid conversion warning in ipv6_send_icmp_unreachable

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1472
     Message-Id: <20260115091124.23360-1-gert@...1296...>
     URL: https://sourceforge.net/p/openvpn/mailman/message/59283657/
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


