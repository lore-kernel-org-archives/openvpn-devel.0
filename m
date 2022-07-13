Date: Wed, 13 Jul 2022 14:28:13 +0200 (CEST)
Message-Id: <202207131228.26DCSDon083705@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220713121416.1912-1-a@...2181...>
References: <20220713121416.1912-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: networking_sitnl: always return
 negative error code in case of failure
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

"obvious in hindsight" :-)

Your patch has been applied to the master branch.

Not applicable to 2.5, as there is no net_iface_del() yet.

commit dab9343a0530ee2468304823181372393d365675 (HEAD -> master)
Author: Antonio Quartulli
Date:   Wed Jul 13 14:14:16 2022 +0200

     networking_sitnl: always return negative error code in case of failure

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220713121416.1912-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24686.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


