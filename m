Date: Mon, 30 Mar 2026 13:07:25 +0200 (CEST)
Message-Id: <202603301107.62UB7PZk035412@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260326062016.3856597-1-haixiao.yan.cn@...3018...>
References: <20260326062016.3856597-1-haixiao.yan.cn@...3018...>
Subject: [Openvpn-devel] [PATCH applied] Re: tests: skip test execution when
 cross-compiling
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
To: Haixiao Yan <haixiao.yan.cn@...3018...>
Cc: openvpn-devel@lists.sourceforge.net

Thanks for finding that bug, and letting us know.

Your patch has been applied to the master and release/2.7 branch (bugfix).

commit 690aace41a68292412da3f313389e79d4a12bfbc (master)
commit 66989b384dc0056e89942bfa0a1546a2644f7831 (release/2.7)
Author: Haixiao Yan
Date:   Thu Mar 26 14:20:16 2026 +0800

     tests: skip test execution when cross-compiling

     Signed-off-by: Haixiao Yan <haixiao.yan.cn@...3018...>
     Acked-By: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20260326062016.3856597-1-haixiao.yan.cn@...3018...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36288.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


