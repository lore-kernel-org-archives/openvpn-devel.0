Date: Thu, 24 Sep 2020 13:42:02 +0200 (CEST)
Message-Id: <202009241142.08OBg2tB009479@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200924065519.1839-1-simon@...2293...>
References: <20200924065519.1839-1-simon@...2293...>
Subject: [Openvpn-devel] [PATCH applied] Re: openvpnmsica: Simplify
 find_adapters() to void return
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
To: Simon Rozman via Openvpn-devel <openvpn-devel@lists.sourceforge.net>
Cc: openvpn-devel@lists.sourceforge.net

Indeed, that looks simple and straightforward :-) - compile
tested on MinGW.

Your patch has been applied to the master and release/2.5 branch.

commit 7f7b05395c3eb634e198d12e212360958c3ca8fb (master)
commit 29e61986af6bfe4ca41163c4a1c74d90b1b0bdea (release/2.5)
Author: Simon Rozman via Openvpn-devel
Date:   Thu Sep 24 08:55:19 2020 +0200

     openvpnmsica: Simplify find_adapters() to void return

     Signed-off-by: Simon Rozman <simon@...2293...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <20200924065519.1839-1-simon@...2293...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21077.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


