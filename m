Date: Sun, 18 Sep 2022 14:13:54 +0200 (CEST)
Message-Id: <202209181213.28ICDslA001856@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220917224227.16988-1-a@...2181...>
References: <20220917224227.16988-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: delete_routes(_ipv6): avoid
 memleak if RT_DEFINED is not set
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
To: Antonio Quartulli <a@...2181...>, guerincamille56@...277...
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Thanks for spotting this and sending a patch.

Not sure why this was fixed for add_route*() in commit a11bea18b1c93
(and then made more pretty in 903e2cf5c1), but forgotten in delete_route*()

Tested with a basic t_client test with ipv4 + ipv6 routes.

Your patch has been applied to the master branch.

commit 5ac33a88b10584c3e52dc0c01dad2571b75be239
Author: Antonio Quartulli
Date:   Sun Sep 18 00:42:27 2022 +0200

     delete_routes(_ipv6): avoid memleak if RT_DEFINED is not set

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220917224227.16988-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25245.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


