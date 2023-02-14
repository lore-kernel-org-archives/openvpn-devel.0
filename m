Date: Tue, 14 Feb 2023 14:11:13 +0100 (CET)
Message-Id: <202302141311.31EDBDUZ022011@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230210133159.1336-1-lstipakov@...277...>
References: <20230210133159.1336-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Improve format specifier for
 socket handle in Windows
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

I'm so not testing this... but I do not need to, the change is trivial
(ok, I cheated, I did test-compile on MinGW).

Your patch has been applied to the master branch.

commit 6731314a82d1a3c76b5497749985ee20c0c7d8eb (master)
commit 8e3331a901dbececc8622e97ed0592ddadf56996 (release/2.6)
Author: Lev Stipakov
Date:   Fri Feb 10 15:31:59 2023 +0200

     Improve format specifier for socket handle in Windows

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Message-Id: <20230210133159.1336-1-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26220.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


