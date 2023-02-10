Date: Fri, 10 Feb 2023 17:58:45 +0100 (CET)
Message-Id: <202302101658.31AGwj2G029233@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230207145416.1415-1-lstipakov@...277...>
References: <20230207145416.1415-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Allow certain DHCP options to
 be used without DHCP server
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
To: Lev Stipakov <lev@...515...>
Cc: openvpn-devel@lists.sourceforge.net

Code looks good, and compiles on MinGW.  Didn't actually test the various
combinations.

Your patch has been applied to the master and release/2.6 branch.

commit 469158f93ea52a6c2f821890ef599299183aa020 (master)
commit 442fde78a1f1f512762a4b2c4db958a3d56410d1 (release/2.6)
Author: Lev Stipakov
Date:   Tue Feb 7 16:54:16 2023 +0200

     Allow certain DHCP options to be used without DHCP server

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Antonio Quartulli <a@...2181...>
     Message-Id: <20230207145416.1415-1-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26169.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


