Date: Tue, 28 Oct 2025 13:33:28 +0100 (CET)
Message-Id: <202510281233.59SCXSOt001459@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251028122028.24628-1-gert@...1296...>
References: <20251028122028.24628-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: mroute: Remove unused mask
 argument of mroute_get_in*
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

The "mask" bit is trivial (I have wondered a few times what it is for,
seems "for nothing" - out it goes!).  The 0xff bit needed a bit more
thinking, but indeed, since we're only masking single-bytes at a time
here, and shift left, 0xffffff and 0xff is the same thing - and not
using an IPv4 constant for IPv6 seems like a proper thing to do!

Your patch has been applied to the master branch.

commit 2ae18239c30d96a4d16bc75a0204c4895e6cbce3
Author: Frank Lichtenheld
Date:   Tue Oct 28 13:20:23 2025 +0100

     mroute: Remove unused mask argument of mroute_get_in*

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1309
     Message-Id: <20251028122028.24628-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33939.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


