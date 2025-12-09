Date: Tue, 9 Dec 2025 16:25:27 +0100 (CET)
Message-Id: <202512091525.5B9FPRAQ063103@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251209133038.5088-1-gert@...1296...>
References: <20251209133038.5088-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: tun: Refactor BSD
 write_tun/read_tun
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

So this patch looks huge, but it really is just removing 3 extra copies of
"read/write_tun()*" from tun.c that all do the same, but in a slightly
different way.

Without verifying line-by-line that they all do *exactly* the same, I
stared sufficently long at the code to assess that - and the rest was 
verified by the buildbots.  We do have active t_client tests on all 
affected platforms that do IPv4 and IPv6 in tun and tap, so if that
all still works, the change is not breaking anything.

Your patch has been applied to the master branch.

commit 6c7489e2edaeeb60fa2b442e4f33d93bfbbdab11
Author: Frank Lichtenheld
Date:   Tue Dec 9 14:30:33 2025 +0100

     tun: Refactor BSD write_tun/read_tun

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1378
     Message-Id: <20251209133038.5088-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34946.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


