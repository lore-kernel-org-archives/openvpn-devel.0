Date: Thu, 15 Aug 2019 18:04:10 +0200 (CEST)
Message-Id: <201908151604.x7FG4A8u016175@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20190815121053.18433-2-arne@...1227...>
References: <20190815121053.18433-2-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Adjust Android code after sitnl
 patch merge
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

I can't really test this, but it only touches (and cleans up) android-
specific code - and by convention if you say "android needs this", so
it does :-) - and it looks generally sane.

Your patch has been applied to the master branch.

commit 26e5b80096a78ec7d5e7bcd15f81155be5fde2ec
Author: Arne Schwabe
Date:   Thu Aug 15 14:10:53 2019 +0200

     Adjust Android code after sitnl patch merge

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20190815121053.18433-2-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg18752.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


