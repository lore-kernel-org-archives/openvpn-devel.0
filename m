Date: Mon, 27 Feb 2023 08:17:20 +0100 (CET)
Message-Id: <202302270717.31R7HKra024431@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230217122156.541-1-lstipakov@...277...>
References: <20230217122156.541-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Avoid management log loop with
 verb >= 6
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

Trivial enough :-)

Your patch has been applied to the master and release/2.6 branch.

commit b8eddda8524bf6f164361667bfce6bbb3fac846b (master)
commit c26609bdcd75da5702befbdfa5d0136a7787e52e (release/2.6)
Author: Lev Stipakov
Date:   Fri Feb 17 14:21:55 2023 +0200

     Avoid management log loop with verb >= 6

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Antonio Quartulli <a@...2181...>
     Message-Id: <20230217122156.541-1-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26284.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


