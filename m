Date: Sat, 23 Aug 2025 17:43:04 +0200 (CEST)
Message-Id: <202508231543.57NFh4AF038331@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250823153652.30938-1-gert@...1296...>
References: <20250823153652.30938-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Clean up documentation for
 --tun-mtu-max
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

This all makes sense - thanks for spotting.  No idea what we were looking
at when merging the original patch...

Not sure introducing the extra define improves readability (the old context
made it quite clear that "1600" is not "a random number out of thin air")
- but since TUN_MTU_DEFAULT has a define in mtu.h, why not.

Your patch has been applied to the master branch.

commit 5c4744f28e2adb3fc8f6fb3b3c8ffe22636eb0a0
Author: Frank Lichtenheld
Date:   Sat Aug 23 17:36:46 2025 +0200

     Clean up documentation for --tun-mtu-max

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250823153652.30938-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32663.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


