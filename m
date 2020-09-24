Date: Thu, 24 Sep 2020 13:38:45 +0200 (CEST)
Message-Id: <202009241138.08OBcjd9009354@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200924064452.1001-3-simon@...2293...>
References: <20200924064452.1001-3-simon@...2293...>
Subject: [Openvpn-devel] [PATCH applied] Re: netsh: Delete WINS servers on
 TUN close
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

Your patch has been applied to the master and release/2.5 branch.

I have not tested this at all (no WINS infra), but "it looks 
reasonable and compiles" (Ubuntu 18, mingw).

commit 370395b3348c4307cdea955abaa36ba315cc128e (master)
commit b77fc7121003d988eaa3eaeef2ec46bff73202cf (release/2.5)
Author: Simon Rozman via Openvpn-devel
Date:   Thu Sep 24 08:44:52 2020 +0200

     netsh: Delete WINS servers on TUN close

     Signed-off-by: Simon Rozman <simon@...2293...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <20200924064452.1001-3-simon@...2293...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21075.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


