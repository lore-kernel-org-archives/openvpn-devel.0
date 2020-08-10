Date: Mon, 10 Aug 2020 18:34:59 +0200 (CEST)
Message-Id: <202008101634.07AGYxab023379@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200810161723.25576-1-a@...2181...>
References: <20200810161723.25576-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: travis: don't run t_net.sh test
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
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Haven't tested, but this looks a reasonable workaround for
"dummy.ko is not available on Travis, and t_net.sh will
always fail, without any informational value"

Your patch has been applied to the master branch.

commit feacd01c584898977c3450bf48d1ea5cbb9029f1
Author: Antonio Quartulli
Date:   Mon Aug 10 18:17:23 2020 +0200

     travis: don't run t_net.sh test

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20200810161723.25576-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg20684.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


