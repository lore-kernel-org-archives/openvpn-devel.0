Date: Tue, 7 Feb 2023 17:59:06 +0100 (CET)
Message-Id: <202302071659.317Gx6xJ059173@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230203191440.136050-5-frank@...2641...>
References: <20230203191440.136050-5-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: Windows: fix unused variable in
 win32_get_arch
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

"Clear enough", indeed.  Test compiled on MinGW.

Your patch has been applied to the master and release/2.6 branch.

commit 2dc2d16559b41d56f662d7cd69ea547e804e27b8 (master)
commit 4718af50bb7b5a913ae4befb2d3a8dd338b3eb74 (release/2.6)
Author: Frank Lichtenheld
Date:   Fri Feb 3 20:14:39 2023 +0100

     Windows: fix unused variable in win32_get_arch

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <20230203191440.136050-5-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26141.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


