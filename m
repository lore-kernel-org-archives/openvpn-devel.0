Date: Fri, 26 Jul 2024 13:58:55 +0200 (CEST)
Message-Id: <202407261158.46QBwtc5092554@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240726104032.2112-1-gert@...1296...>
References: <20240726104032.2112-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: console_systemd: rename
 query_user_exec to query_user_systemd
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

Simplification of code, less #ifdef/#undef tricks, good :-) - stared
at code, and compile tested (FreeBSD + GHA).

Your patch has been applied to the master branch.

commit 418463ad27c13f56adb5b02cfd62018b7d634ee8 (master)
Author: Frank Lichtenheld
Date:   Fri Jul 26 12:40:32 2024 +0200

     console_systemd: rename query_user_exec to query_user_systemd

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20240726104032.2112-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28983.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


